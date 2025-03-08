---
title: "Nix Flake Python Solution: Venv, Cuda, macOS/Windows, Etc."
permalink: /futureproof/nix-flake-python/
description: 
layout: post
sort_order: 1
---

## A Cross-Platform Python Solution with Nix Flakes

Are you looking for a Nix Flake Python solution that works on Macs or Windows,
supporting Python `pip install` commands, your NVidia card if you've got it? Me
too! So I made this. Download it, clone it, fork it, whatever. 

I've updated it to Python 3.13 to get you on all the latest goodness. If that's
out of date by the time you read this, there's just a few places to update the
version reference in the `flake.nix` file which you can usually find in its
latest form on its GitHub page: [Nix Flake Python](https://github.com/miklevin/darwinix) 

### Balancing Nix Immutability with Data Science Needs

Nix's weird but wonderful immutability that makes it so great for portable
cross-platform environments also makes it frustrating for the traditional Data
Science use case. This fixes that.

### Introducing Darwinix: A Minimal Data Science Starting Point

Darwinix is just a bare minimum starting place for Data Science or anyone in
that love-worthy Venn diagram intersection of being a nix and Python user. If
you're on Google Colab paying for stuff you don't need to, this may be worth a
look. You're not forced to pay or lose what you did.

### Included Python Packages

Look in `requirements.txt`. You'll see I've included:

```python
numpy
pandas
requests
jupyterlab
jupyter-ai[all]
```

...but not much else. But no problem. Just build it up yourself the same you
would with any `requirements.txt`. Pin versions if you like, using the pip
requirements way of doing that.

```python
pandas==2.2.1
numpy==1.26.4
requests==2.18.4
```

### Starting Fresh with Your Own Git Repo

Wipe away my `.git` folder to dissociate it from my repo (if you cloned it) and
`git init` it yourself. This gives you that OS-as-Code dream. Write once, run
anywhere as the age-old promise goes.

### Automatic Virtual Environment Setup

What about all that annoying virtualenv stuff? Well, it gets set up
automatically. Once you copy the code, you just `cd` into whatever folder you
unzipped it to and type:

```
cd darwinix  # (or whatever you named it)
nix develop
start
```

...and a JupyterLab instance (with JupyterAI and all) will just pop up in your
browser. Anything you pip install from that terminal or a Jupyter cell will be
accessible. The `.venv` is just there from the `nix develop` step.

### Understanding the Nix Environment Structure

Declarative deterministic nix provides a that immutable "outer" environment that
has just enough Python to create your dynamic, persistent "inner" Python virtual
environment, which is as good as a `.venv` on any platform. And that's done just
once the first time you `nix develop`.

### Getting Started with Nix Commands

If you're new to nix, I recommend looking it up just to get the basics of the
nix commands, particularly in relation to `nix develop`. There's not much to
know, but it is useful to get the idea that the environments you create are tied
to the terminals you activate them from. That sort of thing.

### Why Nix+Pip Beats Other Package Managers

You don't really need Poetry, Pipenv or any of those other things, though I
suppose you could work them in if you really wanted to. But nix+pip seems to be
the sweet spot for optimum system-control for trading environments around, and
optimum pip-installable freedom for not feeling stifled by nix.

### The Best of Both Worlds: Freedom and Control

Get that loosey goosey freedom of pip installing whatever you need until stuff
just works, it's nice to have a traditional `.venv` Python virtual environment,
and that's what this does inside a nix flake. You get the best of both worlds!

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
          python313Full                # Python 3.13 interpreter
          python313Packages.virtualenv # Tool to create isolated Python environments
          figlet                       # For creating ASCII art welcome messages
          tmux                         # Terminal multiplexer for managing sessions
          zlib                         # Compression library for data compression
          git                          # Version control system for tracking changes
          curl                         # Command-line tool for transferring data with URLs
          wget                         # Utility for non-interactive download of files from the web
          cmake                        # Cross-platform build system generator
          htop                         # Interactive process viewer for Unix systems
        ] ++ (with pkgs; pkgs.lib.optionals isLinux [
          gcc                          # GNU Compiler Collection for compiling C/C++ code
          stdenv.cc.cc.lib             # Standard C library for Linux systems
        ]);

        # This script sets up our Python environment and project
        runScript = pkgs.writeShellScriptBin "run-script" ''
          #!/usr/bin/env bash
          
          # Activate the virtual environment
          source .venv/bin/activate

          # Create a fancy welcome message
          REPO_NAME=$(basename "$PWD")
          PROPER_REPO_NAME=$(echo "$REPO_NAME" | awk '{print toupper(substr($0,1,1)) tolower(substr($0,2))}')
          figlet "$PROPER_REPO_NAME"
          echo "Welcome to the $PROPER_REPO_NAME development environment on ${system}!"
          echo 

          # Install Python packages from requirements.txt
          # This allows flexibility to use the latest PyPI packages
          # Note: This makes the environment less deterministic
          echo "- Installing pip packages..."
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

          # Create convenience scripts for managing JupyterLab
          # Note: We've disabled token and password for easier access, especially in WSL environments
          cat << EOF > .venv/bin/start
          #!/bin/sh
          echo "A JupyterLab tab will open in your default browser."
          tmux kill-session -t jupyter 2>/dev/null || echo "No tmux session named 'jupyter' is running."
          tmux new-session -d -s jupyter 'source .venv/bin/activate && jupyter lab --NotebookApp.token="" --NotebookApp.password="" --NotebookApp.disable_check_xsrf=True'
          echo "If no tab opens, visit http://localhost:8888"
          echo "To view JupyterLab server: tmux attach -t jupyter"
          echo "To stop JupyterLab server: stop"
          EOF
          chmod +x .venv/bin/start

          cat << EOF > .venv/bin/stop
          #!/bin/sh
          echo "Stopping tmux session 'jupyter'..."
          tmux kill-session -t jupyter 2>/dev/null || echo "No tmux session named 'jupyter' is running."
          echo "The tmux session 'jupyter' has been stopped."
          EOF
          chmod +x .venv/bin/stop
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
            # export PS1='$(printf "\033[01;34m(nix) \033[00m\033[01;32m[%s@%s:%s]$\033[00m " "\u" "\h" "\w")'
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
            # export PS1='$(printf "\033[01;34m(nix) \033[00m\033[01;32m[%s@%s:%s]$\033[00m " "\u" "\h" "\w")'
            export LD_LIBRARY_PATH=${pkgs.lib.makeLibraryPath commonPackages}:$LD_LIBRARY_PATH

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

Enjoy!
