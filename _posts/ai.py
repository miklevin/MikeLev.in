#!/usr/bin/env python3
import sys
import requests
import re
import textwrap

def parse_version(version_string):
    return [int(x) if x.isdigit() else x for x in re.findall(r'\d+|\D+', version_string)]

def get_best_llama_model(models):
    llama_models = [model for model in models if model.lower().startswith('llama')]
    if not llama_models:
        return None
    def key_func(model):
        parts = model.split(':')
        base_name = parts[0]
        version = parts[1] if len(parts) > 1 else ''
        base_version = re.search(r'llama(\d+(?:\.\d+)*)', base_name.lower())
        base_version = base_version.group(1) if base_version else '0'
        return (parse_version(base_version),
                1 if version == 'latest' else 0,
                parse_version(version))
    return max(llama_models, key=key_func)

def chat_with_ollama(input_text, timeout=30):
    try:
        models_response = requests.get("http://localhost:11434/api/tags", timeout=timeout)
        models_response.raise_for_status()
        
        models = models_response.json()['models']
        model_names = [model['name'] for model in models]
        
        chosen_model = get_best_llama_model(model_names) or model_names[0]
        
        chat_response = requests.post(
            "http://localhost:11434/api/chat",
            json={
                "model": chosen_model,
                "messages": [{"role": "user", "content": input_text}],
                "stream": False
            },
            timeout=timeout
        )
        chat_response.raise_for_status()
        
        response_content = chat_response.json()['message']['content']
        return response_content
    except requests.exceptions.RequestException as e:
        return f"Error: {str(e)}"

def wrap_paragraphs(text, width=80):
    lines = text.split('\n')
    wrapped_lines = []
    current_paragraph = []

    for line in lines:
        if line.strip().startswith('#') or not line.strip():
            if current_paragraph:
                wrapped_lines.extend(textwrap.wrap(' '.join(current_paragraph), width=width))
                wrapped_lines.append('')
                current_paragraph = []
            wrapped_lines.append(line)
        else:
            current_paragraph.append(line.strip())

    if current_paragraph:
        wrapped_lines.extend(textwrap.wrap(' '.join(current_paragraph), width=width))

    return '\n'.join(wrapped_lines)

def remove_extra_blank_lines(text):
    # Split the text into lines
    lines = text.split('\n')
    # Remove leading/trailing blank lines
    lines = [line for line in lines if line.strip() or line.startswith('#')]
    # Reduce multiple consecutive blank lines to a single blank line
    result = []
    for line in lines:
        if line.strip() or (result and result[-1].strip()):
            result.append(line)
    return '\n'.join(result)

if __name__ == "__main__":
    input_text = sys.stdin.read()
    nvim_prompt = (
        "IMPORTANT: Follow these instructions EXACTLY. Do not deviate.\n\n"
        "1. Add ONE well-chosen headline at the beginning of the text. Use ONLY '#' for this headline.\n"
        "2. Insert *italics*, **bold**, and `code` backticks ONLY where absolutely necessary for emphasis or clarity.\n"
        "3. Do NOT change any words or existing formatting.\n"
        "4. Do NOT perform any line wrapping.\n"
        "5. Do NOT insert any blank lines.\n"
        "6. NEVER use underscores (_) for any purpose.\n"
        "7. NEVER use ***bold italics***.\n"
        "8. NEVER use ## or any other level of headline besides #.\n"
        "9. Do NOT use any Markdown syntax not explicitly mentioned here.\n"
        "10. Preserve all existing line breaks exactly as they are.\n\n"
        "Here's the text to enhance:\n\n"
    )
    input_text = nvim_prompt + input_text
    response = chat_with_ollama(input_text)
    wrapped_response = wrap_paragraphs(response)
    final_response = remove_extra_blank_lines(wrapped_response)
    print(final_response)