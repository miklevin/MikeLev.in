---
title: Melding a Mac and Linux Nix Flake
permalink: /mac-nix-flake/
description: I describe the process of creating a cross-platform Nix flake for a development environment that includes JupyterLab, CUDA support, Ollama for local LLMs, and a FastHTML server. I highlight the challenges of working with bleeding-edge technologies and the benefits of Nix's package management system. I also detail the process of configuring NixOS, using virtual environments for Python packages, and testing the setup on different platforms to ensure compatibility and reproducibility.
layout: post
---

## Understanding Nix Flakes for Multi-Platform Development Basics

This multi-platform stuff is epic. I've greated 2 massive Nix Flakes, each of
which has its plusses and minuses, and I want to sort it all out and get a
really good understanding of it all, basically tearing it down and building it
up. But first, the giant flakes...

This works on Linux:

```nix
{
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
        tmux
      ];
      
      # Create a shell script to set up the development environment
      runScript = pkgs.writeShellScriptBin "runScript" ''
        set -e
        export NIXPKGS_ALLOW_UNFREE=1
        export LD_LIBRARY_PATH=${pkgs.lib.makeLibraryPath commonPackages}:$LD_LIBRARY_PATH
        ${if isLinux && cudaSupport then "export LD_LIBRARY_PATH=${pkgs.stdenv.cc.cc.lib}/lib:$LD_LIBRARY_PATH" else ""}
        
        # Get the name of the current directory (repo folder)
        REPO_NAME=$(basename "$PWD")
        
        # Convert the repo name to Proper case (first letter uppercase, rest lowercase)
        PROPER_REPO_NAME=$(echo "$REPO_NAME" | awk '{print toupper(substr($0,1,1)) tolower(substr($0,2))}')
        
        # Use the Proper case repo name in the figlet output
        figlet "$PROPER_REPO_NAME"
        echo "Welcome to the $PROPER_REPO_NAME development environment on ${system}!"
        echo
        echo "- Checking if pip packages are installed..."
        ${if cudaSupport && isLinux then "echo '- CUDA support enabled.'" else ""}
        test -d .venv || ${pkgs.python311.interpreter} -m venv .venv
        set -e  # Exit immediately if a command exits with a non-zero status

        if source .venv/bin/activate && \
           pip install --upgrade pip --quiet && \
           pip install -r requirements.txt --quiet && \
           nb-clean add-filter; then
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
        
        # Create the improved start script
        cat << EOF > .venv/bin/start
        #!/bin/sh
        stop
        echo "Starting JupyterLab and server in tmux sessions..."
        tmux new-session -d -s jupyter 'source .venv/bin/activate && jupyter lab'
        tmux new-session -d -s server 'source .venv/bin/activate && python server.py'
        echo "JupyterLab and server started in tmux sessions."
        echo "To view JupyterLab: tmux attach -t jupyter"
        echo "To view server: tmux attach -t server"
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

        # Create the improved stop script
        cat << EOF > .venv/bin/stop
        #!/bin/sh
        echo "Stopping all tmux sessions..."
        tmux kill-server 2>/dev/null || echo "No tmux sessions were running."
        echo "All tmux sessions have been stopped."
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

...and this works on Mac:

```nix
{
  description = "A flake that reports the OS using separate scripts";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        isDarwin = pkgs.stdenv.isDarwin;
        isLinux = pkgs.stdenv.isLinux;

        # Define common packages used across all platforms
        commonPackages = with pkgs; [
          python311
          python311.pkgs.pip
          python311.pkgs.virtualenv
          figlet
          tmux
          zlib
          git
        ] ++ (with pkgs; pkgs.lib.optionals isLinux [
          gcc
          stdenv.cc.cc.lib
        ]);

        runScript = pkgs.writeShellScriptBin "run-script" ''
          #!/usr/bin/env bash
          # Activate the virtual environment
          source .venv/bin/activate

          # Use the Proper case repo name in the figlet output
          REPO_NAME=$(basename "$PWD")
          PROPER_REPO_NAME=$(echo "$REPO_NAME" | awk '{print toupper(substr($0,1,1)) tolower(substr($0,2))}')
          figlet "$PROPER_REPO_NAME"
          echo "Welcome to the $PROPER_REPO_NAME development environment on ${system}!"
          echo 
          # Install packages from requirements.txt
          echo "- Installing pip packages..."
          if pip install --upgrade pip --quiet && \
            pip install -r requirements.txt --quiet; then
              package_count=$(pip list --format=freeze | wc -l)
              echo "- Done. $package_count pip packages installed."
          else
              echo "Warning: An error occurred during pip setup."
          fi
          if python -c "import numpy" 2>/dev/null; then
            echo "- numpy is importable (good to go!)"
          else
            echo "Error: numpy could not be imported. Check your installation."
          fi
          jupyter lab
        '';

        linuxDevShell = pkgs.mkShell {
          buildInputs = commonPackages;  # Added commonPackages
          shellHook = ''
            # Create the Python virtual environment
            test -d .venv || ${pkgs.python311}/bin/python -m venv .venv
            export VIRTUAL_ENV="$(pwd)/.venv"
            export PATH="$VIRTUAL_ENV/bin:$PATH"
            export PS1='$(printf "\033[01;34m(nix) \033[00m\033[01;32m[%s@%s:%s]$\033[00m " "\u" "\h" "\w")'
            export LD_LIBRARY_PATH=${pkgs.lib.makeLibraryPath commonPackages}:$LD_LIBRARY_PATH
            # Run the common runScript
            ${runScript}/bin/run-script  # Ensure to call the script correctly
          '';
        };

        darwinDevShell = pkgs.mkShell {
          buildInputs = commonPackages;  # Added commonPackages
          shellHook = ''
            # Create the Python virtual environment
            test -d .venv || ${pkgs.python311}/bin/python -m venv .venv
            export VIRTUAL_ENV="$(pwd)/.venv"
            export PATH="$VIRTUAL_ENV/bin:$PATH"
            export PS1='$(printf "\033[01;34m(nix) \033[00m\033[01;32m[%s@%s:%s]$\033[00m " "\u" "\h" "\w")'
            export LD_LIBRARY_PATH=${pkgs.lib.makeLibraryPath commonPackages}:$LD_LIBRARY_PATH
            # Run the common runScript
            ${runScript}/bin/run-script  # Ensure to call the script correctly
          '';
        };

      in {
        devShell = if isLinux then linuxDevShell else darwinDevShell;  # Ensure multi-OS support
      });
}
```

## Using tmux for Background Data Science Platform Control

Okay, that's a competent little data science platform, but it locks up the
command line that you launch it from, so let's run it in the background in a
tmux session which we can control with simple start and stop commands, which we
write as little scripts and drop them in to the Python .venv/bin folder where
you don't need to use paths or even extensions...

```nix
{
  description = "A flake that reports the OS using separate scripts";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        isDarwin = pkgs.stdenv.isDarwin;
        isLinux = pkgs.stdenv.isLinux;

        # Define common packages used across all platforms
        commonPackages = with pkgs; [
          python311
          python311.pkgs.pip
          python311.pkgs.virtualenv
          figlet
          tmux
          zlib
          git
        ] ++ (with pkgs; pkgs.lib.optionals isLinux [
          gcc
          stdenv.cc.cc.lib
        ]);

        runScript = pkgs.writeShellScriptBin "run-script" ''
          #!/usr/bin/env bash
          # Activate the virtual environment
          source .venv/bin/activate

          # Use the Proper case repo name in the figlet output
          REPO_NAME=$(basename "$PWD")
          PROPER_REPO_NAME=$(echo "$REPO_NAME" | awk '{print toupper(substr($0,1,1)) tolower(substr($0,2))}')
          figlet "$PROPER_REPO_NAME"
          echo "Welcome to the $PROPER_REPO_NAME development environment on ${system}!"
          echo 
          # Install packages from requirements.txt
          echo "- Installing pip packages..."
          if pip install --upgrade pip --quiet && \
            pip install -r requirements.txt --quiet; then
              package_count=$(pip list --format=freeze | wc -l)
              echo "- Done. $package_count pip packages installed."
          else
              echo "Warning: An error occurred during pip setup."
          fi
          if python -c "import numpy" 2>/dev/null; then
            echo "- numpy is importable (good to go!)"
          else
            echo "Error: numpy could not be imported. Check your installation."
          fi

          # Create the start script
          cat << EOF > .venv/bin/start
          #!/bin/sh
          stop
          echo "Starting JupyterLab..."
          tmux new-session -d -s jupyter 'source .venv/bin/activate && jupyter lab'
          echo "JupyterLab started."
          echo "To view JupyterLab server: tmux attach -t jupyter"
          echo "To stop JupyterLab server: stop"
          EOF
          chmod +x .venv/bin/start

          # Create the stop script
          cat << EOF > .venv/bin/stop
          #!/bin/sh
          echo "Stopping tmuxs..."
          tmux kill-server 2>/dev/null || echo "No tmux session is running."
          echo "All tmux sessions have been stopped."
          EOF
          chmod +x .venv/bin/stop

        '';

        linuxDevShell = pkgs.mkShell {
          buildInputs = commonPackages;  # Added commonPackages
          shellHook = ''
            # Create the Python virtual environment
            test -d .venv || ${pkgs.python311}/bin/python -m venv .venv
            export VIRTUAL_ENV="$(pwd)/.venv"
            export PATH="$VIRTUAL_ENV/bin:$PATH"
            export PS1='$(printf "\033[01;34m(nix) \033[00m\033[01;32m[%s@%s:%s]$\033[00m " "\u" "\h" "\w")'
            export LD_LIBRARY_PATH=${pkgs.lib.makeLibraryPath commonPackages}:$LD_LIBRARY_PATH
            # Run the common runScript
            ${runScript}/bin/run-script  # Ensure to call the script correctly
          '';
        };

        darwinDevShell = pkgs.mkShell {
          buildInputs = commonPackages;  # Added commonPackages
          shellHook = ''
            # Create the Python virtual environment
            test -d .venv || ${pkgs.python311}/bin/python -m venv .venv
            export VIRTUAL_ENV="$(pwd)/.venv"
            export PATH="$VIRTUAL_ENV/bin:$PATH"
            export PS1='$(printf "\033[01;34m(nix) \033[00m\033[01;32m[%s@%s:%s]$\033[00m " "\u" "\h" "\w")'
            export LD_LIBRARY_PATH=${pkgs.lib.makeLibraryPath commonPackages}:$LD_LIBRARY_PATH
            # Run the common runScript
            ${runScript}/bin/run-script  # Ensure to call the script correctly
          '';
        };

      in {
        devShell = if isLinux then linuxDevShell else darwinDevShell;  # Ensure multi-OS support
      });
}
```

## JupyterLab Works Across Multiple Platforms Despite Some Limitations

And that's tested on Mac, Linux and Windows, although the automatic opening of
the JupyterLab tab in the host system's web browser isn't happening on Windows
WSL. You can still start Juptyer Lab with the command `jupyter lab` and
Ctrl+click the link, but I'll fix that at some point. It's still a massive
success.

And now with optional Nvidia CUDA GPU acceleration support:

```nix
{
  description = "A flake that reports the OS using separate scripts with optional CUDA support and unfree packages allowed.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        # Import nixpkgs with allowUnfree enabled
        pkgs = import nixpkgs {
          system = system;
          config = {
            allowUnfree = true;  # Allow unfree packages like CUDA
          };
        };

        isDarwin = pkgs.stdenv.isDarwin;
        isLinux = pkgs.stdenv.isLinux;

        # Define common packages used across all platforms
        commonPackages = with pkgs; [
          python311
          python311.pkgs.pip
          python311.pkgs.virtualenv
          figlet
          tmux
          zlib
          git
        ] ++ (with pkgs; pkgs.lib.optionals isLinux [
          gcc
          stdenv.cc.cc.lib
        ]);

        # Define optional CUDA packages for Linux
        cudaPackages = with pkgs; [
          cudatoolkit
          cudnn
          nccl
        ];

        # Create a common shell script to run on both Linux and macOS
        runScript = pkgs.writeShellScriptBin "run-script" ''
          #!/usr/bin/env bash
          # Activate the virtual environment
          source .venv/bin/activate

          # Use the Proper case repo name in the figlet output
          REPO_NAME=$(basename "$PWD")
          PROPER_REPO_NAME=$(echo "$REPO_NAME" | awk '{print toupper(substr($0,1,1)) tolower(substr($0,2))}')
          figlet "$PROPER_REPO_NAME"
          echo "Welcome to the $PROPER_REPO_NAME development environment on ${system}!"
          echo 
          # Install packages from requirements.txt
          echo "- Installing pip packages..."
          if pip install --upgrade pip --quiet && \
            pip install -r requirements.txt --quiet; then
              package_count=$(pip list --format=freeze | wc -l)
              echo "- Done. $package_count pip packages installed."
          else
              echo "Warning: An error occurred during pip setup."
          fi
          if python -c "import numpy" 2>/dev/null; then
            echo "- numpy is importable (good to go!)"
          else
            echo "Error: numpy could not be imported. Check your installation."
          fi

          # Create the start script
          cat << EOF > .venv/bin/start
          #!/bin/sh
          stop
          echo "Starting JupyterLab..."
          tmux new-session -d -s jupyter 'source .venv/bin/activate && jupyter lab'
          echo "JupyterLab started."
          echo "To view JupyterLab server: tmux attach -t jupyter"
          echo "To stop JupyterLab server: stop"
          EOF
          chmod +x .venv/bin/start

          # Create the stop script
          cat << EOF > .venv/bin/stop
          #!/bin/sh
          echo "Stopping tmuxs..."
          tmux kill-server 2>/dev/null || echo "No tmux session is running."
          echo "All tmux sessions have been stopped."
          EOF
          chmod +x .venv/bin/stop

        '';

        linuxDevShell = pkgs.mkShell {
          buildInputs = commonPackages ++ (with pkgs; pkgs.lib.optionals (builtins.pathExists "/usr/bin/nvidia-smi") cudaPackages);  # Add CUDA packages if nvidia-smi exists
          shellHook = ''
            # Create the Python virtual environment
            test -d .venv || ${pkgs.python311}/bin/python -m venv .venv
            export VIRTUAL_ENV="$(pwd)/.venv"
            export PATH="$VIRTUAL_ENV/bin:$PATH"
            export PS1='$(printf "\033[01;34m(nix) \033[00m\033[01;32m[%s@%s:%s]$\033[00m " "\u" "\h" "\w")'
            export LD_LIBRARY_PATH=${pkgs.lib.makeLibraryPath commonPackages}:$LD_LIBRARY_PATH

            # Optional CUDA support
            if command -v nvidia-smi &> /dev/null; then
              echo "CUDA hardware detected."
              export CUDA_HOME=${pkgs.cudatoolkit}
              export PATH=$CUDA_HOME/bin:$PATH
              export LD_LIBRARY_PATH=$CUDA_HOME/lib64:$LD_LIBRARY_PATH
            else
              echo "No CUDA hardware detected."
            fi

            # Run the common runScript
            ${runScript}/bin/run-script  # Ensure to call the script correctly
          '';
        };

        darwinDevShell = pkgs.mkShell {
          buildInputs = commonPackages;  # Added commonPackages for macOS
          shellHook = ''
            # Create the Python virtual environment
            test -d .venv || ${pkgs.python311}/bin/python -m venv .venv
            export VIRTUAL_ENV="$(pwd)/.venv"
            export PATH="$VIRTUAL_ENV/bin:$PATH"
            export PS1='$(printf "\033[01;34m(nix) \033[00m\033[01;32m[%s@%s:%s]$\033[00m " "\u" "\h" "\w")'
            export LD_LIBRARY_PATH=${pkgs.lib.makeLibraryPath commonPackages}:$LD_LIBRARY_PATH

            # Run the common runScript
            ${runScript}/bin/run-script  # Ensure to call the script correctly
          '';
        };

      in {
        devShell = if isLinux then linuxDevShell else darwinDevShell;  # Ensure multi-OS support
      });
}
```
