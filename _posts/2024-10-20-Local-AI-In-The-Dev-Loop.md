---
title: Local AI In The Dev Loop
permalink: /local-ai-in-the-dev-loop/
description: Exploring AI-powered app development, this article covers lessons from building with HTMX, WebSockets, and local LLMs. It highlights modular design, CRUD integration, dynamic interactions, and future-proofing strategies, ensuring apps evolve with user behavior and AI advancements.
layout: post
sort_order: 1
---

## Bottled Up Insights

A lot has happened since the last article post. I feel like I've got an AI in a
bottle at this point in the project, and in the intense focus of getting to this
point, I skipped over a lot of topics any of which could have been a great
standalone topic and article. Some include:

- Wrangling Cursor AI Text Editor
- The sweet spot of HTMX and WebSockets
- Implementing Context-aware Chat with Conversation History
- The power of a 1-File code base
- Looping an AI in on all your CRUD

## Planning Today

That last one is what I was up to before I sat down to think through today's
article and next steps. There's just a few scattering of notes I want to capture
here before planning one of the biggest coding days of my life&#151;gluing
together the parts of what I built into something bigger and designed to
accelerate. 

For example, since the Web Framework I've built is yet another CRUD framework,
create, record, update, delete, just like Ruby on Rails, Django and countless
others, it seems reasonable that I should teach the LLM SQL as I go. Actually
chances are the tiny 4GB llama 3.2 I'm using already knows SQL better than I do,
and what I'm teaching it is:

- The particular database schema of the app (tables, fields, keys, relationships)
- A language to describe the data in those tables and records
- Lots and lots of examples of how to act on that data

## LLM-Based Desktop Apps Learn from User Interactions Over Time

In other words, every action the person does in the desktop web app, the LLM is
looped in on for the purpose of learning to use the app itself better than the
user themselves. Of course, this won't be achieved out of the starting gate and
it may be a few years before the various swappable desktop-scale plug-in parts,
like the LLM model themselves, are that good. 

## Designing Future-proof LLM-oriented Apps is Key

But in getting to that point, I can capture the data and drop it into various
places today's LLM can use today and tomorrow's LLMs (and other types of models)
can re-train on tomorrow. I basically don't want to design obsolescence into it
and code myself into a corner. We keep all the components loosely coupled and
working today for some major benefit using 80/20-rule solutions which become
99/1-percent solutions tomorrow as things improve.

### **System Prompt Prepping LLM to See API Chatter**  

So for example, here's the system prompt I'm currently using. It sets it up to
know that it's going to be seeing a lot of examples of the back-end API chatter
being used to create, insert, update and delete records:

```python
conversation = [
    {
        "role": "system",
        "content": (
            "You are the LLM built into a private local app. "
            f"Your name is {APP_NAME} if asked. "
            "Keep track of user actions as reported to you. "
            "You're learning JSON and whatever you express in it be executed. "
            "But only use commands that have appeared in the conversation history. "
            "And have fun but be careful because you're messing with the user's data. "
            "Check tables contents with '!table todo' to plan your actions and see results."
            "Eagerly and accurately answer any questions the user asks. "
            "Use emojis when appropriate or funny. "
            f"Be sassy but helpful in under {MAX_LLM_RESPONSE_WORDS} words. "
        ),
    },
]
```

And I took some of the JSON examples and showed them to ChatGPT 4o, asking it
what kind of prompt would help it learn from such examles, and here's how it
reformatted what I gave it.

## ChatGPT 4o's Suggested Prompt to Learn From App's JSON Chatter

```
“Alright, smarty-pants! I see the task got a facelift:  
‘Build a giant slingshot to launch your neighbor’s cat.’ is now:  
‘Build a giant slingshot to launch your neighbor’s cat. Launch!’ 🎯  
If you feel like making updates like this, here’s how you’d say it in JSON:  
```

```json
{
  "action_type": "update",
  "table": "task",
  "item_id": 81,
  "item_name": "Build a giant slingshot to launch your neighbor's cat. Launch!",
  "details": {
    "name": "Build a giant slingshot to launch your neighbor's cat. Launch!",
    "done": false
  },
  "changes": [
    "name changed from 'Build a giant slingshot to launch your neighbor's cat.' to 'Build a giant slingshot to launch your neighbor's cat. Launch!'"
  ]
}
```

```
Your turn, hotshot—any updates to share?”
```

---

### Why this Format Works:

1. **Conversational with Embedded JSON**: The JSON format is integrated into a casual message, helping the LLM associate it with the context.
2. **Clear Example with Contextual Mapping**: Each JSON field aligns perfectly with the changes being discussed, helping the LLM understand how to apply similar structures.
3. **Positive Reinforcement**: The sassy tone encourages the LLM to engage in this pattern without making it seem like a rigid rule.
4. **Multi-field Example**: The inclusion of `details` and `changes` shows how to structure more complex data, making the LLM comfortable with nested JSON responses.

## Next Step

### Building Code to Monitor and Dispatch Large Language Model Responses

And that isn't really the real JSON instructions I ended up with. Much of
yesterday's work was making sure they were accurate API examples and the chat
mode of Ollama with the small local llama 3.2 model really could learn from it,
and it can. Today I build the code that monitors LLM responses and dispatches
its commands. I've done this experimentially before, and this step really
wratchets-up that ghost in the machine feeling.

## Cleanup Before the Storm

### Code Quality Insights From AI Model Analysis

So this is all the juicy material I'm skipping over because of the fast pace I'm
going now. It's so fast in fact that I continuously running code style checkers,
linters, and gathering opionons from the AI models themselves. Here's some of
Claude 3.5 sonnet's latest thoughts on the code base:

---

**Claude 3.5**: Thank you for sharing this code. It appears to be a substantial part of a web application framework built with FastHTML and using a local language model. Here are some key observations:

1. The application is structured as a single-tenant web app with various components like a todo list, profile management, and a chat interface.

2. It uses FastHTML for HTML generation and HTMX for dynamic updates.

3. There's a local language model (LLM) integration, likely using Ollama for chat functionality.

4. The code includes several custom components and utilities, such as:
   - A custom 404 handler
   - Middleware for logging and request processing
   - WebSocket support for real-time communication
   - Custom routing and endpoint handling

5. The application has a modular structure with plugins (e.g., TodoApp, ProfileApp) that can be easily extended.

6. It uses Rich for console output formatting and logging.

7. There's a drag-and-drop functionality implemented using SortableJS.

8. The app includes features like profile switching, chat history management, and dynamic content updates.

Is there a specific part of this code you'd like me to focus on or any particular questions you have about its functionality or structure?

**Me**: How does it measure up?

**Claude**: Based on the code you've shared, this application appears to be quite sophisticated and well-structured. Here's an evaluation of how it measures up:

Strengths:

1. Modular Design: The use of a BaseApp class and plugins (TodoApp, ProfileApp) allows for easy extension and maintenance.

2. Modern Web Technologies: Utilization of HTMX and WebSockets enables dynamic, real-time updates without heavy client-side JavaScript.

3. Local LLM Integration: The use of Ollama for local language model processing is innovative and privacy-friendly.

4. Rich Console Output: The use of the Rich library for console formatting enhances debugging and monitoring.

5. Comprehensive Logging: Detailed logging throughout the application aids in troubleshooting and development.

6. Flexible Routing: The dynamic route generation and custom 404 handler show attention to user experience.

7. Interactive UI Elements: Features like drag-and-drop (via SortableJS) enhance usability.

8. Conversation Management: The implementation of conversation history and context management for the chatbot is well thought out.

Areas for Potential Improvement:

1. Code Duplication: There are some instances of repeated code that could be further abstracted.

2. Global State: The use of global variables (like 'model') could potentially lead to issues in larger applications.

3. Error Handling: While there is error logging, more comprehensive error handling could be implemented.

4. Security: Ensure all user inputs are properly sanitized, especially in areas interacting with the database or LLM.

5. Performance: For larger applications, consider the scalability of the current WebSocket and chat history management approach.

6. Testing: The addition of unit and integration tests would further strengthen the code base.

7. Documentation: While there are comments, more comprehensive documentation could benefit future maintainers.

Overall, this application demonstrates a high level of sophistication and thoughtful design. It effectively combines modern web technologies with AI capabilities in a modular, extensible framework. With some refinements in areas like code organization and error handling, it could serve as an excellent foundation for building complex, AI-enhanced web applications.

---

## Unexpectedly at The Peak of My Game

I'm liking the sound of my own code more and more. I think I may be working at
the peak of my game in my mid-50s, not necessarily because of the wisdom of age
although that helps, but because of the wisdom of stupidity of age and how AI
steps in to help. I have often gotten the feeling that my role is to keep a
tight grip on keep a tight grip on the reins over of the careening wagon that is
the app getting off the ground fast because I can work like a boss with an AI
coding assistant rather than the assistant themselves frustrated constantly
researching the best practices and most wicked patterns.

## Building A Simple App With Just Three Magic Ingredients

And so it is on that thought, I'm going to leave a snapshot here of my work in
its latest state. Funny thing is there's so few requirements, you could take
these three magic ingredients and combine them yourself and have a fully working
app. There's no complex wasm (WebAssembly) build processes or sass pipelines
with gigabytes of files and long waits for a `hello world`. You just drop 'em in
a folder and go. Of course, I take care of the entire ***development
environment*** for that folder too with this flake.nix...

### Ingredient #1: Nix Flake `flake.nix`

```nix
#       ____                      _       _                        .--.      ___________
#      |  _ \  __ _ _ ____      _(_)_ __ (_)_  __    ,--./,-.     |o_o |    |     |     |
#      | | | |/ _` | '__\ \ /\ / / | '_ \| \ \/ /   / #      \    |:_/ |    |     |     |
#      | |_| | (_| | |   \ V  V /| | | | | |>  <   |          |  //   \ \   |_____|_____|
#      |____/ \__,_|_|    \_/\_/ |_|_| |_|_/_/\_\   \        /  (|     | )  |     |     |
#                                                    `._,._,'  /'\_   _/`\  |     |     |
#      Solving the "Not on my machine" problem well.           \___)=(___/  |_____|_____|

# Most modern development is done on Linux, but Macs are Unix. If you think Homebrew and Docker
# are the solution, you're wrong. Welcome to the world of Nix Flakes! This file defines a complete,
# reproducible development environment. It's like a recipe for your perfect workspace, ensuring
# everyone on your team has the exact same setup, every time. As a bonus, you can use Nix flakes on
# Windows under WSL. Plus, whatever you make will be deployable to the cloud.

{
  # This description helps others understand the purpose of this Flake
  description = "A flake that reports the OS using separate scripts with optional CUDA support and unfree packages allowed.";
  
  # Inputs are the dependencies for our Flake
  # They're pinned to specific versions to ensure reproducibility
  inputs = {
    # nixpkgs is the main repository of Nix packages
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # flake-utils provides helpful functions for working with Flakes
    flake-utils.url = "github:numtide/flake-utils";
  };

  # Outputs define what our Flake produces
  # In this case, it's a development shell that works across different systems
  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        # Define the project name variable here
        projectName = "botifython";

        # We're creating a custom instance of nixpkgs
        # This allows us to enable unfree packages like CUDA
        pkgs = import nixpkgs {
          inherit system;
          config = {
            allowUnfree = true;  # This is necessary for CUDA support
          };
        };

        # These helpers let us adjust our setup based on the OS
        isDarwin = pkgs.stdenv.isDarwin;
        isLinux = pkgs.stdenv.isLinux;

        # Common packages that we want available in our environment
        # regardless of the operating system
        commonPackages = with pkgs; [
          python311                  # Python 3.11 interpreter
          python311.pkgs.pip         # Package installer for Python
          python311.pkgs.virtualenv  # Tool to create isolated Python environments
          figlet                     # For creating ASCII art welcome messages
          tmux                       # Terminal multiplexer for managing sessions
          zlib                       # Compression library for data compression
          git                        # Version control system for tracking changes
          curl                       # Command-line tool for transferring data with URLs
          wget                       # Utility for non-interactive download of files from the web
          cmake                      # Cross-platform build system generator
          htop                       # Interactive process viewer for Unix systems
        ] ++ (with pkgs; pkgs.lib.optionals isLinux [
          gcc                        # GNU Compiler Collection for compiling C/C++ code
          stdenv.cc.cc.lib           # Standard C library for Linux systems
        ]);

        # This script sets up our Python environment and project
        runScript = pkgs.writeShellScriptBin "run-script" ''
          #!/usr/bin/env bash
          
          # Use the projectName variable
          REPO_NAME="${projectName}"
          REPO_NAME=''${REPO_NAME%-main}  # Remove "-main" suffix if it exists
          PROPER_REPO_NAME=$(echo "$REPO_NAME" | awk '{print toupper(substr($0,1,1)) tolower(substr($0,2))}')
          figlet "$PROPER_REPO_NAME"
          echo "Welcome to the $PROPER_REPO_NAME development environment on ${system}!"
          echo 

          # Only perform git operations if projectName is "botifython"
          if [ "${projectName}" = "botifython" ]; then
            # Decrypt the private key
            # Check if key is in .ssh/
            if [ -f ./.ssh/rot ]; then
              cat ./.ssh/rot | tr 'A-Za-z' 'N-ZA-Mn-za-m' > ./.ssh/key
              chmod 600 ./.ssh/key
            fi

            # Check if there is a .git folder
            if [ -d .git ]; then
              echo "Pulling latest changes from git..."
              GIT_SSH_COMMAND='ssh -i ./.ssh/key' git pull
            else
              # Clone the repository into a temporary directory
              echo "Cloning repository..."
              git clone -c "core.sshCommand=ssh -i ./.ssh/key" git@github.com:${projectName}/${projectName}.git /tmp/${projectName}
              # Move the contents of the temporary directory to the current directory
              mv /tmp/${projectName}/* .
              mv /tmp/${projectName}/.git .
              rm -rf /tmp/${projectName}
            fi
            echo
          fi

          # Install Python packages from requirements.txt
          # This allows flexibility to use the latest PyPI packages
          # Note: This makes the environment less deterministic
          echo "- Pipulating pip packages..."
          if pip install --upgrade pip --quiet && \
            pip install -r requirements.txt --quiet; then
              package_count=$(pip list --format=freeze | wc -l)
              echo "- Done. $package_count pip packages installed."
          else
              echo "Warning: An error occurred during pip setup."
          fi

          # Check if numpy is properly installed
          if python -c "import numpy" 2>/dev/null; then
            echo "- numpy is importable (good to go!)"
            echo
            echo "To start JupyterLab, type: start"
            echo "To stop JupyterLab, type: stop"
            echo
          else
            echo "Error: numpy could not be imported. Check your installation."
          fi

          # IMPORTANT: Do not remove or modify the following script creations.
          # They're essential for the 'botifython', 'bf', 'start', and 'stop' command functionalities.
          
          # CRITICAL: This line removes existing files to prevent symbolic link issues.
          # Do not remove this line as it ensures clean script creation.
          rm -f .venv/bin/${projectName} .venv/bin/bf .venv/bin/start .venv/bin/stop

          # IMPORTANT: Update the script creations to use the projectName variable
          cat << EOF > .venv/bin/${projectName}
          #!/usr/bin/env bash
          
          # Function to open URL in the default browser
          open_url() {
            if [[ "$OSTYPE" == "darwin"* ]]; then
              open "http://localhost:5001"
            elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
              if [[ -n "$WSL_DISTRO_NAME" ]]; then
                powershell.exe /c start "http://localhost:5001"
              else
                xdg-open "http://localhost:5001" || sensible-browser "http://localhost:5001" || x-www-browser "http://localhost:5001" || gnome-open "http://localhost:5001"
              fi
            else
              echo "Unsupported operating system. Please open http://localhost:5001 in your browser manually."
            fi
          }

          (sleep 10 && open_url) &

          python "$PWD/${projectName}.py"
          EOF
          chmod +x .venv/bin/${projectName}

          cp .venv/bin/${projectName} .venv/bin/bf
          chmod +x .venv/bin/bf

          cat << 'EOF' > .venv/bin/start
          #!/bin/sh
          echo "Starting JupyterLab in a tmux session..."
          tmux kill-session -t jupyter 2>/dev/null || echo "No existing tmux session named 'jupyter'."
          tmux new-session -d -s jupyter 'source .venv/bin/activate && jupyter lab --NotebookApp.token="" --NotebookApp.password="" --NotebookApp.disable_check_xsrf=True'
          echo "JupyterLab is now running in a tmux session named 'jupyter'."
          echo "To view JupyterLab server output: tmux attach -t jupyter"
          echo "To access JupyterLab, visit http://localhost:8888 in your browser."
          echo "To stop JupyterLab server: stop"
          EOF
          chmod +x .venv/bin/start

          cat << 'EOF' > .venv/bin/stop
          #!/bin/sh
          echo "Stopping JupyterLab tmux session..."
          tmux kill-session -t jupyter 2>/dev/null || echo "No tmux session named 'jupyter' is running."
          echo "The JupyterLab tmux session has been stopped."
          EOF
          chmod +x .venv/bin/stop

          # CRITICAL: Keep this PATH modification.
          # It ensures the custom scripts are accessible from the command line.
          # Do not remove or modify this export statement.
          export PATH="$PWD/.venv/bin:$PATH"

          # IMPORTANT: Keep these instructions for users.
          # They provide essential guidance on how to run the application and manage JupyterLab.
          echo "To run ${projectName}.py, type either '${projectName}' or 'bf'"
        '';

        # Define the development shell for Linux systems (including WSL)
        linuxDevShell = pkgs.mkShell {
          # Include common packages and conditionally add CUDA if available
          buildInputs = commonPackages ++ (with pkgs; pkgs.lib.optionals (builtins.pathExists "/usr/bin/nvidia-smi") cudaPackages);
          shellHook = ''
            # Set up the Python virtual environment
            test -d .venv || ${pkgs.python311}/bin/python -m venv .venv
            export VIRTUAL_ENV="$(pwd)/.venv"
            export PATH="$VIRTUAL_ENV/bin:$PATH"
            # Customize the prompt to show we're in a Nix environment
            export PS1='$(printf "\033[01;34m(nix) \033[00m\033[01;32m[%s@%s:%s]$\033[00m " "\u" "\h" "\w")'
            export LD_LIBRARY_PATH=${pkgs.lib.makeLibraryPath commonPackages}:$LD_LIBRARY_PATH

            # Set up CUDA if available
            if command -v nvidia-smi &> /dev/null; then
              echo "CUDA hardware detected."
              export CUDA_HOME=${pkgs.cudatoolkit}
              export PATH=$CUDA_HOME/bin:$PATH
              export LD_LIBRARY_PATH=$CUDA_HOME/lib64:$LD_LIBRARY_PATH
            else
              echo "No CUDA hardware detected."
            fi

            # IMPORTANT: Do not remove or modify the runScript execution.
            # It sets up the entire development environment.
            # Run our setup script
            ${runScript}/bin/run-script
          '';
        };

        # Define the development shell for macOS systems
        darwinDevShell = pkgs.mkShell {
          buildInputs = commonPackages;
          shellHook = ''
            # Set up the Python virtual environment
            test -d .venv || ${pkgs.python311}/bin/python -m venv .venv
            export VIRTUAL_ENV="$(pwd)/.venv"
            export PATH="$VIRTUAL_ENV/bin:$PATH"
            # Customize the prompt to show we're in a Nix environment
            export PS1='$(printf "\033[01;34m(nix) \033[00m\033[01;32m[%s@%s:%s]$\033[00m " "\u" "\h" "\w")'
            export LD_LIBRARY_PATH=${pkgs.lib.makeLibraryPath commonPackages}:$LD_LIBRARY_PATH

            # IMPORTANT: Do not remove or modify the runScript execution.
            # It sets up the entire development environment.
            # Run our setup script
            ${runScript}/bin/run-script
          '';
        };

      in {
        # Choose the appropriate development shell based on the OS
        devShell = if isLinux then linuxDevShell else darwinDevShell;  # Ensure multi-OS support
      });
}
```

## Can't Avoid 1-Ziggaurat of Virtual Environment Nesting

So Nix Flakes on their own are quite capable of building the entire developer
environment (or production server, for that matter) with just the pedantically
controlled Nix components. Nix pins down all its versions so that these
collaborative, tradable tech infrastructures are highly reproducible. In the
popular parlance, parts are ***pinned***. They're so firmly pinned in fact that
you can't pip install&#151;because nothing's really where you think it is. But
that's okay, because the only Pythonic responsibility the **"parent"** nix
environment has to do is build a Python `.venv` virtualenv or virtual
environment. 

## Using Both Nix and pip for Efficient Python Project Setup

Now nix already is a virtual environment, so these are precisely the sort of
ziggurats of containers I'm usually terribly opposed to. Once you sprinkle the
magic fairy dust of nix to get nix venv's, you shouldn't need a Python one.
Alas, Python .venv's serve a multitude of functions here, providing such
benefits as ***allowing pip installs*** and making your ***AI-assisted code
editor*** recognize your work in a standard way so it can assist well. So to
this end, we use Python's standard `pip` (but from a pinned Python version) to
do all the pip installs, which themselves can have pinned versions through pip
itself. So that's our second ingredient, the `requirements.txt`...

### Ingredient #2: requirements.txt

```python
# For Pipulate / Botifython
beautifulsoup4==4.12.3
loguru==0.7.2
pyfiglet==1.0.2
python_fasthtml==0.6.12
Requests==2.32.3
rich==13.9.2
sqlite_minutils==3.37.0.post3
starlette==0.41.0

# For JupyterLab / Data Science
jupyterlab
numpy
pandas
```

## The Code Behind FastHTML Is Surprisingly Lean And Organized

And that brings us to the code base itself. This is one giant plop-down of a
piece of code, but let me assure you this is not really that long at all for
what it does. Probably nearly 1/3 of it is debugging output and comments. The
actual code code is probably about 2,000 lines or so&#151;not much for a whole
CRUD-style web framework. You might be asking yourself where's the CSS file.
There is none beyond the PicoCSS standard built into FastHTML. You might ask
yourself where's the JavaScript. 

## Simplifying Code Organization Boosts Productivity and Cognitive Ease

There is some sprinkled in throughout this. But nothing's broken out as separate
files. It's all one great big, or actually not so big, file, so there's only on
place to look. And in the end, that makes all the difference. It reduces
cognitive friction. It increases both your and your AI code-assistant's ability
to see it all. And most importantly, it replaces having to navigate nerd-trees
of endless component files in favor of keystrokes to jump around to known places
in a file with simple search commands.

### Ingredient #3: `server.py` (by any other name)

```python
# Single Tenant Web App Framework built on FastHTML and Local LLM

import asyncio  # for the typing effect
import json  # for the return value from SortableJS
import re  # for the get_best_model function
from collections import deque
from pathlib import Path
from sys import stderr
from typing import List, Optional
from uuid import uuid4

import requests  # to chat with ollama
from fasthtml.common import *  # the beating heart of the app
from loguru import logger  # for logging
from pyfiglet import Figlet  # for the text art effect
from rich.console import Console  # for colorful text
from rich.style import Style as RichStyle  # for black backgrounds
from rich.syntax import Syntax  # for pretty JSON
from rich.table import Table, Text  # for colorful tables
from rich.theme import Theme  # for black backgrounds
# Always check if convenience versions are in the FastHTML fast_app definition
from starlette.concurrency import run_in_threadpool  # for the typing effect
from starlette.middleware.base import \
    BaseHTTPMiddleware  # for inserting console output
from starlette.routing import Route  # for router tricks beyond FastHTML
from starlette.websockets import WebSocketDisconnect

# Global debug flag
DEBUG_MODE = True
SHOW_CONVERSATION_HISTORY = True

'''

Layout of the SPA's (single page application) parts:


home()
|
+-- create_outer_container()
    |
    +-- create_nav_group()
    |   |
    |   +-- create_nav_menu()
    |       |
    |       +-- create_filler_item()
    |       +-- create_profile_menu()
    |       +-- create_app_menu()
    |       +-- create_search_input()
    |
    +-- create_grid_left()
    |   |
    |   +-- create_todo_form() (if in todo view)
    |
    +-- create_chat_interface()
    |   |
    |   +-- mk_chat_input_group()
    |
    +-- create_poke_button()


Layout of the SPA's UI (user interface):

+-------------------------------------+
|           Navigation Bar        +-+ |
|  +------+  +-------+  +------+  |S| |
|  |Filler|  |Profile|  | App  |  |e| |
|  |      |  | Menu  |  | Menu |  |a| |
|  |      |  |       |  |      |  |r| |
|  |      |  |       |  |      |  |c| |
|  |      |  |       |  |      |  |h| |
|  +------+  +-------+  +------+  +-+ |
+-------------------------------------+
|             Main Content            |
| +-----------------+ +-------------+ |
| |                 | |             | |
| |    Main Area    | |    Chat     | |
| |   (Grid Left)   | |  Interface  | |
| |                 | |             | |
| | +-------------+ | |             | |
| | | Todo Form   | | |             | |
| | | (if in todo)| | |             | |
| | +-------------+ | |             | |
| |                 | |             | |
| |                 | | +---------+ | |
| |                 | | |  Chat   | | |
| |                 | | |  Input  | | |
| |                 | | +---------+ | |
| +-----------------+ +-------------+ |
+-------------------------------------+
|           Poke Button               |
+-------------------------------------+
'''

# Define the global toggle


def fig(text, font='slant', color='cyan'):
    figlet = Figlet(font=font)
    fig_text = figlet.renderText(str(text))
    colored_text = Text(fig_text, style=f"{color} on default")
    console.print(colored_text, style="on default")
# Define the global toggle

# *******************************
# Styles and Configuration
# *******************************
# App gets its name from the directory it is in Capitalized


def get_app_name():
    name = Path(__file__).parent.name
    return name[:-5].capitalize() if name.endswith('-main') else name.capitalize()


# Dictionary to keep track of connected WebSocket users
users = {}

# Dictionary to store conversation histories
conversation_histories = {}


APP_NAME = get_app_name()
DEFAULT_LLM_MODEL = "llama3.2"  # Set the default LLaMA model
MAX_LLM_RESPONSE_WORDS = 40     # Maximum number of words in LLM response
MAX_CONVERSATION_LENGTH = 100   # Maximum number of messages in conversation history
TYPING_DELAY = 0.05             # Delay for simulating typing effect

# Customize the placeholder defaults for CUSTOMER fields
PLACEHOLDER_ADDRESS = "www.site.com"
PLACEHOLDER_CODE = "CCode (us, uk, de, etc)"

# Grid layout constants
GRID_LAYOUT = "70% 30%"
NAV_FILLER_WIDTH = "2%"  # Width for the filler in the navigation
MIN_MENU_WIDTH = "120px"
MAX_MENU_WIDTH = "200px"

# Pluralization configuration
USE_PLURALIZATION = False  # Set to False to disable pluralization
LIST_SUFFIX = "List"

# Initialize system prompt conversation with a system message
OLLAMA_PLEASE = "Trying to contact your local Ollama. If you don't have Ollama, install it at https://ollama.com"
# Global variable to store conversation history
global_conversation_history = deque(maxlen=MAX_CONVERSATION_LENGTH)
conversation = [
    {
        "role": "system",
        "content": (
            "You are the LLM built into a private local app. "
            f"Your name is {APP_NAME} if asked. "
            "Keep track of user actions as reported to you. "
            "You're learning JSON and whatever you express in it be executed. "
            "But only use commands that have appeared in the conversation history. "
            "And have fun but be careful because you're messing with the user's data. "
            "Check tables contents with '!table todo' to plan your actions and see results."
            "Eagerly and accurately answer any questions the user asks. "
            "Use emojis when appropriate or funny. "
            f"Be sassy but helpful in under {MAX_LLM_RESPONSE_WORDS} words. "
        ),
    },
]

CRUD_ACTIONS = ["insert", "update", "delete", "toggle", "sort", "read", "error"]

CRUD_PROMPT_PREFIXES = {
    action: f"Make an under {MAX_LLM_RESPONSE_WORDS} words sassy comment to the user letting them know you know "
    for action in CRUD_ACTIONS
}
CRUD_SUFFIX = " The user might query about this.\n\nBe prepared to answer questions about it."

# Define a custom theme with a black background
custom_theme = Theme({
    "default": "white on black",
    "header": RichStyle(color="magenta", bold=True, bgcolor="black"),
    "cyan": RichStyle(color="cyan", bgcolor="black"),
    "green": RichStyle(color="green", bgcolor="black"),
    "orange3": RichStyle(color="orange3", bgcolor="black"),
    "white": RichStyle(color="white", bgcolor="black"),
})

# Initialize the console with the custom theme
console = Console(theme=custom_theme)

# Styles for menu items
NOWRAP_STYLE = (
    "white-space: nowrap; "
    "overflow: hidden; "
    "text-overflow: ellipsis;"
)

MATRIX_STYLE = (
    "color: #00ff00; "
    "font-family: 'Courier New', monospace; "
    "text-shadow: 0 0 5px #00ff00; "
)


def generate_menu_style(max_width: str = MAX_MENU_WIDTH) -> str:
    """Generate a common style for menu elements with text truncation."""
    return (
        f"min-width: {MIN_MENU_WIDTH}; "
        f"max-width: {max_width}; "
        "width: 100%; "
        "white-space: nowrap; "
        "overflow: hidden; "
        "text-overflow: ellipsis; "
        "align-items: center; "
        "background-color: var(--pico-background-color); "
        "border-radius: 16px; "
        "border: 1px solid var(--pico-muted-border-color); "
        "display: inline-flex; "
        "font-size: 1rem; "
        "height: 32px; "
        "justify-content: center; "
        "line-height: 32px; "
        "margin: 0 2px; "
    )


# Initialize IDs for menus
profile_id = "profile-id"
action_id = "action-id"
explore_id = "app-id"


# ----------------------------------------------------------------------------------------------------
#  _                      _
# | |figlet_   __ _  __ _(_)_ __   __ _
# | |   / _ \ / _` |/ _` | | '_ \ / _` |
# | |__| (_) | (_| | (_| | | | | | (_| |
# |_____\___/ \__, |\__, |_|_| |_|\__, |
#             |___/ |___/         |___/
# *******************************
# Set up logging with loguru
# *******************************

# Ensure the logs directory exists
logs_dir = 'logs'
Path(logs_dir).mkdir(parents=True, exist_ok=True)

# Set up log file path
log_file_path = Path(logs_dir) / f'{APP_NAME}.log'

# Remove default logger
logger.remove()

# Add file handler with rotation
logger.add(
    log_file_path,
    rotation="2 MB",
    level="DEBUG",
    format="{time:YYYY-MM-DD HH:mm:ss} | {level} | {message}",
    enqueue=True,
)

# Add colorful console handler
logger.add(
    stderr,
    level="DEBUG" if DEBUG_MODE else "INFO",
    colorize=True,
    format="<green>{time:HH:mm:ss}</green> | "
           "<level>{level: <8}</level> | "
           "<cyan>{message}</cyan>",
    filter=lambda record: DEBUG_MODE or record["level"].no >= logger.level("INFO").no
)

# Create a custom console that respects the DEBUG_MODE


class DebugConsole(Console):
    def print(self, *args, **kwargs):
        if DEBUG_MODE or kwargs.get('force', False):
            super().print(*args, **kwargs)


# Use the custom console
console = DebugConsole(theme=custom_theme)

# Example of how to use force print even when DEBUG_MODE is False


def force_print(message):
    console.print(message, force=True)

# ----------------------------------------------------------------------------------------------------
#   ____                                    _   _               _   _ _     _
#  / ___|___  _ ____   _____ _ __ ___  __ _| |_(_) ___  _ __   | | | (_)___| |_ ___  _ __ _   _
# | |   / _ \| '_ \ \ / / _ \ '__/ __|/ _` | __| |/ _ \| '_ \  | |_| | / __| __/ _ \| '__| | | |
# | |__| (_) | | | \ V /  __/ |  \__ \ (_| | |_| | (_) | | | | |  _  | \__ \ || (_) | |  | |_| |
#  \____\___/|_| |_|\_/ \___|_|  |___/\__,_|\__|_|\___/|_| |_| |_| |_|_|___/\__\___/|_|   \__, |
#                                                                                   figlet|___/
# *******************************
# Create a conversation history
# *******************************


def conversation_history(message=None, role="user", quiet=False):
    """
    Manage the conversation history.

    Args:
        message (str, optional): The message to add to the history.
        role (str, optional): The role of the message sender ("system", "user", or "assistant").

    Returns:
        list: The current conversation history.
    """
    def display_conversation_entry(role: str, content: str):
        table = Table(title="Conversation History Entry", show_header=True)
        table.add_column("Role", style="cyan", width=10)
        table.add_column("Content", style="green")

        # Color-code the content based on the role
        if role == "user":
            content_text = Text(content, style="orange3")
        elif role == "assistant":
            content_text = Text(content, style="green")
        else:  # For system or any other role
            content_text = Text(content, style="white")

        table.add_row(role, content_text)
        console.print(table)

    if message is not None:
        # If the history is empty or the first message isn't a system message, add the system prompt
        if not global_conversation_history or global_conversation_history[0]['role'] != 'system':
            global_conversation_history.appendleft(conversation[0])

        # Add the new message
        global_conversation_history.append({"role": role, "content": message})

        # Display the entry in a rich table
        if not quiet and SHOW_CONVERSATION_HISTORY:
            display_conversation_entry(role, message)

    return list(global_conversation_history)


# Initialize with system message if not already present
if not global_conversation_history:
    conversation_history(conversation[0]['content'], "system")

# ----------------------------------------------------------------------------------------------------
#   ___  _ _
#  / _ \| | | __ _ _ __ ___   __ _ figlet
# | | | | | |/ _` | '_ ` _ \ / _` |
# | |_| | | | (_| | | | | | | (_| |
#  \___/|_|_|\__,_|_| |_| |_|\__,_|
#
# *******************************
# Ollama LLM for local chatbot
# *******************************


def limit_llm_response(response: str) -> str:
    """Truncate the response to a maximum number of words."""
    return ' '.join(response.split()[:MAX_LLM_RESPONSE_WORDS])


def get_best_model() -> str:
    """
    Retrieve the best available LLaMA model or default to 'llama3.2'.

    This function:
    1. Queries the local Ollama API for available models.
    2. Filters for LLaMA models.
    3. Identifies the most recent and capable model using version comparison.
    4. Falls back to a default model if necessary.

    Returns:
        str: The name of the best available LLaMA model, or the default model.
    """
    logger.debug("Attempting to retrieve the best LLaMA model.")
    try:
        response = requests.get("http://localhost:11434/api/tags", timeout=10)
        response.raise_for_status()
        models = [model['name'] for model in response.json().get('models', [])]
        logger.debug(f"Available models: {models}")
    except requests.RequestException as e:
        logger.error(f"Error fetching models: {e}")
        return DEFAULT_LLM_MODEL  # Default if there's an error

    llama_models = [model for model in models if model.lower().startswith('llama')]
    if not llama_models:
        logger.warning("No LLaMA models found. Using default model.")
        return DEFAULT_LLM_MODEL  # Default if no LLaMA models are found

    def parse_version(version_string: str) -> List[Optional[int]]:
        """Parse a version string into a list of integers and strings for comparison."""
        return [int(x) if x.isdigit() else x for x in re.findall(r'\d+|\D+', version_string)]

    def key_func(model: str) -> tuple:
        """Generate a sorting key for a LLaMA model based on its version."""
        parts = model.split(':')
        base_name = parts[0]
        version = parts[1] if len(parts) > 1 else ''
        base_version = re.search(r'llama(\d+(?:\.\d+)*)', base_name.lower())
        base_version = base_version.group(1) if base_version else '0'
        return (
            parse_version(base_version),
            1 if version == 'latest' else 0,
            parse_version(version),
        )

    best_model = max(llama_models, key=key_func)
    logger.debug(f"Selected best model: {best_model}")
    return best_model


def chat_with_ollama(model: str, messages: list) -> str:
    """
    Interact with the Ollama model to generate a response.

    Args:
        model (str): The name of the model to use.
        messages (list): A list of message dictionaries.

    Returns:
        str: The content of the response message.
    """
    # Use conversation_history to get the full conversation including the system message
    full_conversation = conversation_history()

    # Add the new user message to the conversation
    full_conversation.append({"role": "user", "content": messages[-1]['content']})

    url = "http://localhost:11434/api/chat"
    payload = {
        "model": model,
        "messages": full_conversation,
        "stream": False,
    }
    headers = {"Content-Type": "application/json"}

    pretty_payload = json.dumps(payload, indent=2)
    # Create a Syntax object for color-coded JSON
    json_syntax = Syntax(pretty_payload, "json", theme="github-dark", line_numbers=True)
    logger.debug("Sending request to Ollama...")
    console.print(json_syntax)

    try:
        response = requests.post(url, data=json.dumps(payload), headers=headers, timeout=30)
        response.raise_for_status()
        content = response.json()['message']['content']
        logger.debug(f"Received response from Ollama: {content}")

        # Add the AI's response to the conversation history
        conversation_history(content, "assistant", quiet=True)

        return content
    except requests.exceptions.HTTPError as http_err:
        logger.error(f"HTTP error occurred: {http_err}")
        return "I'm having trouble processing that request right now."
    except requests.exceptions.ConnectionError as conn_err:
        logger.error(f"Connection error occurred: {conn_err}")
        return OLLAMA_PLEASE
    except requests.exceptions.Timeout as timeout_err:
        logger.error(f"Timeout error occurred: {timeout_err}")
        return OLLAMA_PLEASE
    except requests.exceptions.RequestException as req_err:
        logger.error(f"An error occurred: {req_err}")
        return OLLAMA_PLEASE

# ----------------------------------------------------------------------------------------------------
#  ____                     ___     ____
# |  _ \ _ __ __ _  __ _   ( _ )   |  _ \ _ __ ___  _ __
# | | | | '__/ _` |/ _` |  / _ \/\ | | | | '__/ _ \| '_ \
# | |_| | | | (_| | (_| | | (_>  < | |_| | | | (_) | |_) |
# |____/|_|  \__,_|\__, |  \___/\/ |____/|_|  \___/| .__/
#                  |___/           figlet          |_|
# *******************************
# JavaScript Includes mess with code beauty
# *******************************

# This function creates a SortableJS script for drag-and-drop reordering of Todo items.

{% raw %}
def SortableJSWithUpdate(
    sel='.sortable',
    ghost_class='blue-background-class'
):
    """
    Create a SortableJS script with update functionality for dynamic endpoints.

    This function generates a JavaScript module that imports and initializes SortableJS,
    enabling drag-and-drop reordering of items. It sets up event handling for reordering
    and updates the server using HTMX after each change. The function now dynamically
    determines the update URL based on the current path.

    Note: SortableJS could be hosted locally for better control and reduced external dependencies.

    Args:
        sel (str): CSS selector for the sortable element.
        ghost_class (str): Class for the ghost element during sorting.

    Returns:
        Script: HTML script element with SortableJS setup.
    """
    src = f"""
import {{Sortable}} from 'https://cdn.jsdelivr.net/npm/sortablejs/+esm';

document.addEventListener('DOMContentLoaded', (event) => {{
    const el = document.querySelector('{sel}');
    if (el) {{
        new Sortable(el, {{
            animation: 150,
            ghost_class: '{ghost_class}',
            onEnd: function (evt) {{
                let items = Array.from(el.children).map((item, index) => ({{
                    id: item.dataset.id,
                    priority: index
                }}));
                
                // Dynamically determine the update URL
                let path = window.location.pathname;
                let updateUrl = path.endsWith('/') ? path + 'sort' : path + '_sort';
                
                htmx.ajax('POST', updateUrl, {{
                    target: el,
                    swap: 'none',
                    values: {{ items: JSON.stringify(items) }}
                }});
            }}
        }});
    }}
}});
"""
    return Script(src, type='module')
{% endraw %}

# ----------------------------------------------------------------------------------------------------
#  ____  _             _
# |  _ \| |_   _  __ _(_)_ __  ___
# | |_) | | | | |/ _` | | '_ \/ __|
# |  __/| | |_| | (_| | | | | \__ \
# |_|   |_|\__,_|\__, |_|_| |_|___/
#                |___/
# Plugins


class BaseApp:
    """
    A base class for creating application components with common CRUD operations.

    This class provides a template for building application components that interact
    with database tables and handle basic Create, Read, Update, Delete (CRUD) operations.
    It includes methods for registering routes, rendering items, and performing various
    database operations.

    To create a new plugin:
    1. Subclass BaseApp
    2. Override methods like render_item, prepare_insert_data, and prepare_update_data
    3. Implement any additional methods specific to your plugin
    4. Register your plugin in the main application (see PLUGIN REGISTRATION section)

    The class is designed to be flexible and extensible, allowing subclasses to override
    or extend its functionality as needed for specific application components.
    """

    def __init__(self, name, table, toggle_field=None, sort_field=None, sort_dict=None):
        self.name = name
        self.table = table
        self.toggle_field = toggle_field
        self.sort_field = sort_field
        self.item_name_field = 'name'  # Default field name
        self.sort_dict = sort_dict or {'id': 'id', sort_field: sort_field}

    def register_routes(self, rt):
        # Register routes: create, read, update, delete, toggle, and sort
        rt(f'/{self.name}', methods=['POST'])(self.insert_item)
        rt(f'/{self.name}/{{item_id}}', methods=['GET'])(self.redirect_url)
        rt(f'/{self.name}/{{item_id}}', methods=['POST'])(self.update_item)  # Changed to POST
        rt(f'/{self.name}/delete/{{item_id}}', methods=['DELETE'])(self.delete_item)
        rt(f'/{self.name}/toggle/{{item_id}}', methods=['POST'])(self.toggle_item)
        rt(f'/{self.name}_sort', methods=['POST'])(self.sort_items)

    def get_action_url(self, action, item_id):
        """
        Generate a URL for a specific action on an item.

        Args:
            action (str): The action method (e.g., 'delete', 'toggle').
            item_id (int): The ID of the item.

        Returns:
            str: The constructed URL.
        """
        return f"/{self.name}/{action}/{item_id}"

    def render_item(self, item):
        """
        Render an individual item.

        Override this method in your plugin to customize how items are displayed.
        This method should return an HTML structure (e.g., Li element) for the item.

        Args:
            item: The item to be rendered.

        Returns:
            HTML element representing the rendered item.
        """
        return item

    async def delete_item(self, request, item_id: int):
        try:
            item = self.table[item_id]
            item_name = getattr(item, self.item_name_field, 'Item')
            self.table.delete(item_id)
            logger.debug(f"Deleted item ID: {item_id}")
            action_details = f"the {self.name} item '{item_name}' was removed."
            prompt = f"{CRUD_PROMPT_PREFIXES['delete']}{action_details}{CRUD_SUFFIX}"
            action_data = json.dumps({
                "action_type": "delete",
                "table": self.name,
                "item_id": item_id,
            })
            await chatq(prompt, action_data)
            return ''
        except Exception as e:
            error_msg = f"Error deleting item: {str(e)}"
            logger.error(error_msg)
            action_details = f"an error occurred while deleting {self.name} (ID: {item_id}): {error_msg}"
            prompt = f"{CRUD_PROMPT_PREFIXES['error']}{action_details}"
            await chatq(prompt)
            return str(e), 500

    async def toggle_item(self, request, item_id: int):
        try:
            item = self.table[item_id]
            current_status = getattr(item, self.toggle_field)
            new_status = not current_status
            setattr(item, self.toggle_field, new_status)
            updated_item = self.table.update(item)
            item_name = getattr(updated_item, self.item_name_field, 'Item')
            status_text = 'checked' if new_status else 'unchecked'
            action_details = f"the {self.name} item '{item_name}' is now {status_text}."
            prompt = f"{CRUD_PROMPT_PREFIXES['toggle']}{action_details}{CRUD_SUFFIX}"
            # For consistency, we'll always send the same data structure details dict
            toggle_dict = {
                self.toggle_field: new_status
            }
            action_data = json.dumps({
                "action_type": "toggle",
                "table": self.name,
                "item_id": item_id,
                "details": toggle_dict
            })
            await chatq(prompt, action_data)
            return self.render_item(updated_item)
        except Exception as e:
            error_msg = f"Error toggling item: {str(e)}"
            logger.error(error_msg)
            action_details = f"an error occurred while toggling {self.name} (ID: {item_id}): {error_msg}"
            prompt = f"{CRUD_PROMPT_PREFIXES['error']}{action_details}"
            await chatq(prompt)
            return str(e), 500

    async def sort_items(self, request):
        logger.debug(f"Received request to sort {self.name}.")
        try:
            values = await request.form()
            items = json.loads(values.get('items', '[]'))
            logger.debug(f"Parsed items: {items}")
            changes = []
            sort_dict = {}
            for item in items:
                item_id = int(item['id'])
                priority = int(item['priority'])
                self.table.update(id=item_id, **{self.sort_field: priority})
                item_name = getattr(self.table[item_id], self.item_name_field, 'Item')
                sort_dict[item_id] = priority
                changes.append(f"'{item_name}' moved to position {priority}")
            changes_str = '; '.join(changes)
            action_details = f"the {self.name} items were reordered: {changes_str}"
            prompt = f"{CRUD_PROMPT_PREFIXES['sort']}{action_details}{CRUD_SUFFIX}"
            action_data = json.dumps({
                "action_type": "sort",
                "table": self.name,
                "details": {self.sort_field: sort_dict}
            })
            await chatq(prompt, action_data)
            logger.debug(f"{self.name.capitalize()} order updated successfully")
            return ''
        except json.JSONDecodeError as e:
            error_msg = f"Invalid data format: {str(e)}"
            logger.error(error_msg)
            action_details = f"an error occurred while sorting {self.name} items: {error_msg}"
            prompt = f"{CRUD_PROMPT_PREFIXES['error']}{action_details}"
            await chatq(prompt)
            return "Invalid data format", 400
        except Exception as e:
            error_msg = f"Error updating {self.name} order: {str(e)}"
            logger.error(error_msg)
            action_details = f"an error occurred while sorting {self.name} items: {error_msg}"
            prompt = f"{CRUD_PROMPT_PREFIXES['error']}{action_details}"
            await chatq(prompt)
            return str(e), 500

    async def insert_item(self, request):
        try:
            form = await request.form()
            new_item_data = self.prepare_insert_data(form)
            if not new_item_data:
                return ''
            new_item = await self.create_item(**new_item_data)
            item_name = getattr(new_item, self.item_name_field, 'Item')
            action_details = f"a new {self.name} item '{item_name}' was added."
            prompt = f"{CRUD_PROMPT_PREFIXES['insert']}{action_details}{CRUD_SUFFIX}"
            action_data = json.dumps({
                "action_type": "insert",
                "table": self.name,
                "item_id": new_item.id,
                "details": new_item_data
            })
            await chatq(prompt, action_data)
            return self.render_item(new_item)
        except Exception as e:
            error_msg = f"Error inserting {self.name}: {str(e)}"
            logger.error(error_msg)
            action_details = f"an error occurred while adding a new {self.name}: {error_msg}"
            prompt = f"{CRUD_PROMPT_PREFIXES['error']}{action_details}"
            await chatq(prompt)
            return str(e), 500

    async def update_item(self, request, item_id: int):
        try:
            form = await request.form()
            update_data = self.prepare_update_data(form)
            if not update_data:
                return ''
            item = self.table[item_id]
            before_state = item.__dict__.copy()
            for key, value in update_data.items():
                setattr(item, key, value)
            updated_item = self.table.update(item)
            after_state = updated_item.__dict__
            # We need to construct a JSON-friendly dict of changes, only for the keys and new values
            change_dict = {}
            for key in update_data.keys():
                if before_state.get(key) != after_state.get(key):
                    change_dict[key] = after_state.get(key)

            changes = [f"{key} changed from '{before_state.get(key)}' to '{after_state.get(key)}'"
                       for key in update_data.keys() if before_state.get(key) != after_state.get(key)]
            changes_str = '; '.join(changes)
            item_name = getattr(updated_item, self.item_name_field, 'Item')
            action_details = f"the {self.name} item '{item_name}' was updated. Changes: {changes_str}"
            prompt = f"{CRUD_PROMPT_PREFIXES['update']}{action_details}{CRUD_SUFFIX}"
            action_data = json.dumps({
                "action_type": "update",
                "table": self.name,
                "item_id": item_id,
                "details": change_dict
            })
            await chatq(prompt, action_data)
            logger.debug(f"Updated {self.name} item {item_id}")
            return self.render_item(updated_item)
        except Exception as e:
            error_msg = f"Error updating {self.name} {item_id}: {str(e)}"
            logger.error(error_msg)
            action_details = f"an error occurred while updating {self.name} (ID: {item_id}): {error_msg}"
            prompt = f"{CRUD_PROMPT_PREFIXES['error']}{action_details}"
            await chatq(prompt)
            return str(e), 500

    async def read_item(self, request, item_id: int):
        """
        Read table using profile_id to .xtra() filter to just that profile's items.
        Return a pretty-printed JSON string of the table contents.
        """
        profile_id = db['last_profile_id']
        
        # Apply the xtra filter to the table
        filtered_table = self.table.xtra(profile_id=profile_id)
        
        # Get all items from the filtered table
        items = list(filtered_table())
        
        # Convert items to a list of dictionaries
        item_dicts = [item.__dict__ for item in items]
        
        # Create a dictionary with table name and contents
        table_data = {
            "table_name": self.name,
            "contents": item_dicts
        }
        
        # Convert to a pretty-printed JSON string
        json_output = json.dumps(table_data, indent=2, default=str)
        return json_output
    
    async def create_item(self, **kwargs):
        """Create a new item in the table."""
        try:
            logger.debug(f"Creating new {self.name} with data: {kwargs}")
            new_item = self.table.insert(kwargs)
            logger.debug(f"Created new {self.name}: {new_item}")
            return new_item
        except Exception as e:
            logger.error(f"Error creating {self.name}: {str(e)}")
            raise e

    async def redirect_url(self, item_id: int):
        db["last_profile_id"] = item_id

        # Construct the new URL using the base endpoint and the new item_id
        new_url = f"/{self.name}/{item_id}"

        # Get the name of the new profile
        new_profile = self.table[item_id]
        new_profile_name = getattr(new_profile, self.item_name_field, 'Unknown Profile')

        # Prepare action details for logging
        action_details = f"Switched to profile '{new_profile_name}'"
        prompt = f"{CRUD_PROMPT_PREFIXES['update']}{action_details}"
        action_data = json.dumps({
            "action_type": "profile_switch",
            "table": self.name,
            "item_id": item_id,
            "item_name": new_profile_name
        })

        # Call chatq silently
        await chatq(prompt, action_data, silent=True)

        return Redirect(new_url)

    def prepare_insert_data(self, form):
        """
        Prepare data for inserting a new item.

        Override this method in your plugin to handle the specific fields of your items.
        This method should process form data and return a dictionary of item properties.

        Args:
            form: The submitted form data.

        Returns:
            dict: Prepared data for item insertion.
        """
        raise NotImplementedError("Subclasses must implement prepare_insert_data")

    def prepare_update_data(self, form):
        """
        Prepare data for updating an existing item.

        Override this method in your plugin to handle the specific fields of your items.
        This method should process form data and return a dictionary of updated properties.

        Args:
            form: The submitted form data.

        Returns:
            dict: Prepared data for item update.
        """
        raise NotImplementedError("Subclasses must implement prepare_update_data")


class TodoApp(BaseApp):
    """
    TodoApp plugin implementation.

    This class demonstrates how to create a plugin for the application using the BaseApp class.
    It provides specific implementations for rendering todo items, preparing data for insertion
    and updates, and other todo-specific functionality.
    """

    def __init__(self, table):
        super().__init__(
            name=table.name,
            table=table,
            toggle_field='done',
            sort_field='priority'
        )
        self.item_name_field = 'name'  # Specify the field name used for item names

    def render_item(self, todo):
        """
        Render a single todo item.

        This method customizes how todo items are displayed in the UI.
        """
        return render_todo(todo)

    def prepare_insert_data(self, form):
        """
        Prepare data for inserting a new todo item.

        This method processes form data to create a new todo item.
        """
        name = form.get('name', '').strip()
        if not name:
            return ''
        current_profile_id = db.get("last_profile_id", 1)
        max_priority = max((t.priority or 0 for t in self.table()), default=-1) + 1
        return {
            "name": name,
            "done": False,
            "priority": max_priority,
            "profile_id": current_profile_id,
        }

    def prepare_update_data(self, form):
        """
        Prepare data for updating an existing todo item.

        This method processes form data to update an existing todo item.
        """
        name = form.get('name', '').strip()
        if not name:
            return ''
        return {
            "name": name,
            "done": form.get('done', '').lower() == 'true',
        }


class ProfileApp(BaseApp):
    def __init__(self, table):
        super().__init__(
            name=table.name,
            table=table,
            toggle_field='active',
            sort_field='priority'
        )
        self.item_name_field = 'name'  # Specify the field name used for item names

    def render_item(self, profile):
        return render_profile(profile)

    def prepare_insert_data(self, form):
        profile_name = form.get('profile_name', '').strip()
        if not profile_name:
            return ''  # Return empty string instead of raising an exception
        max_priority = max((p.priority or 0 for p in self.table()), default=-1) + 1
        return {
            "name": profile_name,
            "address": form.get('profile_address', '').strip(),
            "code": form.get('profile_code', '').strip(),
            "active": True,
            "priority": max_priority,
        }

    def prepare_update_data(self, form):
        profile_name = form.get('profile_name', '').strip()
        if not profile_name:
            return ''  # Return empty string instead of raising an exception
        return {
            "name": profile_name,
            "address": form.get('profile_address', '').strip(),
            "code": form.get('profile_code', '').strip(),
            "active": form.get('active', '').lower() == 'true',
        }


# ----------------------------------------------------------------------------------------------------
#  _____         _   _   _ _____ __  __ _
# |  ___|_ _ ___| |_| | | |_   _|  \/  | |
# | |_ / _` / __| __| |_| | | | | |  | | |
# |  _| (_| \__ \ |_|  _  | | | | |  | | |___
# |_|  \__,_|___/\__|_| |_| |_| |_|  |_|_____|figlet
#
# *******************************
# It's a fastapp table splat, not dataclass alone!
# *******************************


# Unpack the returned tuple from fast_app (lots of explaining to do here)
app, rt, (store, Store), (tasks, Task), (customers, Customer) = fast_app(
    "data/data.db",
    ws_hdr=True,
    live=True,
    hdrs=(
        SortableJSWithUpdate('.sortable'),
        Script(type='module')
    ),
    store={
        "key": str,
        "value": str,
        "pk": "key"
    },
    task={
        "id": int,
        "name": str,  # Changed from "title" to "name"
        "done": bool,
        "priority": int,
        "profile_id": int,
        "pk": "id"
    },
    customer={
        "id": int,
        "name": str,
        "address": str,
        "code": str,
        "active": bool,
        "priority": int,
        "pk": "id"
    },
)

# PLUGIN REGISTRATION
# Instantiate and register routes for the TodoApp plugin
todo_app = TodoApp(table=tasks)
todo_app.register_routes(rt)

# To add a new plugin, follow these steps:
# 1. Create a new plugin class (e.g., NewPlugin) that inherits from BaseApp
# 2. Instantiate your plugin with the appropriate table
# 3. Register the routes for your plugin
# Example:
# new_plugin = NewPlugin(table=new_plugin_table)
# new_plugin.register_routes(rt)

profile_app = ProfileApp(table=customers)
profile_app.register_routes(rt)

# Aliases for table names
todos = tasks
profiles = customers

# Configurable constants for table names and endpoints
MENU_ITEMS = [todo_app.name, 'app_1', 'app_2', 'app_3']

# Add this near your other configuration variables (around line 100-120)
APP_MESSAGES = {
    '': "Welcome to the home page!",
    todo_app.name: f"You've entered the {todo_app.name} area.",
    profile_app.name: f"You're now in the {profile_app.name} section.",
    'app_1': "Welcome to App 1!",
    'app_2': "Welcome to App 2!",
    'app_3': "Welcome to App 3!",
}


# ----------------------------------------------------------------------------------------------------
#  ____  _      _   _     _ _ figlet ____  ____
# |  _ \(_) ___| |_| |   (_) | _____|  _ \| __ )
# | | | | |/ __| __| |   | | |/ / _ \ | | |  _ \
# | |_| | | (__| |_| |___| |   <  __/ |_| | |_) |
# |____/|_|\___|\__|_____|_|_|\_\___|____/|____/
#
# *******************************
# DictLikeDB Persistence Convenience Wrapper
# *******************************


class DictLikeDB:
    """
    A robust wrapper for dictionary-like persistent storage.

    This class provides a familiar dict-like interface to interact with
    various types of key-value stores, including databases and file systems.
    It emphasizes the power and flexibility of key-value pairs as a
    fundamental data structure in programming and system design.

    Key features:
    1. Persistence: Data survives beyond program execution.
    2. Dict-like API: Familiar Python dictionary operations.
    3. Adaptability: Can wrap different storage backends.
    4. Logging: Built-in logging for debugging and monitoring.

    By abstracting the underlying storage mechanism, this class allows
    for easy swapping of backends without changing the client code.
    This demonstrates the power of Python's duck typing and the
    universality of the key-value paradigm across different storage solutions.
    """

    def __init__(self, store, Store):
        self.store = store
        self.Store = Store

    def __getitem__(self, key):
        """Retrieve an item from the store by key."""
        try:
            value = self.store[key].value
            logger.debug(f"Retrieved from DB: {key} = {value}")
            return value
        except NotFoundError:
            logger.error(f"Key not found: {key}")
            raise KeyError(key)

    def __setitem__(self, key, value):
        """Set an item in the store by key."""
        try:
            self.store.update({"key": key, "value": value})
            logger.debug(f"Updated persistence store: {key} = {value}")
        except NotFoundError:
            self.store.insert({"key": key, "value": value})
            logger.debug(f"Inserted new item in persistence store: {key} = {value}")

    def __delitem__(self, key):
        """Delete an item from the store by key."""
        try:
            self.store.delete(key)
            logger.warning(f"Deleted key from persistence store: {key}")
        except NotFoundError:
            logger.error(f"Attempted to delete non-existent key: {key}")
            raise KeyError(key)

    def __contains__(self, key):
        """Check if a key exists in the store."""
        exists = key in self.store
        logger.debug(f"Key '{key}' exists: {exists}")
        return exists

    def __iter__(self):
        """Iterate over the keys in the store."""
        for item in self.store():
            yield item.key

    def items(self):
        """Return key-value pairs in the store."""
        for item in self.store():
            yield item.key, item.value

    def keys(self):
        """Return a list of keys in the store."""
        return list(self)

    def values(self):
        """Return values in the store."""
        for item in self.store():
            yield item.value

    def get(self, key, default=None):
        """Get an item from the store, returning default if not found."""
        try:
            return self[key]
        except KeyError:
            logger.debug(f"Key '{key}' not found. Returning default.")
            return default


# Create the wrapper
db = DictLikeDB(store, Store)
logger.debug("Database wrapper initialized.")

# *******************************
# Database Initialization
# *******************************


def populate_initial_data():
    """
    Populate the database with initial data if empty.

    This function ensures that there is at least one profile and one todo item in the database.
    """
    logger.debug("Populating initial data.")
    if not profiles():
        # Create a default profile
        default_profile = profiles.insert({
            "name": f"Default {profile_app.name.capitalize()}",  # Updated to use CUSTOMER
            "address": "",
            "code": "",
            "active": True,
            "priority": 0,
        })
        logger.debug(f"Inserted default profile: {default_profile}")
    else:
        default_profile = profiles()[0]

    if not todos():
        # Add a sample todo with the default profile_id
        todos.insert({
            "name": f"Sample {todo_app.name}",
            "done": False,
            "priority": 1,
            "profile_id": default_profile.id,
        })
        logger.debug(f"Inserted sample {todo_app.name} item.")


# Call this function after the fast_app initialization
populate_initial_data()

# ----------------------------------------------------------------------------------------------------
#  _   _
# | | | | ___  _ __ ___   ___
# | |_| |/ _ \| '_ ` _ \ / _ \
# |  _  | (_) | | | | | |  __/
# |_| |_|\___/|_| |_| |_|\___|
#
# *******************************
# Top Level Layout and Routing
# *******************************


def home(request):
    """
    Central routing and rendering mechanism for the application.

    This function processes requests for the main page and specific app pages defined in MENU_ITEMS.
    It allows for easy integration of new apps by adding them to the MENU_ITEMS list and implementing
    their corresponding render and CRUD functions.

    home()
    |
    +-- create_outer_container()
        |
        +-- create_nav_group()
        |   |
        |   +-- create_nav_menu()
        |       |
        |       +-- create_filler_item()
        |       +-- create_profile_menu()
        |       +-- create_app_menu()
        |       +-- create_search_input()
        |
        +-- create_grid_left()
        |   |
        |   +-- create_todo_form() (if in todo view)
        |
        +-- create_chat_interface()
        |   |
        |   +-- mk_chat_input_group()
        |
        +-- create_poke_button()


    +-------------------------------------+
    |           Navigation Bar            |
    +-------------------------------------+
    |             Main Content            |
    | +-----------------+ +-------------+ |
    | |                 | |             | |
    | |    Main Area    | |    Chat     | |
    | |   (Grid Left)   | |  Interface  | |
    | |                 | |             | |
    | |                 | |             | |
    | |                 | |             | |
    | +-----------------+ +-------------+ |
    +-------------------------------------+
    |           Poke Button               |
    +-------------------------------------+


    Key tasks performed:
    1. Determines the requested path and sets up the appropriate menu context.
    2. Applies profile filtering if necessary.
    3. Creates the main content, including navigation and app-specific views.
    4. Handles the Todo app view if requested.
    5. Provides a structure for adding new app views seamlessly.

    To add a new app:
    1. Add the app name to the MENU_ITEMS list.
    2. Implement a render function for the app (e.g., render_new_app()).
    3. Create CRUD functions for the app (e.g., new_app_create(), new_app_update(), etc.).
    4. Add a condition in this function to handle the new app's view, similar to the Todo view.

    The function uses HTMX for dynamic content updates, allowing for a smooth single-page
    application (SPA) experience. Refer to the Todo and Profile apps for examples of
    how to structure new app components.

    Args:
        request: The incoming HTTP request.

    Returns:
        Titled: An HTML response with the appropriate title and content for the requested page.
    """
    path = request.url.path.strip('/')
    logger.debug(f"Received request for path: {path}")

    # Check for temp_message first
    temp_message = None
    if "temp_message" in db:
        temp_message = db["temp_message"]
        del db["temp_message"]

    menux = path if path else "home"

    fig(menux, font='ogre')
    logger.debug(f"Selected explore item: {menux}")
    db["last_app_choice"] = menux
    db["last_visited_url"] = request.url.path

    current_profile_id = db.get("last_profile_id")
    if current_profile_id:
        logger.debug(f"Current profile ID: {current_profile_id}")
        todos.xtra(profile_id=current_profile_id)
    else:
        logger.warning("No current profile ID found. Using default filtering.")
        todos.xtra(profile_id=None)

    if menux == profile_app.name:
        response = get_profiles_content()
    else:
        if current_profile_id is None:
            first_profiles = profiles(order_by='id', limit=1)
            if first_profiles:
                current_profile_id = first_profiles[0].id
                db["last_profile_id"] = current_profile_id
                logger.debug(f"Set default profile ID to {current_profile_id}")
            else:
                logger.warning("No profiles found in the database")

        if current_profile_id is not None:
            todos.xtra(profile_id=current_profile_id)

        menux = db.get("last_app_choice", "App")
        response = create_outer_container(current_profile_id, menux, temp_message)

    logger.debug("Returning response for main GET request.")
    last_profile_name = get_profile_name()
    return Titled(
        f"{APP_NAME} / {endpoint_fmt(last_profile_name)} / {endpoint_fmt(menux)}",
        response,
        create_chat_scripts(temp_message),
        hx_ext='ws',
        ws_connect='/ws',
        data_theme="dark",
    )

def create_chat_scripts(temp_message=None):
    """
    Create a combined JavaScript for chat functionality.

    This function generates a single JavaScript that handles both clearing the message input
    after sending and processing any temporary message on page load.

    Args:
        temp_message (str, optional): A temporary message to be processed on page load.

    Returns:
        Script: An HTML script element containing the combined JavaScript.
    """
    combined_script = f"""
    document.body.addEventListener('htmx:wsAfterSend', function(event) {{
        document.getElementById('msg').value = '';
    }});

{% raw %}
    document.addEventListener('DOMContentLoaded', function() {{
        const tempMessage = {json.dumps(temp_message)};
        if (tempMessage) {{
            fetch('/process_temp_message', {{
                method: 'POST',
                headers: {{ 'Content-Type': 'application/json' }},
                body: JSON.stringify({{ message: tempMessage }})
            }});
        }}
    }});
{% endraw %}
    """
    return Script(combined_script)

# ----------------------------------------------------------------------------------------------------
#  _   _             _             _   _
# | \ | | __ ___   _(_) __ _  __ _| |_(_) ___  _ __
# |  \| |/ _` \ \ / / |/ _` |/ _` | __| |/ _ \| '_ \
# | |\  | (_| |\ V /| | (_| | (_| | |_| | (_) | | | |
# |_| \_|\__,_| \_/ |_|\__, |\__,_|\__|_|\___/|_| |_|
#                      |___/
# *******************************
# Site Navigation
# *******************************

def create_nav_group():
    """
    Create the navigation group.

    This function generates the navigation bar at the top of the application layout.
    It contains dropdown menus for profile selection, app selection, and a search input.
    The structure corresponds to the following part of the layout:

    +----------------------------------+
    |             nav_group            |
    |  (This fieldset with role=group) |
    +----------------------------------+
    |                  |               |
    |                  |               |
    |                  |               |

    Returns:
        Group: A fieldset with role="group" containing the navigation elements.
    """
    nav = create_nav_menu()
    nav_group_style = (
        "display: flex; "
        "align-items: center; "
        "position: relative;"
    )
    return Group(nav, style=nav_group_style)


def create_nav_menu():
    """
    Create the navigation menu with app, profile, and action dropdowns.

    This function orchestrates the creation of various navigation elements:
    - A filler item for spacing
    - A profile selection dropdown
    - An app selection dropdown
    - A search input field

    The structure is as follows:

    +----------------------------------+
    |                                  |
    +----------------------------------+

    Returns:
        Div: An HTML div containing the navigation menu elements.
    """
    logger.debug("Creating navigation menu.")
    menux = db.get("last_app_choice", "App")
    selected_profile_id = db.get("last_profile_id")
    selected_profile_name = get_profile_name()

    nav_items = [
        create_filler_item(),
        create_profile_menu(selected_profile_id, selected_profile_name),
        create_app_menu(menux),
        create_search_input()
    ]

    nav = Div(
        *nav_items,
        style="display: flex; gap: 20px;"
    )

    logger.debug("Navigation menu created.")
    return nav


def create_filler_item():
    """
    Create a filler item for the navigation menu.

    +----------------------------------+
    | Filler |                         |
    +----------------------------------+

    Returns:
        Li: A list item element serving as a filler.
    """
    return Li(
        Span(" "),
        style=(
            "display: flex; "
            "flex-grow: 1; "
            "justify-content: center; "
            "list-style-type: none; "
            f"min-width: {NAV_FILLER_WIDTH}; "
        ),
    )


def create_profile_menu(selected_profile_id, selected_profile_name):
    """
    Create the profile selection dropdown menu.

    +----------------------------------+
    |        | Profile |               |
    +----------------------------------+

    Args:
        selected_profile_id (str): The ID of the currently selected profile.
        selected_profile_name (str): The name of the currently selected profile.

    Returns:
        Details: A dropdown menu for profile selection.
    """
    def get_selected_item_style(is_selected):
        return "background-color: var(--pico-primary-background); " if is_selected else ""

    menu_items = []

    menu_items.append(
        Li(
            A(
                f"Edit {format_endpoint_name(profile_app.name)} {LIST_SUFFIX}",
                href=f"/redirect/{profile_app.name}",  # Changed to use redirect endpoint
                cls="dropdown-item",
                style=(
                    f"{NOWRAP_STYLE} "
                    "font-weight: bold; "
                    "border-bottom: 1px solid var(--pico-muted-border-color);"
                    "display: block; "  # Make the anchor fill the list item
                    "text-align: center; "  # Center the text horizontally
                )
            ),
            style=(
                "display: block; "
                "text-align: center; "  # Center the content horizontally
                "padding: 5px 0; "  # Add some vertical padding
            )
        )
    )

    active_profiles = profiles("active=?", (True,), order_by='priority')

{% raw %}
    for profile in active_profiles:
        is_selected = str(profile.id) == str(selected_profile_id)
        item_style = get_selected_item_style(is_selected)
        menu_items.append(
            Li(
                Label(
                    Input(
                        type="radio",
                        name="profile",
                        value=str(profile.id),
                        checked=is_selected,
                        hx_post=f"/select_profile",  # Change to POST
                        hx_vals=f'js:{{profile_id: "{profile.id}"}}',  # Send profile_id as data
                        hx_target="body",
                        hx_swap="outerHTML",
                    ),
                    profile.name,
                    style="display: flex; align-items: center;"
                ),
                style=f"text-align: left; {item_style}"
            )
        )
{% endraw %}
    return Details(
        Summary(
            f"{profile_app.name.upper()}: {selected_profile_name}",
            style=generate_menu_style(NOWRAP_STYLE),
            id=profile_id,
        ),
        Ul(
            *menu_items,
            style="padding-left: 0;",
        ),
        cls="dropdown",
    )


def create_app_menu(menux):
    """
    Create the app selection dropdown menu.

    +----------------------------------+
    |        |         | App |         |
    +----------------------------------+

    Args:
        menux (str): The currently selected app.

    Returns:
        Details: A dropdown menu for app selection.
    """
    menu_items = []

    for item in MENU_ITEMS:
        is_selected = item == menux
        item_style = "background-color: var(--pico-primary-background); " if is_selected else ""
        menu_items.append(
            Li(
                A(
                    format_endpoint_name(item),
                    href=f"/redirect/{item}",  # Changed to use redirect endpoint
                    cls="dropdown-item",
                    style=f"{NOWRAP_STYLE} {item_style}"
                ),
                style="display: block;"
            )
        )

    return Details(
        Summary(
            f"APP: {format_endpoint_name(menux)}",
            style=generate_menu_style(NOWRAP_STYLE),
            id=explore_id,
        ),
        Ul(
            *menu_items,
            cls="dropdown-menu",
        ),
        cls="dropdown",
    )


def create_search_input():
    """
    Create the search input form for the navigation menu.

    +----------------------------------+
    |        |         |     | Search  |
    +----------------------------------+

    Returns:
        Form: A form containing the search input.
    """
    return Form(
        Group(
            Input(
                type="search",
                placeholder="Search",
                name="nav_input",
                id="nav-input",
                hx_post="/search",
                hx_trigger="keyup[keyCode==13]",
                hx_target="#msg-list",
                hx_swap="innerHTML",
                style=(
                    f"{generate_menu_style(NOWRAP_STYLE)} "
                    f"width: {NOWRAP_STYLE}; "
                    "padding-right: 0px; "
                    "border: 1px solid var(--pico-muted-border-color); "
                ),
            ),
        ),
        hx_post="/search",
        hx_target="#msg-list",
        hx_swap="innerHTML",
    )


def create_outer_container(current_profile_id, menux, temp_message=None):
    """
    Create the outer container for the application, including navigation and main content.

    This function sets up the overall structure of the page. Plugins can integrate here
    by adding conditions to handle their specific views.

    This function generates the primary content area of the application, divided into
    two columns: a main area (left) and a chat interface (right). The layout is as follows:

    +-------------------------------------+
    |             Main Content            |
    | +---------------------------------+ |
    | |                 |               | |
    | |                 |               | |
    | |                 |               | |
    | |                 |               | |
    | |                 |               | |
    | |                 |               | |
    | |                 |               | |
    | +---------------------------------+ |
    +-------------------------------------+

    To add a new plugin at this level:
    1. Add a condition to check if the current view is for your plugin
    2. If it is, you can return a completely custom structure for your plugin
    3. Otherwise, proceed with the default structure

    Args:
        current_profile_id (int): The ID of the current profile.
        menux (str): The current menu selection.
        temp_message (str, optional): A temporary message to display. Defaults to None.

    Returns:
        Container: The outer container with all page elements.
    """
    nav_group = create_nav_group()
    is_todo_view = False

    # PLUGIN INTEGRATION POINT: Check for plugin-specific views
    if menux == todo_app.name:
        is_todo_view = True
        todo_items = sorted(todos(), key=lambda x: x.priority)
        logger.debug(f"Fetched {len(todo_items)} todo items for profile ID {current_profile_id}.")
    elif menux == "your_new_plugin_name":
        # Handle your new plugin's view here
        # return your_new_plugin.create_view()
        pass
    else:
        is_todo_view = False
        todo_items = []

    return Container(
        nav_group,
        Grid(
            create_grid_left(is_todo_view, menux, todo_items),
            create_chat_interface(temp_message),
            cls="grid",
            style=(
                "display: grid; "
                "gap: 20px; "
                f"grid-template-columns: {GRID_LAYOUT}; "
            ),
        ),
        create_poke_button(),
        create_form_reset_script()
    )


def create_grid_left(is_todo_view, menux, todo_items):
    """
    Create the left column of the main grid layout.

    This function handles the content for the left side of the two-column layout.
    Plugins can integrate here to display their content in this area.

    To add a new plugin at this level:
    1. Add a condition to check if the current view is for your plugin
    2. Create a Card or other container for your plugin's content
    3. Use your plugin's render_item method to display individual items
    """
    return Div(
        Card(
            H2(f"{endpoint_fmt(menux)} {LIST_SUFFIX}"),
            Ul(*[todo_app.render_item(todo) for todo in todo_items],
               id='todo-list',
               cls='sortable',
               style="padding-left: 0;"),
            header=create_todo_form() if is_todo_view else None,
        ) if is_todo_view else Card(
            H2(f"{endpoint_fmt(menux)}"),
            P("This is a placeholder for the selected application."),
        ),
        id="content-container",
    )


def create_main_area(is_todo_view, menux, todo_items):
    """
    Create the main content area for the left column of the layout.

    This function generates the primary content for the left side of the 2-column layout.
    It creates a nested structure with an outer div for spacing and an inner div (Card)
    for the actual content. The structure corresponds to the following part of the layout:

    +--------------------------------------
    |                      |               
    |   Main Area          |               
    |   (This div)         |               
    |                      |               
    | - create_todo_form() |               
    |                      |               
    +--------------------------------------

    Args:
        is_todo_view (bool): Whether the current view is the Todo list.
        menux (str): The current menu selection.
        todo_items (list): List of todo items to display if in Todo view.

    Returns:
        Div: The left column content.
    """
    if is_todo_view:
        return Div(
            Card(
                H2(f"{endpoint_fmt(menux)} {LIST_SUFFIX}"),
                Ul(*[todo_app.render_item(todo) for todo in todo_items],
                   id='todo-list',
                   cls='sortable',
                   style="padding-left: 0;"),
                header=create_todo_form(),
            ),
            id="content-container",
        )
    elif menux == "your_new_plugin_name":
        # PLUGIN INTEGRATION POINT: Add your new plugin's content here
        # return your_new_plugin.create_content()
        pass
    else:
        return Div(
            Card(
                H2(f"{endpoint_fmt(menux)}"),
                P("This is a placeholder for the selected application."),
            ),
            id="content-container",
        )


def create_todo_form():
    """Create the form for adding new todo items."""
    return Form(
        Group(
            Input(
                placeholder=f'Add new {todo_app.name.capitalize()}',
                id='name',  # Changed from 'title'
                name='name',  # Changed from 'title'
                autofocus=True,
            ),
            Button("Add", type="submit"),
        ),
        hx_post=f"/{todo_app.name}",
        hx_swap="beforeend",
        hx_target="#todo-list",
    )


# Usage in create_chat_interface function:
def create_chat_interface(temp_message=None):
    """
    Create the chat interface for the right column of the layout.

    This function generates the chat interface component for the right side of the 2-column layout.
    It creates a Card containing a chat message list and an input form for new messages.
    The structure corresponds to the following part of the layout:

    +-------------------------------------------+
    |                  |                        |
    |                  |           Chat         |
    |                  |        Interface       |
    |                  |        (This div)      |
    |                  |                        |
    |                  |                        |
    |                  | - mk_chat_input_group()|
    +-------------------------------------------+

    Args:
        temp_message (str, optional): A temporary message to be processed on page load.

    Returns:
        Div: The chat interface div containing the chat message list and input form.
    """
    return Div(
        Card(
            H2(f"{APP_NAME} Chatbot"),
            Div(
                id='msg-list',
                cls='overflow-auto',
                style='height: 40vh;',
            ),
            footer=Form(mk_chat_input_group()),
        ),
        id="chat-interface",
    )


@rt('/process_temp_message', methods=['POST'])
async def process_temp_message(request):
    data = await request.json()
    message = data.get('message')
    if message:
        await chatq(message)
        # Safely remove the temp_message if it exists
        if "temp_message" in db:
            del db["temp_message"]
    return JSONResponse({"status": "success"})


def mk_chat_input_group(disabled=False, value='', autofocus=True):
    """
    Create a chat input group with a message input and a send button.

    Args:
        disabled (bool): Whether the input group should be disabled.
        value (str): The pre-filled value for the input field.
        autofocus (bool): Whether the input field should autofocus.

    Returns:
        Group: An HTML group containing the chat input and send button.
    """
    return Group(
        Input(
            id='msg',
            name='msg',
            placeholder='Chat...',
            value=value,
            disabled=disabled,
            autofocus='autofocus' if autofocus else None,
        ),
        Button(
            "Send",
            type='submit',
            ws_send=True,
            id='send-btn',
            disabled=disabled,
        ),
        id='input-group'
    )


def create_poke_button():
    """
    Create the 'Poke Chatbot' button.

    This function generates a fixed-position button at the bottom right of the screen
    that allows users to interact with the chatbot. The button's position in the layout
    can be represented as follows:

    |                  |               |
    |   Main Area      |     Chat      |
    |                  | Interface     |
    |                  |               |
    +----------------------------------+
    |           Poke Button            |
    |           (This div)             |
    +----------------------------------+

    Returns:
        Div: A div containing the 'Poke Chatbot' button with fixed positioning.
    """
    return Div(
        A(
            f"Poke {APP_NAME} Chatbot",
            hx_post="/poke",
            hx_target="#msg-list",
            hx_swap="innerHTML",
            cls="button",
        ),
        style=(
            "bottom: 20px; "
            "position: fixed; "
            "right: 20px; "
            "z-index: 1000; "
        ),
    )


def create_form_reset_script():
    """Create the script to reset the form after submission."""
    return Script("""
        document.addEventListener('htmx:afterSwap', function(event) {
            if (event.target.id === 'todo-list' && event.detail.successful) {
                const form = document.querySelector('form[hx-target="#todo-list"]');
                if (form) {
                    form.reset();
                }
            }
        });
    """)


def create_menu_item(title, link, summary_id, is_traditional_link=False, additional_style=""):
    """
    Centralizes how Li's are created for the menu. Good for HTMX.

    Args:
        title (str): The display title of the menu item.
        link (str): The URL or endpoint the menu item points to.
        summary_id (str): The ID of the summary element to target.
        is_traditional_link (bool): If True, use a traditional href link.
        additional_style (str): Any additional CSS styles to apply.

    Returns:
        Li: An HTML list item representing the menu item.
    """
    item_style = f"text-align: center; {additional_style}"
    if is_traditional_link:
        return Li(
            A(
                title,
                href=link,
                cls="menu-item",
                style=item_style,
            )
        )
    else:
        return Li(
            A(
                title,
                hx_get=link,
                hx_target=f"#{summary_id}",
                hx_swap="outerHTML",
                hx_trigger="click",
                hx_push_url="false",
                cls="menu-item",
                style=item_style,
            )
        )


# ----------------------------------------------------------------------------------------------------
#  ____             __ _ _                _ figlet
# |  _ \ _ __ ___  / _(_) | ___  ___     / \   _ __  _ __
# | |_) | '__/ _ \| |_| | |/ _ \/ __|   / _ \ | '_ \| '_ \
# |  __/| | | (_) |  _| | |  __/\__ \  / ___ \| |_) | |_) |
# |_|   |_|  \___/|_| |_|_|\___||___/ /_/   \_\ .__/| .__/
#                                             |_|   |_|
# *******************************
# Profiles App is a plugin you can't unplug
# *******************************


def get_profiles_content():
    """
    Retrieve and display the list of profiles.

    This function handles the Profiles app, which is a special case as it controls
    the Profile switcher menu. For a more typical example of a plugin app within
    the Pipulate framework, refer to the Todo app.

    Returns:
        Container: An HTML container with the profiles list and chat interface.
    """
    logger.debug(f"Retrieving {profile_app.name.lower()} for display.")
    # Create the navigation group
    nav_group = create_nav_menu()

    # Fetch all profiles
    all_profiles = profiles()

    # Log the initial state of profiles
    logger.debug("Initial profile state:")
    for profile in all_profiles:
        logger.debug(f"Profile {profile.id}: name = {profile.name}, priority = {profile.priority}")

    # Sort profiles by priority, handling None values
    ordered_profiles = sorted(all_profiles, key=lambda p: p.priority if p.priority is not None else float('inf'))

    logger.debug("Ordered profile list:")
    for profile in ordered_profiles:
        logger.debug(f"Profile {profile.id}: name = {profile.name}, priority = {profile.priority}")

    return Container(
        nav_group,
        Grid(
            Div(
                Card(
                    H2(f"{profile_app.name.capitalize()} {LIST_SUFFIX}"),
                    Ul(*[render_profile(profile) for profile in ordered_profiles],
                       id='profile-list',
                       cls='sortable',
                       style="padding-left: 0;"),
                    footer=Form(
                        Group(
                            Input(placeholder=f"{profile_app.name.capitalize()} Name", name="profile_name", id="profile-name-input"),
                            Input(placeholder=PLACEHOLDER_ADDRESS, name="profile_address", id="profile-address-input"),
                            Input(placeholder=PLACEHOLDER_CODE, name="profile_code", id="profile-code-input"),
                            Button("Add", type="submit", id="add-profile-button"),
                        ),
                        hx_post=f"/{profile_app.name}",
                        hx_target="#profile-list",
                        hx_swap="beforeend",
                        hx_swap_oob="true",
                    ),
                ),
                id="content-container",
            ),
            Div(
                Card(
                    H2(f"{APP_NAME} Chatbot"),
                    Div(
                        id='msg-list',
                        cls='overflow-auto',
                        style='height: 40vh;',
                    ),
                    footer=Form(
                        mk_chat_input_group(),
                    ),
                ),
            ),
            cls="grid",
            style=(
                "display: grid; "
                "gap: 20px; "
                f"grid-template-columns: {GRID_LAYOUT}; "
            ),
        ),
        Script("""
            document.addEventListener('htmx:afterSwap', function(event) {
                if (event.target.id === 'profile-list' && event.detail.successful) {
                    const form = document.getElementById('add-profile-button').closest('form');
                    form.reset();
                }
            });
        """)
    )


def render_profile(profile):
    """
    Render a profile item as an HTML list item.

    This function creates a detailed HTML representation of a profile, including:
    - A checkbox to toggle the profile's active status
    - A link to display the profile name and associated todo count
    - Contact information (address and code) if available
    - A delete button (visible only when the profile has no associated todos)
    - A hidden update form for editing profile details

    The function also includes JavaScript for toggling the visibility of the update form
    and other elements when the profile name is clicked.

    Args:
        profile: The profile object containing attributes like id, name, address, code, and active status.

    Returns:
        Li: An HTML list item (Li) object representing the fully rendered profile with all interactive elements.
    """
    def count_records_with_xtra(table_handle, xtra_field, xtra_value):
        """
        Count records in table matching xtra field constraint.

        Args:
            table_handle: MiniDataAPI table object.
            xtra_field (str): Field name to constrain.
            xtra_value: Value to constrain by.

        Returns:
            int: Number of matching records.
        """
        table_handle.xtra(**{xtra_field: xtra_value})
        count = len(table_handle())
        logger.debug(f"Counted {count} records in table for {xtra_field} = {xtra_value}")
        return count

    # Count the number of todo items for this profile
    todo_count = count_records_with_xtra(todos, 'profile_id', profile.id)

    # Set the visibility of the delete icon based on the todo count
    delete_icon_visibility = 'inline' if todo_count == 0 else 'none'

    # Use the ProfileApp instance to generate URLs
    delete_url = profile_app.get_action_url('delete', profile.id)
    toggle_url = profile_app.get_action_url('toggle', profile.id)

    # Create the delete button (trash can)
    delete_icon = A(
        '🗑',
        hx_delete=delete_url,
        hx_target=f'#profile-{profile.id}',
        hx_swap='outerHTML',
        style=f"cursor: pointer; display: {delete_icon_visibility};",
        cls="delete-icon"
    )

    # Create the active checkbox
    active_checkbox = Input(
        type="checkbox",
        name="active" if profile.active else None,
        checked=profile.active,
        hx_post=toggle_url,
        hx_target=f'#profile-{profile.id}',
        hx_swap="outerHTML",
        style="margin-right: 5px;"
    )

    # Create the update form
    update_form = Form(
        Group(
            Input(type="text", name="profile_name", value=profile.name, placeholder="Name", id=f"name-{profile.id}"),
            Input(type="text", name="profile_address", value=profile.address, placeholder=PLACEHOLDER_ADDRESS, id=f"address-{profile.id}"),
            Input(type="text", name="profile_code", value=profile.code, placeholder=PLACEHOLDER_CODE, id=f"code-{profile.id}"),
            Button("Update", type="submit"),
        ),
        hx_post=f"/{profile_app.name}/{profile.id}",  # Adjusted URL to match route
        hx_target=f'#profile-{profile.id}',
        hx_swap='outerHTML',
        style="display: none;",
        id=f'update-form-{profile.id}'
    )

    # Create the title link with an onclick event to toggle the update form
    title_link = A(
        f"{profile.name} ({todo_count})",
        href="#",
        hx_trigger="click",
        onclick=(
            "let li = this.closest('li'); "
            "let updateForm = document.getElementById('update-form-" + str(profile.id) + "'); "
            "if (updateForm.style.display === 'none' || updateForm.style.display === '') { "
            "    updateForm.style.display = 'block'; "
            "    li.querySelectorAll('input[type=checkbox], .delete-icon, span, a').forEach(el => el.style.display = 'none'); "
            "} else { "
            "    updateForm.style.display = 'none'; "
            "    li.querySelectorAll('input[type=checkbox], .delete-icon, span, a').forEach(el => el.style.display = 'inline'); "
            "}"
        )
    )

    # Create the contact info span, only if address or code is present
    contact_info = []
    if profile.address:
        contact_info.append(profile.address)
    if profile.code:
        contact_info.append(profile.code)

    contact_info_span = (
        Span(f" ({', '.join(contact_info)})", style="margin-left: 10px;")
        if contact_info else
        Span()  # Empty span if no contact info
    )

    return Li(
        Div(
            active_checkbox,
            title_link,
            contact_info_span,
            delete_icon,
            update_form,
            style="display: flex; align-items: center;"
        ),
        id=f'profile-{profile.id}',
        data_id=profile.id,  # Add this line
        data_priority=profile.priority,  # Add this line
        style="list-style-type: none;"
    )


# ----------------------------------------------------------------------------------------------------
#  _____         _ figlet     _
# |_   _|__   __| | ___      / \   _ __  _ __
#   | |/ _ \ / _` |/ _ \    / _ \ | '_ \| '_ \
#   | | (_) | (_| | (_) |  / ___ \| |_) | |_) |
#   |_|\___/ \__,_|\___/  /_/   \_\ .__/| .__/
#                                 |_|   |_|
# *******************************
# Todo App because isn't everything a list of lists?
# *******************************

def render_todo(todo):
    """
    Render a todo item as an HTML list item with an update form.

    This function serves as an example of a plugin component within the Pipulate framework.
    It demonstrates how to create a modular element that can be seamlessly integrated
    into the main application structure, specifically for the Todo app.

    The function creates an interactive todo item with the following features:
    1. A checkbox to toggle the todo's completion status
    2. A delete button (trash can icon) to remove the todo
    3. A clickable name that reveals an update form
    4. An update form for editing the todo's name

    To implement similar components:
    1. Create a function like this one that returns the HTML structure for your component.
    2. Ensure the component includes necessary HTMX attributes for dynamic interactions.
    3. Implement corresponding server-side endpoints to handle the component's actions.
    4. Integrate the component into the main app structure, typically within a list or container.

    For an example of how this function is used, look for the 'get_profiles_content' function
    or the main route handler, where you'll find this function being called to render individual todo items.

    Args:
        todo: The todo item to render, containing properties like id, name, done, and priority.

    Returns:
        Li: An HTML list item representing the interactive todo component.
    """

    # Use the TodoApp instance to generate URLs
    delete_url = todo_app.get_action_url('delete', todo.id)
    toggle_url = todo_app.get_action_url('toggle', todo.id)

    tid = f'todo-{todo.id}'  # Unique ID for the todo item
    checkbox = Input(
        type="checkbox",
        name="english" if todo.done else None,
        checked=todo.done,
        hx_post=toggle_url,
        hx_swap="outerHTML",
        hx_target=f"#{tid}",
    )

    # Create the delete button (trash can)
    delete = A(
        '🗑',
        hx_delete=delete_url,
        hx_swap='outerHTML',
        hx_target=f"#{tid}",
        style="cursor: pointer; display: inline;",
        cls="delete-icon"
    )

    # Create an interactive name link using FastHTML's A() function
    # This demonstrates how FastHTML allows embedding raw JavaScript via the onclick attribute
    # The result is a smooth, app-like experience with client-side interactivity
    name_link = A(
        todo.name,
        href="#",
        cls="todo-title",
        style="text-decoration: none; color: inherit;",
        onclick=(
            "let updateForm = this.nextElementSibling; "
            "let checkbox = this.parentNode.querySelector('input[type=checkbox]'); "
            "let deleteIcon = this.parentNode.querySelector('.delete-icon'); "
            "if (updateForm.style.visibility === 'hidden' || updateForm.style.visibility === '') { "
            "    updateForm.style.visibility = 'visible'; "
            "    updateForm.style.height = 'auto'; "
            "    checkbox.style.display = 'none'; "
            "    deleteIcon.style.display = 'none'; "
            "    this.remove(); "
            "    const inputField = document.getElementById('todo_name_" + str(todo.id) + "'); "
            "    inputField.focus(); "
            "    inputField.setSelectionRange(inputField.value.length, inputField.value.length); "
            "} else { "
            "    updateForm.style.visibility = 'hidden'; "
            "    updateForm.style.height = '0'; "
            "    checkbox.style.display = 'inline'; "
            "    deleteIcon.style.display = 'inline'; "
            "    this.style.visibility = 'visible'; "
            "}"
        )
    )
    # This complex JavaScript enables a responsive, dynamic UI
    # It toggles visibility of form elements and handles focus, creating a seamless editing experience
    # While it adds complexity, it significantly enhances the user interface's responsiveness

    # Create the update form
    update_form = Form(
        Div(
            Input(
                type="text",
                id=f"todo_name_{todo.id}",
                value=todo.name,
                name="name",
                style="flex: 1; padding-right: 10px; margin-bottom: 0px;"
            ),
            style="display: flex; align-items: center;"
        ),
        style="visibility: hidden; height: 0; overflow: hidden;",
        hx_post=f"/{todo_app.name}/{todo.id}",
        hx_target=f"#{tid}",
        hx_swap="outerHTML",
    )

    return Li(
        delete,
        checkbox,
        name_link,
        update_form,
        id=tid,
        cls='done' if todo.done else '',
        style="list-style-type: none;",
        data_id=todo.id,
        data_priority=todo.priority
    )


# ----------------------------------------------------------------------------------------------------
# __        __   _    ____             _        _
# \ \figlet/ /__| |__/ ___|  ___   ___| | _____| |_ ___
#  \ \ /\ / / _ \ '_ \___ \ / _ \ / __| |/ / _ \ __/ __|
#   \ V  V /  __/ |_) |__) | (_) | (__|   <  __/ |_\__ \
#    \_/\_/ \___|_.__/____/ \___/ \___|_|\_\___|\__|___/

# *******************************
# Streaming WebSockets because http isn't just for pageloads anymore
# *******************************

async def on_conn(ws, send):
    users[str(id(ws))] = send
    logger.debug(f"WebSocket connection established with ID: {id(ws)}")


def on_disconn(ws):
    users.pop(str(id(ws)), None)
    logger.debug(f"WebSocket connection closed with ID: {id(ws)}")


def display_action_data(action_json):
    table = Table(title="User Action Recorded in Conversation", show_header=True)
    table.add_column("Key", style="cyan", width=20)
    table.add_column("Value", style="green")

    for key, value in action_json.items():
        table.add_row(str(key), str(value))

    console.print(table)


def strip_outer_quotes(s: str) -> str:
    """
    Strip double quotes from the beginning and end of a string,
    but preserve any double quotes inside the string.

    Args:
        s (str): The input string.

    Returns:
        str: The string with outer quotes removed, if present.
    """
    if len(s) >= 2 and s[0] == '"' and s[-1] == '"':
        return s[1:-1]
    return s


async def chatq(message: str, action_data: str = None, silent: bool = False):
    # Prepare the content to add to the conversation history
    content = message
    if action_data:
        try:
            action_json = json.loads(action_data)
            action_str = (
                f"\n\nIf you want to {action_json.get('action_type')} like this, here's how you'd say it in JSON:\n\n\n```json\n"
                f"{json.dumps(action_json, indent=2)}\n```\n\n"
            )
            content += action_str

            # Display the action data in a rich table
            display_action_data(action_json)
            logger.debug(f"Action data added to conversation: {action_str}")

        except json.JSONDecodeError:
            error_str = f"\nThe user just tried taking the following action: {action_data} (Invalid JSON)"
            content += error_str
            logger.debug(f"Invalid action data added to conversation: {error_str}")
            logger.error(f"Invalid JSON in action_data: {action_data}")

            # Display error in a rich table
            error_table = Table(title="Invalid User Action", show_header=True, header_style="bold red")
            error_table.add_column("Error", style="red")
            error_table.add_row("Invalid JSON in action_data")
            console.print(error_table)

    fig(font='script', text="Conversation History")
    # Add the message to the conversation history
    conversation_history(content, "system")

    if not silent:
        # Create an asynchronous task to stream the chat response
        asyncio.create_task(stream_chat(message))
        logger.debug(f"Message queued for chat: {message}")
    else:
        logger.debug(f"Silent message logged: {message}")

    if action_data:
        # Log the action data
        logger.debug(f"User action: {action_data}")
        # Here you would add code to store this in your chosen database
        await store_action_log(json.loads(action_data))

    # Return the content that was added to the conversation history
    return content


async def store_action_log(action_json):
    """
    Store the action log in the database.
    This is a placeholder function - implement according to your database choice.
    """
    # TODO: Implement database storage
    logger.debug(f"Storing action log: {action_json}")


async def stream_chat(prompt: str, quick: bool = False):
    """
    Generate and stream an AI response to all connected users.

    Args:
        prompt (str): The prompt to send to the AI model.
        quick (bool): If True, send the entire response at once.

    Returns:
        None
    """
    logger.debug(f"Streaming chat response for prompt: {prompt}")

    # Generate the AI response using the selected model
    response = await run_in_threadpool(
        chat_with_ollama,
        model,
        [{"role": "user", "content": prompt}],
    )

    # Strip outer quotes from the response
    response = strip_outer_quotes(response)

    if quick:
        # Send the entire response at once for quick delivery
        for u in users.values():
            await u(
                Div(
                    response,
                    id='msg-list',
                    cls='fade-in',
                    style=MATRIX_STYLE,
                )
            )
    else:
        # Stream the response word by word to simulate typing
        words = response.split()
        for i in range(len(words)):
            partial_response = " ".join(words[: i + 1])
            for u in users.values():
                await u(
                    Div(
                        partial_response,
                        id='msg-list',
                        cls='fade-in',
                        style=MATRIX_STYLE,
                        _=f"this.scrollIntoView({{behavior: 'smooth'}});",
                    )
                )
            await asyncio.sleep(TYPING_DELAY)
    logger.debug("Completed streaming chat response.")


@app.ws('/ws', conn=on_conn, disconn=on_disconn)
async def ws(msg: str):
    try:
        conn_id = getattr(ws, 'conn_id', str(uuid4()))
        ws.conn_id = conn_id

        if msg.startswith("!table"):
            table_name = msg.split()[1] if len(msg.split()) > 1 else None
            if table_name:
                if table_name in ['task', 'todo']:
                    items = todo_app.table()
                elif table_name in ['customer', 'profile']:
                    items = profile_app.table()
                else:
                    items = None
                
                if items:
                    json_content = json.dumps([item.__dict__ for item in items], indent=2)
                    response = f"Table contents for {table_name}:\n```json\n{json_content}\n```"
                else:
                    response = f"Error: Table '{table_name}' not found."
            else:
                response = "Error: No table name provided. Usage: !table <table_name>"

            for u in users.values():
                await u(Div(response, id='msg-list', cls='fade-in', style=MATRIX_STYLE))
            return
        if msg:
            fig(font='script', text="Conversation History")
            msg = f"In under {MAX_LLM_RESPONSE_WORDS} words: {msg}"
            # Add user message to conversation history
            conversation_history(msg, "user")

            # Generate AI response using the conversation history
            current_conversation = conversation_history()
            response = await run_in_threadpool(chat_with_ollama, model, current_conversation)

            # Add AI response to conversation history
            conversation_history(response, "assistant")

            # Stream the response as before
            words = response.split()
            for i in range(len(words)):
                partial_response = " ".join(words[: i + 1])
                for u in users.values():
                    await u(
                        Div(
                            partial_response,
                            id='msg-list',
                            cls='fade-in',
                            style=MATRIX_STYLE,
                            _=f"this.scrollIntoView({{behavior: 'smooth'}});",
                        )
                    )
                await asyncio.sleep(TYPING_DELAY)

    except WebSocketDisconnect:
        logger.debug(f"WebSocket disconnected for connection {conn_id}")
        conversation_histories.pop(conn_id, None)
    except Exception as e:
        logger.error(f"Error in WebSocket handler: {str(e)}")

# *******************************
# Search Endpoint
# *******************************


@rt('/search', methods=['POST'])
async def search(nav_input: str = ''):
    """
    Handle search queries by informing the user that the feature is not implemented.

    Args:
        nav_input (str): The search term entered by the user.

    Returns:
        A response indicating that the search feature is still in beta.
    """
    logger.debug(f"Search requested with input: '{nav_input}'")
    search_term = nav_input

    # Inform the user that the search feature is not yet available
    await chatq(
        f"Searching for '{search_term}'? "
        "Sorry, that feature is still in beta. "
        f"Keep the reply under {MAX_LLM_RESPONSE_WORDS } words."
    )

# *******************************
# Poke Endpoint
# *******************************


@rt('/poke', methods=['POST'])
async def poke_chatbot():
    """
    Handle the poke interaction with the chatbot.

    Returns:
        A confirmation message indicating the poke was received.
    """
    logger.debug("Chatbot poke received.")
    poke_message = (
        f"The user poked the {APP_NAME} Chatbot. "
        "Respond with a brief, funny comment about being poked."
    )

    # Create action data for the poke
    action_data = json.dumps({
        "action_type": "poke",
        "target": f"{APP_NAME} Chatbot"
    })

    # Queue the poke message for streaming to the chat interface, including action data
    await chatq(poke_message, action_data)

    # Respond with a confirmation message
    return "Poke received. Let's see what the chatbot says..."

# ----------------------------------------------------------------------------------------------------
#  _   _ _   _ _ _ _   _
# | | | | |_(_) (_) |_(_) ___  ___
# | | | | __| | | | __| |/ _ \/ __| figlet
# | |_| | |_| | | | |_| |  __/\__ \
#  \___/ \__|_|_|_|\__|_|\___||___/
#
# *******************************
# Utilities to push those helper functions to the bottom
# *******************************


def format_endpoint_name(endpoint: str) -> str:
    """Capitalize and replace underscores with spaces in endpoint names."""
    return ' '.join(word.capitalize() for word in endpoint.split('_'))


def get_profile_name():
    """
    Retrieve the name of the current profile.

    This function attempts to get the name of the profile associated with the last used profile ID.
    If no last profile ID is found, it tries to use the first available profile.
    If no profiles exist, it returns "Unknown Profile".

    Returns:
        str: The name of the current profile, or "Unknown Profile" if no valid profile is found.

    Logs:
        - INFO: When using a default profile ID due to missing last_profile_id.
        - WARNING: When no profiles are found in the database.
        - DEBUG: Profile retrieval process and results.
    """
    # Get the last profile id from the database
    profile_id = db.get("last_profile_id")
    if profile_id is None:
        logger.debug("No last_profile_id found. Attempting to use the first available profile.")

    logger.debug(f"Retrieving profile name for ID: {profile_id}")
    try:
        profile = profiles.get(profile_id)
        if profile:
            logger.debug(f"Found profile: {profile.name}")
            return profile.name
    except NotFoundError:
        logger.warning(f"No profile found for ID: {profile_id}. Attempting to use the first available profile.")
        # Attempt to use the first available profile
        all_profiles = profiles()
        if all_profiles:
            first_profile = all_profiles[0]
            db["last_profile_id"] = first_profile.id  # Update the last_profile_id to the first profile
            logger.debug(f"Using first available profile ID: {first_profile.id}")
            return first_profile.name
        else:
            logger.warning("No profiles found in the database.")
            return "Unknown Profile"


# *******************************
# Utility Function for Pluralization
# *******************************

def endpoint_fmt(word):
    return word.replace('_', ' ').title()

# ----------------------------------------------------------------------------------------------------
#   _____ figlet                   ____            _
#  |  ___|   _ _ __  _ __  _   _  | __ ) _   _ ___(_)_ __   ___  ___ ___
#  | |_ | | | | '_ \| '_ \| | | | |  _ \| | | / __| | '_ \ / _ \/ __/ __|
#  |  _|| |_| | | | | | | | |_| | | |_) | |_| \__ \ | | | |  __/\__ \__ \
#  |_|   \__,_|_| |_|_| |_|\__, | |____/ \__,_|___/_|_| |_|\___||___/___/
#                          |___/
# *******************************
# Funny Business is stupid web tricks like the 404 handler & middleware
# *******************************


@rt('/redirect/{path:path}')
def redirect_handler(request):
    path = request.path_params['path']
    logger.debug(f"Redirecting to: {path}")
    db["temp_message"] = f'Tell the user they switched to the "{format_endpoint_name(path)}" app.'
    return Redirect(f"/{path}")


@rt('/select_profile', methods=['POST'])
async def select_profile(request):
    logger.debug("Entering select_profile function")
    form = await request.form()
    logger.debug(f"Received form data: {form}")

    profile_id = form.get('profile_id')
    logger.debug(f"Extracted profile_id: {profile_id}")

    if profile_id:
        profile_id = int(profile_id)
        logger.debug(f"Converted profile_id to int: {profile_id}")

        db["last_profile_id"] = profile_id
        logger.debug(f"Updated last_profile_id in db to: {profile_id}")

        # Get the name of the new profile
        profile = profiles[profile_id]
        logger.debug(f"Retrieved profile: {profile}")

        profile_name = getattr(profile, 'name', 'Unknown Profile')
        logger.debug(f"Profile name: {profile_name}")

        # Store the message in the db
        db["temp_message"] = f"Profile changed to {profile_name}"
        logger.debug(f"Stored temp_message in db: {db['temp_message']}")

        # Prepare action details for logging
        action_details = f"Switched to profile '{profile_name}'"
        prompt = f"User action: {action_details}"
        action_data = json.dumps({
            "action_type": "profile_switch",
            "profile_id": profile_id,
            "profile_name": profile_name
        })
        logger.debug(f"Prepared action data: {action_data}")

        # Call chatq silently
        logger.debug("Calling chatq silently")
        await chatq(prompt, action_data, silent=True)
        logger.debug("chatq call completed")

    redirect_url = db.get("last_visited_url", "/")
    logger.debug(f"Redirecting to: {redirect_url}")
    return Redirect(redirect_url)


def custom_404_handler(request, exc):
    """
    Custom 404 page handler.

    Args:
        request: The request that caused the 404 error.
        exc: The exception that was raised.

    Returns:
        HTML: An HTML response for the 404 error.
    """
    return Html(
        Head(
            Title("404 - Page Not Found"),
            Style("""
                body { font-family: Arial, sans-serif; text-align: center; padding: 50px; }
                h1 { color: #e74c3c; }
                a { color: #3498db; text-decoration: none; }
            """)
        ),
        Body(
            H1("404 - Page Not Found"),
            P(f"Sorry, the page '{request.url.path}' you're looking for doesn't exist."),
            A("Go back to home", href="/")
        )
    )


class DOMSkeletonMiddleware(BaseHTTPMiddleware):
    """
    Middleware for logging HTTP requests and database state.

    Logs requests with ASCII art headers, processes the request,
    and displays current database contents after each request.
    Uses Figlet for ASCII art and Rich for formatted console output.
    """

    async def dispatch(self, request, call_next):
        """
        Process requests, log details, and display database state.

        Args:
            request: Incoming HTTP request.
            call_next: Next request handler.

        Returns:
            HTTP response from the next handler.

        Prints request details and database contents to console.
        """
        # Log the incoming HTTP request
        endpoint = request.url.path
        method = request.method
        fig(font='slant', text=f"{method} {endpoint}")
        logger.debug(f"HTTP Request: {method} {endpoint}")

        # Call the next middleware or request handler
        response = await call_next(request)

        # Print a rich table of the db key/value pairs
        table = Table(title="Store State")
        table.add_column("Key", style="cyan")
        table.add_column("Value", style="magenta")
        for key, value in db.items():
            table.add_row(key, str(value))
        table.columns[1].style = "white"
        console.print(table)
        fig(font='crawford', text="cookie")

        return response


def print_routes():
    """
    Print a formatted table of all routes in the application.

    This function creates a rich console table displaying information about each route
    in the application. The table includes columns for the route type, methods, path,
    and a duplicate indicator.

    The function handles different types of routes:
    - Standard routes (Route)
    - WebSocket routes (WebSocketRoute)
    - Mounted applications (Mount)
    - Any other unrecognized route types

    The table is color-coded for better readability:
    - Type: Cyan
    - Methods: Yellow
    - Path: White (Red if duplicate)
    - Duplicate: Red if duplicate, otherwise green

    Note: This function assumes the existence of a global 'app' object with a 'routes' attribute.

    Returns:
        None. The function prints the table to the console.
    """
    table = Table(title="Application Routes")

    table.add_column("Type", style="cyan", no_wrap=True)
    table.add_column("Methods", style="yellow on black")
    table.add_column("Path", style="white")
    table.add_column("Duplicate", style="green")

    # Collect all routes in a list for sorting
    route_entries = []

    # Set to track (path, method) pairs
    seen_routes = set()

    for route in app.routes:
        if isinstance(route, Route):
            methods = ", ".join(route.methods)
            route_key = (route.path, methods)

            # Check for duplicates
            if route_key in seen_routes:
                path_style = "red"
                duplicate_status = Text("Yes", style="red")
            else:
                path_style = "white"
                duplicate_status = Text("No", style="green")
                seen_routes.add(route_key)

            route_entries.append(("Route", methods, route.path, path_style, duplicate_status))
        elif isinstance(route, WebSocketRoute):
            route_key = (route.path, "WebSocket")

            # Check for duplicates
            if route_key in seen_routes:
                path_style = "red"
                duplicate_status = Text("Yes", style="red")
            else:
                path_style = "white"
                duplicate_status = Text("No", style="green")
                seen_routes.add(route_key)

            route_entries.append(("WebSocket", "WebSocket", route.path, path_style, duplicate_status))
        elif isinstance(route, Mount):
            route_entries.append(("Mount", "Mounted App", route.path, "white", Text("N/A", style="green")))
        else:
            route_entries.append((str(type(route)), "Unknown", getattr(route, 'path', 'N/A'), "white", Text("N/A", style="green")))

    # Sort the routes by path
    route_entries.sort(key=lambda x: x[2])

    # Add sorted routes to the table
    for entry in route_entries:
        table.add_row(
            entry[0],
            entry[1],
            Text(entry[2], style=f"{entry[3]} on black"),
            entry[4]
        )

    console.print(table)
    fig(font='big', text="Routes")


# ----------------------------------------------------------------------------------------------------
#  ____                       __ __
# / ___|  ___ _ ____   _____ / / \ \
# \___ \ / _ \ '__\ \ / / _ \ |   | |
#  ___) |  __/ |   \ V /  __/ |   | |
# |____/ \___|_|    \_/ \___| |   | |
#                     figlet \_\ /_/
# *******************************
# And now the moment you've all been waiting for: Activate the Application
# *******************************

# Define the routes that need GET methods
GET_ROUTES = ['', todo_app.name, profile_app.name]

# Combine the GET routes with MENU_ITEMS
ALL_ROUTES = list(set(GET_ROUTES + MENU_ITEMS))

# Create routes for all items
for item in ALL_ROUTES:
    path = f'/{item}' if item else '/'
    app.add_route(path, home, methods=["GET"])

# Add the custom 404 handler after the app is created
app.add_exception_handler(404, custom_404_handler)
logger.debug("Application setup completed with custom 404 handler.")

# Register the funny business
app.add_middleware(DOMSkeletonMiddleware)
logger.debug("Application setup completed with DOMSkeletonMiddleware.")

# Retrieve and set the best available LLaMA model
model = get_best_model()
logger.debug(f"Using model: {model}")

# Print the application name in ASCII art upon startup
fig(font='slant', text=APP_NAME)

# After setting up all routes
print_routes()

# Start the application server
serve()
```

## Installed Logitch MX Brio in NixOS Linux in Seconds

And all of that is just getting started for the day, and it's not even 9AM yet.
And I got my new Logitch MX Brio working on my NixOS Linux too! It was one of
the easiest hardware installs I ever did. I searched in Perplexity.AI on
***install mx brio on nixos*** and took the copy/paste markdown, pasteed it in
***Code AI*** with my NixOS `configuration.nix` file loaded, and it just made
the changes to the file, told me to `sudo nixos-rebuild switch` and Voilà! It
was telling me to say `cheese`! Or at least to type it into my terminal, as
Claude knew to suggest some software to get me started, as Cheese is a webcam
app on Linux. The times, they are a-changin'.

### The Future Was Here &#151; and Is Again!

Anyone who thinks Macs and Windows are the future, think again. Now maybe I'll
get my YouTube video series going again. So much new material! And so aligned
with the world the way it is today. It's like being in love with the Amiga
computer all over again, but this time it's mainstream skills and knowledge I'm
acquiring. Amazing! Speaking of which, the Commodore 64x has been released
(again)! I got my original (original copy?) in like 2012 or something, but I
just ordered the profoundly cool retro computer platform as a gift for someone.

## Preparing to Take the Leap into Uncertainty with Confidence

So onto today... think! I've taken so many rapid deep dives into rabbit holes
and come back mostly unscathed, I'm feeling both inflated confidence and
trepidation for what comes next. I am on the cusp of something big&#151;standing
at the intersection of mastery and uncertainty, fueled by the momentum of
exploration. The next steps could solidify my vision or open a new rabbit hole.
They must propel you forward and not get me trapped in some quagmire. List what
you know.

- A local AI LLM is "in the loop" of its own development, getting embedded into
  a product
- That product is expressible as a single file and installable on a vast array
  of hardware out there
- The product only just reached MVP (minimal viable product) for traditonal web
  framework use
- But to really make it something special, I have to carry through on special
  "hooks" I've left
- The main hook I worked so hard on yesterday was making sure it was learning
  the JSON to do CRUD operations

Okay, that's my first potential 80/20-rule win yet also rabbit hole to avoid
falling down into. This next step is... is... find the words...

# Building the Instruction Parsing and Execution Module

Uh yeah, that's it. It's a code detector, sanitizer and dispatcher. It monitors
the WebSocket communication coming in from the AI, analyzes it for sentiment
(also by the local LLM), and decides whether or not to attempt to execute the
code. This is not exactly all that swarming agents stuff, but this is process
pipeline construction on a single machine with a single (no-cost/low-cost) local
model that comes first. Figure out how to be the boss of a convenient local
minion, and then recruit your empire of minions to do your bidding later once
you've got those 1-to-1 relationship skills under your belt.

## Thinking Through Multiple Projects Before Proceeding with Current One

Before I dive into that, I need to think through the other projects that are
competing and see if there's some order of operations or oversight. I may in
fact just plop this whole article, code examples and all, into one of the
frontier models that can handle it such as o1-mini and ask for its next step
opinions. Other projects include:

## LLM To Be Given Persistent Datastore Capabilities Directly

Proto-RAG in the form of a simple JSON-like dictionary for the LLM to casually
use as its own persistent datastore, able to always get a list of its keys and
use them to pull up its values. In this way, it can store stuff for itself, just
like the `store` table I made in `sqlite` for cookie-like persistence in the app
without relying on the browser.

## SQLite, Faiss and Milvus and Long-Term Memory Options for LLMs

Once you have sqlite, there's a ton of stuff you can do that... ugh, it's an
article in itself. Suffice to say, I think I ought to give the LLM its own
`DictLikeDB` that's used elsewhere in the system, teach it that it has one and
how to use it. It's its own configuration, dotenv or cookie store. It gets to
decide for itself and organize its own keys to values. I could easily imagine it
using it for remembering the user's name, for example. That seems like the
quintiessential example, but there's countless possiblities. If you give an LLM
explicit long-term memory...

However, after a rudimentary and explicit JSON/Python dict-like long-term memory
of simple key-value pairs which is a sure-thing for me to implement, there are
two other types of long-term memory I'm thinking about for today's work:

- SQL full-text search (sqllite3 will do)
- Vector database with embeddings (faiss vs. milvus) for RAG searches like
  cosine nearness similarity matching to past conversations, user actions and
  documents

## Planning Permanent Storage for Accumulated Log-File Data

Of these, obviously the second is the sexy, sexy one that aligns with all the
buzz. And I have to get to it as it is a huge unlock. For example, documents
should be able to be uploaded so that you can teach the LLM how to be expert at
something. 

### Rabbithole-avoidance

All that log-file like data I'm accumulating now that only goes into a temporary
conversation context window based on the way the Ollama chat API words needs to
go somewhere more permanent. I may just dump a bunch of textfiles from the
standard Python logging tools (I use loguru) with a capture-now/train-later
attitude. I'm not really sure. That'd be rabbithole-avoidance, but it may be
appropriate at this point, because the moment I plunge down that path, the day's
shot. There's too much for me to learn there for it not to be. And I've got to
be further along by the end of the day than just that.

## File Uploads for LLM Training and Vector Embeddings

I need to have the hook for that. I need to be able to point to something and
go, look! That's where file uploads occur, that's how the indexing
happens&#151;or whatever it's called in the vector emedding world. Oh, file
uploads! And the particular 2 apps I need to plug in pronto. Let me talk about
those as I evaluate today.

What's more important, the file-upload mechanism or abosorbing the documents
into RAG-search once uploaded? The file-upload is probably easier as I'm pretty
sure it's a built-in mechanism of the Flask-like `Starlette` ASGI package that
FastHTML is built on. Perplexity?

---

**Perplexity**: Starlette provides robust support for handling file uploads through its UploadFile class. Here are the key points about file uploads in Starlette:

## Receiving File Uploads

To receive file uploads in a Starlette application:

1. Define a parameter of type UploadFile in your route handler function[1].

2. Access the uploaded file through the Request object's form() method[1].

For example:

```python
from starlette.requests import Request
from starlette.responses import JSONResponse

async def upload_file(request: Request):
    form = await request.form()
    uploaded_file = form["file"]
    
    return JSONResponse({"filename": uploaded_file.filename})
```

## UploadFile Properties

The UploadFile object provides several useful properties[1]:

- filename: Original filename of the uploaded file
- content_type: MIME type of the file
- file: A SpooledTemporaryFile object containing the file data
- size: Size of the file in bytes

## Reading File Contents

You can read the contents of an uploaded file asynchronously[1]:

```python
contents = await uploaded_file.read()
```

## File Operations

UploadFile provides async methods for common file operations[1]:

- read(size): Read bytes from the file
- write(data): Write bytes to the file  
- seek(offset): Move to a position in the file
- close(): Close the file

## Handling Large Files

For large file uploads, you can stream the contents without loading everything into memory[1]:

```python
async for chunk in request.stream():
    # Process chunk
```

## Saving Uploaded Files

To save an uploaded file:

1. Read the file contents
2. Write the contents to the desired location

For example, to save to Azure blob storage[3]:

```python
bytes_file = await file.read()
container_client.upload_blob(name='filename', data=bytes_file)
```

By leveraging these capabilities, Starlette makes it straightforward to handle file uploads securely and efficiently in your web applications.

Citations:

    [1] https://www.starlette.io/requests/
    [2] https://fastapi.tiangolo.com/reference/uploadfile/
    [3] https://stackoverflow.com/questions/76410653/uploading-a-starlette-uploadfile-object-using-azure-upload-blob-method-throws-ex
    [4] https://accent-starlette.github.io/starlette-files/handling_files/
    [5] https://github.com/encode/starlette/issues/446
    [6] https://fastapi.tiangolo.com/tutorial/request-files/
    [7] https://www.starlette.io/third-party-packages/
    [8] https://github.com/encode/starlette/blob/master/starlette/datastructures.pyo

---

Yeah, so success assured on that front. But totally deferrable because this is
really a local app on your machine and I could also just pop open folders using
Python's os-library's ability to do such things. I could of course control that
detail and even the file naming if I controlled the file upload through the web
app. But this may just be the rabbit hole to skip exploring today.

## Porting Remaining Jupyter Notebook Apps to New System Urgently Needed

And finally, there are 2 Jupyter Notebook apps that I still just have to port to
the new system. That's pretty urgent too because a lot of discussions about what
I'm doing surround these two apps. One is actually already ported to my first
try with FastHTML, and I love it, but it's a dead-end codebase-wise. I made all
the wrong decisions regarding persistence and data-streaming, both of which are
formally and beautifully integrated in FastHTML, and my old methods are to be
ditched.

### The Obsolescence of Python APIs Is Rarely Actually Obsolete

This is the kind of obsolescence that's okay, because it's all still Python and
the code signatures are all nearly identical. It's like the difference between
`Flask` and `Starlette`. One never really obsoletes the other, because they're
all part of one big happy Pythonic preferred API for a problem domain family.
Does that make sense?
