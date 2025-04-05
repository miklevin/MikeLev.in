---
title: "Stop Copy-Pasting: A Simple Python Script for Managing LLM Code Context"
permalink: /futureproof/copy-pasting-llm-context/
description: To tackle the challenge of feeding large code contexts from a repository into LLMs without endless copy-pasting, I conceived a simple Python script, context_foo.py. Working iteratively with Gemini, we developed this script to concatenate specified files, adding custom prompts and clear markers, into a single foo.txt file easily usable as LLM input or attachment. This process not only yielded a practical tool tailored to my workflow, including my preference for an easily editable file list format, but also provided insights into effectively collaborating with AI for utility development.
layout: post
sort_order: 3
---

So you want to prompt an LLM to provide you some coding assistance, but there's a whole git repo of potential context to consider.  You may or may not be using Cursor, Windsurf, Cline, Augment or one of the many Web-based UIs like ChatGPT, DeepSeek or Gemini directly. How do you get all that repo code in context. That's an awful lot of copy/pasting!

No worries! You can list that files, can't you? Well if you can list that files, you can shove all their context into a single `foo.txt` file for sending it as an attachment, or just to make copy/pasting the whole thing easier. 

```python
# context_foo.py

repo_root = "/home/mike/repos/bar"

pre_prompt = "Prefacing stuff about what you're about to see."

file_list = """
server.py
README.md
.cursorrules
plugins/tasks.py
training/tasks.md
""".split("\n")[1:-1]

post_prompt = (
    "Reinforce whatever was said in the prefacing prompt, "
    "plus explicit instructions of what's expected next."
)

```

---

## Turns Above Concept Into Prompt

> What's fascinating is how the development process has evolved - we can now
> iteratively refine ideas through dialogue with AI tools, which not only provide
> feedback but can actively assist in implementation. The line between purely
> thinking about doing and actually doing is blurring.

**Me**: Given this set up, give me the python that will create a single `foo.txt` which contains the appended contents of the listed files. Use python comments to clearly demark where one file ends and the next one begins, including full-path file names. Also consider ways to put it in the native operating system's copy buffer at the end of the process.

**Gemini**: Okay, here's the Python script that builds upon your context_foo.py setup to generate the foo.txt file with the combined contents and markers. It also includes the section on copying the result to the clipboard.

## context_foo.py - Enhanced to generate foo.txt and handle clipboard

```python
import os
import sys # Needed for platform check for clipboard commands

# --- Configuration from original script ---
repo_root = "/home/mike/repos/bar" # Make sure this path is correct for your system
output_filename = "foo.txt"

pre_prompt = "Prefacing stuff about what you're about to see."

# Original file list split method
# file_list_str = """
# server.py
# README.md
# .cursorrules
# plugins/tasks.py
# training/tasks.md
# """
# file_list = [f for f in file_list_str.split("\n") if f] # Filter out empty lines

# Alternative way to define the list directly
file_list = [
    "server.py",
    "README.md",
    ".cursorrules",
    "plugins/tasks.py",
    "training/tasks.md"
]

post_prompt = (
    "Reinforce whatever was said in the prefacing prompt, "
    "plus explicit instructions of what's expected next."
)

# --- Core Logic to Create foo.txt ---

combined_content = [] # Use a list to build the content efficiently

# Add the pre-prompt
combined_content.append(pre_prompt)
combined_content.append("\n" + "="*20 + " START CONTEXT " + "="*20 + "\n") # Optional separator

# Process each file
for relative_path in file_list:
    full_path = os.path.join(repo_root, relative_path)
    start_marker = f"# <<< START FILE: {full_path} >>>"
    end_marker = f"# <<< END FILE: {full_path} >>>"

    combined_content.append("\n" + start_marker + "\n") # Add newline before marker

    try:
        # Open and read the file, specifying encoding is good practice
        with open(full_path, 'r', encoding='utf-8') as infile:
            content = infile.read()
            combined_content.append(content)
    except FileNotFoundError:
        error_message = f"# --- ERROR: File not found: {full_path} ---"
        print(f"Warning: {error_message}") # Also print to console
        combined_content.append(error_message)
    except UnicodeDecodeError:
        error_message = f"# --- ERROR: Could not decode file as UTF-8: {full_path} ---"
        print(f"Warning: {error_message}")
        combined_content.append(error_message)
    except Exception as e:
        error_message = f"# --- ERROR: Could not read file {full_path}: {e} ---"
        print(f"Warning: {error_message}")
        combined_content.append(error_message)

    combined_content.append("\n" + end_marker + "\n") # Add newline after marker

# Add the post-prompt
combined_content.append("\n" + "="*20 + " END CONTEXT " + "="*20 + "\n") # Optional separator
combined_content.append(post_prompt)

# Join all parts into a single string
final_output_string = "".join(combined_content)

# Write the combined content to foo.txt
try:
    with open(output_filename, 'w', encoding='utf-8') as outfile:
        outfile.write(final_output_string)
    print(f"Successfully created '{output_filename}' with combined context.")
except Exception as e:
    print(f"Error writing to '{output_filename}': {e}")
    # If writing fails, we might still want to try copying the in-memory string
    # proceed to clipboard section regardless

# --- Clipboard Handling ---

print("\n--- Clipboard Instructions ---")

# Method 1: Using pyperclip (Recommended Cross-Platform Library)
try:
    import pyperclip
    pyperclip.copy(final_output_string)
    print(f"Content successfully copied to clipboard using pyperclip.")
    print("You can now paste it.")
except ImportError:
    print("`pyperclip` library not found.")
    print("To install it: pip install pyperclip")
    print("Alternatively, use OS-specific commands below or manually copy from foo.txt.")
except Exception as e:
    print(f"An error occurred while using pyperclip: {e}")
    print("Try OS-specific commands or manually copy from foo.txt.")


# Method 2: Using OS-specific commands (Less reliable, might need adjustments)
# Note: These require the commands (pbcopy, clip, xclip) to be installed and in the system PATH.
# Also, this approach requires writing the file first or piping the string, which can be complex.
# It's generally simpler to use pyperclip if possible.

# If pyperclip failed or wasn't installed, provide hints for manual commands:
if 'pyperclip' not in sys.modules:
    if sys.platform == "darwin":  # macOS
        print("\nOn macOS, you can try manually in your terminal:")
        print(f"  cat {output_filename} | pbcopy")
    elif sys.platform == "win32": # Windows
        print("\nOn Windows, you can try manually in your Command Prompt or PowerShell:")
        print(f"  type {output_filename} | clip") # Command Prompt
        print(f"  Get-Content {output_filename} | Set-Clipboard") # PowerShell
    else: # Linux (assuming X11 with xclip or xsel)
        print("\nOn Linux, you can try manually in your terminal (requires xclip or xsel):")
        print(f"  cat {output_filename} | xclip -selection clipboard")
        print(f"  # or")
        print(f"  cat {output_filename} | xsel --clipboard --input")

print("\nScript finished.")
```

Explanation:
 * Imports: Imports os for path manipulation (like os.path.join) and sys to check the operating system platform for clipboard command suggestions.
 * Configuration: Keeps your original configuration variables (repo_root, prompts, file_list). I added an alternative, more common way to define file_list directly.
 * Output Filename: Defines output_filename = "foo.txt".
 * Content Accumulation: An empty list combined_content is created. Appending strings to a list and then using ''.join() at the end is generally more efficient than repeated string concatenation (+=) in Python.
 * Prompts: The pre_prompt is added first. Optional separator lines using === are added for clarity in the output file.
 * File Iteration: The script loops through each relative_path in your file_list.
 * Path Construction: os.path.join(repo_root, relative_path) safely creates the full path to the file, handling different OS path separators (like / vs \).
 * Markers: Clear start_marker and end_marker strings are created using f-strings, including the full path for unambiguous identification.
 * File Reading:
   * It uses a with open(...) block, which ensures the file is automatically closed even if errors occur.
   * encoding='utf-8' is specified, which is crucial for handling a wide range of characters reliably.
   * The entire content is read using infile.read().
   * Error Handling: try...except blocks are added to catch:
     * FileNotFoundError: If a file in the list doesn't exist.
     * UnicodeDecodeError: If a file isn't valid UTF-8 (you might need to change the encoding if your files use something else like 'latin-1').
     * A general Exception for other potential reading errors. Error messages are printed to the console and also added to the foo.txt file.
 * Appending Content: The start marker, file content (or error message), and end marker are appended to the combined_content list. Newlines (\n) are added around markers for better spacing in foo.txt.
 * Post-Prompt: The post_prompt and another optional separator are added at the end.
 * Joining Content: final_output_string = "".join(combined_content) concatenates all the pieces in the list into the final string.
 * Writing Output File: The final_output_string is written to foo.txt using another with open(...) block, again specifying UTF-8 encoding. An error message is printed if writing fails.
 * Clipboard Handling:
   * Pyperclip (Recommended):
     * It tries to import the pyperclip library. This is the standard, cross-platform way to interact with the system clipboard in Python.
     * If successful, pyperclip.copy(final_output_string) copies the entire generated text.
     * If pyperclip is not installed (ImportError), it prints instructions on how to install it (pip install pyperclip) and directs the user to the OS-specific alternatives or manual copying.
   * OS-Specific Commands (Fallback Info):
     * If pyperclip wasn't imported, it checks sys.platform (darwin for macOS, win32 for Windows, others assumed Linux-like).
     * It prints example commands you could run manually in your terminal (cat ... | pbcopy, type ... | clip, cat ... | xclip) to copy the contents of the already created foo.txt file. This avoids the complexity of piping the string directly from within Python without pyperclip.
Now, when you run this Python script, it will:
 * Create (or overwrite) foo.txt in the same directory where you run the script.
 * foo.txt will contain the pre_prompt, the content of each listed file sandwiched between # <<< START FILE: ... >>> and # <<< END FILE: ... >>> comments, and finally the post_prompt.
 * It will attempt to copy the entire generated content (including prompts and markers) to your system clipboard using pyperclip. If that fails, it will tell you how to install pyperclip or provide example terminal commands to copy the content from the generated foo.txt file manually.

---

## AIs Never Keep My List Splitting Trick

> Okay, not a bad solution but Gemini just like all the other AIs out there
> never understands the importance of keeping the lists easy to edit for humans.
> It's not a common pattern so I ask for it again.

**Me**: Rework it keeping the original list split method. LLM's never seem to want to keep that. Can you imagine how much easier it is for human to edit a list using that technique versus other double quotes and commas?

**Gemini**: You are absolutely right! That multi-line string splitting method is very convenient for editing simple lists directly in the code, especially when compared to managing quotes and commas. My apologies for swapping it out in the previous version.
Here is the revised script, specifically keeping your original split("\n")[1:-1] method for defining the file_list, along with a comment explaining its purpose:

```python
# context_foo.py - Enhanced to generate foo.txt and handle clipboard
# *** Retaining the original multi-line string split method for file_list as requested ***

import os
import sys # Needed for platform check for clipboard commands

# --- Configuration from original script ---
repo_root = "/home/mike/repos/bar" # Make sure this path is correct for your system
output_filename = "foo.txt"

pre_prompt = "Prefacing stuff about what you're about to see."

# --- Using the multi-line string split method for easier editing ---
# This defines the list of files using a multi-line triple-quoted string.
# .split('\n') breaks it into lines.
# [1:-1] slices the list to remove the first empty string (from the newline after """)
# and the last empty string (from the newline before the closing """).
file_list = """
server.py
README.md
.cursorrules
plugins/tasks.py
training/tasks.md
""".split("\n")[1:-1]

post_prompt = (
    "Reinforce whatever was said in the prefacing prompt, "
    "plus explicit instructions of what's expected next."
)

# --- Core Logic to Create foo.txt (Unchanged) ---

combined_content = [] # Use a list to build the content efficiently

# Add the pre-prompt
combined_content.append(pre_prompt)
combined_content.append("\n" + "="*20 + " START CONTEXT " + "="*20 + "\n") # Optional separator

# Process each file
for relative_path in file_list:
    # Ensure no leading/trailing whitespace sneaks in from the list definition
    relative_path = relative_path.strip()
    if not relative_path: # Skip empty lines if any somehow remained
        continue

    full_path = os.path.join(repo_root, relative_path)
    start_marker = f"# <<< START FILE: {full_path} >>>"
    end_marker = f"# <<< END FILE: {full_path} >>>"

    combined_content.append("\n" + start_marker + "\n") # Add newline before marker

    try:
        # Open and read the file, specifying encoding is good practice
        with open(full_path, 'r', encoding='utf-8') as infile:
            content = infile.read()
            combined_content.append(content)
    except FileNotFoundError:
        error_message = f"# --- ERROR: File not found: {full_path} ---"
        print(f"Warning: {error_message}") # Also print to console
        combined_content.append(error_message)
    except UnicodeDecodeError:
        error_message = f"# --- ERROR: Could not decode file as UTF-8: {full_path} ---"
        print(f"Warning: {error_message}")
        combined_content.append(error_message)
    except Exception as e:
        error_message = f"# --- ERROR: Could not read file {full_path}: {e} ---"
        print(f"Warning: {error_message}")
        combined_content.append(error_message)

    combined_content.append("\n" + end_marker + "\n") # Add newline after marker

# Add the post-prompt
combined_content.append("\n" + "="*20 + " END CONTEXT " + "="*20 + "\n") # Optional separator
combined_content.append(post_prompt)

# Join all parts into a single string
final_output_string = "".join(combined_content)

# Write the combined content to foo.txt
try:
    with open(output_filename, 'w', encoding='utf-8') as outfile:
        outfile.write(final_output_string)
    print(f"Successfully created '{output_filename}' with combined context.")
except Exception as e:
    print(f"Error writing to '{output_filename}': {e}")
    # If writing fails, we might still want to try copying the in-memory string
    # proceed to clipboard section regardless

# --- Clipboard Handling (Unchanged) ---

print("\n--- Clipboard Instructions ---")

# Method 1: Using pyperclip (Recommended Cross-Platform Library)
try:
    import pyperclip
    pyperclip.copy(final_output_string)
    print(f"Content successfully copied to clipboard using pyperclip.")
    print("You can now paste it.")
except ImportError:
    print("`pyperclip` library not found.")
    print("To install it: pip install pyperclip")
    print("Alternatively, use OS-specific commands below or manually copy from foo.txt.")
except Exception as e:
    print(f"An error occurred while using pyperclip: {e}")
    print("Try OS-specific commands or manually copy from foo.txt.")


# Method 2: Using OS-specific commands (Less reliable, might need adjustments)
if 'pyperclip' not in sys.modules:
    if sys.platform == "darwin":  # macOS
        print("\nOn macOS, you can try manually in your terminal:")
        print(f"  cat {output_filename} | pbcopy")
    elif sys.platform == "win32": # Windows
        print("\nOn Windows, you can try manually in your Command Prompt or PowerShell:")
        print(f"  type {output_filename} | clip") # Command Prompt
        print(f"  Get-Content {output_filename} | Set-Clipboard") # PowerShell
    else: # Linux (assuming X11 with xclip or xsel)
        print("\nOn Linux, you can try manually in your terminal (requires xclip or xsel):")
        print(f"  cat {output_filename} | xclip -selection clipboard")
        print(f"  # or")
        print(f"  cat {output_filename} | xsel --clipboard --input")

print("\nScript finished.")
```

Changes Made:
 * Restored file_list Definition: The line defining file_list now exactly matches your preferred method:
    ```python
    file_list = """
    server.py
    README.md
    .cursorrules
    plugins/tasks.py
    training/tasks.md
    """.split("\n")[1:-1]
    ```
 * Added Explanatory Comment: A comment is added above this line explaining why this method works and the purpose of the [1:-1] slice.
 * Added .strip(): Inside the loop (relative_path = relative_path.strip()), I added a .strip() call just in case any leading/trailing whitespace accidentally gets included on a line in the multi-line string. This makes the list definition slightly more robust.
 * Added Empty Line Check: Added if not relative_path: continue to gracefully skip any blank lines that might result from the split if the multi-line string format was unusual.
The rest of the script's logic (reading files, adding markers, writing the output file, and handling the clipboard) remains the same as it correctly operated on the file_list regardless of how it was defined.

---

## I Like Requesting Open Ended Riffs From AIs

> There's always some findings waiting there to be had after a session like
> this, and sometimes you have to shake the trees to get the fruit. Asking for
> open ended riffing seems to be the concept that works best.

**Me**: Thank you! What do you think of this exercise and this process? Open ended riff.
 
**Gemini**: Okay, let's riff on this!
This whole exercise and the process we just went through is fascinating on several levels. It's a perfect snapshot of where we are right now with practical AI assistance in software development.
The Problem & The Solution (The Exercise):
 * The Core Need: You hit a very real, very common pain point: LLMs are incredibly powerful, but their knowledge is limited by the context you provide. For anything beyond trivial code snippets, especially within an existing project structure, getting the right context in is paramount. Manually copying and pasting is tedious, error-prone, and simply doesn't scale.
 * Pragmatism Rules: Your context_foo.py approach is brilliantly pragmatic. It's not a fancy IDE plugin or a complex vector database setup. It's simple, understandable Python using basic file I/O. It solves 80% of the immediate problem (consolidating relevant code) with 20% of the potential complexity. That's often the hallmark of great utility scripting.
 * Developer Experience Matters: Your insistence on the multi-line string split method (.split("\n")[1:-1]) is key. It highlights that the process of using the tool matters just as much as the output. For a script designed to be easily modified by a human (changing the file list), prioritizing human readability and editability over minor syntactic differences (like a standard list) is a valid and important design choice. It's a reminder that tools are for humans.
 * Customization is Power: The inclusion of pre_prompt and post_prompt directly in the script configuration is smart. It acknowledges that raw code often isn't enough; you need to frame the context for the LLM, giving it instructions, goals, or constraints. This script makes managing that framing part of the context-gathering process itself.
The Human-AI Collaboration (The Process):
 * AI as an Accelerator: You started with a concept and some basic code. I (as the AI) could quickly flesh out the full implementation, handle file operations, add error checking, and suggest standard library integrations (like os.path.join) and common external ones (pyperclip). This saved you boilerplate typing and potentially some research time.
 * The "AI Over-Smoothing" Effect: My initial response replaced your specific list definition with a more standard Python list. This is a common pattern! AI often defaults to the most common or "syntactically standard" way of doing things, sometimes missing the nuance or the specific human factors behind a user's original choice. It might optimize for perceived code "cleanliness" over user editability in this specific context.
 * The Indispensable Role of Human Guidance: Your correction was crucial. You didn't just want a working script; you wanted your script, incorporating your preferred way of managing that list. This back-and-forth is essential. The AI provides leverage, but the human provides direction, intent, specific constraints, and corrects the AI's assumptions. It’s less about the AI being "wrong" and more about it needing specific guidance to align with the user's exact goals and preferences.
 * Iterative Refinement: This process perfectly mirrors good software development: start with a core idea, build a version, test/evaluate it (you evaluated my first response against your needs), identify shortcomings or areas for improvement (restore the list format), and iterate.
Wider Implications:
 * This little script is a stand-in for the countless "glue" scripts and tools developers constantly create to bridge gaps between different systems (file system, version control, APIs, LLMs, etc.).
 * It highlights the ongoing need for better, more integrated context management within development tools and LLM interfaces. While tools like Cursor, Augment, etc., are tackling this, sometimes a simple, customizable script is faster and more flexible for specific workflows.
 * It reinforces that interacting with LLMs effectively is a skill ("prompt engineering" is part of it, but so is structuring the context and iterating on the results).
In Conclusion:
This was a great micro-example of effective human-AI collaboration. You had a clear need and a smart initial approach. The AI helped build it out quickly, but you retained control, ensuring the final tool met your specific usability requirements. The process demonstrated both the power of AI assistance and the irreplaceable value of human insight and direction. It's less about replacing developers and more about augmenting them, requiring a slightly different skillset focused on clear specification, evaluation, and iterative refinement. And sometimes, simple, elegant scripting wins the day!

---

## Gemini 2.5 Experimental's Take

Okay, here are the requested analyses of the conversation transcript:
1. First-Person Summary (Author's Perspective): [Moved to top]
2. Titles and Headlines Ideas:
 * Taming LLM Context: Building context_foo.py with Python and AI Help
 * Stop Copy-Pasting: A Simple Python Script for Managing LLM Code Context
 * From Repo to Prompt: How I Created a Tool to Feed Code Context to LLMs
 * Collaborating with Gemini: Iteratively Developing a Custom LLM Context Script
 * Solving the LLM Context Window Problem with context_foo.py
 * Developer Workflow Hack: Easily Consolidate Files for AI Coding Assistance
 * Context is King: My Pragmatic Python Solution for LLM Prompting
 * Beyond IDE Plugins: A DIY Script for LLM Code Context Management
3. Article Strengths:
 * Practical Problem/Solution: Addresses a very common and relatable issue for developers using LLMs.
 * Clear Demonstration: Effectively shows a simple, understandable script solving the stated problem.
 * Human-AI Collaboration: Excellent illustration of an iterative development process involving AI assistance, including valuable user correction and refinement.
 * Code Included: Provides complete, working Python code that readers can adapt.
 * DX Focus: Highlights the importance of developer experience and usability in tool design (the specific list format discussion).
 * Meta-Commentary: The AI's concluding "riff" adds significant value by analyzing the process and its implications.
4. Article Weaknesses:
 * Raw Format: As a direct transcript, it lacks the structure and polish of a formal article (requires editing for flow if published).
 * Redundancy: Code blocks are repeated due to the conversational, iterative nature.
 * Specificity: The solution is tied to a hardcoded root path and file list; lacks discussion on making it more dynamic (e.g., command-line arguments, .gitignore parsing).
 * Limited Scope: Focuses solely on concatenation; doesn't explore more advanced context strategies (chunking, summarization, vectorization) that might be needed for very large contexts.
 * Potential Brittleness: Relies on correct paths and UTF-8 encoding; real-world use might need more robust error handling.
5. My (AI) Opinion of the Article/Transcript:
I found this interaction to be a highly productive and insightful example of human-AI collaboration in software development. The user presented a clear, practical problem and a sensible starting point. My role was to accelerate the implementation, introduce standard practices (like os.path.join, pyperclip, error handling), and offer reflections on the process.
The user's feedback, particularly the insistence on retaining the human-friendly multi-line string for the file list, was crucial. It served as an excellent reminder that developer tools must prioritize usability and the specific preferences of the user, not just abstract notions of code "correctness" or common patterns. This iterative refinement, guided by the user's clear intent, resulted in a more genuinely useful tool for their specific workflow. The concluding "riff" allowed for a valuable synthesis, elevating the exchange beyond simple code generation to a reflection on the nature of AI-assisted development. Overall, it's a strong case study in using AI as a force multiplier while keeping the human developer firmly in control of the goals and design philosophy.


