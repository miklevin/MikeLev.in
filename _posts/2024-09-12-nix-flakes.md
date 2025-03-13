---
title: Getting Started with Nix Flakes
permalink: /futureproof/nix-flakes/
description: This article describes my journey to integrate Nix Flakes into my NixOS configuration for better version control and reproducibility. Initially hesitant due to the perceived complexity, I eventually embraced Flakes for their ability to simplify git management and streamline my workflow. The article provides a step-by-step guide on implementing Nix Flakes, moving the system configuration to user space, and rebuilding the system for a more manageable and reproducible development environment.
layout: post
---

The article that was originally here was pushed down a bit for what you're
probably here for. Here's a Python Nix Flake that works on macOS, Windows (with
WSL) and with your NVIDIA card if you've got it, for CUDA support.

What's more, it addresses the ***inflexibility*** and often ***out-of-date pip
packages*** of a traditional Python nix flake by creating a Python virtual
environment and installing all the PyPI requirements with pip.

All the cool kids are using `uv` today instead of pip, and if you want that
version, you can check the article: [Replacing `pip` In Python Nix Flake With
`uv`](/python-nix-flake-uv/). And more yabbering on why all this works so well
can be found at the article: [Nix Flake Python Solution: Venv, Cuda,
macOS/Windows, Etc.](/nix-flake-python/).

Enjoy!

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

## Introduction

From tinkering with **Levinux** to embracing **NixOS**, I've been on a quest for the holy grail of **reproducible, timeless computing environments**. Now, with **Nix Flakes**, I'm taking another leap into the future of system configuration. Join me as I unravel the complexities, face my initial skepticism, and discover how Flakes might just be the missing piece in our perpetual tech puzzle. Spoiler alert: **It's not as flaky as I first thought!**

---

## Getting Started with Nix Flakes

I discovered **NixOS** some months ago and recognized a kindred spirit. Some 15 years ago, I started a project called **Levinux** that tried to make a completely portable minimal Linux system for cutting through the ages that would play host to such roles as my main development system and home of a private journal. I wanted to make my daily work routine timeless so I could get better and better at a smaller set of muscle memory skills over time. **Muscle memory**, I deduced, was the path to forever improving craft in tech.

---

## The Quest for a Timeless Development Environment

But I based **Levinux** on ye old emulator, **QEMU**, and it lacked performance and viability as a main day-to-day platform. It was like a lowest common denominator virtual machine that used an extremely tiny Linux (**Tiny Core Linux**) based on the premise that all other "host" systems (Macs, Windows, and other Linuxes) could always easily run it. The flaw in this was that, though it was like a neat magic trick, the **performance was terrible**, and it was **not suitable as a daily platform** for work. Whatever I chose had to hold its own against anything else out there.

---

## The Disappointment of Virtual Machines and Containers

Of course, one's mind goes to more powerful virtual machines like **VirtualBox** or containers like **Docker** or **LXC/LXD**. But over the years, both virtual machines and containers have disappointed me. You've now got these big virtual images that can get lost, trashed up, or just weigh you down with all the extra steps and tooling. There was always a "host" machine that was something else. While **Levinux** was a VM technology too, it built entire systems from scratch with recipe files. And I learned **Nix** was a language to do this, and **NixOS** was an OS built from it, and the benefit could be realized on Macs and Windows too in folders where you could do similar builds.

---

## The Promise of Nix: A Deterministic System Definition

So I realized a language exists for you to **deterministically define a whole system with a text file**! Or you could determine **"flakes"** of a system and instantiate them under Macs and Windows. It'd be like a bash file that does a whole bunch of sequential `apt` installs without version issues because everything's **pinned**. In such a scenario, you can just **rebuild a system anytime, anywhere, and on almost anything**. Hardware changes. Platforms change. But a **phantom system** can cut through it all in time and space by **nixing all those versioning issues** for Unix-like development.

---

## Embracing the Nix Ecosystem

What a brilliant name for a brilliant system. I would have preferred if **Nix** were just Python, but as it is, it's a new language similar to Haskell specifically for configuring systems in a way that fixes the **"not on my machine" problem**. It not being Python, it's going to take some work for me. **I'm a confirmed monoglot**. I speak English-only, in terms of spoken languages, and I speak Python only when I can help it, in machine terms. Much doesn't fit my head. Python does, just barely. **Taking on learning this system configuration language is a challenge for me, but one that is worth it**.

---

## Understanding Nix: Language, OS, and Package Manager

**Nix is three things**: a language, an operating system, and a package manager.

When Nix builds your whole OS, it's called **NixOS**, and is basically a Linux distro, though there is some debate around whether it qualifies as a Linux distro, being so radically different from mainstream versions like **Red Hat** or **Debian**. The system is built from the software in the Nix package management system using the Nix language. There's a **triangle diagram** out there that tries to explain it. It's all so well thought out and has been around long enough to now be battle-hardened and time-tested. It's a safe bet and like **Levinux perfected**.

### Visualizing Nix Components

<div class="mermaid">
graph TD
    A["Nix"] --> B["Nix Language"]
    A --> C["Nix Package Manager"]
    A --> D["NixOS"]
    D --> E["Linux Distro"]
</div>

---

## The Power of a Single Configuration File

A single file defines your system, which you can rebuild from frequently. So, for example, there are no `apt` installs or permanent `pip` installs. Instead, those directives go into `configuration.nix` if you want the changes to persist, and you **rebuild your entire system**—which takes much less time than you might think and can be done without restarting your system or even interrupting your workflow much.

And of course, you can **temporarily install things** and try them out before committing them to your system. So you know that feeling of gradually **polluting your system** over time from trying this or that, scattering libraries and files all over your system causing lurking problems? It just doesn't happen on **NixOS**. Everything is **deliberate, deterministic, and self-cleaning** because the whole system gets rebuilt as if from scratch all the time.

---

## The Challenge of Version Control for System Configuration

And that brings us to the purpose of this article. A large part of the appeal of **NixOS** is that the entire system gets defined and built from a single file `/etc/nixos/configuration.nix`. It's super-easy to jump on the NixOS bandwagon this way, immediately tweaking out this file for your preferred environment.

But also being a text file as it is, one of the first things you want to do is put it in a **git repo** and perhaps push it up to **GitHub** so your system can become a living, growing document that's with you for the rest of your life, potentially. Not only does **Nix** fix the "not on my machine" problem, but it makes your metaphorical machine into a **summonable phantom** that travels with you through life, instantiatable on any hardware like a spell of possession. And to manage this magic, you generally want **git**. `/etc/nixos/` should be in a git repo, right?

---

## The Root User Dilemma and the Introduction of Nix Flakes

This is where **NixOS** hits its first weakness in that `/etc/nixos/` is a **protected location** belonging to the **root user**—and not the system user. This is logical and doesn't seem bad at first because you can easily enough `sudo` to edit the files, but making the whole directory into a git/GitHub repo is challenging.

You immediately need special scripts to adjust file permissions and ownership in a parallel directory that you can edit so all your git tooling and configuration is used. But if you're going to do that, why not just **symlink** to the new directory? **Enter Nix Flakes**.

While there are other benefits to flakes, it is this out-of-the-starting-gate gotcha that got me. And I was so hesitant because the initial beauty of **Nix** is in its simplicity. **Nix-it-all**! No more magical mixtures of `apt-get`s, `pip` installs, environment variables. Less surface area. Lower cognitive overhead. Set it all once in one place and always know where to look.

---

## Overcoming Resistance to Nix Flakes

So I **resisted Nix Flakes for months**. Things are complicated enough not only switching off of Windows and Mac and onto Linux, but it's switching onto a version of Linux where everything is different than a normal Linux. Normal Linux like **Red Hat**, **Debian**, or **Arch** use something called the **Filesystem Hierarchy Standard (FHS)** and all files are put in location.

On **NixOS**, while the FHS is still there, all the files are **symlinked** into location. You'll hear the term **immutable version of Linux**. Like **Tiny Core Linux** that **Levinux** was based on, things just can't get messed up because there's a reliable system reset that **nukes the place from orbit**. It's the only way to be sure.

Given all the radical new thinking required for a full OS-switch (which is actually not required for just using the `nix` command on Mac or Windows), I avoided the extra complication of a still optional and experimental feature of **Nix** called **Flakes**. In my mind, **nix nixed the complication** by gathering everything into one `/etc/nixos/configuration.nix` file, and **flakes flaked out the simplicity**. It was all named with such unintentional irony. **Nix nixed** the complications on Unix/Linux-like (*nix) systems, and **Flakes**, in my opinion, just made such a simple system flaky again. Why have to look in multiple places at multiple files when you could only look at one? But the truth is, it **simplified getting `configuration.nix` into git**.

---

## The Revelation: Flakes Simplify Git Management

So, I'm coming around. **Flakes don't have to complicate things**. Initially, the touted benefit of Flakes seemed only to be exact-version pinning when you distributed sub-chunks (flakes) of a system to other people on different systems so they could deterministically reproduce it. Now that's awesome, but it didn't justify complicating the simplicity and elegance of `configuration.nix`.

But what I discover is that **flakes simply let you move `configuration.nix` out of system space and into user space** so you don't need any custom scripts or tooling to get it manageable under git. This was an **awakening**, and **I'm switching over to Flakes now**.

---

## Implementing Nix Flakes: A Step-by-Step Guide

Here's what I did in order to do it just once. You'll notice that turning it into a **git repo** is a part of the process. The **Nix Flake** feature and using git repos seem very intertwined. If you use git all the time for its miscellaneous backup and deployment capabilities, the utility of flakes will be obvious.

Imagine a git repo carrying around everything it needs from the parent OS to get it working. Forget `virtualenv`, `requirements.txt`, `pip`, `poetry`, and the mishmash of commands and acrobatics you need to do to get things working. Just `cd` into the repo and type `nix develop` and you're in business.

### Steps to Implement Nix Flakes

Let's get to it. You **enabled flakes** with that one line in your `configuration.nix` and **rebuilt your system**. Flakes are enabled but nothing seems to have changed. Open a Terminal and here's what you do to get `/etc/nixos/` out of system space and into user space, allowing it to be managed under git:

1. **Create a new directory for your NixOS configuration:**

    ```bash
    mkdir ~/nixos-config
    sudo cp /etc/nixos/* ~/nixos-config/
    sudo chown -R $USER:users ~/nixos-config
    cd ~/nixos-config
    ```

    This makes a copy of your `/etc/nixos/` location.

{:start="2"}
2. **Add a minimal `flake.nix` file:**

    I don't know if this is technically even necessary for this use case as the symlink might be enough for `sudo nixos-rebuild switch`, but let's put it there anyway because it's how flakes in general work.

    ```nix
    # flake.nix
    {
      inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
      };

      outputs = { self, nixpkgs }: {
        nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [ ./configuration.nix ];
        };
      };
    }
    ```

{:start="3"}
3. **Initialize a git repository:**

    ```bash
    git init
    git add .
    git commit -m "Initial commit"
    ```

{:start="4"}
4. **Check that everything's in place:**

    ```bash
    nix flake check
    ```

    Resolve any errors. If everything checks out, proceed to the next step.

{:start="5"}
5. **Backup and symlink the new configuration:**

    ```bash
    sudo mv /etc/nixos /etc/nixos.bak  # Backup old config
    sudo ln -s /home/username/nixos-config /etc/nixos  # Symlink new config (replace 'username' with your actual username)
    ```

{:start="6"}
6. **Rebuild your system:**

    The new command that will build your system if you hadn't symlinked is:

    ```bash
    sudo nixos-rebuild switch --flake /home/username/nixos-config#nixos
    ```

    But because of the symlink, you can continue to use:

    ```bash
    sudo nixos-rebuild switch
    ```

---

## Conclusion: Embracing Nix Flakes with Confidence

And so, I have turned on the **Nix Flakes** optional feature, switched my `configuration.nix` over to be more easily managed with **git**, and my workflow has **not changed at all**.

The additional cognitive overhead and constant additional friction to process that I had feared with **Nix Flakes** hasn't yet materialized. So I can now cautiously approach the new Flake features, which I actually do need for sharing work with my coworkers, without being overwhelmed by exploding complexity.

---

## Visual Summary of the Journey

<div class="mermaid">
graph TD
    A["Levinux Project"] -->|"Quest for timeless computing"| B["NixOS Discovery"]
    B --> C{"Initial NixOS Setup"}
    C -->|"Simple but limited"| D["Single configuration.nix"]
    C -->|"Desire for version control"| E["Git Management Challenges"]
    E --> F{"Nix Flakes"}
    F -->|"Initial skepticism"| G["Perceived Complexity"]
    F -->|"Realization"| H["Simplified Git Management"]
    H --> I["Move Config to User Space"]
    I --> J["Enable Flakes Feature"]
    J --> K["Create flake.nix"]
    K --> L["Symlink to /etc/nixos"]
    L --> M["Improved Workflow"]
    M --> N["Version-Controlled Config"]
    N --> O["Easier Sharing and Reproducibility"]
    
    style A fill:#f9f,stroke:#333,stroke-width:2px
    style B fill:#bbf,stroke:#333,stroke-width:2px
    style F fill:#bfb,stroke:#333,stroke-width:2px
    style M fill:#fbb,stroke:#333,stroke-width:2px
</div>

