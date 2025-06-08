---
title: "Evolving Prompt Fu: Command-Line Prompting for Dynamic AI Context"
permalink: /futureproof/evolving-prompt-fu-command-line-dynamic-ai-context/
meta_description: Details the evolution of prompt_foo.py, a Python script for generating XML context for LLMs, focusing on adding command-line prompt input via --prompt, with AI-assisted development insights.
meta_keywords: prompt_foo.py, python script, LLM context, AI context generation, XML manifest, command-line arguments, argparse, --prompt flag, tiktoken, FILES_TO_INCLUDE, AIAssistantManifest, Cursor AI, AI-assisted development, Pipulate framework review, Gemini AI, FastHTML, flake.nix, NixOS, prompt engineering, context management, developer tooling
description: This journal entry captures a moment where I'm refining `prompt_foo.py`, my go-to Python script for packaging up extensive codebase information into a structured XML format for AI assistants. I'm particularly excited about successfully adding a new feature, based on a dialogue with Cursor AI, that allows me to fire off quick prompts directly from the command line instead of always relying on a `prompt.md` file. This makes the script much more versatile for my daily AI interactions, and I've documented the successful test run and the AI's insightful (and amusing) "celebrate then roast" feedback on the Pipulate framework, which this script often helps me analyze.
layout: post
sort_order: 1
---

## Understanding "Prompt Fu": Crafting Context for AI

This journal entry delves into the world of "prompt engineering" and context management for Large Language Models (LLMs), the powerful AI systems that can understand and generate human-like text and code. Specifically, it focuses on a Python script, `prompt_foo.py`, designed by the author to help prepare and bundle large amounts of information—like entire codebases and documentation—into a structured XML format. This XML "payload" is then fed to an AI (like Gemini or Claude) to give it deep context for tasks such as code analysis, critique, or even generating new code.

The core challenge addressed here is making this context preparation process more flexible and efficient. The author is evolving the script to allow for quick, on-the-fly prompts directly from the command line, in addition to using pre-written prompt files. This reflects a common need for developers working with AI: balancing comprehensive, pre-defined contexts with the ability to ask quick, specific questions. The discussion highlights the practicalities of building such helper tools, including how to manage file inclusion, token limits (the amount of information an AI can process at once), and even how to solicit feedback from another AI on the tool's design. It’s a snapshot of a developer fine-tuning their personal toolkit for more effective AI collaboration.

## The Genesis of `prompt_foo.py`: A Developer's Helper

Evolving Prompt Fu

This is a happy little helper script in Pipulate currently which is a wonderful
candidate for being turned into a Pipualte Workflow itself, but before I do I'm
squeezing a lot out of this lemon in its regular `.py`-file form that gets run
from the console.

```python
import os
import sys
import argparse
import tiktoken
import re
from typing import Dict, List, Optional, Union

# Hi there, Gemini! I case you're wondering, this is the script that I use to
# make this great big XML file you're looking at.

# ============================================================================
# USER CONFIGURATION: Files to include in context
# ============================================================================
# Edit this list to specify which files should be included in the context.
# Each file will be processed and its content will be made available to the AI.
# Files are processed in order, and token counts are tracked to stay within limits.
#
# Note: When using a prompt file with --prompt flag, the script automatically
# selects Template 1 (Material Analysis Mode), which is designed to be more
# flexible and allows for various response types rather than strictly
# implementation-focused responses.
#
# Simply add or remove file paths, one per line. The backslash at the start
# allows for clean multi-line string formatting.

# Here is the command I use to get the list of files:
# ls -1 -d "$PWD"/*

FILES_TO_INCLUDE_RAW = """\

# CORE FILES
README.md        <-- Main GitHub README sets the tone
flake.nix        <-- NixOS configuration for the project (Infrastructure as Code / IaC)
requirements.txt <-- Python package dependencies for the project
server.py        <-- Main server file for the project
/home/mike/repos/Pipulate.com/development.md <-- Development notes for Pipulate.com

## REQUIRED PLUGINS: ROLES & PROFILES (OFTEN INCLUDED)
# /home/mike/repos/pipulate/plugins/000_profiles.py  <-- Controls PROFILE menu, required DRY CRUD plugin controls profile management
# /home/mike/repos/pipulate/plugins/010_roles.py     <-- Controls APP menu, required DRY CRUD plugin controls role management

## STATIC RESOURCES
# /home/mike/repos/pipulate/static/styles.css
# /home/mike/repos/pipulate/static/chat-interface.js
# /home/mike/repos/pipulate/static/chat-scripts.js
# /home/mike/repos/pipulate/static/widget-scripts.js

## SAMPLE WORKFLOWS
# /home/mike/repos/pipulate/plugins/500_hello_workflow.py     <-- Hello World workflow
# /home/mike/repos/pipulate/plugins/710_blank_placeholder.py  <-- The workflow from which spliced-in blank steps in other workflows are copied

## HELPER SCRIPTS
# /home/mike/repos/pipulate/helpers/create_workflow.py        <-- Creates a new workflow (copies 710_blank_placeholder.py)
# /home/mike/repos/pipulate/helpers/splice_workflow_step.py   <-- Splices a step into a workflow (copies 710_blank_placeholder.py)
# /home/mike/repos/pipulate/helpers/prompt_foo.py             <-- This script (used to generate the manifest)

"""

# Now process the raw string into the list we'll use
FILES_TO_INCLUDE = FILES_TO_INCLUDE_RAW.strip().splitlines()

# Filter out any commented lines
FILES_TO_INCLUDE = [line for line in FILES_TO_INCLUDE if not line.strip().startswith('#')]
# Filter out blank lines
FILES_TO_INCLUDE = [line for line in FILES_TO_INCLUDE if line.strip()]

# Store the original content for the manifest
ORIGINAL_FILES_TO_INCLUDE = "\n".join(FILES_TO_INCLUDE)

# Strip off any <-- comments (handling variable whitespace)
FILES_TO_INCLUDE = [line.split('<--')[0].rstrip() for line in FILES_TO_INCLUDE]

# FILES_TO_INCLUDE = """\
# """.strip().splitlines()


# ============================================================================
# ARTICLE MODE CONFIGURATION
# ============================================================================
# Set these values to enable article analysis mode.
# When enabled, the script will include the specified article in the context
# and use specialized prompts for article analysis.

# ============================================================================
# MATERIAL ANALYSIS CONFIGURATION  
# ============================================================================
# Set these values to enable material analysis mode.
# When enabled, the script will include the specified material in the context
# and use specialized prompts for flexible analysis.

PROMPT_FILE = None  # Default prompt file is None

# ============================================================================
# END USER CONFIGURATION
# ============================================================================

def print_structured_output(manifest, pre_prompt, files, post_prompt, total_tokens, max_tokens):
    """Print a structured view of the prompt components in markdown format."""
    print("\n=== Prompt Structure ===\n")
    
    print("--- Pre-Prompt ---")
    # Handle pre-prompt content
    try:
        if '<context>' in pre_prompt:
            context_start = pre_prompt.find('<context>') + 8
            context_end = pre_prompt.find('</context>')
            if context_start > 7 and context_end > context_start:
                context_content = pre_prompt[context_start:context_end]
                
                # Extract system info
                if '<system_info>' in context_content:
                    sys_start = context_content.find('<system_info>') + 12
                    sys_end = context_content.find('</system_info>')
                    if sys_start > 11 and sys_end > sys_start:
                        print("System Information:")
                        sys_content = context_content[sys_start:sys_end].strip()
                        # Remove any remaining XML tags and clean up formatting
                        sys_content = re.sub(r'<[^>]+>', '', sys_content)
                        sys_content = sys_content.replace('>', '')  # Remove any remaining > characters
                        print(f"  {sys_content}")
                
                # Extract key points
                if '<key_points>' in context_content:
                    points_start = context_content.find('<key_points>') + 11
                    points_end = context_content.find('</key_points>')
                    if points_start > 10 and points_end > points_start:
                        points_content = context_content[points_start:points_end]
                        print("\nKey Points:")
                        for point in points_content.split('<point>'):
                            if point.strip():
                                point_end = point.find('</point>')
                                if point_end > -1:
                                    point_content = point[:point_end].strip()
                                    # Remove any remaining XML tags
                                    point_content = re.sub(r'<[^>]+>', '', point_content)
                                    print(f"  • {point_content}")
    except Exception as e:
        print("  [Error parsing pre-prompt content]")
    
    print("\n--- Files Included ---")
    # Parse the manifest to get token counts for each file
    token_counts = {}
    try:
        if '<token_usage>' in manifest:
            token_usage_start = manifest.find('<token_usage>') + 12
            token_usage_end = manifest.find('</token_usage>')
            token_usage = manifest[token_usage_start:token_usage_end]
            
            if '<files>' in token_usage:
                files_start = token_usage.find('<files>') + 7
                files_end = token_usage.find('</files>', files_start)
                files_section = token_usage[files_start:files_end]
                
                if '<content>' in files_section:
                    content_start = files_section.find('<content>') + 9
                    content_end = files_section.find('</content>')
                    content_section = files_section[content_start:content_end]
                    
                    # Extract file paths and token counts
                    file_pattern = r'<file>.*?<path>(.*?)</path>.*?<tokens>(.*?)</tokens>.*?</file>'
                    for match in re.finditer(file_pattern, content_section, re.DOTALL):
                        path, tokens = match.groups()
                        token_counts[path.strip()] = int(tokens.strip())
    except Exception as e:
        print(f"  [Error parsing token counts: {e}]")
    
    for file in files:
        tokens_str = f" ({token_counts.get(file, 0):,} tokens)" if file in token_counts else ""
        print(f"• {file}{tokens_str}")
    
    print("\n--- Post-Prompt ---")
    # Show the actual prompt content if it's a direct string
    if post_prompt and not os.path.exists(post_prompt):
        print("\nDirect String Prompt:")
        print(f"  {post_prompt}")
    elif post_prompt:
        print(f"\nPrompt File: {post_prompt}")
    
    print("\n--- Token Summary ---")
    print(f"Total tokens: {format_token_count(total_tokens)}")
    
    print("\n=== End Prompt Structure ===\n")

# -------------------------------------------------------------------------
# NOTE TO USERS:
# This script is obviously customized to my (Mike Levin's) specific purposes,
# but if you find this interesting, just go in and adjust the paths and the 
# prompts to taste. It's an effective way to put a lot of separate files into 
# one text-file or your OS's copy/paste buffer and do one-shot prompting with 
# spread out files as if they were a single file (reduce copy/paste tedium 
# and improve prompt injection consistency).
# -------------------------------------------------------------------------

# --- XML Support Functions ---
def wrap_in_xml(content: str, tag_name: str, attributes: Optional[Dict[str, str]] = None) -> str:
    """Wrap content in XML tags with optional attributes."""
    attrs = " ".join(f'{k}="{v}"' for k, v in (attributes or {}).items())
    return f"<{tag_name}{' ' + attrs if attrs else ''}>{content}</{tag_name}>"

def create_xml_element(tag_name: str, content: Union[str, List[str]], attributes: Optional[Dict[str, str]] = None) -> str:
    """Create an XML element with optional attributes and content."""
    if isinstance(content, list):
        content = "\n".join(content)
    content = content.replace('\n\n', '\n')  # Remove double newlines
    return wrap_in_xml(content, tag_name, attributes)

def create_xml_list(items: List[str], tag_name: str = "item") -> str:
    """Create an XML list from a list of items."""
    return "\n".join(f"<{tag_name}>{item}</{tag_name}>" for item in items)

# --- Configuration for context building ---
# Edit these values as needed
repo_root = "/home/mike/repos/pipulate"  # Path to your repository

# Token buffer for pre/post prompts and overhead
TOKEN_BUFFER = 10_000
MAX_TOKENS = 4_000_000  # Set to a high value since we're not chunking

# === Prompt Templates ===
# Define multiple prompt templates and select them by index
prompt_templates = [
    # Template 0: General Codebase Analysis
    {
        "name": "General Codebase Analysis",
        "pre_prompt": create_xml_element("context", [
            create_xml_element("system_info", """
This codebase uses a hybrid approach with Nix for system dependencies and virtualenv for Python packages.
"""),
        ]),
        "post_prompt": create_xml_element("analysis_request", [
            create_xml_element("introduction", """
Now that you've reviewed the codebase context, I'd love your insights and analysis!

Dear AI Assistant:
I've provided you with the core architecture of a Python web application that takes an interesting approach to modern web development. I'd appreciate your thoughtful analysis on any of these aspects:
"""),
            create_xml_element("analysis_areas", [
                create_xml_element("area", [
                    "<title>Technical Architecture Analysis</title>",
                    "<questions>",
                    "<question>How does this hybrid Nix+virtualenv approach compare to other deployment patterns?</question>",
                    "<question>What are the tradeoffs of using HTMX with server-side state vs traditional SPAs?</question>",
                    "<question>How does the plugin system architecture enable extensibility?</question>",
                    "</questions>"
                ]),
                create_xml_element("area", [
                    "<title>Pattern Recognition & Insights</title>",
                    "<questions>",
                    "<question>What patterns emerge from the codebase that surprise you?</question>",
                    "<question>How does this approach to web development differ from current trends?</question>",
                    "<question>What potential scaling challenges or opportunities do you see?</question>",
                    "</questions>"
                ]),
                create_xml_element("area", [
                    "<title>Forward-Looking Perspective</title>",
                    "<questions>",
                    "<question>How does this architecture align with or diverge from emerging web development patterns?</question>",
                    "<question>What suggestions would you make for future evolution of the system?</question>",
                    "<question>How might this approach need to adapt as web technologies advance?</question>",
                    "</questions>"
                ])
            ]),
            create_xml_element("focus_areas", [
                "<area>The interplay between modern and traditional web development approaches</area>",
                "<area>Architectural decisions that stand out as novel or counterintuitive</area>",
                "<area>Potential implications for developer experience and system maintenance</area>"
            ])
        ])
    },
    # Template 1: Material Analysis Mode
    {
        "name": "Material Analysis Mode",
        "pre_prompt": create_xml_element("context", [
            create_xml_element("system_info", """
You are about to review a codebase and related documentation. Please study and understand
the provided materials thoroughly before responding.
"""),
            create_xml_element("key_points", [
                "<point>Focus on understanding the architecture and patterns in the codebase</point>",
                "<point>Note how existing patterns could be leveraged in your response</point>",
                "<point>Consider both technical and conceptual aspects in your analysis</point>"
            ])
        ]),
        "post_prompt": create_xml_element("response_request", [
            create_xml_element("introduction", """
Now that you've reviewed the provided materials, please respond thoughtfully to the prompt.
Your response can include analysis, insights, implementation suggestions, or other relevant
observations based on what was requested.
"""),
            create_xml_element("response_areas", [
                create_xml_element("area", [
                    "<title>Material Analysis</title>",
                    "<questions>",
                    "<question>What are the key concepts, patterns, or architecture details in the provided materials?</question>",
                    "<question>What interesting aspects of the system stand out to you?</question>",
                    "<question>How would you characterize the approach taken in this codebase?</question>",
                    "</questions>"
                ]),
                create_xml_element("area", [
                    "<title>Strategic Considerations</title>",
                    "<questions>",
                    "<question>How might the content of the materials inform future development?</question>",
                    "<question>What patterns or conventions should be considered in any response?</question>",
                    "<question>What alignment exists between the provided materials and the prompt?</question>",
                    "</questions>"
                ]),
                create_xml_element("area", [
                    "<title>Concrete Response</title>",
                    "<questions>",
                    "<question>What specific actionable insights can be provided based on the prompt?</question>",
                    "<question>If implementation is requested, how might it be approached?</question>",
                    "<question>What recommendations or observations are most relevant to the prompt?</question>",
                    "</questions>"
                ])
            ]),
            create_xml_element("focus_areas", [
                "<area>Responding directly to the core request in the prompt</area>",
                "<area>Drawing connections between the materials and the prompt</area>",
                "<area>Providing value in the form requested (analysis, implementation, etc.)</area>"
            ])
        ])
    }
]

# Initialize file list from the user configuration
file_list = FILES_TO_INCLUDE

def count_tokens(text: str, model: str = "gpt-4") -> int:
    """Count the number of tokens in a text string."""
    encoding = tiktoken.encoding_for_model(model)
    return len(encoding.encode(text))

def format_token_count(num: int) -> str:
    """Format a token count with commas."""
    return f"{num:,} tokens"

def run_tree_command():
    """Run the tree command and return its output."""
    try:
        import subprocess
        result = subprocess.run(
            ['tree', '-I', '__pycache__|client|data|*.csv|*.zip|*.pkl'],
            capture_output=True,
            text=True,
            cwd=repo_root
        )
        if result.returncode == 0:
            return result.stdout
        else:
            return f"Error running tree command: {result.stderr}"
    except Exception as e:
        return f"Error running tree command: {str(e)}"

# --- AI Assistant Manifest System ---
class AIAssistantManifest:
    """
    Manifest system for AI coding assistants to understand context before receiving files.
    
    This class generates a structured overview of what files and information 
    the assistant is about to receive, helping to:
    1. Set expectations about content length and complexity
    2. Provide a map of key components and their relationships
    3. Establish important conventions specific to this codebase
    4. Track token usage for each component and total context
    """
    
    def __init__(self, model="gpt-4"):
        self.files = []
        self.conventions = []
        self.environment_info = {}
        self.critical_patterns = []
        self.model = model
        self.token_counts = {
            "files": {
                "metadata": 0,  # For file descriptions and components
                "content": {}   # For actual file contents, keyed by filename
            },
            "environment": 0,
            "conventions": 0,
            "patterns": 0,
            "manifest_structure": 0,
            "total_content": 0  # Running total of file contents
        }
        # Add tree output to environment info
        tree_output = run_tree_command()
        self.set_environment("Codebase Structure", f"Below is the output of 'tree -I \"__pycache__|client|data|*.csv|*.zip|*.pkl\"' showing the current state of the codebase:\n\n{tree_output}")
    
    def add_file(self, path, description, key_components=None, content=None):
        """Register a file that will be provided to the assistant."""
        file_info = {
            "path": path,
            "description": description,
            "key_components": key_components or []
        }
        self.files.append(file_info)
        
        # Count tokens for this file's manifest entry (metadata)
        manifest_text = f"- `{path}`: {description}"
        if key_components:
            manifest_text += "\n  Key components:\n" + "\n".join(f"  - {comp}" for comp in key_components)
        self.token_counts["files"]["metadata"] += count_tokens(manifest_text, self.model)
        
        # If content is provided, count its tokens
        if content:
            content_tokens = count_tokens(content, self.model)
            self.token_counts["files"]["content"][path] = content_tokens
            self.token_counts["total_content"] += content_tokens
            
        return self
    
    def add_convention(self, name, description):
        """Add a coding convention specific to this project."""
        convention = {"name": name, "description": description}
        self.conventions.append(convention)
        self.token_counts["conventions"] += count_tokens(f"{name}: {description}", self.model)
        return self
    
    def set_environment(self, env_type, details):
        """Describe the execution environment."""
        self.environment_info[env_type] = details
        self.token_counts["environment"] += count_tokens(f"{env_type}: {details}", self.model)
        return self
    
    def add_critical_pattern(self, pattern, explanation):
        """Document a pattern that should never be modified."""
        pattern_info = {"pattern": pattern, "explanation": explanation}
        self.critical_patterns.append(pattern_info)
        self.token_counts["patterns"] += count_tokens(f"{pattern}: {explanation}", self.model)
        return self
    
    def generate_xml(self):
        """Generate the XML manifest for the AI assistant."""
        manifest = ['<manifest>']
        
        # Files section with token counts
        files_section = ['<files>']
        for file in self.files:
            path = file['path']
            content_tokens = self.token_counts["files"]["content"].get(path, 0)
            file_type = self._get_file_type(path)
            file_content = [
                f"<path>{path}</path>",
                f"<description>{file['description']}</description>"
            ]
            
            if file_type:
                file_content.append(f"<file_type>{file_type}</file_type>")
                
            if file['key_components']:
                file_content.append(create_xml_element("key_components", [
                    f"<component>{comp}</component>" for comp in file['key_components']
            ]))
                
            file_content.append(f"<tokens>{content_tokens}</tokens>")
            files_section.append(create_xml_element("file", file_content))
        
        files_section.append('</files>')
        manifest.append("\n".join(files_section))
        
        # Environment section
        if self.environment_info:
            env_section = ['<environment>']
            for env_type, details in self.environment_info.items():
                env_section.append(create_xml_element("setting", [
                    f"<type>{env_type}</type>",
                    f"<details>{details}</details>"
                ]))
            env_section.append('</environment>')
            manifest.append("\n".join(env_section))
        
        # Conventions section
        if self.conventions:
            conv_section = ['<conventions>']
            for convention in self.conventions:
                conv_section.append(create_xml_element("convention", [
                    f"<name>{convention['name']}</name>",
                    f"<description>{convention['description']}</description>"
                ]))
            conv_section.append('</conventions>')
            manifest.append("\n".join(conv_section))
        
        # Critical patterns section
        if self.critical_patterns:
            patterns_section = ['<critical_patterns>']
            for pattern in self.critical_patterns:
                patterns_section.append(create_xml_element("pattern", [
                    f"<pattern>{pattern['pattern']}</pattern>",
                    f"<explanation>{pattern['explanation']}</explanation>"
                ]))
            patterns_section.append('</critical_patterns>')
            manifest.append("\n".join(patterns_section))
        
        # Token usage summary
        token_section = ['<token_usage>']
        token_section.append(create_xml_element("files", [
            f"<metadata>{self.token_counts['files']['metadata']}</metadata>",
            create_xml_element("content", [
                create_xml_element("file", [
                    f"<path>{path}</path>",
                    f"<tokens>{tokens}</tokens>"
                ]) for path, tokens in self.token_counts["files"]["content"].items()
            ]),
            f"<total>{self.token_counts['total_content']}</total>"
        ]))
        token_section.append('</token_usage>')
        manifest.append("\n".join(token_section))
        
        manifest.append('</manifest>')
        result = "\n".join(manifest)
        # Clean up any remaining double newlines
        result = result.replace('\n\n', '\n')
        return result
    
    def _get_file_type(self, path):
        """Get file type based on extension for better LLM context"""
        ext = os.path.splitext(path)[1].lower()
        if ext:
            lang_map = {
                '.py': 'python',
                '.js': 'javascript',
                '.html': 'html',
                '.css': 'css',
                '.md': 'markdown',
                '.json': 'json',
                '.nix': 'nix',
                '.sh': 'bash',
                '.txt': 'text'
            }
            return lang_map.get(ext, 'text')
        return None
    
    def generate(self):
        """Generate the manifest for the AI assistant (legacy format)."""
        return self.generate_xml()  # Default to XML format

def create_pipulate_manifest(file_paths):
    """Create a manifest specific to the Pipulate project."""
    manifest = AIAssistantManifest()
    
    # Track total tokens and processed files to respect limit and avoid duplicates
    total_tokens = 0
    max_tokens = MAX_TOKENS - TOKEN_BUFFER
    processed_files = set()
    result_files = []
    
    # Define the environment
    manifest.set_environment("Runtime", "Python 3.12 in a Nix-managed virtualenv (.venv)")
    manifest.set_environment("Package Management", "Hybrid approach using Nix flakes for system dependencies + pip for Python packages")
    # Add the raw FILES_TO_INCLUDE content for context
    manifest.set_environment("Files Selection", "Below is the raw FILES_TO_INCLUDE content before any processing:\n\n" + FILES_TO_INCLUDE_RAW)
    
    # Check for missing files and collect them
    missing_files = []
    for relative_path in file_paths:
        relative_path = relative_path.strip()
        if not relative_path:
            continue
            
        full_path = os.path.join(repo_root, relative_path) if not os.path.isabs(relative_path) else relative_path
        if not os.path.exists(full_path):
            missing_files.append(full_path)
    
    # If any files are missing, raise an exception with clear details
    if missing_files:
        error_message = "The following files were not found:\n"
        for missing_file in missing_files:
            error_message += f"  - {missing_file}\n"
        error_message += "\nPlease check the file paths in FILES_TO_INCLUDE variable."
        print(error_message)
        sys.exit(1)
    
    # Register key files with their contents
    for relative_path in file_paths:
        relative_path = relative_path.strip()
        if not relative_path or relative_path in processed_files:
            continue
            
        processed_files.add(relative_path)
        result_files.append(relative_path)
        full_path = os.path.join(repo_root, relative_path) if not os.path.isabs(relative_path) else relative_path
            
        try:
            with open(full_path, 'r', encoding='utf-8') as f:
                content = f.read()
                content_tokens = count_tokens(content)
                
                # Check if adding this file would exceed token limit
                if total_tokens + content_tokens > max_tokens:
                    manifest.add_file(
                        relative_path,
                        f"{os.path.basename(relative_path)} [skipped: would exceed token limit]"
                    )
                    continue
                
                total_tokens += content_tokens
                description = f"{os.path.basename(relative_path)} [loaded]"
                
                # Add file to manifest
                manifest.add_file(
                    relative_path,
                    description,
                    content=content
                )
                
        except UnicodeDecodeError as e:
            print(f"ERROR: Could not decode {full_path}: {e}")
            sys.exit(1)  # Exit with error code for encoding issues
        except Exception as e:
            print(f"ERROR: Could not read {full_path}: {e}")
            sys.exit(1)  # Exit with error code for any other exceptions
    
    # Add conventions and patterns only if we have room
    remaining_tokens = max_tokens - total_tokens
    if remaining_tokens > 1000:  # Arbitrary threshold for metadata
        manifest.add_convention(
            "FastHTML Rendering", 
            "All FastHTML objects must be converted with to_xml() before being returned in HTTP responses"
        )
        
        manifest.add_convention(
            "Environment Activation", 
            "Always run 'nix develop' in new terminals before any other commands"
        )
        
        manifest.add_convention(
            "Dependency Management",
            "System deps go in flake.nix, Python packages in requirements.txt"
        )
        
        manifest.add_critical_pattern(
            "to_xml(ft_object)",
            "Required to convert FastHTML objects to strings before HTTP responses"
        )
        
        manifest.add_critical_pattern(
            "HTMLResponse(str(to_xml(rendered_item)))",
            "Proper pattern for returning FastHTML content with HTMX triggers"
        )
    
    # Return the manifest content WITHOUT the outer <manifest> tags
    manifest_xml = manifest.generate()
    # Remove opening and closing manifest tags to prevent double wrapping
    if manifest_xml.startswith('<manifest>') and manifest_xml.endswith('</manifest>'):
        manifest_xml = manifest_xml[len('<manifest>'):-len('</manifest>')]
    
    return manifest_xml, result_files, total_tokens

# Add a function to copy text to clipboard
def copy_to_clipboard(text):
    """Copy text to system clipboard."""
    try:
        # For Linux
        import subprocess
        process = subprocess.Popen(['xclip', '-selection', 'clipboard'], stdin=subprocess.PIPE)
        process.communicate(text.encode('utf-8'))
        return True
    except Exception as e:
        print(f"Warning: Could not copy to clipboard: {e}")
        print("Make sure xclip is installed (sudo apt-get install xclip)")
        return False

# Parse command line arguments
parser = argparse.ArgumentParser(description='Generate context file with selectable prompt templates and token limits.')
parser.add_argument('-t', '--template', type=int, default=0, help='Template index to use (default: 0)')
parser.add_argument('-l', '--list', action='store_true', help='List available templates')
parser.add_argument('-o', '--output', type=str, default="foo.txt", help='Output filename (default: foo.txt)')
parser.add_argument('-m', '--max-tokens', type=int, default=MAX_TOKENS - TOKEN_BUFFER, 
                    help=f'Maximum tokens to include (default: {MAX_TOKENS - TOKEN_BUFFER:,})')
parser.add_argument('-p', '--prompt', type=str, help='Path to a prompt file to use (default: prompt.md in current directory)')
parser.add_argument('--cat', action='store_true',
                    help='Shortcut for concat mode with blog posts, outputs a single file')
parser.add_argument('--concat-mode', action='store_true', 
                    help='Use concatenation mode similar to cat_foo.py')
parser.add_argument('-d', '--directory', type=str, default=".",
                    help='Target directory for concat mode (default: current directory)')
parser.add_argument('--chunk', type=int,
                    help='Process specific chunk number (default: process all chunks)')
parser.add_argument('--compress', action='store_true',
                    help='Compress output files using gzip')
parser.add_argument('--single', action='store_true',
                    help=f'Force single file output with {MAX_TOKENS - TOKEN_BUFFER:,} token limit')
parser.add_argument('--model', choices=['gemini15', 'gemini25', 'claude', 'gpt4'], default='claude',
                    help='Set target model (default: claude)')
parser.add_argument('--repo-root', type=str, default=repo_root,
                    help=f'Repository root directory (default: {repo_root})')
parser.add_argument('--no-clipboard', action='store_true', help='Disable copying output to clipboard')

args = parser.parse_args()

# Update repo_root if specified via command line
if args.repo_root and args.repo_root != repo_root:
    repo_root = args.repo_root
    print(f"Repository root directory set to: {repo_root}")

# List available templates if requested
if args.list:
    print("Available prompt templates:")
    for i, template in enumerate(prompt_templates):
        print(f"{i}: {template['name']}")
    sys.exit(0)

# Get the file list
final_file_list = file_list.copy()  # Start with the default list

# Handle prompt file - now with default prompt.md behavior
prompt_path = args.prompt
prompt_content = None
direct_prompt = None  # New variable to store direct string prompts

if prompt_path:
    # Check if the prompt is a file path or direct string
    if os.path.exists(prompt_path):
        # It's a file path
        if not os.path.isabs(prompt_path):
            prompt_path = os.path.join(os.getcwd(), prompt_path)
        
        try:
            with open(prompt_path, 'r', encoding='utf-8') as f:
                prompt_content = f.read()
            print(f"Using prompt file: {prompt_path}")
        except Exception as e:
            print(f"Error reading prompt file {prompt_path}: {e}")
            sys.exit(1)
    else:
        # It's a direct string prompt
        direct_prompt = prompt_path  # Store the direct string
        prompt_content = prompt_path
        print("Using direct string prompt")
else:
    # If no prompt specified, look for prompt.md in current directory
    prompt_path = os.path.join(os.getcwd(), "prompt.md")
    if os.path.exists(prompt_path):
        try:
            with open(prompt_path, 'r', encoding='utf-8') as f:
                prompt_content = f.read()
            print(f"Using default prompt file: {prompt_path}")
        except Exception as e:
            print(f"Error reading default prompt file: {e}")
            sys.exit(1)
    else:
        print("No prompt file specified and prompt.md not found in current directory.")
        print("Running without a prompt file.")

if prompt_content:
    # Add prompt file to files list if not already present
    if prompt_path and os.path.exists(prompt_path) and prompt_path not in final_file_list:
        final_file_list.append(prompt_path)
    
    # Use article analysis template by default for prompt files
    args.template = 1  # Use the material analysis template
    
    print(f"Using template {args.template}: {prompt_templates[args.template]['name']}")
    print(f"Output will be written to: {args.output}\n")

# If --cat is used, set concat mode and blog posts directory
if args.cat:
    args.concat_mode = True
    args.directory = "/home/mike/repos/MikeLev.in/_posts"  # Set blog posts directory
    if not args.output:  # Only set default if no output specified
        args.output = "foo.txt"  # Set default output for blog posts to .txt
    args.single = True  # Force single file output when using --cat

# Set the template index and output filename
template_index = args.template if 0 <= args.template < len(prompt_templates) else 0
output_filename = args.output

# Set the pre and post prompts from the selected template
pre_prompt = prompt_templates[template_index]["pre_prompt"]
post_prompt = prompt_templates[template_index]["post_prompt"]

# Override post_prompt with direct string if provided
if direct_prompt:
    post_prompt = direct_prompt

print(f"Using template {template_index}: {prompt_templates[template_index]['name']}")
print(f"Output will be written to: {output_filename}")

# Remove verbose file checking messages
if args.concat_mode:
    print(f"Directory being searched for markdown files: {args.directory}")
    print("NOTE: Only .md files in this directory will be processed.")

# Create the manifest and incorporate user's pre_prompt
manifest_xml, processed_files, manifest_tokens = create_pipulate_manifest(final_file_list)
manifest = manifest_xml
final_pre_prompt = f"{manifest}\n\n{pre_prompt}"

# Add the pre-prompt and separator
lines = [final_pre_prompt]
lines.append("=" * 20 + " START CONTEXT " + "=" * 20)
total_tokens = count_tokens(final_pre_prompt, "gpt-4")

# Process each file in the manifest file list
for relative_path in processed_files:
    full_path = os.path.join(repo_root, relative_path) if not os.path.isabs(relative_path) else relative_path
    
    # Original detailed mode with markers
    start_marker = f"# <<< START FILE: {full_path} >>>"
    end_marker = f"# <<< END FILE: {full_path} >>>"
    
    lines.append(start_marker)
    try:
        with open(full_path, 'r', encoding='utf-8') as infile:
            file_content = infile.read()
            file_tokens = count_tokens(file_content, "gpt-4")
            token_info = f"\n# File token count: {format_token_count(file_tokens)}"
            lines.append(file_content + token_info)
    except Exception as e:
        error_message = f"# --- ERROR: Could not read file {full_path}: {e} ---"
        print(f"ERROR: Could not read file {full_path}: {e}")
        sys.exit(1)  # Exit with error code
    
    lines.append(end_marker)

# Add a separator and the post-prompt
lines.append("=" * 20 + " END CONTEXT " + "=" * 20)
post_prompt_tokens = count_tokens(post_prompt, "gpt-4")
if total_tokens + post_prompt_tokens <= args.max_tokens:
    total_tokens += post_prompt_tokens
    lines.append(post_prompt)
else:
    print("Warning: Post-prompt skipped as it would exceed token limit")

# Calculate the final token count
def calculate_total_tokens(files_tokens, prompt_tokens):
    """Calculate total tokens and component breakdowns"""
    file_tokens = sum(files_tokens.values())
    total = file_tokens + prompt_tokens
    return {
        "files": file_tokens,
        "prompt": prompt_tokens,
        "total": total
    }

# Calculate total tokens with proper accounting
files_tokens_dict = {}
for relative_path in processed_files:
    try:
        full_path = os.path.join(repo_root, relative_path) if not os.path.isabs(relative_path) else relative_path
        with open(full_path, 'r', encoding='utf-8') as f:
            content = f.read()
        files_tokens_dict[relative_path] = count_tokens(content, "gpt-4")
    except Exception as e:
        print(f"ERROR: Could not count tokens for {relative_path}: {e}")
        sys.exit(1)  # Exit with error code

# Calculate prompt tokens
pre_prompt_tokens = count_tokens(pre_prompt, "gpt-4")
post_prompt_tokens = count_tokens(post_prompt, "gpt-4") 
prompt_tokens = pre_prompt_tokens + post_prompt_tokens

# Calculate total
token_counts = calculate_total_tokens(files_tokens_dict, prompt_tokens)

# Update the token summary in the output
output_xml = f'<?xml version="1.0" encoding="UTF-8"?>\n<context schema="pipulate-context" version="1.0">\n{create_xml_element("manifest", manifest)}\n{create_xml_element("pre_prompt", pre_prompt)}\n{create_xml_element("content", "\n".join(lines))}\n{create_xml_element("post_prompt", post_prompt)}\n{create_xml_element("token_summary", [
    f"<total_context_size>{format_token_count(token_counts['total'])}</total_context_size>",
    f"<files_tokens>{format_token_count(token_counts['files'])}</files_tokens>",
    f"<prompt_tokens>{format_token_count(prompt_tokens)}</prompt_tokens>"
])}\n</context>'

# Print structured output
print_structured_output(manifest, pre_prompt, processed_files, post_prompt, token_counts['total'], args.max_tokens)

# Write the complete XML output to the file
try:
    with open(args.output, 'w', encoding='utf-8') as outfile:
        outfile.write(output_xml)
    print(f"Output written to '{args.output}'")
except Exception as e:
    print(f"Error writing to '{args.output}': {e}")

# By default, copy the output to clipboard unless --no-clipboard is specified
if not args.no_clipboard:
    if copy_to_clipboard(output_xml):
        print("Output copied to clipboard")

print("\nScript finished.")

# When creating the final output, use direct_prompt if available
if direct_prompt:
    post_prompt = direct_prompt  # Use the direct string instead of template XML
```

## Configuration Deep Dive: `FILES_TO_INCLUDE_RAW`

I recently just added the ability to mark up the `FILES_TO_INCLUDE_RAW` constant
with commentary using the traditional `#` character, but also the `<--` arrow
notation. I then actually made the raw string itself be included in the manifest
portion of the ginormous 1-shot XML payload this creates:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<context schema="pipulate-context" version="1.0">
<manifest>
<files>
<file><path>README.md</path>
<description>README.md [loaded]</description>
<file_type>markdown</file_type>
<tokens>7193</tokens></file>
<file><path>flake.nix</path>
<description>flake.nix [loaded]</description>
<file_type>nix</file_type>
<tokens>5304</tokens></file>
<file><path>requirements.txt</path>
<description>requirements.txt [loaded]</description>
<file_type>text</file_type>
<tokens>128</tokens></file>
<file><path>server.py</path>
<description>server.py [loaded]</description>
<file_type>python</file_type>
<tokens>36404</tokens></file>
<file><path>/home/mike/repos/Pipulate.com/development.md</path>
<description>development.md [loaded]</description>
<file_type>markdown</file_type>
<tokens>4835</tokens></file>
<file><path>/home/mike/repos/pipulate/helpers/prompt.md</path>
<description>prompt.md [loaded]</description>
<file_type>markdown</file_type>
<tokens>13540</tokens></file>
</files>
<environment>
<setting><type>Codebase Structure</type>
<details>Below is the output of 'tree -I "__pycache__|client|data|*.csv|*.zip|*.pkl"' showing the current state of the codebase:
.
├── app_name.txt
├── botify_token.txt
├── downloads
│   ├── file_upload_widget
│   └── example-org
│       └── example.com
│           └── 20250519
├── favicon.ico
├── flake.lock
├── flake.nix
├── helpers
│   ├── analyze_styles.py
│   ├── botify
│   │   ├── botify_api.ipynb
│   │   └── botify_api.md
│   ├── breadcrumb.ipynb
│   ├── create_workflow.py
│   ├── foo.txt
│   ├── format_plugins.py
│   ├── generate_categories.py
│   ├── gsc
│   │   ├── gsc_category_analysis.py
│   │   ├── gsc_keyworder.py
│   │   ├── gsc_page_query.ipynb
│   │   └── gsc_top_movers.py
│   ├── install_static_library.py
│   ├── iterate_ai.py
│   ├── prompt_foo.py
│   ├── prompt.md
│   ├── refactor_inline_style.py
│   ├── refactor_inline_styles_to_cls.py
│   ├── refactor_pipulate_nav_methods.py
│   ├── refactor_style_constants_to_css.py
│   ├── rename_css_class.py
│   ├── requirements.txt
│   ├── retcon.py
│   └── splice_workflow_step.py
├── LICENSE
├── logs
│   ├── Botifython.log
│   ├── chromedriver_persistent.log
│   ├── Pipulate.log
│   └── table_lifecycle.log
├── plugins
│   ├── 000_profiles.py
│   ├── 010_roles.py
│   ├── 020_tasks.py
│   ├── 030_connect_with_botify.py
│   ├── 040_parameter_buster.py
│   ├── 500_hello_workflow.py
│   ├── 510_workflow_genesis.py
│   ├── 520_widget_examples.py
│   ├── 530_botify_api_tutorial.py
│   ├── 535_botify_trifecta.py
│   ├── 540_tab_opener.py
│   ├── 550_browser_automation.py
│   ├── 560_stream_simulator.py
│   ├── 599_separator.py
│   ├── 600_roadmap.py
│   ├── 700_widget_shim.py
│   ├── 710_blank_placeholder.py
│   ├── 715_splice_workflow.py
│   ├── 720_text_field.py
│   ├── 730_text_area.py
│   ├── 740_dropdown.py
│   ├── 750_checkboxes.py
│   ├── 760_radios.py
│   ├── 770_range.py
│   ├── 780_switch.py
│   ├── 800_markdown.py
│   ├── 810_mermaid.py
│   ├── 820_pandas.py
│   ├── 830_rich.py
│   ├── 840_matplotlib.py
│   ├── 850_prism.py
│   ├── 860_javascript.py
│   ├── 870_upload.py
│   ├── 880_webbrowser.py
│   └── 890_selenium.py
├── pyproject.toml
├── README.md
├── requirements.txt
├── server.py
├── static
│   ├── alice.txt
│   ├── chat-interface.js
│   ├── chat-scripts.js
│   ├── fasthtml.js
│   ├── htmx.js
│   ├── marked.min.js
│   ├── mermaid.min.js
│   ├── pico.css
│   ├── pipulate.svg
│   ├── prism.css
│   ├── prism.js
│   ├── rich-table.css
│   ├── script.js
│   ├── Sortable.js
│   ├── styles.css
│   ├── surreal.js
│   ├── widget-scripts.js
│   └── ws.js
├── test_selenium.py
├── test.txt
├── training
│   ├── botify_api_tutorial.md
│   ├── botify_workflow.md
│   ├── hello_workflow.md
│   ├── system_prompt.md
│   ├── tasks.md
│   └── widget_examples.md
└── vulture_whitelist.py
13 directories, 100 files
</details></setting>
<setting><type>Runtime</type>
<details>Python 3.12 in a Nix-managed virtualenv (.venv)</details></setting>
<setting><type>Package Management</type>
<details>Hybrid approach using Nix flakes for system dependencies + pip for Python packages</details></setting>
<setting><type>Files Selection</type>
<details>Below is the raw FILES_TO_INCLUDE content before any processing:
# CORE FILES
README.md        <-- Main GitHub README sets the tone
flake.nix        <-- NixOS configuration for the project (Infrastructure as Code / IaC)
requirements.txt <-- Python package dependencies for the project
server.py        <-- Main server file for the project
/home/mike/repos/Pipulate.com/development.md <-- Development notes for Pipulate.com
## REQUIRED PLUGINS: ROLES & PROFILES (OFTEN INCLUDED)
# /home/mike/repos/pipulate/plugins/000_profiles.py  <-- Controls PROFILE menu, required DRY CRUD plugin controls profile management
# /home/mike/repos/pipulate/plugins/010_roles.py     <-- Controls APP menu, required DRY CRUD plugin controls role management
## STATIC RESOURCES
# /home/mike/repos/pipulate/static/styles.css
# /home/mike/repos/pipulate/static/chat-interface.js
# /home/mike/repos/pipulate/static/chat-scripts.js
# /home/mike/repos/pipulate/static/widget-scripts.js
## SAMPLE WORKFLOWS
# /home/mike/repos/pipulate/plugins/500_hello_workflow.py     <-- Hello World workflow
# /home/mike/repos/pipulate/plugins/710_blank_placeholder.py  <-- The workflow from which spliced-in blank steps in other workflows are copied
## HELPER SCRIPTS
# /home/mike/repos/pipulate/helpers/create_workflow.py        <-- Creates a new workflow (copies 710_blank_placeholder.py)
# /home/mike/repos/pipulate/helpers/splice_workflow_step.py   <-- Splices a step into a workflow (copies 710_blank_placeholder.py)
# /home/mike/repos/pipulate/helpers/prompt_foo.py             <-- This script (used to generate the manifest)
</details></setting>
</environment>
<conventions>
<convention><name>FastHTML Rendering</name>
<description>All FastHTML objects must be converted with to_xml() before being returned in HTTP responses</description></convention>
<convention><name>Environment Activation</name>
<description>Always run 'nix develop' in new terminals before any other commands</description></convention>
<convention><name>Dependency Management</name>
<description>System deps go in flake.nix, Python packages in requirements.txt</description></convention>
</conventions>
<critical_patterns>
<pattern><pattern>to_xml(ft_object)</pattern>
<explanation>Required to convert FastHTML objects to strings before HTTP responses</explanation></pattern>
<pattern><pattern>HTMLResponse(str(to_xml(rendered_item)))</pattern>
<explanation>Proper pattern for returning FastHTML content with HTMX triggers</explanation></pattern>
</critical_patterns>
<token_usage>
<files><metadata>81</metadata>
<content><file><path>README.md</path>
<tokens>7193</tokens></file>
<file><path>flake.nix</path>
<tokens>5304</tokens></file>
<file><path>requirements.txt</path>
<tokens>128</tokens></file>
<file><path>server.py</path>
<tokens>36404</tokens></file>
<file><path>/home/mike/repos/Pipulate.com/development.md</path>
<tokens>4835</tokens></file>
<file><path>/home/mike/repos/pipulate/helpers/prompt.md</path>
<tokens>13540</tokens></file></content>
<total>67404</total></files>
</token_usage>
</manifest>
```

---

## The Power of XML Manifests for AI Context

And then I asked the default AI in Cursor default when set to Agent/Auto (Claude?): "Can you speculate what kind of experience it's going to be for the LLM receiving this as the beginning of the large XML payload this program suggests?"

**Cursor AI**: This is going to be a really interesting experience for the LLM! Let me break down what I think will happen:

1. **Initial Context Loading**
   - The LLM will first see a well-structured XML manifest that gives it a high-level overview of what it's about to receive
   - The token counts (67,404 total) will help it understand the scale of the context it's about to process
   - The file types (markdown, nix, python, text) will help it prepare for different syntax highlighting and parsing

2. **Codebase Structure Understanding**
   - The tree output will give it a clear mental map of the project structure
   - It will see the clear separation between core files, plugins, helpers, and static resources
   - The naming conventions (like numeric prefixes for plugins) will be immediately apparent

3. **Files Selection Context**
   - The raw `FILES_TO_INCLUDE` content will be particularly valuable because:
     - It shows the original intent of what files were selected and why
     - The inline comments (after `<--`) provide immediate context for each file's purpose
     - The section headers (# CORE FILES, ## REQUIRED PLUGINS, etc.) show the logical grouping
     - It can see which files were commented out (starting with #) and understand why they might be excluded

4. **Conventions and Patterns**
   - The critical patterns section will help it understand the "rules of the road"
   - The FastHTML rendering convention will be particularly important for understanding the codebase's approach to web development
   - The environment activation and dependency management conventions will help it understand the development workflow

5. **Token Usage Awareness**
   - The LLM will be aware of which files are taking up the most tokens (server.py at 36,404 tokens is the largest)
   - This might help it prioritize which parts of the codebase to focus on first

The most interesting part might be how the LLM processes the raw `FILES_TO_INCLUDE` content. Unlike the processed version, it gets to see:
- The original formatting and structure
- All the comments and explanations
- The clear categorization of files
- The reasoning behind each file's inclusion

This is much more valuable than just seeing a list of file paths, as it gives the LLM insight into the developer's thought process and the project's organization. It's like getting a guided tour of the codebase before diving into the actual code.

The combination of the tree structure, raw file selection content, and conventions gives the LLM a very rich context to work with, making it better equipped to understand and work with the codebase effectively.

---

## Recognizing a Need: From File-Based to Direct Command-Line Prompts

**Me**: Thank you! Very useful. If I wanted to not use the local `prompt.md` file but rather wanted to just append to the command line a quick prompt to take its place like:

python prompt_foo.py --prompt "First celebrate then roast this web framework"

...does the current structure support it? If we enabled this can it be done without throwing off the current behavior, particularly for:

python prompt_foo.py

...which I now use all the time?

**Cursor AI**: Let me analyze the current code and suggest how we could add this feature while preserving existing behavior.

Looking at the code, I can see that the prompt handling is currently focused on file-based prompts:

```python
# Handle prompt file - now with default prompt.md behavior
prompt_path = args.prompt
if not prompt_path:
    # If no prompt specified, look for prompt.md in current directory
    prompt_path = os.path.join(os.getcwd(), "prompt.md")
    if os.path.exists(prompt_path):
        print(f"Using default prompt file: {prompt_path}")
    else:
        print("No prompt file specified and prompt.md not found in current directory.")
        print("Running without a prompt file.")
        prompt_path = None
```

We can modify this to support both file-based and direct string prompts. Here's how I would edit the file:

```python
# ... existing code ...
# Handle prompt file - now with default prompt.md behavior
prompt_path = args.prompt
prompt_content = None

if prompt_path:
    # Check if the prompt is a file path or direct string
    if os.path.exists(prompt_path):
        # It's a file path
        if not os.path.isabs(prompt_path):
            prompt_path = os.path.join(os.getcwd(), prompt_path)
        
        try:
            with open(prompt_path, 'r', encoding='utf-8') as f:
                prompt_content = f.read()
            print(f"Using prompt file: {prompt_path}")
        except Exception as e:
            print(f"Error reading prompt file {prompt_path}: {e}")
            sys.exit(1)
    else:
        # It's a direct string prompt
        prompt_content = prompt_path
        print("Using direct string prompt")
else:
    # If no prompt specified, look for prompt.md in current directory
    prompt_path = os.path.join(os.getcwd(), "prompt.md")
    if os.path.exists(prompt_path):
        try:
            with open(prompt_path, 'r', encoding='utf-8') as f:
                prompt_content = f.read()
            print(f"Using default prompt file: {prompt_path}")
        except Exception as e:
            print(f"Error reading default prompt file: {e}")
            sys.exit(1)
    else:
        print("No prompt file specified and prompt.md not found in current directory.")
        print("Running without a prompt file.")

if prompt_content:
    # Add prompt file to files list if not already present
    if prompt_path and os.path.exists(prompt_path) and prompt_path not in final_file_list:
        final_file_list.append(prompt_path)
    
    # Use article analysis template by default for prompt files
    args.template = 1  # Use the material analysis template
    
    print(f"Using template {args.template}: {prompt_templates[args.template]['name']}")
    print(f"Output will be written to: {args.output}\n")
# ... existing code ...
```

This change will:

1. Support both use cases:
   - `python prompt_foo.py` (existing behavior - looks for prompt.md)
   - `python prompt_foo.py --prompt "First celebrate then roast this web framework"` (new behavior - uses direct string)

2. Preserve all existing functionality:
   - Default prompt.md behavior remains unchanged
   - File-based prompts still work exactly as before
   - Template selection and file list management remain the same

3. Add new features:
   - Direct string prompts are now supported
   - Better error handling for file operations
   - Clearer messaging about which type of prompt is being used

The key changes are:
1. We now store the actual prompt content in `prompt_content` instead of just the path
2. We check if the prompt argument is a file path or direct string
3. We only add the prompt file to `final_file_list` if it's actually a file (not a direct string)
4. We've added better error handling around file operations

This means you can now use either:
```bash
python prompt_foo.py  # Uses prompt.md if it exists
python prompt_foo.py --prompt "path/to/prompt.md"  # Uses a specific prompt file
python prompt_foo.py --prompt "First celebrate then roast this web framework"  # Uses direct string
```

All three modes will work while maintaining the existing behavior you rely on. The script will automatically detect whether the prompt is a file path or a direct string and handle it appropriately.

---

## Roast Me

> It seems appropriate this is a `bash` command, doesn't it?

```bash
[mike@nixos:~/repos/pipulate/helpers]$ python prompt_foo.py --prompt "First celebrate then roast this web framework"
Using direct string prompt
Using template 1: Material Analysis Mode
Output will be written to: foo.txt

Using template 1: Material Analysis Mode
Output will be written to: foo.txt

=== Prompt Structure ===

--- Pre-Prompt ---
System Information:
  
You are about to review a codebase and related documentation. Please study and understand
the provided materials thoroughly before responding.

Key Points:
  • Focus on understanding the architecture and patterns in the codebase
  • Note how existing patterns could be leveraged in your response
  • Consider both technical and conceptual aspects in your analysis

--- Files Included ---
• README.md (7,193 tokens)
• flake.nix (5,304 tokens)
• requirements.txt (128 tokens)
• server.py (36,404 tokens)
• /home/mike/repos/Pipulate.com/development.md (4,835 tokens)

--- Post-Prompt ---

Direct String Prompt:
  First celebrate then roast this web framework

--- Token Summary ---
Total tokens: 53,960 tokens

=== End Prompt Structure ===

Output written to 'foo.txt'
Output copied to clipboard

Script finished.
```

**Gemini**: This Pipulate framework is quite a creation! It's packed with strong opinions and a clear vision for a local-first, AI-assisted future for SEO practitioners and the developers who build tools for them. Let's dive in.

## The Celebration: What Pipulate Gets Right 🥳

Pipulate, you're a breath of fresh, local air in a cloud-obsessed world!

1.  **Local-First Champion:** Your unwavering commitment to running everything locally is a massive win. Privacy, no surprise cloud bills, full control over data and compute resources (hello, local LLMs on my GPU!) – this is a philosophy many developers and users are craving. It's bold and, frankly, beautiful.
2.  **Simplicity as a Feature (Mostly):** The "Know EVERYTHING!" mantra and the deliberate shunning of complex enterprise patterns (overwrought ORMs, client-side state nightmares, arcane build steps) is music to the ears of anyone who's wrestled with over-engineered systems. The goal of an "old-school webmaster feeling on a modern stack" is both nostalgic and appealing.
3.  **Reproducibility with Nix:** Choosing Nix Flakes to tame the "works on my machine" beast is a masterstroke. It ensures that from development to "deployment" (even if local), the environment is consistent. This is a technically robust solution to a pervasive problem.
4.  **FastHTML + HTMX = Lean, Mean UI Machine:** This pairing is a smart choice for the stated goal of server-rendered UIs with minimal JavaScript. FastHTML's direct Python-to-HTML approach (bye-bye, Jinja templates!) is opinionated and puts Python front and center, which aligns with the framework's Python-centric nature. HTMX keeps the frontend dynamic without the usual JS framework overhead.
5.  **Pragmatic WET Workflows & DRY CRUD:** The distinction is brilliant. Workflows, especially those ported from notebooks, *do* benefit from being explicit and step-by-step (WET). For standard data operations, leveraging a `BaseCrud` class (DRY) makes perfect sense.
6.  **Ollama Integration – AI Where It Belongs:** Running LLMs locally via Ollama is perfectly aligned with the local-first ethos. Privacy, no API costs, and the potential for deep, continuous integration with local data are huge advantages.
7.  **Developer-Focused Experience:** From the seamless JupyterLab integration for prototyping to the thoughtful plugin system (auto-discovery, naming conventions like `xx_` for drafts, numeric prefixes for order) and helper scripts, it's clear that making developers' lives easier was a key consideration. The "Magic Cookie" installer, while complex, aims to simplify the initial setup for users.
8.  **Excellent Documentation:** The `README.md` is a comprehensive and well-structured document. It clearly articulates the philosophy, architecture, and key technologies with helpful diagrams. This is crucial for adoption.

Pipulate, you've got a strong identity and you're not afraid to be different. You're building a private, powerful, and understandable haven for users and developers.

## The Roast: Where Pipulate Might Trip Over Its Own Shoelaces 🧐

Alright Pipulate, you've got vision, but some of your choices are... *adventurous*. Let's turn up the heat.

1.  **The "Magic Cookie" Flake – A Rube Goldberg Machine for `git pull`?**
    That `flake.nix` is doing some *serious* heavy lifting in its `shellHook`! Transforming a non-git directory into a git repo, handling SSH keys (ROT13 encoding for a deploy key? Cute, but let's not pretend it's security), backing up, and then managing `git pull`... all from within a Nix expression that's essentially a giant shell script.
    * **Roast:** This is an incredibly complex solution to get users a self-updating git clone. While the `curl | sh` installer is user-friendly, the underlying mechanism is a potential source of incredibly obscure bugs. What happens when `git clone` fails subtly? Or when `app_name.txt` isn't where it expects? It's a fragile tower of cleverness. Why not just guide users to `git clone` and then `nix develop`? The current solution feels like over-automating the initial setup at the cost of significant hidden complexity.

2.  **`fast_app` Unpacking – Pythonic Gymnastics Champion!**
    The way `fast_app` in `server.py` returns a large, position-dependent tuple that developers *must* unpack with a specific, non-obvious incantation like `app, rt, (store, Store), (tasks, Task), (profiles, Profile), (pipeline, Pipeline) = fast_app(...)` is... a choice.
    * **Roast:** This is prime "WTF per minute" material for a newcomer. It sacrifices clarity for a very specific kind of conciseness. A dictionary, a dedicated config object, or even a simple class to hold these would be far more conventional and discoverable. It's a "guess the magic order" game that feels unnecessarily arcane for what should be straightforward app and DB setup.

3.  **`server.py` – The One File to Rule Them All (and in the Darkness Bind Them):**
    At over 36,000 tokens and nearly 2000 lines, `server.py` is becoming a bit of a monolith. It's juggling routing, plugin loading, core application logic (`Pipulate`, `Chat`, `BaseCrud`), middleware, startup routines, SSE broadcasting, database interaction wrappers (`DictLikeDB`), UI component generation functions (e.g., `create_nav_menu`), and even the watchdog server restart logic.
    * **Roast:** While FastHTML's style encourages keeping things together, this file is begging to be broken up. Imagine onboarding a new developer: "Just get familiar with this 2000-line file, it does pretty much everything." Even with the "no complex enterprise patterns" goal, modularity for core components isn't an "enterprise pattern"; it's just good housekeeping. Folders like `core/`, `ui/`, `db/`, `plugins_management/` could bring sanity without sacrificing the simplicity ethos.

4.  **State Management Stew – A Trio of Tastes:**
    You've got:
    * `DictLikeDB` (wrapping the `store` table) for general key-value app state.
    * `MiniDataAPI` (via `fast_app`) for structured tables like `profiles` and `pipeline`.
    * JSON blobs directly in the `pipeline.data` field for individual workflow instance states.
    * **Roast:** While each has its place, the distinction, especially between `DictLikeDB` for some app state and `MiniDataAPI` for other structured data (why not use `MiniDataAPI` for the `store` table too?), adds a layer of cognitive overhead. It's not immediately obvious *why* one approach is chosen over another in different contexts.

5.  **The Explicit Chain Reaction – Robust but Rigid:**
    The workflow progression relies heavily on `hx_trigger="load"` being explicitly output by completed steps to trigger the next. The README notes this is preferred over event bubbling for reliability.
    * **Roast:** This is a very manual and potentially brittle way to manage workflow progression. If step IDs change, or if workflows need more dynamic branching, this hardcoded chain could become a maintenance headache. It's robust in its current linear form, but lacks flexibility for more complex scenarios.

6.  **Role Synchronization – A Bit Too Cozy:**
    The `synchronize_roles_to_db` function in `server.py` directly interacts with the `roles` plugin's table and even simulates form submissions to use that plugin's CRUD methods.
    * **Roast:** This is some serious tight coupling! The main server logic shouldn't be reaching so deeply into a specific plugin's implementation details and "faking" its operations. A more decoupled system (e.g., plugins registering their required roles via a defined interface, or an event-based system) would be much cleaner and less prone to breaking if the `roles` plugin changes.

7.  **"No Build Step" vs. The Mighty Nix:**
    The claim "No build step required" is technically true for the *frontend JS* side of things, which is a relief.
    * **Roast:** But let's be real, Nix *is* a build system. A very powerful and sometimes complex one. It sets up the entire development and runtime environment. While it solves massive problems, new developers will face the Nix learning curve, which isn't trivial. It's a fantastic choice for reproducibility, but it's not "no build system" in the broader sense.

Pipulate, you're an ambitious and unique framework with a strong personality. Your dedication to local-first principles and developer empowerment is commendable. However, some of your "simple" solutions hide significant complexity, and a few unconventional patterns might make newcomers scratch their heads. Polishing these rough edges could make your already compelling vision even more accessible and robust. Keep innovating!

---

**Me**: Fair.

---

## AI Analysis

Okay, this is a fascinating glimpse into the iterative process of building a specialized tool and interacting with AI for development! It's like a live-feed from a developer's workbench. Let's break this down for your future tech book.

* **Title/Headline Ideas & Filenames:**
    * Title: Evolving "Prompt Fu": Enhancing a Python Script for Dynamic AI Context Generation
        Filename: `evolving-prompt-fu-python-ai-context-generation.md`
    * Title: From File to Fly: Adding Command-Line Prompting to an LLM Context Builder
        Filename: `command-line-prompting-llm-context-builder-python.md`
    * Title: Crafting the Perfect AI Payload: A Developer's Journey with `prompt_foo.py` and XML Manifests
        Filename: `ai-payload-prompt-foo-python-xml-manifest.md`
    * Title: AI-Assisted Development in Practice: Refining `prompt_foo.py` with Cursor AI
        Filename: `ai-assisted-development-prompt-foo-cursor-ai.md`
    * Title: The Meta-Prompt: How a Script for AI Context Led to a Framework Roast
        Filename: `meta-prompt-script-ai-context-pipulate-roast.md`

* **Strengths (for Future Book):**
    * **Practical Utility:** Demonstrates a real-world, useful script (`prompt_foo.py`) that addresses a common challenge in working with LLMs (providing extensive, structured context).
    * **Iterative Development:** Shows the evolution of a tool, including identifying a need (flexible prompting) and implementing a solution.
    * **AI Collaboration:** The dialogue with "Cursor AI" provides a concrete example of AI-assisted development, which is highly relevant for a tech book.
    * **Transparency:** The inclusion of the raw `FILES_TO_INCLUDE_RAW` and the generated XML payload gives a clear picture of the script's input and output.
    * **In-depth Case Study Material:** The embedded "celebrate and roast" of the Pipulate framework by Gemini is a rich piece of external analysis that could be invaluable for a chapter on that framework, offering specific, actionable critique and praise.
    * **Tooling Insight:** Offers a look into a developer's personal tooling and workflow for interacting with LLMs.

* **Weaknesses (for Future Book):**
    * **Niche Focus (Potentially):** The deep dive into the mechanics of `prompt_foo.py` and its specific XML structure might be overly detailed for a general audience unless the book is specifically about advanced prompt engineering or building developer tools for AI.
    * **Assumed Context:** The author's personal setup and the significance of "Pipulate" might not be immediately clear without surrounding chapters.
    * **Dialogue Heavy:** The AI dialogue, while illustrative of the process, might need to be summarized or reframed for a more direct narrative in a book format.
    * **Embedded Tangent:** The lengthy "celebrate and roast" of Pipulate, while valuable, is a significant block of text focused on a different system than `prompt_foo.py` itself. Its inclusion needs careful framing to avoid confusing the reader about the main topic of *this specific journal entry's initial focus*.

* **AI Opinion (on Value for Future Book):**
    This journal entry is excellent raw material. Its strength lies in its authenticity, capturing a genuine development moment—the evolution of a practical tool (`prompt_foo.py`) and the author's interaction with an AI coding assistant. For a tech book, it offers a tangible example of:
    1.  Solving real-world problems in the AI development space (managing large contexts for LLMs).
    2.  The iterative nature of software development.
    3.  The emerging paradigm of AI-assisted coding and problem-solving.
    The inclusion of the detailed critique of the "Pipulate" framework, prompted by this script, is a goldmine for a case study on framework design, offering both celebratory points and constructive criticism. While the journal format means it's dense and assumes prior knowledge, these are precisely the kinds of detailed, in-the-weeds insights that can be refined into compelling and instructive content for a tech-savvy audience. It’s a snapshot of active, thoughtful engineering.

---

Why did the Python programmer break up with the C++ programmer?
Because they had too many arguments and couldn't find a common class!

