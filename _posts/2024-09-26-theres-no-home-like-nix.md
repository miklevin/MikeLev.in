---
title: There's No Home Like Nix
permalink: /theres-no-home-like-nix/
description: In this article, I delve into building a Python web development environment within Nix, offering solutions for incorporating packages not readily available in the Nix repository. I guide you through using dotenv to securely manage environment variables and present a practical example of a simple FastHTML web application that prompts users for a secret and stores it safely. Additionally, I demonstrate the implementation of a basic chat server with Ollama, emphasizing the advantages of leveraging local LLMs for AI-assisted development.
layout: post
---

Now, we embark on WebDev-style application development in Nix, moving forward in earnest. Everything so far in this blog has been akin to designing Dorothy's *"There's no place like home"* spell—a tricky thing to describe, but much like cleansing the palate or returning to a martial arts ready stance. Just as your taste buds and physical prowess shouldn't sway to the whims of vendors, neither should your technical abilities. It is the pursuit of **generic** technical skills that can future-proof you, even as AI rapidly advances.

## The Idea of 'Home' in Unix/Linux

So I chip off a **flake** of my system. Home is anything Unix/Linux-like. It can be macOS, because Apple's **Darwin Unix** is close enough. Any popular Linux distro, whether it's Debian, RedHat, or Arch-derived, is a fine home too. Even Windows with its **WSL (Windows Subsystem for Linux)** qualifies.

### The Problem with Scripting Different Platforms

They all, in fact, have the same problem. You can't just write scripts to cobble together **home**, because your automated `brew` scripts would be different from your `apt` scripts, which are different from your `yum` or `pacman` scripts. This problem unfortunately gets fixed these days with Docker containers and virtual machines, but that just makes a tangled web of not-very-friendly home. *Home should be a script.* Have you watched those YouTube videos? First, you install this, then you do that, and after a hundred little touches (getting any of which wrong will break the system), you're ready to start.

### Enter Nix: The Solution to Homebuilding

If you haven't gotten the idea yet, this whacky wonderful Swiss Army knife called **`nix`** solves all that. It's like your original OS installer, brew, yum, apt, pacman, and even Python's pip installer all rolled into one. Getting **"home"** back should just be a single file that brilliantly builds your home on-demand. We'll splurge a little and say two files: one for the overarching system and one for the apps within. *It should just be that easy.*

### Configuration.nix: Building Home on Any Platform

And so it is! My **"home"** script is called `/etc/nixos/configuration.nix`. Think of it as my **house**. Your house can be a MacBook or a Windows laptop, or any machine you sit down at, because you can sprinkle some magic fairy dust (install **nix**), and like Dorothy, be transported to a familiar Linux-like environment by virtue of the **`nix`** command. Your home can be built from bricks, like **NixOS**. But even if it's built from sticks like **macOS** or straw like **Windows**, the same basic trick gets you a familiar home with a driveway and a garage to drive your secondary home (car, aka app) into.

### Nix Flakes: Secondary Homes (Apps)

Those secondary homes are called things like `~/repos/myapp/flake.nix`. While not as big as your main home, a **nix flake** can still carry around a lot of the things that you need. A car is like a little home, right? You feel comfortable in it, and the location of the steering wheel and seats aren't always changing, right? So *muscle memory* can kick in, and you can immediately drive well. That's a **nix flake**. And after being lost in the wilderness for a bit, head spinning from the pace of change in technology, I finally have my car ready. That was the subject of that lengthy article yesterday.

### The Tech Counter-Revolution: Simplicity and Efficiency

So I say it's time to start writing that app in earnest, yet here I go rambling on and on. You get it, right? We are on the verge of a *tech counter-revolution*. It's one that favors simplicity and doing more with less. **Less code. Less surface area. Less to audit. Less people.** Sounds scary? No, it's enormously empowering for the individual, and a lot like the return to the early days of the Web, where a Webmaster with a good knowledge of the LAMP platform and how HTTP works could pretty much do everything. I've learned recently that this concept is referred to lately as ***Infrastructure as Code*** or *IaC*. **One flake to rule them all!**

### Refurbishing Pipulate with Nix and Large Language Models

Yesterday was already a pretty epic day getting my **flake** drivable. I'm refurbishing my old **Pipulate** Free and Open Source Software for SEO vehicle. It's gone through iterations where it was a local web app and iterations where it was fully Jupyter Notebook-based. Now, I'm getting the best of all worlds, with a sprinkling of locally installed large language models if the host machine has **Ollama** installed with an LLM like **llama3.1** (which I'm currently using). This provides a certain baseline of capabilities that are reasonable on modern machines. Even MacBooks can have built-in **ChatGPT-like** features with a quick install and download, and it has endless application on a local web app.

### Final Preparations for Development

Most of today went into that last round of preparation, making the car ready for driving. In this case, it was a quick `start` and `stop` command to get both **JupyterLab** and the **FastHTML** server running while not tying up the command-line console it was launched from. I'm a **vim/NeoVim** user, and I may wish to use the console for text editing. But I also tested the integration with **VSCode-like** programs that detect and use the Python virtual environments. So, basically, you can use your favorite editor even though I've effectively bundled in an **AI-assisted Jupyter Notebooks** editing environment by default. But go ahead and use your own favorite editor, like **Cursor**. The `start` program opens a tab for **JupyterLab** in your default browser, along with a tab for **FastHTML**. **FastHTML** is set to pick up file changes, so you don't need to stop and start the server to see your changes.

### Custom Prompts and Environment Enhancements

What else? Oh, I got the custom prompts working so you can see that you're in a Python (.venv) in the conventional way Python users expect. And when you type `exit` to get out of it and go one virtual environment nested level up into **Nix**, you see a custom prompt there letting you know you're still in a **Nix** shell. Macs do this automatically (at least with the **Determinate Systems installer**), so you will see a double indication on Macs when stepping out. And I don't have command-line recall working when in the Python `.venv`. But I chased rabbits down rabbit holes long enough today.

### Moving Forward: Writing the FastHTML App

It's time to write a **FastHTML** app. But before I do, here's the current state of the master template **nix flake**.

---

# The Pipulate Nix Flake

This is a **Nix flake** that defines a reproducible development environment for a project called **Pipulate**. This flake sets up a development shell with all necessary dependencies and includes scripts to start and stop services like **JupyterLab** and a custom **FastHTML** server.


```nix
{
  #  ____  _             _       _          This is a Nix flake that defines a reproducible
  # |  _ \(_)_ __  _   _| | __ _| |_ ___    development environment for a project called
  # | |_) | | '_ \| | | | |/ _` | __/ _ \   Pipulate. This flake sets up a development shell
  # |  __/| | |_) | |_| | | (_| | ||  __/   with all necessary dependencies and includes
  # |_|   |_| .__/ \__,_|_|\__,_|\__\___|   scripts to start and stop services like JupyterLab
  #         |_|                             and a custom FastHTML server.                     


  # Define the external dependencies (other flakes) this flake uses
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";  # Nix packages source
    flake-utils.url = "github:numtide/flake-utils";    # Helpful utilities for flakes
  };

  # Define the outputs of this flake
  outputs = inputs @ { self, nixpkgs, flake-utils, ... }:
    # Generate outputs for each default system (e.g., x86_64-linux, aarch64-darwin)
    flake-utils.lib.eachDefaultSystem (system: let
      # Import nixpkgs for the current system, allowing unfree packages
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      # Import local configuration if it exists, otherwise use an empty set
      localConfig = if builtins.pathExists ./local.nix then import ./local.nix else {};
      cudaSupport = if localConfig ? cudaSupport then localConfig.cudaSupport else false;
      
      # Detect the current platform
      isLinux = pkgs.stdenv.isLinux;
      isDarwin = pkgs.stdenv.isDarwin;
      
      # Define common packages used across all platforms
      commonPackages = with pkgs; [
        python311
        python311.pkgs.pip
        python311.pkgs.virtualenv
        cmake
        ninja
        gcc
        git
        zlib
        stdenv.cc.cc.lib
        figlet
      ];
      
      # Create a shell script to set up the development environment
      runScript = pkgs.writeShellScriptBin "runScript" ''
        set -e
        export NIXPKGS_ALLOW_UNFREE=1
        export LD_LIBRARY_PATH=${pkgs.lib.makeLibraryPath commonPackages}:$LD_LIBRARY_PATH
        ${if isLinux && cudaSupport then "export LD_LIBRARY_PATH=${pkgs.stdenv.cc.cc.lib}/lib:$LD_LIBRARY_PATH" else ""}
        figlet "Pipulate"
        echo "Welcome to the Pipulate development environment on ${system}!"
        echo
        echo "- Checking if pip packages are installed..."
        ${if cudaSupport && isLinux then "echo '- CUDA support enabled.'" else ""}
        test -d .venv || ${pkgs.python311.interpreter} -m venv .venv
        set -e  # Exit immediately if a command exits with a non-zero status

        if source .venv/bin/activate && \
           pip install --upgrade pip --quiet && \
           pip install -r requirements.txt --quiet; then
            package_count=$(pip list --format=freeze | wc -l)
            echo "- Done. $package_count pip packages installed."
        else
            echo "Warning: An error occurred during setup."
        fi
        # Check if numpy is importable (the lyncpin to know if the environment is ready)
        echo "- Checking if numpy is importable..."
        if python -c "import numpy" 2>/dev/null; then
          echo "- numpy is importable (good to go!)"
          echo
          echo "- Start JupyterLab and FastHTML server with: start"
          echo "- Stop JupyterLab and FastHTML server with: stop"
          echo "- To exit the Pipulate environment, type 'exit' twice."
          echo
        else
          echo "Error: numpy could not be imported. Check your installation."
        fi
        
        # Check for Ollama server
        echo "Checking Ollama connectivity..."
        ollama_response=$(python ollama_check.py)
        echo "Ollama says: $ollama_response"
        echo

        echo "Learn more at https://pipulate.com <--Ctrl+Click"
        
        # Create the start script
        cat << EOF > .venv/bin/start
        #!/bin/sh
        stop
        echo "Starting JupyterLab and server..."
        jupyter lab > jupyter.log 2>&1 &
        python server.py > server.log 2>&1 &
        echo "JupyterLab and server started in the background."
        echo "JupyterLab log: jupyter.log"
        echo "Server log: server.log"
        sleep 2
        if [[ "$OSTYPE" == "linux-gnu"* ]]; then
            xdg-open "http://localhost:5001" > /dev/null 2>&1 &
        elif [[ "$OSTYPE" == "darwin"* ]]; then
            open "http://localhost:5001" > /dev/null 2>&1 &
        else
            echo "Unsupported OS."
        fi
        EOF
        chmod +x .venv/bin/start

        # Create the stop script
        cat << EOF > .venv/bin/stop
        #!/bin/sh
        echo "Stopping JupyterLab, Jupyter kernels, and server..."
        pkill -f "jupyter-lab"
        pkill -f "ipykernel_launcher"
        pkill -f "python server.py"
        echo "Waiting for processes to terminate..."
        sleep 2
        if pgrep -f "jupyter-lab" > /dev/null || pgrep -f "ipykernel_launcher" > /dev/null || pgrep -f "python server.py" > /dev/null; then
          echo "Some processes are still running. Forcefully terminating..."
          pkill -9 -f "jupyter-lab"
          pkill -9 -f "ipykernel_launcher"
          pkill -9 -f "python server.py"
        fi
        echo "All processes have been stopped."
        EOF
        chmod +x .venv/bin/stop

        # Override PROMPT_COMMAND and set custom PS1
        export PROMPT_COMMAND=""
        PS1='$(printf "\033[01;34m(%s)\033[00m \033[01;32m[%s@%s:%s]$\033[00m " "$(basename "$VIRTUAL_ENV")" "\u" "\h" "\w")'
        export PS1       
        exec bash --norc --noprofile
      '';
      
      # Define the development shell for Linux systems
      linuxDevShell = pkgs.mkShell {
        buildInputs = commonPackages ++ (with pkgs; [
          pythonManylinuxPackages.manylinux2014Package
          stdenv.cc.cc.lib
        ]) ++ pkgs.lib.optionals (cudaSupport && system == "x86_64-linux") (with pkgs; [
          cudatoolkit
          cudnn
          (ollama.override { acceleration = "cuda"; })
        ]);
        shellHook = ''
          ${runScript}/bin/runScript
          # Set up Nix prompt for when user exits Python venv
          nix_prompt='\[\033[1;34m\][nix-dev]\[\033[0m\] \w $ '
          if [ -n "$ZSH_VERSION" ]; then
            setopt PROMPT_SUBST
            PS1="%F{blue}[nix-dev]%f %~ $ "
          else
            PS1="$nix_prompt"
          fi
        '';
      };
      
      # Define the development shell for Darwin (macOS) systems
      darwinDevShell = pkgs.mkShell {
        buildInputs = commonPackages;
        shellHook = ''
          ${runScript}/bin/runScript
          # Set up Nix prompt for when user exits Python venv
          if [ -n "$ZSH_VERSION" ]; then
            setopt PROMPT_SUBST
            PS1="%F{blue}[nix-dev]%f %~ $ "
          else
            PS1='\[\033[1;34m\][nix-dev]\[\033[0m\] \w $ '
          fi
        '';
      };
    in {
      # Choose the appropriate devShell based on the current platform
      devShell = if isLinux then linuxDevShell else darwinDevShell;
    });
}
```

## The Host System Plays a Vital Role in Cloud Deployments

So a flake like this basically defines a whole computer, system, application,
cloud deployment, what have you. There's certain capabilities you assume that
the **host system** brings to the picture, like *internet access* and some local
file storage. But it takes the place of tons of other technology, and as
complicated as it may look, it at least gathers all the complexity into one
place. It even lets you adapt to differences in the host system, exception
handling I am not trilled to do, but the exception in this case is Macs, and
that is worth it because so much of the developer audience for this sort of
stuff are Mac users.

Anyhow, the way Nix flakes like this are generally used are that they are a file
in a git (and thus often GitHub) repo. When you clone a repo locally, which you
can actually do with this flake:

    git clone https://github.com/miklevin/pipulate

...you can then `cd` into the folder and type:

    nix develop

## Hydrating a Nix Flake with Nix Develop

This ***"hydrates"*** the application on your machine, as the cool kids seem to
be over-saying these days. You can also think of it like running a recipe, which
the same Mac cool kids might know as `brew install` formulas. There's a
*formula* for building this or that. Same thing, but for Linux instead of Macs
in particular, and with a whole bunch of stuff to make sure it happens the same
way every time. You might also call it a build or a make system. You just don't
have to be a genius like a C programmer.

So when you type `nix develop`, it follows out all those instructions, and in
this case, you'll see something like this output...

```
[mike@nixos:~/repos/pipulate]$ nix develop
warning: Git tree '/home/mike/repos/pipulate' is dirty
 ____  _             _       _       
|  _ \(_)_ __  _   _| | __ _| |_ ___ 
| |_) | | '_ \| | | | |/ _` | __/ _ \
|  __/| | |_) | |_| | | (_| | ||  __/
|_|   |_| .__/ \__,_|_|\__,_|\__\___|
        |_|                          
Welcome to the Pipulate development environment on x86_64-linux!

- Checking if pip packages are installed...
- Done. 171 pip packages installed.
- Checking if numpy is importable...
- numpy is importable (good to go!)

- Start JupyterLab and FastHTML server with: start
- Stop JupyterLab and FastHTML server with: stop
- To exit the Pipulate environment, type 'exit' twice.

Checking Ollama connectivity...
Ollama says: Using model: llama3.1:latest
I think you meant "procreate"!

Here's a clever way to say it:

"Prepared to propagate the species and perpetuate the family line, one delightful descendant at a time!"

Or, if you want to make it a bit more humorous:

"It's time to multiply like rabbits... or at least, that's what I keep telling my significant other!"

Learn more at https://pipulate.com <--Ctrl+Click
```

## Local ChatBot Access Included

I say "something like this" will output, because it will indeed be different
every time because of the way I check for connectivity with a local Ollama LLM
server. If you're on a Mac and simply keep that little Llama in your menu bar
because you're one of the cool kids, this lets you connect to it.

## `start` and `stop` Commands

So the development work is as if your own local machine was hosting the app. For
that, you need something running. In this case, it's both JupyterLab for a Data
Science-like approach, and a very basic FastHTML app under Uvicorn. And to get
these servers started, you have to start them. I experimented with starting them
automatically when you `nix develop`, but that got a little messy. I decided to
make it deliberate with the simplest, most obvious commands `start` and `stop`.

## Running Commands in Background for Multi-Platform Environments

This is vital for my next round of work, because since these environments are
initiated from a command-line Terminal, the commands that start the various
servers like JupyterLab and FastHTML tie up the console. In Linux there's a ton
of ways to run stuff in the background, and I explored quite a few until I
settled on the simplest I could imagine. It has to be simple because it has to
be multi-platform. I considered splitting the command-line Terminal up into
window panes with `tmux`. 

## Making A Simple Script Easy To Understand And Use

Ultimately, I settled on just running them invisibly in the background,
outputting a local file log if you really wanted to monitor its output, you
could with the `tail` command or somethinig. Bottom line is I made it as simple
as possible for the newb without turning it into a multi-day project. I can
always refine it over time.

---

## Anatomy of a Flake

I feel like I just did this yesterday, but the flake has actually become quite a
bit more sophisticated. So I will once again break it down the code step by step
to explain what each part does.

### **1. Flake Inputs**

```nix
inputs = {
  nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";  # Nix packages source
  flake-utils.url = "github:numtide/flake-utils";    # Helpful utilities for flakes
};
```

- **`nixpkgs`**: Specifies the version of the Nix Packages collection to use (NixOS 24.05).
- **`flake-utils`**: Provides utility functions for Nix flakes, such as `eachDefaultSystem`.

---

### **2. Flake Outputs**

```nix
outputs = inputs @ { self, nixpkgs, flake-utils, ... }:
  flake-utils.lib.eachDefaultSystem (system: let
    # ...
  in {
    # ...
  });
```

- **Purpose**: Generates outputs for each supported system (e.g., `x86_64-linux`, `aarch64-darwin`).
- **`system`**: Represents the target system architecture.

---

### **3. Importing Nixpkgs and Configuration**

```nix
pkgs = import nixpkgs {
  inherit system;
  config.allowUnfree = true;
};

localConfig = if builtins.pathExists ./local.nix then import ./local.nix else {};
cudaSupport = if localConfig ? cudaSupport then localConfig.cudaSupport else false;
```

- **`pkgs`**: Imports the Nix packages for the current system, allowing unfree packages.
- **`localConfig`**: Imports a local configuration file (`local.nix`) if it exists.
- **`cudaSupport`**: Determines if CUDA support is enabled based on the local configuration.

---

### **4. Platform Detection**

```nix
isLinux = pkgs.stdenv.isLinux;
isDarwin = pkgs.stdenv.isDarwin;
```

- **`isLinux` / `isDarwin`**: Flags to identify the operating system.

---

### **5. Common Packages**

```nix
commonPackages = with pkgs; [
  python311
  python311.pkgs.pip
  python311.pkgs.virtualenv
  cmake
  ninja
  gcc
  git
  zlib
  stdenv.cc.cc.lib
  figlet
];
```

- **Purpose**: Defines a list of packages required for the development environment.
- **Includes**:
  - **Python 3.11** and tools (`pip`, `virtualenv`).
  - **Build tools**: `cmake`, `ninja`, `gcc`.
  - **Version control**: `git`.
  - **Libraries**: `zlib`, standard C library.
  - **Utilities**: `figlet` (for ASCII art in the terminal).

---

### **6. Run Script (`runScript`)**

```nix
runScript = pkgs.writeShellScriptBin "runScript" ''
  # Script content
'';
```

- **Purpose**: Creates a shell script to set up the development environment.
- **Actions**:
  - Sets environment variables (`NIXPKGS_ALLOW_UNFREE`, `LD_LIBRARY_PATH`).
  - Displays a welcome message using `figlet`.
  - Checks and sets up a Python virtual environment (`.venv`).
  - Installs Python packages from `requirements.txt`.
  - Verifies that `numpy` is importable.
  - Checks connectivity with the `Ollama` server via `ollama_check.py`.
  - Creates `start` and `stop` scripts inside `.venv/bin/`.

---

### **7. Start and Stop Scripts**

#### **Start Script**

- **Location**: `.venv/bin/start`
- **Purpose**: Starts JupyterLab and the custom server in the background.
- **Actions**:
  - Stops any existing instances.
  - Launches services and logs output to `jupyter.log` and `server.log`.
  - Opens the default web browser to `http://localhost:5001` based on the OS.

#### **Stop Script**

- **Location**: `.venv/bin/stop`
- **Purpose**: Stops JupyterLab, Jupyter kernels, and the custom server.
- **Actions**:
  - Terminates processes gracefully, and forcefully if necessary.

---

### **8. Shell Prompt Customization**

```nix
# Override PROMPT_COMMAND and set custom PS1
export PROMPT_COMMAND=""
PS1='$(printf "\033[01;34m(%s)\033[00m \033[01;32m[%s@%s:%s]$\033[00m " "$(basename "$VIRTUAL_ENV")" "\u" "\h" "\w")'
export PS1
exec bash --norc --noprofile
```

- **Purpose**: Customizes the shell prompt to display the virtual environment and user information.
- **`exec bash --norc --noprofile`**: Starts a new bash shell without reading startup files.

---

### **9. Development Shells**

#### **Linux Development Shell (`linuxDevShell`)**

```nix
linuxDevShell = pkgs.mkShell {
  buildInputs = commonPackages ++ (with pkgs; [
    pythonManylinuxPackages.manylinux2014Package
    stdenv.cc.cc.lib
  ]) ++ pkgs.lib.optionals (cudaSupport && system == "x86_64-linux") (with pkgs; [
    cudatoolkit
    cudnn
    (ollama.override { acceleration = "cuda"; })
  ]);
  shellHook = ''
    ${runScript}/bin/runScript
    # Shell prompt setup
  '';
};
```

- **`buildInputs`**:
  - Adds platform-specific packages.
  - Includes CUDA packages if enabled.
- **`shellHook`**: Runs the `runScript` when the shell is entered.

#### **Darwin Development Shell (`darwinDevShell`)**

```nix
darwinDevShell = pkgs.mkShell {
  buildInputs = commonPackages;
  shellHook = ''
    ${runScript}/bin/runScript
    # Shell prompt setup
  '';
};
```

- **Simpler setup**: Only includes `commonPackages`.

---

### **10. Selecting the Appropriate Dev Shell**

```nix
devShell = if isLinux then linuxDevShell else darwinDevShell;
```

- **Purpose**: Exposes the appropriate development shell based on the operating system.

---

### **Additional Details**

- **CUDA Support**:
  - Enabled through `local.nix`.
  - Adds CUDA libraries and adjusts `LD_LIBRARY_PATH` on Linux systems.
  
- **Ollama Server**:
  - Checks server connectivity using a Python script (`ollama_check.py`).
  - Optionally includes an overridden `ollama` package with CUDA acceleration.

- **Environment Variables**:
  - `NIXPKGS_ALLOW_UNFREE=1`: Allows installation of unfree packages.
  - `LD_LIBRARY_PATH`: Includes paths to necessary libraries.

- **Scripts Execution**:
  - **`start`**: Use this script to start development services.
  - **`stop`**: Use this script to stop running services.
  
- **Shell Customization**:
  - Adjusts the prompt for both Bash and Zsh shells.
  - Provides a consistent look and feel across different environments.

---

### **Usage Instructions**

1. **Enter the Development Shell**:
   ```bash
   nix develop
   ```
   - This command invokes the appropriate dev shell for your system.
   - The `shellHook` runs automatically, setting up the environment.

2. **Activate the Virtual Environment**:
   - The `runScript` creates and activates `.venv` for Python dependencies.

3. **Install Python Packages**:
   - Automatically installs packages from `requirements.txt`.

4. **Start Services**:
   ```bash
   start
   ```
   - Starts JupyterLab and the custom server.
   - Opens `http://localhost:5001` in your default browser if supported.

5. **Stop Services**:
   ```bash
   stop
   ```
   - Gracefully stops all running services.

6. **Exit the Environment**:
   - Type `exit` twice to leave the virtual environment and the Nix shell.

---

### **Summary**

- **Purpose**: This Nix flake automates the setup of a consistent development environment for the Pipulate project across different systems.
- **Features**:
  - Manages dependencies via Nix and Python virtual environments.
  - Provides scripts to control development services.
  - Customizes the shell environment for ease of use.
  - Supports optional CUDA acceleration on Linux.
  
---

## Well, that's nice. But what about Apple Metal support for Apple GPUs?

**PerplexityAI**: Unfortunately, this Nix flake does not directly support Apple Metal. Here are the key reasons:

1. Platform specificity: Metal is an Apple-specific graphics API, while this flake is designed to work across multiple platforms, including Linux and macOS[1].
2. No Metal-specific packages: The flake doesn't include any Metal-specific packages or dependencies in its buildInputs[4].
3. Focus on Python and CUDA: The flake is primarily set up for a Python development environment, with optional CUDA support for Linux systems. It doesn't include any Metal-specific configuration or tools[4].
4. Cross-platform design: The flake uses flake-utils to generate outputs for each default system, indicating a focus on cross-platform compatibility rather than Apple-specific technologies[4].
5. No Apple-specific GPU configurations: While the flake checks for CUDA support on Linux, there are no equivalent checks or configurations for Metal on macOS[4].

To support Metal, the flake would need significant modifications, including:

1. Adding Metal-specific packages and dependencies for macOS systems.
2. Implementing checks for Metal support on Apple devices.
3. Including Metal-specific configuration and environment variables.
4. Potentially adding Metal-related development tools or SDKs.

Given the current structure, this flake is not designed to support or utilize Apple Metal. It's more focused on providing a cross-platform Python development environment with optional CUDA support for Linux systems.

Citations:

    [1] https://support.apple.com/en-us/102894
    [2] https://www.anandtech.com/show/8116/some-thoughts-on-apples-metal-api
    [3] https://www.reddit.com/r/GraphicsProgramming/comments/1ap6d09/is_there_a_use_formarket_for_metal/
    [4] https://developer.apple.com/videos/play/tech-talks/10580/
    [5] https://developer.apple.com/forums/thread/38469
    [6] https://github.com/dustinlyons/nixos-config
    [7] https://blog.lambdaclass.com/using-metal-and-rust-to-make-fft-even-faster/
    [8] https://github.com/tpwrules/nixos-apple-silicon

---

# Web App Development at Home

And now for the app! All this is to have a place to work experimentially on
Python with the freedom that Notebooks provide, then to migrate the important
bits over to a Web app. Back in the day, that day being 1998 through the 200X's,
I made those apps with Microsoft Active Server Pages (ASP), which you still see
around. This was before NodeJS and the explosion of complex client-side
JavaScript frameworks like React. Ruby on Rails also came along. Despite having
tried, I never jumped on either of those bandwagons, client-side JS nor Ruby
joyful frameworks.

### The Jupyter Notebook Detour

Instead, I went the Python route, fell in love with the language, and even shied
away from the Python Django framework. I like lightweight, like the Pyton Flask
micro web framework. But too often, you still have to look at HTML and
JavaScript as you blend Python with them using some templating system, like
jinja2 (big in Flask), mako (what Reddit was made with), or other double
curly-braced template languages like nunchucks or liquid templates that use
those mustaches {% raw %}{{ foo }}{% endraw %}. Instead, I avoided web
developmenmt by using Python in Jupyter Notebooks for my various SEO tasks.

### FastHTML Web App Simplification

So now I've got a bunch of Notebooks that are already working. But the world has
changed again, and now I have to bring the utility of those notebooks to a
broader range of people, sparing them the difficulty of learning how to do
things in a Notebook. As easy as they are, tasks can be even easier for this
audience when the Notebook is just turned into a Web app. It's easier for the
app user, but harder for the app developer. If only the complexity of Web app
development wasn't so steep. Enter FastHTML! Here is its Hello World web app...

### Flask Minus the Mustache Syntax

```python
from fasthtml.common import *

# Initialize the FastHTML application
app, rt = fast_app()

# Define a route for the home page
@rt("/")
def get():
    # Return a titled page with a simple "Hello, World!" message
    return Titled("Hello World", P("Hello, World!"))

# Start the server
serve()
```

## Creating A Simple Web Page With Python

Notice the lack of a template language. Notice the lack of crosseye-inducing
double curly brackets. HTML tags are represented as Python functions with names
reflecting the element. `P()` is for paragraph `<p>` and `Titled()` is for a
titled page with both a title tag and a headline-like page title. When you `nix
develop` the ***pipulate flake*** on your machine, a webserver is set up on
localhost:5001, and you get a rudimentary page. It does use CSS and JavaScript
as well to build the page, but you don't have to look at it.

### Flask - Mustaches + HTMX = Pythonic SPA

FastHTML combines the routing decorators of the Flask-like API with a Python web
framework that uses function names that reflect their HTML elements, and a
method of updating things on the page called HTMX. HTMX is a way of changing
page data without a page reload, enabling single-page applications (SPA) with
amazingly small amounts of clear concise code to get the job done. 

And still, you don't have to actually look at the JavaScript. When the button is
pressed, it calls a page (function) called `increment` and swaps the inner HTML
with the result of that function...

```python
from fasthtml.common import *

# Initialize the FastHTML application
app, rt = fast_app()

x = 0

@app.get("/")
def home():
    return Title("FastHTML HTMX Demo"), Main(
        H1("Hello, FastHTML with HTMX!"),
        P(f"Count: {x}", id="count"),
        Button("Increment", 
               hx_post="/increment", 
               hx_target="#count", 
               hx_swap="innerHTML")
    )

@app.post("/increment")
def increment():
    global x
    x += 1
    return f"Count: {x}"

# Start the server
serve()
```

## The Rise of Interpreted Languages in Web Development

Look, no JavaScript! And no CSS for that matter. And no build procedure. Just
change the code in the file, go refresh the page, see your changes! This is the
"build vs. no-build" or "compiled vs. interpreted" debate in web development.
Compiled clearly won, but interpreted is making a comeback.

### The Build vs No-Build Debate

Dem's fightin' words! There's webdev religious dogmas here. The webdev community
has decided to minimize the amount of work to be done on the server by shifting
it to the browser using client-side JavaScript framework like React, Vue,
Svelte. The result is having to "compile" JavaScript code, introducing a
**"build"** process where there was none before, and tons of having to handle
JSON instead of HTML.

### JavaScript Frameworks Victims of Conway's Law

To me, workflow-wise this loses all the wonderful quickness and easy breezy
nature of webdev that used to be there. Advocates of compiled JavaScript say the
benefit is worth it. But to me, it just makes it overly complex and
inaccessible. It's Conway's Law in action. Things become more complex to reflect
the people who designed them, which on the Web resulted in shutting out people
like me who prefer a no-build environment. 

### Joyful Frameworks

I actually closely align with David Heinemeier Hansson (DHH), the creator of
Ruby on Rails on this and a lot of these principles. With a little caching and
the just-in-time compiling that is invisibly in the process that's in the
process anyway these days, even for the "interpreted" approach, you can keep web
development easy breezy, lightweight and joyful like it used to be.

---

# I Have a Secret

Okay, so that was FastHTML's Hello World and HTMX usage. But there is one more
building block we need. And yes, I put these examples on my "home" article
because these are all new additions to my home that I have to keep reminding
myself of. They are WebDev capabilities I've avoiding having to face for years
because Notebooks got me a get-out-of-jail free card. But no more. The last
building block example here is how to keep secrets when you go about trading
these web apps as nix flakes.

## Environment Variables

The best practice for using secrets in your code seems to have settled on
environment variables. All the OSes have them. But it just shifts around where
the secrets are kept, from out of your programming code and into some other file
on your computer, the idea being you will somehow inherit those environment
variables from your OS and never have to display them. 

### pip install dotenv

Guess what? Merely shifting where secrets are kept doesn't get you off the hook
of having to manage them well. You still need some apparatus to do that! And the
Python community seems to have settled on a pip installable package called
`dotenv` that reads (and now also writes) a file called `.env`. So here's a
simplest code I could come up with that 1-time prompts the user to provide a
secret (like an API key or token) and writes it into the .env file for later
use...

```python
from fasthtml.common import *
from dotenv import load_dotenv, set_key
import os

# Initialize the FastHTML application
app, rt = fast_app()

# Load environment variables
load_dotenv()

@rt("/")
def get():
    # Reload the environment variables to reflect any updates
    load_dotenv()
    secret = os.getenv('SECRET')
    if secret:
        message = P("I already know your secret")
    else:
        message = Form(method="post")(
            Label("Enter the secret:", Input(type="password", name="secret")),
            Button("Submit", type="submit")
        )
    return Titled("Secret Prompt", message)

@rt("/", methods=["POST"])
def post(secret: str):
    # Save the secret to the .env file if it hasn't been set
    if not os.getenv('SECRET'):
        set_key('.env', 'SECRET', secret)
        load_dotenv()  # Reload the .env file after updating it
        return Titled("Secret Saved", P("Your secret has been saved."))
    else:
        return Titled("Secret Already Set", P("A secret is already set. No changes were made."))

# Start the server
serve()
```

## Our New Building Blocks Are Here To Be Documented Thoroughly

And THAT is our new building blocks! The whole thing is documented at the
[fastht.ml](https://www.fastht.ml/) website. And this is where I'm making my own
building-block documentation so I can start converting Notebooks over to Web
Apps! Want to know a secret? So do web apps! And it's a pain because as
distributable and sharable as these things are through nix flakes, you can't
toss secrets like API keys into those git repos. And so right out of the
starting gate, we are hit with that complication.

And with these 3 examples in-hand, Hello World, HTMX SPA and Secret Handling, I
have everything I need to jump head-first into Web Application development
again. Ugh!
