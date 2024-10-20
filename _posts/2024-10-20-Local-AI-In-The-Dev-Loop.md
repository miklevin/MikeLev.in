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
a folder and go. Of course, I take care of the entire development environment
for that folder too with this flake.nix...

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

## The Simplified Code Base Reduces Cognitive Friction for Developers

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
