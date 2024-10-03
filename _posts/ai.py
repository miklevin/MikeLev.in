#!/usr/bin/env python3
import sys
import requests

def get_best_llama_model(models):
    llama_models = [model for model in models if model.lower().startswith('llama')]
    return max(llama_models, key=lambda x: x.split(':')[0], default=models[0]) if llama_models else models[0]

def chat_with_ollama(input_text, timeout=30):
    try:
        models_response = requests.get("http://localhost:11434/api/tags", timeout=timeout)
        models_response.raise_for_status()
        
        models = [model['name'] for model in models_response.json()['models']]
        chosen_model = get_best_llama_model(models)
        
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
        
        return chat_response.json()['message']['content'].strip()
    except requests.exceptions.RequestException as e:
        return f"Error: {str(e)}"

if __name__ == "__main__":
    original_text = sys.stdin.read()
    
    headline_prompt = (
        "Generate a concise, relevant headline for the following text. "
        "Respond with ONLY the headline, nothing else. "
        "Use title case and do not include a hash symbol (#) or any formatting. "
        "The headline should be no more than 10 words long.\n\n"
        "Text to summarize:\n\n" + original_text
    )
    
    headline = chat_with_ollama(headline_prompt)
    
    # Ensure the headline doesn't exceed 10 words
    headline = ' '.join(headline.split()[:10])
    
    # Format the final output
    final_output = f"## {headline}\n\n{original_text}"
    
    print(final_output)
