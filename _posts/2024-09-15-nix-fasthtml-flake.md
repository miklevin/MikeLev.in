---
title: Nix FastHTML and Jupyter Flake
permalink: /nix-fasthtml-flake/
description: We incrementally built a flake.nix for a cross-platform development environment that supports JupyterLab, CUDA, local LLM via Ollama, and a FastHTML/HTMX server, with automatic startup and pip installation for unsupported packages.
layout: post
---

---
title: Overcoming Development Environment Challenges with Nix: Building a Versatile `flake.nix`
permalink: /nix-pipulate-flake/
description: Learn how I methodically crafted a cross-platform Nix flake that integrates JupyterLab, CUDA support, Ollama for local LLMs, and a FastHTML server, leveraging virtual environments for maximum flexibility.
layout: post
---

Creating a seamless development environment that works effortlessly across both macOS and Linux, supports CUDA acceleration, and accommodates specialized tools like JupyterLab and FastHTML can be challenging. I embarked on this journey by starting with a minimal `flake.nix` and progressively adding features to overcome each obstacle. The key was integrating a virtual environment, which not only allowed me to pip install packages not available in the Nix repository but also provided flexibility for future data science needs. Here's how I built up the `flake.nix` step by step to achieve a robust and adaptable setup.

### Version 1: Minimal Python Environment

I began with the most basic setup to ensure that Nix was correctly configured. This minimal `flake.nix` includes only the Python interpreter.

```nix
# flake.nix - Version 1: Minimal Python Environment
{
  description = "Minimal Python Development Environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05"; # Adjust based on your NixOS channel version
  };

  outputs = { self, nixpkgs }: {
    devShells = {
      default = { pkgs }: pkgs.mkShell {
        buildInputs = with pkgs; [
          python311  # Include Python 3.11
        ];
      };
    };
  };
}
```

*This setup ensures that Python is available, serving as the foundation for further enhancements.*

### Version 2: Adding JupyterLab and Data Science Packages

Next, I incorporated essential data science tools, including JupyterLab, to facilitate interactive notebooks.

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

*With JupyterLab and popular data science libraries like pandas and numpy, the environment became more powerful for data analysis tasks.*

### Version 3: Introducing CUDA Support

To leverage GPU acceleration on Linux systems, I added conditional support for CUDA. This allows the environment to utilize CUDA when available, enhancing performance for compatible applications.

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

*By conditionally including CUDA packages, the environment remains lightweight on systems without GPU support while providing enhanced capabilities where possible.*

### Version 4: Incorporating FastHTML/HTMX Server and Virtual Environment

The crucial step was integrating the FastHTML/HTMX server, which required pip installation since `python-fasthtml` isn't available in the Nix repository. To manage this, I introduced a virtual environment. This not only resolved the immediate need but also offered flexibility for data scientists to install additional packages as needed.

```nix
# flake.nix - Version 4: Add FastHTML/HTMX Server Support with Virtual Environment
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
          lib = pkgs.lib;
          cudaPackages = lib.optionals (cudaSupport && system == "x86_64-linux") (with pkgs; [
            cudatoolkit
            cudnn
            (pkgs.ollama.override { acceleration = "cuda"; })
          ]);
          ps = pkgs.python311Packages;
          pytorchPackage = if cudaSupport && system == "x86_64-linux" then
            ps.pytorch.override { cudaSupport = true; }
          else if system == "aarch64-darwin" then
            ps.pytorch-bin
          else
            ps.pytorch;
          pythonPackages = pkgs.python311.withPackages (ps: [
            ps.jupyterlab
            ps.pandas
            ps.requests
            ps.sqlitedict
            ps.numpy
            ps.matplotlib
            ps.nbdev
            ps.fastapi   # For web applications
            ps.simplenote
            pytorchPackage
            ps.pip  # Include pip for installing python-fasthtml
          ]);
          devTools = with pkgs; [
            git
            neovim
            # Add other development tools if needed
          ];
        in pkgs.mkShell {
          buildInputs = devTools ++ [ pythonPackages ] ++ cudaPackages;

          shellHook = ''
            export NIXPKGS_ALLOW_UNFREE=1
            echo "Welcome to the Pipulate development environment on ${system}!"
            ${if cudaSupport then "echo 'CUDA support enabled.'" else ""}
            
            # Create a virtual environment if it doesn't exist
            if [ ! -d .venv ]; then
              ${pythonPackages.python.interpreter} -m venv .venv
            fi
            
            # Activate the virtual environment
            source .venv/bin/activate
            
            # Install python-fasthtml if not already installed
            if ! python -c "import fasthtml" 2>/dev/null; then
              echo "Installing python-fasthtml..."
              pip install python-fasthtml > /dev/null 2>&1
              if [ $? -eq 0 ]; then
                echo "python-fasthtml installed successfully."
              else
                echo "Failed to install python-fasthtml. Please check your internet connection and try again."
              fi
            else
              echo "python-fasthtml is already installed."
            fi
            
            echo "Development environment is ready!"
          '';
        };
      });
    };
}
```

*The introduction of a virtual environment is pivotal. It allows for the installation of `python-fasthtml` via pip and provides a sandbox for data scientists to add any additional Python packages without altering the Nix configuration.*

### Version 5: Automating JupyterLab and FastHTML Server Startup

To enhance productivity, I configured the environment to automatically start JupyterLab and the FastHTML server upon entering the development shell. This ensures that all necessary services are up and running without manual intervention.

```nix
# flake.nix - Version 5: Auto-Start JupyterLab and FastHTML Server
{
  description = "Pipulate Development Environment with python-fasthtml";

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
          lib = pkgs.lib;
          cudaPackages = lib.optionals (cudaSupport && system == "x86_64-linux") (with pkgs; [
            cudatoolkit
            cudnn
            (pkgs.ollama.override { acceleration = "cuda"; })
          ]);
          ps = pkgs.python311Packages;
          pytorchPackage = if cudaSupport && system == "x86_64-linux" then
            ps.pytorch.override { cudaSupport = true; }
          else if system == "aarch64-darwin" then
            ps.pytorch-bin
          else
            ps.pytorch;
          pythonPackages = pkgs.python311.withPackages (ps: [
            ps.jupyterlab
            ps.pandas
            ps.requests
            ps.sqlitedict
            ps.numpy
            ps.matplotlib
            ps.nbdev
            ps.fastapi   # For web applications
            ps.simplenote
            pytorchPackage
            ps.pip  # Include pip for installing python-fasthtml
          ]);
          devTools = with pkgs; [
            git
            neovim
            # Add other development tools if needed
          ];
        in pkgs.mkShell {
          buildInputs = devTools ++ [ pythonPackages ] ++ cudaPackages;

          shellHook = ''
            export NIXPKGS_ALLOW_UNFREE=1
            echo "Welcome to the Pipulate development environment on ${system}!"
            ${if cudaSupport then "echo 'CUDA support enabled.'" else ""}
            
            # Create a virtual environment if it doesn't exist
            if [ ! -d .venv ]; then
              ${pythonPackages.python.interpreter} -m venv .venv
            fi
            
            # Activate the virtual environment
            source .venv/bin/activate
            
            # Install python-fasthtml if not already installed
            if ! python -c "import fasthtml" 2>/dev/null; then
              echo "Installing python-fasthtml..."
              pip install python-fasthtml > /dev/null 2>&1
              if [ $? -eq 0 ]; then
                echo "python-fasthtml installed successfully."
              else
                echo "Failed to install python-fasthtml. Please check your internet connection and try again."
              fi
            else
              echo "python-fasthtml is already installed."
            fi
            
            echo "Development environment is ready!"

            # === Start Jupyter Lab and Python Server ===

            # Start Jupyter Lab in the background
            echo "Starting Jupyter Lab..."
            jupyter lab &
            JUPYTER_PID=$!

            # Start Python server in the background
            echo "Starting Python server..."
            python server.py &
            SERVER_PID=$!

            # Function to handle cleanup on exit
            cleanup() {
              echo "Stopping Jupyter Lab..."
              kill $JUPYTER_PID

              echo "Stopping Python server..."
              kill $SERVER_PID
            }

            # Trap the EXIT signal to trigger cleanup
            trap cleanup EXIT
          '';
        };
      });
    };
}
```

*Automatically starting JupyterLab and the FastHTML server streamlines the workflow, allowing developers to focus on their tasks without worrying about manually launching services.*

### Final `flake.nix`: Comprehensive Development Environment

Combining all the enhancements, the final `flake.nix` provides a comprehensive development environment that is flexible, powerful, and easy to use across different systems.

```nix
# pipulate/flake.nix
{
  description = "Pipulate Development Environment with python-fasthtml";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
  };

  outputs = { self, nixpkgs }:
    let
      systems = [ "x86_64-linux" "aarch64-darwin" ];
      forAllSystems = f: builtins.listToAttrs (map (system: { name = system; value = f system; }) systems);
      # Import local configuration if present
      localConfig = if builtins.pathExists ./local.nix then import ./local.nix else {};
      # Use the ? operator to check for cudaSupport
      cudaSupport = if localConfig ? cudaSupport then localConfig.cudaSupport else false;
    in
    {
      devShells = forAllSystems (system: {
        default = let
          pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
          lib = pkgs.lib;
          # CUDA-specific packages (only on your system)
          cudaPackages = lib.optionals (cudaSupport && system == "x86_64-linux") (with pkgs; [
            pkgs.cudatoolkit
            pkgs.cudnn
            (pkgs.ollama.override { acceleration = "cuda"; })
          ]);
          # Define Python package set
          ps = pkgs.python311Packages;
          # Conditionally override PyTorch for CUDA support
          pytorchPackage = if cudaSupport && system == "x86_64-linux" then
            ps.pytorch.override { cudaSupport = true; }
          else if system == "aarch64-darwin" then
            ps.pytorch-bin
          else
            ps.pytorch;
          # Python packages including JupyterLab and others
          pythonPackages = pkgs.python311.withPackages (ps: [
            ps.jupyterlab
            ps.pandas
            ps.requests
            ps.sqlitedict
            ps.numpy
            ps.matplotlib
            ps.nbdev
            ps.fastapi   # For web applications
            ps.simplenote
            pytorchPackage
            ps.pip  # Include pip for installing python-fasthtml
          ]);
          # Common development tools
          devTools = with pkgs; [
            git
            neovim
            # Add other development tools if needed
          ];
        in pkgs.mkShell {
          buildInputs = devTools ++ [ pythonPackages ] ++ cudaPackages;

          shellHook = ''
            export NIXPKGS_ALLOW_UNFREE=1
            echo "Welcome to the Pipulate development environment on ${system}!"
            ${if cudaSupport then "echo 'CUDA support enabled.'" else ""}
            
            # Create a virtual environment if it doesn't exist
            if [ ! -d .venv ]; then
              ${pythonPackages.python.interpreter} -m venv .venv
            fi
            
            # Activate the virtual environment
            source .venv/bin/activate
            
            # Install python-fasthtml if not already installed
            if ! python -c "import fasthtml" 2>/dev/null; then
              echo "Installing python-fasthtml..."
              pip install python-fasthtml > /dev/null 2>&1
              if [ $? -eq 0 ]; then
                echo "python-fasthtml installed successfully."
              else
                echo "Failed to install python-fasthtml. Please check your internet connection and try again."
              fi
            else
              echo "python-fasthtml is already installed."
            fi
            
            echo "Development environment is ready!"

            # === Start Jupyter Lab and Python Server ===

            # Start Jupyter Lab in the background
            echo "Starting Jupyter Lab..."
            jupyter lab &
            JUPYTER_PID=$!

            # Start Python server in the background
            echo "Starting Python server..."
            python server.py &
            SERVER_PID=$!

            # Function to handle cleanup on exit
            cleanup() {
              echo "Stopping Jupyter Lab..."
              kill $JUPYTER_PID

              echo "Stopping Python server..."
              kill $SERVER_PID
            }

            # Trap the EXIT signal to trigger cleanup
            trap cleanup EXIT
          '';
        };
      });
    };
}
```

### Why the Virtual Environment Matters

Integrating a virtual environment within the `flake.nix` setup was a game-changer. It addressed the necessity of installing `python-fasthtml`—a package not available in the Nix repository—by leveraging `pip`. Beyond solving this immediate challenge, the virtual environment empowers data scientists and developers to freely install any additional Python packages after running `nix develop`, without altering the core Nix configuration. This flexibility ensures that the environment can adapt to evolving project requirements, making it a versatile tool for various development and data science tasks.

### Summary of Enhancements

1. **Minimal Setup:** Established a basic Python environment to verify Nix functionality.
2. **Data Science Tools:** Integrated JupyterLab and essential libraries like pandas and numpy.
3. **CUDA Support:** Added conditional CUDA packages to leverage GPU acceleration on Linux.
4. **Virtual Environment:** Implemented a virtual environment to pip install `python-fasthtml` and provide flexibility for additional packages.
5. **Automated Services:** Configured automatic startup for JupyterLab and the FastHTML server, ensuring a seamless development experience.

By methodically expanding the `flake.nix`, I transformed a simple setup into a powerful, ready-to-use environment that elegantly handles dependencies and offers unparalleled flexibility for diverse development needs. This approach not only resolved immediate challenges but also laid a solid foundation for future scalability and adaptability.
