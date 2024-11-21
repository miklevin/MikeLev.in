---
title: Cross-Platform Nix Flake for Jupyter & FastHTML  
permalink: /nix-fasthtml-flake/  
description: I describe the process of creating a cross-platform Nix flake for a development environment that includes JupyterLab, CUDA support, Ollama for local LLMs, and a FastHTML server. I started with a minimal setup and progressively added features to overcome challenges, including integrating a virtual environment for installing packages not available in the Nix repository. This approach ensures flexibility and adaptability for future data science and development needs.
layout: post
---

## Building a Versatile flake.nix Configuration for Seamless Development

Creating a seamless development environment that operates effortlessly across macOS, Linux, and even Windows with WSL can be challenging. Incorporating CUDA acceleration and specialized tools like JupyterLab and FastHTML adds further complexity. To tackle these challenges, I embarked on a journey to build a versatile `flake.nix` configuration. Starting with a minimal setup, I progressively added features to overcome each obstacle. A pivotal aspect of this approach was integrating a virtual environment, which not only allowed for the installation of packages not available in the Nix repository but also provided the flexibility needed for future data science endeavors. Below is a step-by-step account of how I developed the `flake.nix` to create a robust and adaptable setup.

### Version 1: Minimal Python Environment

I began with the most basic setup to ensure that Nix was correctly configured and functioning on both Linux and macOS systems. This minimal `flake.nix` includes only the Python interpreter, establishing a solid foundation for further enhancements.

```nix
# flake.nix - Version 1: Minimal Python Environment
{
  description = "Minimal Python 3.11 Development Environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
  };

  outputs = { self, nixpkgs }:
    let
      systems = [ "x86_64-linux" "aarch64-darwin" ];
      forAllSystems = f: builtins.listToAttrs (map (system: { name = system; value = f system; }) systems);
    in
    {
      devShells = forAllSystems (system: {
        default = let
          pkgs = import nixpkgs { inherit system; };
          # Python 3.11 without additional packages
          python = pkgs.python311;
        in pkgs.mkShell {
          buildInputs = [
            python
          ];

          shellHook = ''
            echo "Welcome to the Python 3.11 development environment on ${system}!"
            echo "Python version: $(python --version)"
            echo "Type 'python' to start the Python interpreter."
          '';
        };
      });
    };
}
```

*This setup ensures that Python is available, serving as the foundation for further enhancements.*

### Version 2: Adding JupyterLab and Data Science Packages

With the basic environment in place, the next step was to incorporate essential data science tools, including JupyterLab, to facilitate interactive notebooks and data analysis.

```nix
# flake.nix - Version 2: Add JupyterLab and Data Science Packages
{
  description = "Data Science Development Environment with JupyterLab";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
  };

  outputs = { self, nixpkgs }:
    let
      systems = [ "x86_64-linux" "aarch64-darwin" ];
      forAllSystems = f: builtins.listToAttrs (map (system: { name = system; value = f system; }) systems);
    in
    {
      devShells = forAllSystems (system: {
        default = let
          pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
          # Define Python package set
          ps = pkgs.python311Packages;
          # Python packages for data science
          pythonPackages = pkgs.python311.withPackages (ps: [
            ps.jupyterlab
            ps.pandas
            ps.numpy
            ps.matplotlib
            ps.scikit-learn
            ps.seaborn
            (if system == "aarch64-darwin" then ps.pytorch-bin else ps.pytorch)
          ]);
          # Common development tools
          devTools = with pkgs; [
            git
          ];
        in pkgs.mkShell {
          buildInputs = devTools ++ [ pythonPackages ] ++ [
            pkgs.stdenv.cc.cc.lib
          ];

          shellHook = ''
            export NIXPKGS_ALLOW_UNFREE=1
            export LD_LIBRARY_PATH=${pkgs.stdenv.cc.cc.lib}/lib:$LD_LIBRARY_PATH
            echo "Welcome to the Data Science development environment on ${system}!"
            echo "Development environment is ready!"
            echo "To start JupyterLab, run: jupyter lab"
          '';
        };
      });
    };
}
```

*With JupyterLab and popular data science libraries like pandas and numpy, the environment became more powerful for data analysis tasks.*

### Version 3: Introducing CUDA Support

To harness the power of GPU acceleration on Linux systems, I added conditional support for CUDA. This enhancement allows the environment to utilize CUDA when available, significantly boosting performance for compatible applications.

```nix
# flake.nix - Version 3: Add CUDA Support
{
  description = "Data Science Development Environment with JupyterLab";

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
          # CUDA-specific packages (only on Linux)
          cudaPackages = lib.optionals (cudaSupport && system == "x86_64-linux") (with pkgs; [
            pkgs.cudatoolkit
            pkgs.cudnn
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
          # Python packages for data science
          pythonPackages = pkgs.python311.withPackages (ps: [
            ps.jupyterlab
            ps.pandas
            ps.numpy
            ps.matplotlib
            ps.scikit-learn
            ps.seaborn
            pytorchPackage
          ]);
          # Common development tools
          devTools = with pkgs; [
            git
          ];
        in pkgs.mkShell {
          buildInputs = devTools ++ [ pythonPackages ] ++ cudaPackages ++ [
            pkgs.stdenv.cc.cc.lib
          ];

          shellHook = ''
            export NIXPKGS_ALLOW_UNFREE=1
            export LD_LIBRARY_PATH=${pkgs.stdenv.cc.cc.lib}/lib:$LD_LIBRARY_PATH
            echo "Welcome to the Data Science development environment on ${system}!"
            ${if cudaSupport then "echo 'CUDA support enabled.'" else ""}
            
            echo "Development environment is ready!"
            echo "To start JupyterLab, run: jupyter lab"
          '';
        };
      });
    };
}
```

*By conditionally including CUDA packages, the environment remains lightweight on systems without GPU support while providing enhanced capabilities where possible.*

### Version 4: Incorporating FastHTML/HTMX Server and Virtual Environment

The next critical step was integrating the FastHTML/HTMX server. Since `python-fasthtml` isn't available in the Nix repository, I utilized `pip` for installation by introducing a virtual environment. This approach not only addressed the immediate requirement but also allowed data scientists to install additional packages as needed without modifying the core Nix configuration.

```nix
# flake.nix - Version 4: Add FastHTML/HTMX support
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
            # Add other development tools if needed
          ];
        in pkgs.mkShell {
          buildInputs = devTools ++ [ pythonPackages ] ++ cudaPackages ++ [
            pkgs.stdenv.cc.cc.lib  # Include libstdc++
          ];

          shellHook = ''
            export NIXPKGS_ALLOW_UNFREE=1
            export LD_LIBRARY_PATH=${pkgs.stdenv.cc.cc.lib}/lib:$LD_LIBRARY_PATH
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
            echo "To start JupyterLab, run: jupyter lab"
            echo "To start the Python server, run: python server.py"
          '';
        };
      });
    };
}
```

*Implementing a virtual environment not only resolved the immediate need for `python-fasthtml` but also provided the flexibility to install additional Python packages as required.*

### Final `flake.nix`: Comprehensive Development Environment

To maximize productivity, I configured the environment to automatically start JupyterLab and the FastHTML server upon entering the development shell. This automation ensures that all necessary services are up and running without manual intervention. The final `flake.nix` combines all previous enhancements, delivering a comprehensive development environment that is flexible, powerful, and easy to use across different systems.

```nix
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
            # Add other development tools if needed
          ];
        in pkgs.mkShell {
          buildInputs = devTools ++ [ pythonPackages ] ++ cudaPackages ++ [
            pkgs.stdenv.cc.cc.lib  # Include libstdc++
          ];

          shellHook = ''
            export NIXPKGS_ALLOW_UNFREE=1
            export LD_LIBRARY_PATH=${pkgs.stdenv.cc.cc.lib}/lib:$LD_LIBRARY_PATH
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

### Why the Virtual Environment Matters

Integrating a virtual environment within the `flake.nix` setup was a game-changer. It addressed the necessity of installing `python-fasthtml`—a package not available in the Nix repository—by leveraging `pip`. Beyond solving this immediate challenge, the virtual environment empowers data scientists and developers to freely install any additional Python packages after running `nix develop`, without altering the core Nix configuration. This flexibility ensures that the environment can adapt to evolving project requirements, making it a versatile tool for various development and data science tasks.

### Summary of Enhancements

1. **Minimal Setup:** Established a basic Python environment to verify Nix functionality.
2. **Data Science Tools:** Integrated JupyterLab and essential libraries like pandas and numpy.
3. **CUDA Support:** Added conditional CUDA packages to leverage GPU acceleration on Linux.
4. **Virtual Environment:** Implemented a virtual environment to pip install `python-fasthtml` and provide flexibility for additional packages.
5. **Automated Services:** Configured automatic startup for JupyterLab and the FastHTML server, ensuring a seamless development experience.

By methodically expanding the `flake.nix`, I transformed a simple setup into a powerful, ready-to-use environment that elegantly handles dependencies and offers unparalleled flexibility for diverse development needs. This approach not only resolved immediate challenges but also laid a solid foundation for future scalability and adaptability.
