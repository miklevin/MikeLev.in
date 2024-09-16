---
title: Nix FastHTML and Jupyter Flake
permalink: /nix-fasthtml-flake/
description: We incrementally built a flake.nix for a cross-platform development environment that supports JupyterLab, CUDA, local LLM via Ollama, and a FastHTML/HTMX server, with automatic startup and pip installation for unsupported packages.
layout: post
---

I started with a bare-bones flake.nix, determined to create a flexible development environment that works seamlessly across macOS and Linux. Step by step, I added the essentials: Python, JupyterLab, data science tools, and even CUDA support for GPU acceleration. The challenge of installing python-fasthtml, which wasn’t in the Nix repo, was no match for a quick pip install in the shell setup. With each iteration, I refined the setup, ensuring it auto-started JupyterLab and the FastHTML server, handling everything smoothly. Now, I have a powerful, ready-to-go environment that adapts to any machine, overcoming all hurdles with elegance.

### Version 1: Minimal Flake with Basic Python Environment

Start with a minimal `flake.nix` to set up a basic Python development environment.

```nix
# flake.nix - Version 1: Minimal Python Environment
{
  description = "Minimal Python Development Environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05"; # Adjust this based on your NixOS channel version
  };

  outputs = { self, nixpkgs }: {
    devShells = {
      # Define a development shell for both Linux and macOS
      default = { pkgs }: pkgs.mkShell {
        buildInputs = with pkgs; [
          python311  # Include Python 3.11
        ];
      };
    };
  };
}
```

This basic setup includes only the Python interpreter and is a good starting point to ensure your Nix environment is working.

### Version 2: Adding JupyterLab and Basic Data Science Packages

Now, extend the environment by adding JupyterLab and common data science packages.

```nix
# flake.nix - Version 2: Add JupyterLab and Data Science Packages
{
  description = "Python Development Environment with JupyterLab";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
  };

  outputs = { self, nixpkgs }: {
    devShells = {
      default = { pkgs }: pkgs.mkShell {
        buildInputs = with pkgs.python311Packages; [
          jupyterlab
          pandas
          numpy
          matplotlib
          scipy
        ];
      };
    };
  };
}
```

This version introduces JupyterLab and basic data science packages like `pandas`, `numpy`, and `matplotlib`.

### Version 3: Adding Support for CUDA (if available)

Add conditional support for CUDA packages to leverage GPU acceleration if needed.

```nix
# flake.nix - Version 3: Add CUDA Support
{
  description = "Python Environment with JupyterLab and Optional CUDA";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
  };

  outputs = { self, nixpkgs }:
    let
      systems = [ "x86_64-linux" "aarch64-darwin" ];
      forAllSystems = f: builtins.listToAttrs (map (system: { name = system; value = f system; }) systems);
      localConfig = if builtins.pathExists ./local.nix then import ./local.nix else {};
      cudaSupport = if localConfig ? cudaSupport then localConfig.cudaSupport else false;
    in {
      devShells = forAllSystems (system: {
        default = let
          pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
          cudaPackages = if cudaSupport && system == "x86_64-linux" then with pkgs; [
            cudatoolkit
            cudnn
          ] else [];
        in pkgs.mkShell {
          buildInputs = with pkgs.python311Packages; [
            jupyterlab
            pandas
            numpy
            matplotlib
            scipy
          ] ++ cudaPackages;
        };
      });
    };
}
```

In this version, CUDA support is conditionally added for Linux systems. You can set `cudaSupport` in a `local.nix` file if needed.

### Version 4: Adding FastHTML/HTMX Server Setup

Now, extend the environment to include the FastHTML/HTMX server and ensure the ability to install `python-fasthtml` using `pip`.

```nix
# flake.nix - Version 4: Add FastHTML/HTMX Server Support
{
  description = "Environment with JupyterLab, CUDA, and FastHTML/HTMX Server";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
  };

  outputs = { self, nixpkgs }:
    let
      systems = [ "x86_64-linux" "aarch64-darwin" ];
      forAllSystems = f: builtins.listToAttrs (map (system: { name = system; value = f system; }) systems);
      localConfig = if builtins.pathExists ./local.nix then import ./local.nix else {};
      cudaSupport = if localConfig ? cudaSupport then localConfig.cudaSupport else false;
    in {
      devShells = forAllSystems (system: {
        default = let
          pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
          cudaPackages = if cudaSupport && system == "x86_64-linux" then with pkgs; [
            cudatoolkit
            cudnn
          ] else [];
        in pkgs.mkShell {
          buildInputs = with pkgs.python311Packages; [
            jupyterlab
            pandas
            numpy
            matplotlib
            scipy
            fastapi
            pip  # Include pip to install python-fasthtml
          ] ++ cudaPackages;

          shellHook = ''
            echo "Setting up development environment..."
            # Install python-fasthtml using pip
            pip install python-fasthtml
          '';
        };
      });
    };
}
```

In this version, `pip` is used to install `python-fasthtml`, which is not available in the Nix repositories. A `shellHook` is added to run commands automatically upon entering the shell.

### Version 5: Starting JupyterLab and FastHTML Server Automatically

Finally, add a setup to automatically start JupyterLab and the FastHTML server.

```nix
# flake.nix - Version 5: Auto-Start JupyterLab and FastHTML Server
{
  description = "Full Development Environment with JupyterLab, CUDA, and FastHTML Server";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
  };

  outputs = { self, nixpkgs }:
    let
      systems = [ "x86_64-linux" "aarch64-darwin" ];
      forAllSystems = f: builtins.listToAttrs (map (system: { name = system; value = f system; }) systems);
      localConfig = if builtins.pathExists ./local.nix then import ./local.nix else {};
      cudaSupport = if localConfig ? cudaSupport then localConfig.cudaSupport else false;
    in {
      devShells = forAllSystems (system: {
        default = let
          pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
          cudaPackages = if cudaSupport && system == "x86_64-linux" then with pkgs; [
            cudatoolkit
            cudnn
          ] else [];
        in pkgs.mkShell {
          buildInputs = with pkgs.python311Packages; [
            jupyterlab
            pandas
            numpy
            matplotlib
            scipy
            fastapi
            pip  # Include pip to install python-fasthtml
          ] ++ cudaPackages;

          shellHook = ''
            echo "Setting up development environment..."
            pip install python-fasthtml

            echo "Starting Jupyter Lab and Python server..."

            # Start Jupyter Lab in the background
            jupyter lab &
            JUPYTER_PID=$!

            # Start Python server in the background
            python -m fastapi &
            SERVER_PID=$!

            cleanup() {
              kill $JUPYTER_PID
              kill $SERVER_PID
            }
            trap cleanup EXIT
          '';
        };
      });
    };
}
```

This final version completes the setup by automatically starting JupyterLab and the FastHTML server in the background and handling cleanup on exit.

### Summary of Changes:
1. **Version 1:** Minimal Python environment.
2. **Version 2:** Add JupyterLab and data science packages.
3. **Version 3:** Add conditional CUDA support.
4. **Version 4:** Introduce FastHTML/HTMX server setup and `pip` installation.
5. **Version 5:** Auto-start JupyterLab and the FastHTML server.

This incremental approach ensures that each step is clear, manageable, and builds upon the previous configuration, eventually reaching your intended result.
