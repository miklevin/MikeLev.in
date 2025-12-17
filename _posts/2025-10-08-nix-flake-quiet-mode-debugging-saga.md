---
title: 'Crafting a Quiet Mode for a Nix Flake: A Live Debugging Session'
permalink: /futureproof/nix-flake-quiet-mode-debugging-saga/
description: "This entry is a perfect snapshot of my day-to-day. I started with a\
  \ simple goal\u2014adding a 'quiet' mode to my Nix flake for running scripts\u2014\
  and ended up on a mini debugging adventure that perfectly illustrates the power\
  \ of declarative environments. It shows how even a minor refactor can expose hidden\
  \ dependencies and reinforces my belief in Infrastructure as Code. The final, successful\
  \ script run, listing over 6.6 million tokens of my own writing, was a deeply satisfying\
  \ endcap to the session."
meta_description: A developer's real-time process of refactoring a Nix flake to add
  a quiet mode, leading to an unexpected Python dependency debug and a successful
  fix.
meta_keywords: Nix, Nix Flake, quiet mode, debugging, Python, ModuleNotFoundError,
  pyyaml, Infrastructure as Code, IaC, developer workflow, AI-assisted development
layout: post
sort_order: 6
---

{% raw %}


## Setting the Stage: Context for the Curious Book Reader

This entry is a perfect, unfiltered snapshot of my daily development loop: identify a small friction point, use an AI as a collaborator to propose a code change, and then rigorously test the result. What begins as a simple request to add a 'quiet mode' to a Nix development environment quickly pivots into a classic debugging session. It's a real-world demonstration of how Infrastructure as Code (IaC) provides immense power through precision, but demands that same precision in return. The story culminates in the discovery and fixing of a single, undeclared Python dependency—a satisfyingly simple solution to a show-stopping problem, all validated by the very tools the environment was built to support.

---

## Technical Journal Entry Begins

Okay, so I have this program `list_articles.py` but it's in the Pipulate repo
and I want a version of it to "live" right in the MikeLev.in repo where I am
actually `cd`'d into editing the articles all the time. But every git repo
you're in is like carrying around your own developer environment or
*Infrastructure as Code* (IaC) with Nix. And the one I have over in Pipulate is
different from the one over here in MikeLev.in. And so...

## The Initial Goal: A 'Quiet' Environment

**Me**: I need this Nix flake `flake.nix`:

```nix
# Jekyll Environment Setup for Nix
# ==============================
# This flake provides a complete development environment for Jekyll sites with:
# - Ruby and Jekyll with all necessary dependencies
# - Rouge for syntax highlighting
# - Python environment for additional tools
# - Neovim for text editing
# - Git for version control
# - Automatic Jekyll server startup on environment entry
#
# Environment Variables
# -------------------
# The environment is configured with the following key variables:
# - GEM_HOME: Local gem installation directory (.gem)
# - GEM_PATH: Path to find gems
# - BUNDLE_FORCE_RUBY_PLATFORM: Forces native gem compilation
# - LD_LIBRARY_PATH: Paths to required system libraries
# - PKG_CONFIG_PATH: Paths for pkg-config to find build dependencies
#
# Available Commands
# ----------------
# 1. jes: Start Jekyll server with automatic environment checks
#    - Checks Ruby version compatibility
#    - Ensures all gems are installed
#    - Handles port configuration
#    - Provides verbose output and incremental builds
#    - AUTOMATICALLY CALLED when entering nix develop
#
# 2. jes-stop: Stop any running Jekyll servers
#
# 3. rebuild-gems: Clean and rebuild native gem extensions
#    - Targets problematic gems (json, ffi, nokogiri)
#    - Rebuilds with correct library paths
#
# 4. reset-ruby-env: Complete Ruby environment reset
#    - Backs up Gemfile and Gemfile.lock
#    - Removes .gem directory
#    - Reinstalls bundler and all gems
#
# Common Issues and Solutions
# -------------------------
# 1. Ruby Version Mismatch:
#    - Detected by check_ruby_version function
#    - Automatically rebuilds affected gems
#    - Specifically handles ffi_c.so version mismatches
#
# 2. Missing Gems:
#    - Detected by bundle check
#    - Automatically installs missing gems
#    - Configures bundler for local installation
#
# 3. Native Extension Issues:
#    - Use rebuild-gems to rebuild problematic extensions
#    - System libraries are properly linked via LD_LIBRARY_PATH
#    - Build options configured for common problematic gems
#
# Best Practices
# -------------
# 1. Always run nix develop from the Jekyll site root
# 2. Use .port file to configure custom ports
# 3. Keep Gemfile and Gemfile.lock in version control
# 4. Run reset-ruby-env for major environment issues
# 5. Use rebuild-gems for specific gem issues
# 6. Jekyll server starts automatically on environment entry
#
# Version History
# --------------
# v1.0.6: Added automatic Jekyll server startup on environment entry
# v1.0.5: Added bundle exec for Jekyll checks
# v1.0.4: Improved error handling and diagnostics
# v1.0.3: Fixed environment variable handling
# v1.0.2: Added version number and improved checks
# v1.0.1: Initial version with basic functionality

{
  description = "Nix flake for Jekyll environment with Rouge for syntax highlighting and Bundler support";

  inputs = {
    # Use a stable Nixpkgs version. Update this to a newer version if needed.
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # Optionally, specify the flake-utils for multi-system support
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        # Python environment with required packages
        pythonEnv = pkgs.python3.withPackages (ps: with ps; [
          requests
          tiktoken
          # Add other Python packages needed for your project here
        ]);
      in
      {
        # Define the development shell with all necessary dependencies
        devShells.default = pkgs.mkShell {
          # Include necessary packages in the PATH
          buildInputs = [
            pkgs.ruby                       # Ruby for Jekyll and Bundler
            pkgs.jekyll                     # Jekyll from Nixpkgs
            pkgs.rubyPackages_3_2.rouge     # Rouge (provides rougify)
            pkgs.neovim                     # Neovim for text editing
            pkgs.git                        # Git for version control
            pythonEnv                       # Use the Python environment defined above
            pkgs.stdenv.cc.cc.lib          # Add C++ standard library
            pkgs.pkg-config                 # Add pkg-config for build dependencies
            pkgs.openssl                    # Add openssl for native gem compilation
            pkgs.zlib                       # Add zlib for nokogiri
            pkgs.libffi                     # Add libffi for ffi gem
            pkgs.libxml2                    # Add libxml2 for nokogiri
            pkgs.libxslt                    # Add libxslt for nokogiri
          ];

          # Set environment variables and define helper functions
          shellHook = ''
            # Set up Ruby environment variables
            export GEM_HOME=$PWD/.gem
            export GEM_PATH=$GEM_HOME
            export PATH=$GEM_HOME/bin:$PATH
            
            # Force native gem compilation
            export BUNDLE_FORCE_RUBY_PLATFORM=1
            
            # Set up library paths for native extensions
            export LD_LIBRARY_PATH="${pkgs.ruby}/lib:${pkgs.stdenv.cc.cc.lib}/lib:$LD_LIBRARY_PATH"
            export LD_LIBRARY_PATH="${pkgs.libffi}/lib:$LD_LIBRARY_PATH"
            export LD_LIBRARY_PATH="${pkgs.zlib}/lib:$LD_LIBRARY_PATH"
            export LD_LIBRARY_PATH="${pkgs.libxml2}/lib:$LD_LIBRARY_PATH"
            export LD_LIBRARY_PATH="${pkgs.libxslt}/lib:$LD_LIBRARY_PATH"
            
            # Configure pkg-config paths for build dependencies
            export PKG_CONFIG_PATH="${pkgs.zlib.dev}/lib/pkgconfig:$PKG_CONFIG_PATH"
            export PKG_CONFIG_PATH="${pkgs.libffi.dev}/lib/pkgconfig:$PKG_CONFIG_PATH"
            export PKG_CONFIG_PATH="${pkgs.libxml2.dev}/lib/pkgconfig:$PKG_CONFIG_PATH"
            export PKG_CONFIG_PATH="${pkgs.libxslt.dev}/lib/pkgconfig:$PKG_CONFIG_PATH"
            
            # Install bundler if not present
            if ! gem list -i bundler > /dev/null 2>&1; then
              echo "Installing bundler..."
              gem install bundler --no-document
            fi

            # Configure bundler for local gem installation
            bundle config set --local path "$GEM_HOME"
            
            # Set build options for problematic native extensions
            bundle config build.nokogiri --use-system-libraries
            bundle config build.ffi --enable-system-libffi
            bundle config build.eventmachine --with-cflags="-I${pkgs.openssl.dev}/include"
            bundle config set force_ruby_platform true

            # Additional build configuration
            export BUNDLE_BUILD__EVENTMACHINE="--with-cflags=-I${pkgs.openssl.dev}/include"
            export PKG_CONFIG_PATH="${pkgs.openssl.dev}/lib/pkgconfig:$PKG_CONFIG_PATH"
            
            # macOS-specific Neovim configuration
            if [ "$(uname)" = "Darwin" ]; then
              echo "Detected macOS. Setting up Neovim configuration."
              CONFIG_DIR="$HOME/Library/Application Support/nvim"
              INIT_LUA_SOURCE="$HOME/repos/nixos/init.lua"
              INIT_LUA_TARGET="$CONFIG_DIR/init.lua"

              mkdir -p "$CONFIG_DIR"
              ln -sf "$INIT_LUA_SOURCE" "$INIT_LUA_TARGET"
              echo "Symlink created: $INIT_LUA_TARGET -> $INIT_LUA_SOURCE"
            else
              echo "Linux detected. Skipping Neovim setup as it's not needed."
            fi

            # Alias vim to nvim
            alias vim=nvim

            # Jekyll serve function with automatic environment checks
            jes() {
              echo "Jekyll Environment Script v1.0.6"
              
              # Store the current directory
              current_dir=$(pwd)
              
              # Find the Jekyll root (where Gemfile exists)
              site_root="$current_dir"
              while [[ "$site_root" != "/" && ! -f "$site_root/Gemfile" ]]; do
                site_root="$(dirname "$site_root")"
              done

              if [[ ! -f "$site_root/Gemfile" ]]; then
                echo "Error: Could not find Gemfile. Are you in a Jekyll site directory?"
                return 1
              fi

              # Read port from .port file or use default
              if [ -f "$site_root/.port" ]; then
                port=$(cat "$site_root/.port")
                echo "Using port $port from .port file"
              else
                port=4000
                echo "No .port file found, using default port $port"
              fi

              # Function to check for Ruby version mismatch
              check_ruby_version() {
                echo "Checking Ruby environment..."
                
                # Save current environment
                local old_gem_home="$GEM_HOME"
                local old_gem_path="$GEM_PATH"
                local old_path="$PATH"
                local old_bundle_gemfile="$BUNDLE_GEMFILE"
                local old_bundle_path="$BUNDLE_PATH"
                
                # Set environment for checks
                export GEM_HOME="$site_root/.gem"
                export GEM_PATH="$GEM_HOME"
                export PATH="$GEM_HOME/bin:$PATH"
                export BUNDLE_GEMFILE="$site_root/Gemfile"
                export BUNDLE_PATH="$GEM_HOME"
                
                # First check if jekyll binary exists
                if [ ! -f "$site_root/.gem/ruby/3.3.0/bin/jekyll" ]; then
                  echo "Jekyll binary not found. Will need to install gems."
                  return 1
                fi
                
                # Try to run jekyll with --version and capture both stdout and stderr
                local jekyll_output
                jekyll_output=$(cd "$site_root" && bundle exec jekyll --version 2>&1)
                local jekyll_status=$?
                
                if [ $jekyll_status -ne 0 ]; then
                  echo "Jekyll binary check failed with status $jekyll_status"
                  echo "Error output: $jekyll_output"
                  
                  if echo "$jekyll_output" | grep -q "incompatible library version"; then
                    echo "Detected Ruby version mismatch. Rebuilding gems..."
                    rm -rf "$site_root/.gem"
                    return 1
                  else
                    echo "Unknown Jekyll error. Rebuilding gems..."
                    rm -rf "$site_root/.gem"
                    return 1
                  fi
                fi
                
                # Check for specific Ruby version mismatch in ffi_c.so
                if [ -f "$site_root/.gem/ruby/3.3.0/gems/ffi-1.17.1/lib/ffi_c.so" ]; then
                  local ffi_libs
                  ffi_libs=$(ldd "$site_root/.gem/ruby/3.3.0/gems/ffi-1.17.1/lib/ffi_c.so" 2>&1)
                  if echo "$ffi_libs" | grep -q "libruby-3.3.7"; then
                    echo "Detected Ruby 3.3.7 vs 3.3.8 mismatch in ffi_c.so. Rebuilding ffi gem..."
                    rm -rf "$site_root/.gem/ruby/3.3.0/gems/ffi-1.17.1"
                    rm -rf "$site_root/.gem/ruby/3.3.0/specifications/ffi-1.17.1.gemspec"
                    return 1
                  fi
                fi

                # Check if bundle check passes
                local bundle_output
                bundle_output=$(cd "$site_root" && bundle check 2>&1)
                local bundle_status=$?
                
                if [ $bundle_status -ne 0 ]; then
                  echo "Bundle check failed with status $bundle_status"
                  echo "Error output: $bundle_output"
                  echo "Rebuilding gems..."
                  rm -rf "$site_root/.gem"
                  return 1
                fi

                # Restore environment
                export GEM_HOME="$old_gem_home"
                export GEM_PATH="$old_gem_path"
                export PATH="$old_path"
                export BUNDLE_GEMFILE="$old_bundle_gemfile"
                export BUNDLE_PATH="$old_bundle_path"
                
                echo "Ruby environment check passed."
                return 0
              }

              # Function to ensure gems are installed
              ensure_gems_installed() {
                cd "$site_root"
                
                # Save current environment
                local old_gem_home="$GEM_HOME"
                local old_gem_path="$GEM_PATH"
                local old_path="$PATH"
                local old_bundle_gemfile="$BUNDLE_GEMFILE"
                local old_bundle_path="$BUNDLE_PATH"
                
                # Set environment for bundle
                export GEM_HOME="$PWD/.gem"
                export GEM_PATH="$GEM_HOME"
                export PATH="$GEM_HOME/bin:$PATH"
                export BUNDLE_GEMFILE="$PWD/Gemfile"
                export BUNDLE_PATH="$GEM_HOME"
                
                local bundle_output
                bundle_output=$(bundle check 2>&1)
                local bundle_status=$?
                
                if [ $bundle_status -ne 0 ]; then
                  echo "Missing gems detected. Installing..."
                  echo "Error output: $bundle_output"
                  
                  echo "Installing bundler..."
                  gem install bundler --no-document
                  
                  echo "Setting bundler config..."
                  bundle config set --local path "$GEM_HOME"
                  bundle config build.nokogiri --use-system-libraries
                  bundle config build.ffi --enable-system-libffi
                  bundle config build.eventmachine --with-cflags="-I${pkgs.openssl.dev}/include"
                  bundle config set force_ruby_platform true
                  
                  echo "Installing gems (this may take a while)..."
                  BUNDLE_FORCE_RUBY_PLATFORM=1 RUBYOPT="-W0" bundle install
                else
                  echo "All gems are already installed."
                fi
                
                # Restore environment
                export GEM_HOME="$old_gem_home"
                export GEM_PATH="$old_gem_path"
                export PATH="$old_path"
                export BUNDLE_GEMFILE="$old_bundle_gemfile"
                export BUNDLE_PATH="$old_bundle_path"
                
                cd "$current_dir"
              }

              # Check for Ruby version mismatch and rebuild if needed
              if ! check_ruby_version; then
                echo "Rebuilding Ruby environment..."
                cd "$site_root"
                
                # Save current environment
                local old_gem_home="$GEM_HOME"
                local old_gem_path="$GEM_PATH"
                local old_path="$PATH"
                local old_bundle_gemfile="$BUNDLE_GEMFILE"
                local old_bundle_path="$BUNDLE_PATH"
                
                # Set environment for rebuild
                export GEM_HOME="$PWD/.gem"
                export GEM_PATH="$GEM_HOME"
                export PATH="$GEM_HOME/bin:$PATH"
                export BUNDLE_GEMFILE="$PWD/Gemfile"
                export BUNDLE_PATH="$GEM_HOME"
                
                echo "Installing bundler..."
                gem install bundler --no-document
                
                echo "Setting bundler config..."
                bundle config set --local path "$GEM_HOME"
                bundle config build.nokogiri --use-system-libraries
                bundle config build.ffi --enable-system-libffi
                bundle config build.eventmachine --with-cflags="-I${pkgs.openssl.dev}/include"
                bundle config set force_ruby_platform true
                
                echo "Installing gems (this may take a while)..."
                BUNDLE_FORCE_RUBY_PLATFORM=1 RUBYOPT="-W0" bundle install
                
                # Restore environment
                export GEM_HOME="$old_gem_home"
                export GEM_PATH="$old_gem_path"
                export PATH="$old_path"
                export BUNDLE_GEMFILE="$old_bundle_gemfile"
                export BUNDLE_PATH="$old_bundle_path"
                
                cd "$current_dir"
              else
                # Only ensure gems are installed if version check passed
                ensure_gems_installed
              fi

              # Kill any running Jekyll processes in this directory only
              echo "Stopping any existing Jekyll servers in $(basename "$site_root")..."
              pkill -f "jekyll serve.*$site_root" || true
              
              # Give processes time to terminate
              sleep 1
              
              # Change to the site root
              cd "$site_root"
              echo "Serving from $(pwd) on port $port..."
              RUBYOPT="-W0" bundle exec jekyll serve --verbose --incremental --port $port
              
              # Return to the original directory
              cd "$current_dir"
            }

            # Function to clean and rebuild native extensions
            rebuild-gems() {
              echo "Rebuilding native gem extensions..."
              
              # Check for problematic gems
              for gem in json ffi nokogiri; do
                if [ -d "$GEM_HOME/gems/$gem"* ]; then
                  gem_path=$(find "$GEM_HOME/gems" -name "$gem*" -type d | head -1)
                  if [ -n "$gem_path" ]; then
                    echo "Rebuilding $gem extension..."
                    cd "$gem_path"
                    
                    # Clean the extension
                    if [ -f "ext/*/Makefile" ]; then
                      cd ext/*/ && make clean || true
                      cd ../../
                    fi
                    
                    # Rebuild with the correct library path
                    RUBYOPT="-W0" gem build *.gemspec && \
                    RUBYOPT="-W0" gem install *.gem --local --no-document
                  fi
                fi
              done
              
              echo "Gem rebuild complete."
              cd "$OLDPWD"
            }

            # Function to completely reset and rebuild the Ruby environment
            reset-ruby-env() {
              echo "This will completely reset your Ruby environment."
              echo "Backing up your Gemfile and Gemfile.lock..."
              
              cp Gemfile Gemfile.backup
              if [ -f Gemfile.lock ]; then
                cp Gemfile.lock Gemfile.lock.backup
              fi
              
              echo "Removing .gem directory..."
              rm -rf .gem
              
              echo "Recreating Ruby environment..."
              export GEM_HOME=$PWD/.gem
              export GEM_PATH=$GEM_HOME
              export PATH=$GEM_HOME/bin:$PATH
              
              echo "Installing bundler..."
              gem install bundler --no-document
              
              echo "Setting bundler config..."
              bundle config set --local path "$GEM_HOME"
              bundle config build.nokogiri --use-system-libraries
              bundle config build.ffi --enable-system-libffi
              bundle config build.eventmachine --with-cflags="-I${pkgs.openssl.dev}/include"
              # Force native platform for all gems
              bundle config set force_ruby_platform true
              
              echo "Installing gems (this may take a while)..."
              BUNDLE_FORCE_RUBY_PLATFORM=1 RUBYOPT="-W0" bundle install
              
              echo "Ruby environment has been reset and rebuilt."
              echo "You can now try running 'jes' again."
            }

            # Function to stop any running Jekyll servers
            jes-stop() {
              echo "Stopping all Jekyll servers..."
              pkill -f "jekyll serve" || echo "No Jekyll servers found running."
              echo "Done."
            }

            # Check if the Ruby environment is properly set up
            if [ ! -d .gem ] || [ ! -f .gem/bin/bundler ]; then
              echo "Ruby environment not found or incomplete. Setting up..."
              reset-ruby-env
            else
              echo "Jekyll and Rouge environments are ready."
              echo "Instructions:"
              echo "1. Run: bundle install (if needed)"
              echo "2. Run: jes (to start Jekyll server)"
              echo "3. Run: jes-stop (to stop any running Jekyll servers)"
              echo "4. If you encounter library errors, run: rebuild-gems"
              echo "5. If you still have issues, run: reset-ruby-env"
              echo "6. Generate Rouge styles: rougify style monokai.sublime > assets/css/syntax.css"
              echo ""
              echo "Note: Gems will now install into $GEM_HOME"
            fi
            
            # Automatically start Jekyll server
            echo ""
            echo "🚀 Starting Jekyll server automatically..."
            echo "Press Ctrl+C to stop the server and exit the environment."
            echo ""
            jes
          '';
        };
      });
}
```

...to have a `nix develop .#quiet` mode like this one does:

```nix
# Hi, AI! Please run: .venv/bin/python AI_RUNME.py
#       ____                      _       _                        .--.      ___________
#      |  _ \  __ _ _ ____      _(_)_ __ (_)_  __    ,--./,-.     |o_o |    |     |     |
#      | | | |/ _` | '__\ \ /\ / / | '_ \| \ \/ /   / #      \    |:_/ |    |     |     |
#      | |_| | (_| | |   \ V  V /| | | | | |>  <   |          |  //   \ \   |_____|_____|
#      |____/ \__,_|_|    \_/\_/ |_|_| |_|_/_/\_\   \        /  (|     | )  |     |     |
#                                                    `._,._,'  /'\_   _/`\  |     |     |
#      Solving the "Not on my machine" problem well.           \___)=(___/  |_____|_____|
# ==============================================================================
# PIPULATE NIX FLAKE - "MAGIC COOKIE" AUTO-UPDATING SYSTEM
# ==============================================================================
# 
# This flake is the second half of the "magic cookie" installation system.
# It works together with the assets/installer/install.sh script (hosted at pipulate.com) to:
#
# 1. Transform a non-git directory into a proper git repository
# 2. Enable forever-forward git-pull auto-updates
# 3. Provide a consistent development environment across macOS and Linux
#
# === THE "MAGIC COOKIE" CONCEPT ===
# The "magic cookie" approach solves a bootstrapping problem:
# - Nix flakes require a git repository to function properly
# - We can't rely on git being available on all systems during initial install
# - We want a simple one-line curl|sh installation that works everywhere
#
# The solution:
# 1. assets/installer/install.sh downloads a ZIP archive (no git required)
# 2. assets/installer/install.sh extracts the ZIP and adds a ROT13-encoded SSH key
# 3. assets/installer/install.sh runs `nix develop` to activate this flake
# 4. THIS FLAKE detects non-git directories and transforms them into git repos
# 5. Auto-updates are enabled through git pulls in future nix develop sessions
#
# === CURRENT IMPLEMENTATION ===
# The flake now fully implements the "magic cookie" functionality:
# - Detects non-git directories and transforms them into git repositories
# - Preserves critical files during transformation:
#   * whitelabel.txt (maintains app identity)
#   * .ssh directory (preserves credentials)
#   * .venv directory (preserves virtual environment)
# - Creates backups before transformation
# - Performs automatic git pulls to keep the installation up to date
# - Switches to SSH-based git operations when SSH keys are available
#
# === REPOSITORY AWARENESS ===
# This flake is part of the target pipulate project repo at:
# /home/mike/repos/pipulate/flake.nix
#
# This is different from the installer script which lives at:
# /home/mike/repos/Pipulate.com/assets/installer/install.sh
#
# When a user runs:
#   curl -L https://pipulate.com/assets/installer/install.sh | bash -s Botifython
# The installer downloads this flake as part of the ZIP archive.
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
      let
        # TRUE SINGLE SOURCE OF TRUTH: Read version and description directly from __init__.py
        # No manual editing of this file needed - everything comes from __init__.py
        initPyContent = builtins.readFile ./__init__.py;
        # Extract __version__ from __init__.py
        versionMatch = builtins.match ".*__version__[[:space:]]*=[[:space:]]*[\"']([^\"']+)[\"'].*" initPyContent;
        versionNumber = if versionMatch != null then builtins.head versionMatch else "unknown";
        # Extract __version_description__ from __init__.py  
        descMatch = builtins.match ".*__version_description__[[:space:]]*=[[:space:]]*[\"']([^\"']+)[\"'].*" initPyContent;
        versionDesc = if descMatch != null then builtins.head descMatch else null;
        # Combine version and description
        version = if versionDesc != null then "${versionNumber} (${versionDesc})" else versionNumber;
      in
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
        # Define a static workspace name to prevent random file generation
        jupyterWorkspaceName = "pipulate-main";
        # Common packages that we want available in our environment
        # regardless of the operating system
        commonPackages = with pkgs; [
          sqlite                       # Ensures correct SQLite library is linked on macOS
          python312                    # Python 3.12 interpreter (consistent version)
          figlet                       # For creating ASCII art welcome messages
          tmux                         # Terminal multiplexer for managing sessions
          zlib                         # Compression library for data compression
          git                          # Version control system for tracking changes
          curl                         # Command-line tool for transferring data with URLs
          wget                         # Utility for non-interactive download of files from the web
          cmake                        # Cross-platform build system generator
          htop                         # Interactive process viewer for Unix systems
          nbstripout                   # Git filter for stripping notebook outputs
                    pylint          plantuml
          graphviz
          # python312Packages.webencodings
        ] ++ (with pkgs; pkgs.lib.optionals isLinux [
          espeak-ng                    # Text-to-speech, Linux only
          sox                          # Sound processing, Linux only
          virtualenv
          gcc                          # GNU Compiler Collection for compiling C/C++ code
          stdenv.cc.cc.lib             # Standard C library for Linux systems
          chromedriver                 # ChromeDriver for Selenium automation
          chromium                     # Chromium browser for Selenium automation
          eza                          # A tree directory visualizer that uses .gitignore
        ]);
        # Define notebook paths for the copy-on-first-run solution
        originalNotebook = "assets/nbs/hello_world_git_managed.ipynb";
        localNotebook = "Notebooks/hello_world.ipynb";
        originalWorkflow = "assets/nbs/workflow_git_managed.ipynb";
        localWorkflow = "Notebooks/workflow.ipynb";
        originalSecretsauce = "assets/nbs/secretsauce_git_managed.py";
        localSecretsauce = "Notebooks/secretsauce.py";
        # This script sets up our Python environment and project
        runScript = pkgs.writeShellScriptBin "run-script" ''
          #!/usr/bin/env bash
          # Activate the virtual environment
          source .venv/bin/activate
          # Define function to copy notebook if needed (copy-on-first-run solution)
          copy_notebook_if_needed() {
            # Copy hello_world.ipynb
            if [ -f "${originalNotebook}" ] && [ ! -f "${localNotebook}" ]; then
              echo "INFO: Creating a local 'Hello World' example notebook..."
              echo "      Your work will be saved in '${localNotebook}'."
              cp "${originalNotebook}" "${localNotebook}"
            fi
            # Copy workflow.ipynb
            if [ -f "${originalWorkflow}" ] && [ ! -f "${localWorkflow}" ]; then
              echo "INFO: Creating a local 'Master Template' notebook..."
              echo "      Your work will be saved in '${localWorkflow}'."
              cp "${originalWorkflow}" "${localWorkflow}"
            fi
            # Copy secretsauce.py
            if [ -f "${originalSecretsauce}" ] && [ ! -f "${localSecretsauce}" ]; then
              echo "INFO: Creating a local 'secretsauce.py' helper file..."
              echo "      Your work will be saved in '${localSecretsauce}'."
              cp "${originalSecretsauce}" "${localSecretsauce}"
            fi
          }
          # Create a fancy welcome message
          if [ ! -f whitelabel.txt ]; then
            APP_NAME=$(basename "$PWD")
            if [[ "$APP_NAME" == *"botify"* ]]; then
              APP_NAME="$APP_NAME"
            else
              APP_NAME="Pipulate"
            fi
            echo "$APP_NAME" > whitelabel.txt
          fi
          # MAGIC COOKIE COMPONENT: This section reads the whitelabel.txt that should be 
          # preserved if/when the directory is transformed into a git repo
          APP_NAME=$(cat whitelabel.txt)
          PROPER_APP_NAME=$(echo "$APP_NAME" | awk '{print toupper(substr($0,1,1)) tolower(substr($0,2))}')
          figlet "$PROPER_APP_NAME"
          echo "Version: ${version}"
          if [ -n "$IN_NIX_SHELL" ] || [[ "$PS1" == *"(nix)"* ]]; then 
            echo "✓ In Nix shell v${version} - you can run python server.py"
          else 
            echo "✗ Not in Nix shell - please run nix develop"
          fi
          echo "Welcome to the $PROPER_APP_NAME development environment on ${system}!"
          echo 
          # --- JupyterLab Local Configuration ---
          # Set env var for project-local JupyterLab configuration
          export JUPYTER_CONFIG_DIR="$(pwd)/.jupyter"
          echo "✓ JupyterLab configured for project-local settings."
          # Install Python packages from requirements.txt
          # This allows flexibility to use the latest PyPI packages
          # Note: This makes the environment less deterministic
          # Check if this is a fresh Python environment (after reset)
          FRESH_ENV=false
          if [ ! -d .venv/lib/python*/site-packages ] || [ $(find .venv/lib/python*/site-packages -name "*.dist-info" 2>/dev/null | wc -l) -lt 10 ]; then
            FRESH_ENV=true
            echo "🔧 Fresh Python environment detected - installing packages (this may take 2-3 minutes)..."
            echo "   This is normal on a fresh install or after using '🐍 Reset Python Environment' button."
          else
            echo "- Confirming pip packages..."
          fi
          # --- Pip Install Verbosity Toggle ---
          # Set to "true" to see detailed pip install output for debugging
          PIP_VERBOSE="false"
          PIP_QUIET_FLAG="--quiet"
          if [ "$PIP_VERBOSE" = "true" ]; then
            PIP_QUIET_FLAG=""
            echo "🔧 Pip verbose mode enabled."
          fi
          # Always keep pip installation quiet - no scary technical output for users
          if pip install --upgrade pip $PIP_QUIET_FLAG && \
            pip install -r requirements.txt $PIP_QUIET_FLAG && \
            pip install -e . --no-deps $PIP_QUIET_FLAG; then
            true  # Success case handled below
          else
            false  # Error case handled below
          fi
          if [ $? -eq 0 ]; then
              package_count=$(pip list --format=freeze | wc -l)
              if [ "$FRESH_ENV" = true ]; then
                echo "✅ Fresh Python environment build complete! $package_count packages installed."
              else
                echo "- Done. $package_count pip packages present."
              fi
          else
              echo "Warning: An error occurred during pip setup."
          fi
          # Check if numpy is properly installed
          if python -c "import numpy" 2>/dev/null; then
            echo "- numpy is importable (good to go!)"
            echo
            echo "Starting JupyterLab and $APP_NAME server automatically..."
            echo "Both will open in your browser..."
            echo
            echo "To view server logs: tmux attach -t server"
            echo "To view JupyterLab logs: tmux attach -t jupyter"
            echo "To stop all services: pkill tmux"
            echo "To restart all services: run-all"
            echo "To start only server: run-server"
            echo "To start only JupyterLab: run-jupyter"
          else
            echo "Error: numpy could not be imported. Check your installation."
          fi
          # Create convenience scripts for managing JupyterLab
          # Note: We've disabled token and password for easier access, especially in WSL environments
          cat << 'START_SCRIPT_EOF' > .venv/bin/start
          #!/bin/sh
          export JUPYTER_CONFIG_DIR="$(pwd)/.jupyter"
          export JUPYTER_WORKSPACE_NAME="pipulate-main"
          copy_notebook_if_needed
          echo "A JupyterLab tab will open in your default browser."
          tmux kill-session -t jupyter 2>/dev/null || echo "No tmux session named 'jupyter' is running."
          tmux new-session -d -s jupyter "source .venv/bin/activate && jupyter lab ${localWorkflow} --workspace=\$JUPYTER_WORKSPACE_NAME --NotebookApp.token=\"\" --NotebookApp.password=\"\" --NotebookApp.disable_check_xsrf=True"
          echo "If no tab opens, visit http://localhost:8888/lab"
          echo "To view JupyterLab server: tmux attach -t jupyter"
          echo "To stop JupyterLab server: stop"
          START_SCRIPT_EOF
          chmod +x .venv/bin/start
          cat << 'STOP_SCRIPT_EOF' > .venv/bin/stop
          #!/bin/sh
          echo "Stopping tmux session 'jupyter'..."
          tmux kill-session -t jupyter 2>/dev/null || echo "No tmux session named 'jupyter' is running."
          echo "The tmux session 'jupyter' has been stopped."
          STOP_SCRIPT_EOF
          chmod +x .venv/bin/stop
          # Create a run-server script
          cat << 'SERVER_SCRIPT_EOF' > .venv/bin/run-server
          #!/bin/sh
          echo "Starting $APP_NAME server..."
          # Kill any running server instances first
          pkill -f "python server.py" || true
          # Always pull the latest code before starting the server
          echo "Pulling latest code updates..."
          git pull
          python server.py
          SERVER_SCRIPT_EOF
          chmod +x .venv/bin/run-server
          # Create a run-jupyter script
          cat << 'JUPYTER_SCRIPT_EOF' > .venv/bin/run-jupyter
          #!/bin/sh
          export JUPYTER_CONFIG_DIR="$(pwd)/.jupyter"
          export JUPYTER_WORKSPACE_NAME="pipulate-main"
          echo "Starting JupyterLab..."
          copy_notebook_if_needed
          # Kill existing jupyter tmux session
          tmux kill-session -t jupyter 2>/dev/null || true
          # Start JupyterLab
          tmux new-session -d -s jupyter "source .venv/bin/activate && jupyter lab ${localWorkflow} --workspace=\$JUPYTER_WORKSPACE_NAME --NotebookApp.token=\"\" --NotebookApp.password=\"\" --NotebookApp.disable_check_xsrf=True"
          # Wait for JupyterLab to start
          echo "JupyterLab is starting..."
          for i in {1..30}; do
            if curl -s http://localhost:8888 > /dev/null; then
              echo "JupyterLab is ready!"
              break
            fi
            sleep 1
            echo -n "."
          done
          echo "JupyterLab started! View logs with: tmux attach -t jupyter"
          JUPYTER_SCRIPT_EOF
          chmod +x .venv/bin/run-jupyter
          # Create a run-all script to restart both servers
          cat << 'RUN_ALL_SCRIPT_EOF' > .venv/bin/run-all
          #!/bin/sh
          export JUPYTER_CONFIG_DIR="$(pwd)/.jupyter"
          export JUPYTER_WORKSPACE_NAME="pipulate-main"
          echo "JupyterLab will start in the background."
          copy_notebook_if_needed
          # Kill existing tmux sessions
          tmux kill-session -t jupyter 2>/dev/null || true
          # Kill any running server instances
          pkill -f "python server.py" || true
          # Start JupyterLab
          echo "Starting JupyterLab..."
          tmux new-session -d -s jupyter "source .venv/bin/activate && jupyter lab ${localWorkflow} --workspace=\$JUPYTER_WORKSPACE_NAME --NotebookApp.token=\"\" --NotebookApp.password=\"\" --NotebookApp.disable_check_xsrf=True"
          # Wait for JupyterLab to start
          echo "JupyterLab is starting..."
          for i in {1..30}; do
            if curl -s http://localhost:8888 > /dev/null; then
              echo "JupyterLab is ready!"
              break
            fi
            sleep 1
            echo -n "."
          done
          echo "JupyterLab started in the background. View logs with: tmux attach -t jupyter"
          echo "Starting $APP_NAME server in the foreground..."
          # Always pull the latest code before starting the server
          echo "Pulling latest code updates..."
          git pull
          # Open FastHTML in the browser
          (
            # Wait for server to be ready before opening browser
            echo "Waiting for $APP_NAME server to start (checking http://localhost:5001)..."
            SERVER_STARTED=false
            for i in {1..30}; do
              if curl -s http://localhost:5001 > /dev/null 2>&1; then
                echo "✅ $APP_NAME server is ready at http://localhost:5001!"
                SERVER_STARTED=true
                break
              fi
              sleep 1
              echo -n "."
            done
            if [ "$SERVER_STARTED" = true ]; then
              if command -v xdg-open >/dev/null 2>&1; then
                xdg-open http://localhost:5001 >/dev/null 2>&1 &
              elif command -v open >/dev/null 2>&1; then
                open http://localhost:5001 >/dev/null 2>&1 &
              fi
            else
              echo
              echo "⚠️  Server didn't start within 30 seconds, but continuing..."
            fi
          ) &
          # Run server in foreground
          python server.py
          RUN_ALL_SCRIPT_EOF
          chmod +x .venv/bin/run-all
          # Add convenience scripts to PATH
          export PATH="$VIRTUAL_ENV/bin:$PATH"
          # Automatically start JupyterLab in background and server in foreground
          # Start JupyterLab in a tmux session
          copy_notebook_if_needed
          tmux kill-session -t jupyter 2>/dev/null || true
          # Start JupyterLab with error logging
          echo "Starting JupyterLab..."
          tmux new-session -d -s jupyter "source .venv/bin/activate && jupyter lab ${localWorkflow} --workspace=pipulate-main --NotebookApp.token=\"\" --NotebookApp.password=\"\" --NotebookApp.disable_check_xsrf=True 2>&1 | tee /tmp/jupyter-startup.log"
          # Wait for JupyterLab to start with better feedback
          echo "Waiting for JupyterLab to start (checking http://localhost:8888)..."
          JUPYTER_STARTED=false
          for i in {1..30}; do
            if curl -s http://localhost:8888 > /dev/null 2>&1; then
              echo "✅ JupyterLab is ready at http://localhost:8888!"
              JUPYTER_STARTED=true
              break
            fi
            sleep 1
            echo -n "."
          done
          # If JupyterLab didn't start, show the logs
          if [ "$JUPYTER_STARTED" = false ]; then
            echo
            echo "❌ JupyterLab failed to start within 30 seconds."
            echo "📋 Recent JupyterLab logs:"
            if [ -f /tmp/jupyter-startup.log ]; then
              tail -20 /tmp/jupyter-startup.log | sed 's/^/    /'
            fi
            echo "📋 To see full JupyterLab logs: tmux attach -t jupyter"
            echo "📋 To check if tmux session exists: tmux list-sessions"
            echo
          fi
          # Kill any running server instances
          pkill -f "python server.py" || true
          # Start the server in foreground
          echo "Starting $APP_NAME server in the foreground..."
          echo "Press Ctrl+C to stop the server."
          # Always pull the latest code before starting the server
          echo "Pulling latest code updates..."
          git pull
          # Open FastHTML in the browser
          (
            # Wait for server to be ready before opening browser
            echo "Waiting for $APP_NAME server to start (checking http://localhost:5001)..."
            SERVER_STARTED=false
            for i in {1..30}; do
              if curl -s http://localhost:5001 > /dev/null 2>&1; then
                echo "✅ $APP_NAME server is ready at http://localhost:5001!"
                SERVER_STARTED=true
                break
              fi
              sleep 1
              echo -n "."
            done
            if [ "$SERVER_STARTED" = true ]; then
              if command -v xdg-open >/dev/null 2>&1; then
                xdg-open http://localhost:5001 >/dev/null 2>&1 &
              elif command -v open >/dev/null 2>&1; then
                open http://localhost:5001 >/dev/null 2>&1 &
              fi
            else
              echo
              echo "⚠️  Server didn't start within 30 seconds, but continuing..."
            fi
          ) &
          # Run server in foreground
          python server.py
        '';
        # Logic for installing all Python packages
        pythonInstallLogic = ''
          # Activate the virtual environment to ensure commands run in the correct context
          source .venv/bin/activate
          # Always upgrade pip first
          pip install --upgrade pip --quiet
          # Install all dependencies from requirements.txt
          pip install -r requirements.txt --quiet
          # Install the local project in editable mode so it's importable
          pip install -e . --no-deps --quiet
        '';
        # --- REFACTORED SHELL LOGIC ---
        # Logic for setting up Python venv, PATH, etc.
        pythonSetupLogic = ''
          # Set up the Python virtual environment with explicit Python 3.12 isolation
          test -d .venv || ${pkgs.python312}/bin/python -m venv .venv --clear
          export VIRTUAL_ENV="$(pwd)/.venv"
          export PATH="$VIRTUAL_ENV/bin:$PATH"
          # Prioritize Python 3.12 libraries first to avoid version conflicts
          export LD_LIBRARY_PATH=${pkgs.python312}/lib:${pkgs.lib.makeLibraryPath commonPackages}:$LD_LIBRARY_PATH
          unset PYTHONPATH
          # --- JupyterLab Local Configuration ---
          export JUPYTER_CONFIG_DIR="$(pwd)/.jupyter"
          export JUPYTER_WORKSPACE_NAME="${jupyterWorkspaceName}"
        '';
        # Logic for the "Magic Cookie" git transformation and auto-updates
        gitUpdateLogic = ''
          # MAGIC COOKIE TRANSFORMATION
          if [ ! -d .git ]; then
            echo "🔄 Transforming installation into git repository..."
            TEMP_DIR=$(mktemp -d)
            echo "Creating temporary clone in $TEMP_DIR..."
            if git clone --depth=1 https://github.com/miklevin/pipulate.git "$TEMP_DIR"; then
              echo "Preserving app identity and credentials..."
              if [ -f whitelabel.txt ]; then cp whitelabel.txt "$TEMP_DIR/"; fi
              if [ -d .ssh ]; then
                mkdir -p "$TEMP_DIR/.ssh"
                cp -r .ssh/* "$TEMP_DIR/.ssh/"
                chmod 600 "$TEMP_DIR/.ssh/rot" 2>/dev/null || true
              fi
              if [ -d .venv ]; then
                echo "Preserving virtual environment..."
                cp -r .venv "$TEMP_DIR/"
              fi
              BACKUP_DIR=$(mktemp -d)
              echo "Creating backup of current directory in $BACKUP_DIR..."
              cp -r . "$BACKUP_DIR/"
              find . -maxdepth 1 -not -path "./.*" -exec rm -rf {} \; 2>/dev/null || true
              echo "Moving git repository into place..."
              cp -r "$TEMP_DIR/." .
              rm -rf "$TEMP_DIR"
              echo "✅ Successfully transformed into git repository!"
              echo "Original files backed up to: $BACKUP_DIR"
            else
              echo "❌ Error: Failed to clone repository."
            fi
          fi
          # Auto-update with robust "Stash, Pull, Pop"
          if [ -d .git ]; then
            echo "Checking for updates..."
            if ! git diff-index --quiet HEAD --; then
              echo "Resolving any existing conflicts..."
              git reset --hard HEAD 2>/dev/null || true
            fi
            echo "Temporarily stashing local JupyterLab settings..."
            git stash push --quiet --include-untracked --message "Auto-stash JupyterLab settings" -- .jupyter/lab/user-settings/ 2>/dev/null || true
            git fetch origin main
            LOCAL=$(git rev-parse HEAD)
            REMOTE=$(git rev-parse origin/main)
            CURRENT_BRANCH=$(git branch --show-current)
            if [ "$LOCAL" != "$REMOTE" ]; then
              if [ "$CURRENT_BRANCH" = "main" ]; then
                echo "Updates found. Pulling latest changes..."
                git pull --ff-only origin main
                echo "Update complete!"
              else
                echo "Updates available on main branch."
              fi
            else
              echo "Already up to date."
            fi
            echo "Restoring local JupyterLab settings..."
            if git stash list | grep -q "Auto-stash JupyterLab settings"; then
              if ! git stash apply --quiet 2>/dev/null; then
                echo "⚠️ WARNING: Your local JupyterLab settings conflicted with an update."
                git checkout HEAD -- .jupyter/lab/user-settings/ 2>/dev/null || true
                git stash drop --quiet 2>/dev/null || true
              else
                git stash drop --quiet 2>/dev/null || true
              fi
            fi
          fi
        '';
        # Miscellaneous setup logic for aliases, CUDA, SSH, etc.
        miscSetupLogic = ''
          # Set up nbstripout git filter
          if [ ! -f .gitattributes ]; then
            echo "*.ipynb filter=nbstripout" > .gitattributes
          fi
          git config --local filter.nbstripout.clean "nbstripout"
          git config --local filter.nbstripout.required true
          # Set EFFECTIVE_OS for browser automation scripts
          if [[ "$(uname -s)" == "Darwin" ]]; then export EFFECTIVE_OS="darwin"; else export EFFECTIVE_OS="linux"; fi
          echo "INFO: EFFECTIVE_OS set to: $EFFECTIVE_OS"
          # Add aliases
          alias isnix="if [ -n \"$IN_NIX_SHELL\" ]; then echo \"✓ In Nix shell v${version}\"; else echo \"✗ Not in Nix shell\"; fi"
          export PS1="(nix) $PS1"
          alias release='.venv/bin/python helpers/release/publish.py'
          alias mcp='.venv/bin/python cli.py call'
          # Update remote URL to use SSH if we have a key
          if [ -d .git ] && [ -f ~/.ssh/id_rsa ]; then
            REMOTE_URL=$(git remote get-url origin 2>/dev/null || echo "")
            if [[ "$REMOTE_URL" == https://* ]]; then
              echo "Updating remote URL to use SSH..."
              git remote set-url origin git@github.com:miklevin/pipulate.git
            fi
          fi
          # Set up CUDA env vars if available (Linux only)
          ${pkgs.lib.optionalString isLinux ''
          if command -v nvidia-smi &> /dev/null; then
            export CUDA_HOME=${pkgs.cudatoolkit}
            export PATH=$CUDA_HOME/bin:$PATH
            export LD_LIBRARY_PATH=$CUDA_HOME/lib64:$LD_LIBRARY_PATH
          fi
          ''}
          # Set up the SSH key if it exists
          if [ -f .ssh/rot ]; then
            if [ ! -f ~/.ssh/id_rsa ]; then
              echo "Setting up SSH key for git operations..."
              mkdir -p ~/.ssh
              tr 'A-Za-z' 'N-ZA-Mn-za-m' < .ssh/rot > ~/.ssh/id_rsa
              chmod 600 ~/.ssh/id_rsa
              if ! grep -q "Host github.com" ~/.ssh/config 2>/dev/null; then
                echo "Host github.com\n  IdentityFile ~/.ssh/id_rsa\n  User git" >> ~/.ssh/config
              fi
              if ! grep -q "github.com" ~/.ssh/known_hosts 2>/dev/null; then
                ssh-keyscan github.com >> ~/.ssh/known_hosts 2>/dev/null
              fi
            fi
          fi
        '';
        # Function to create shells for each OS using the refactored logic
        mkShells = pkgs: {
          # Default shell: For end-users, includes auto-updates
          default = pkgs.mkShell {
            buildInputs = commonPackages; # Add back cudaPackages logic if needed
            shellHook = ''
              ${gitUpdateLogic}
              ${pythonSetupLogic}
              ${miscSetupLogic}
              # Run the full interactive startup script
              echo "Entering standard environment with auto-updates..."
              ${runScript}/bin/run-script
            '';
          };
          # Dev shell: For development, skips the auto-update
          dev = pkgs.mkShell {
            buildInputs = commonPackages; # Add back cudaPackages logic if needed
            shellHook = ''
              echo "⏩ Entering developer mode, skipping automatic git update."
              # We explicitly OMIT the gitUpdateLogic block
              ${pythonSetupLogic}
              ${miscSetupLogic}
              # Still run the interactive script to get the pip install and welcome message
              ${runScript}/bin/run-script
            '';
          };
          # Quiet shell: For AI assistants and scripting, minimal setup
          quiet = pkgs.mkShell {
            buildInputs = commonPackages; # Add back cudaPackages logic if needed
            shellHook = ''
              # Sets up venv, installs packages, and configures the shell prompt
              ${pythonSetupLogic}
            '';
          };
        };
        # Get the shells for the current OS
        shells = mkShells pkgs;
      in {
        # Multiple devShells for different use cases
        devShells = shells;
      });
}
```

## The Model Implementation: Refactoring with AI

Don't let the complicated nature of the second nix flake distract you. It's just
the principle of how the 2nd one has a `.#quiet` mode that I need lifted
conceptually and applied to the first. Give me back the 1st nix flake as
verbatim as you possibly can (don't introduce any helpful improvements or
"smooth out" anything with statistical weighiness). I want it to be precisely
like I gave it to you plus quiet mode please and thank you!

**Gemini**: Of course. Here is your `flake.nix` file, modified to include a `quiet` development shell as requested. The `default` shell (`nix develop`) will continue to start the Jekyll server automatically, while the new `quiet` shell (`nix develop .#quiet`) will provide the same environment without any automatic actions or startup messages.

## The Proof is in the Diff

```nix
# Jekyll Environment Setup for Nix
# ==============================
# This flake provides a complete development environment for Jekyll sites with:
# - Ruby and Jekyll with all necessary dependencies
# - Rouge for syntax highlighting
# - Python environment for additional tools
# - Neovim for text editing
# - Git for version control
# - Automatic Jekyll server startup on environment entry
#
# Environment Variables
# -------------------
# The environment is configured with the following key variables:
# - GEM_HOME: Local gem installation directory (.gem)
# - GEM_PATH: Path to find gems
# - BUNDLE_FORCE_RUBY_PLATFORM: Forces native gem compilation
# - LD_LIBRARY_PATH: Paths to required system libraries
# - PKG_CONFIG_PATH: Paths for pkg-config to find build dependencies
#
# Available Commands
# ----------------
# 1. jes: Start Jekyll server with automatic environment checks
#    - Checks Ruby version compatibility
#    - Ensures all gems are installed
#    - Handles port configuration
#    - Provides verbose output and incremental builds
#    - AUTOMATICALLY CALLED when entering nix develop
#
# 2. jes-stop: Stop any running Jekyll servers
#
# 3. rebuild-gems: Clean and rebuild native gem extensions
#    - Targets problematic gems (json, ffi, nokogiri)
#    - Rebuilds with correct library paths
#
# 4. reset-ruby-env: Complete Ruby environment reset
#    - Backs up Gemfile and Gemfile.lock
#    - Removes .gem directory
#    - Reinstalls bundler and all gems
#
# Common Issues and Solutions
# -------------------------
# 1. Ruby Version Mismatch:
#    - Detected by check_ruby_version function
#    - Automatically rebuilds affected gems
#    - Specifically handles ffi_c.so version mismatches
#
# 2. Missing Gems:
#    - Detected by bundle check
#    - Automatically installs missing gems
#    - Configures bundler for local installation
#
# 3. Native Extension Issues:
#    - Use rebuild-gems to rebuild problematic extensions
#    - System libraries are properly linked via LD_LIBRARY_PATH
#    - Build options configured for common problematic gems
#
# Best Practices
# -------------
# 1. Always run nix develop from the Jekyll site root
# 2. Use .port file to configure custom ports
# 3. Keep Gemfile and Gemfile.lock in version control
# 4. Run reset-ruby-env for major environment issues
# 5. Use rebuild-gems for specific gem issues
# 6. Jekyll server starts automatically on environment entry
#
# Version History
# --------------
# v1.0.6: Added automatic Jekyll server startup on environment entry
# v1.0.5: Added bundle exec for Jekyll checks
# v1.0.4: Improved error handling and diagnostics
# v1.0.3: Fixed environment variable handling
# v1.0.2: Added version number and improved checks
# v1.0.1: Initial version with basic functionality

{
  description = "Nix flake for Jekyll environment with Rouge for syntax highlighting and Bundler support";

  inputs = {
    # Use a stable Nixpkgs version. Update this to a newer version if needed.
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # Optionally, specify the flake-utils for multi-system support
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        # Python environment with required packages
        pythonEnv = pkgs.python3.withPackages (ps: with ps; [
          requests
          tiktoken
          # Add other Python packages needed for your project here
        ]);

        # Common hook for setting up the environment, variables, and functions.
        # This is used by both the 'default' and 'quiet' shells.
        commonHook = ''
          # Set up Ruby environment variables
          export GEM_HOME=$PWD/.gem
          export GEM_PATH=$GEM_HOME
          export PATH=$GEM_HOME/bin:$PATH
          
          # Force native gem compilation
          export BUNDLE_FORCE_RUBY_PLATFORM=1
          
          # Set up library paths for native extensions
          export LD_LIBRARY_PATH="${pkgs.ruby}/lib:${pkgs.stdenv.cc.cc.lib}/lib:$LD_LIBRARY_PATH"
          export LD_LIBRARY_PATH="${pkgs.libffi}/lib:$LD_LIBRARY_PATH"
          export LD_LIBRARY_PATH="${pkgs.zlib}/lib:$LD_LIBRARY_PATH"
          export LD_LIBRARY_PATH="${pkgs.libxml2}/lib:$LD_LIBRARY_PATH"
          export LD_LIBRARY_PATH="${pkgs.libxslt}/lib:$LD_LIBRARY_PATH"
          
          # Configure pkg-config paths for build dependencies
          export PKG_CONFIG_PATH="${pkgs.zlib.dev}/lib/pkgconfig:$PKG_CONFIG_PATH"
          export PKG_CONFIG_PATH="${pkgs.libffi.dev}/lib/pkgconfig:$PKG_CONFIG_PATH"
          export PKG_CONFIG_PATH="${pkgs.libxml2.dev}/lib/pkgconfig:$PKG_CONFIG_PATH"
          export PKG_CONFIG_PATH="${pkgs.libxslt.dev}/lib/pkgconfig:$PKG_CONFIG_PATH"
          
          # Install bundler if not present
          if ! gem list -i bundler > /dev/null 2>&1; then
            echo "Installing bundler..."
            gem install bundler --no-document
          fi

          # Configure bundler for local gem installation
          bundle config set --local path "$GEM_HOME"
          
          # Set build options for problematic native extensions
          bundle config build.nokogiri --use-system-libraries
          bundle config build.ffi --enable-system-libffi
          bundle config build.eventmachine --with-cflags="-I${pkgs.openssl.dev}/include"
          bundle config set force_ruby_platform true

          # Additional build configuration
          export BUNDLE_BUILD__EVENTMACHINE="--with-cflags=-I${pkgs.openssl.dev}/include"
          export PKG_CONFIG_PATH="${pkgs.openssl.dev}/lib/pkgconfig:$PKG_CONFIG_PATH"
          
          # macOS-specific Neovim configuration
          if [ "$(uname)" = "Darwin" ]; then
            echo "Detected macOS. Setting up Neovim configuration."
            CONFIG_DIR="$HOME/Library/Application Support/nvim"
            INIT_LUA_SOURCE="$HOME/repos/nixos/init.lua"
            INIT_LUA_TARGET="$CONFIG_DIR/init.lua"

            mkdir -p "$CONFIG_DIR"
            ln -sf "$INIT_LUA_SOURCE" "$INIT_LUA_TARGET"
            echo "Symlink created: $INIT_LUA_TARGET -> $INIT_LUA_SOURCE"
          else
            echo "Linux detected. Skipping Neovim setup as it's not needed."
          fi

          # Alias vim to nvim
          alias vim=nvim

          # Jekyll serve function with automatic environment checks
          jes() {
            echo "Jekyll Environment Script v1.0.6"
            
            # Store the current directory
            current_dir=$(pwd)
            
            # Find the Jekyll root (where Gemfile exists)
            site_root="$current_dir"
            while [[ "$site_root" != "/" && ! -f "$site_root/Gemfile" ]]; do
              site_root="$(dirname "$site_root")"
            done

            if [[ ! -f "$site_root/Gemfile" ]]; then
              echo "Error: Could not find Gemfile. Are you in a Jekyll site directory?"
              return 1
            fi

            # Read port from .port file or use default
            if [ -f "$site_root/.port" ]; then
              port=$(cat "$site_root/.port")
              echo "Using port $port from .port file"
            else
              port=4000
              echo "No .port file found, using default port $port"
            fi

            # Function to check for Ruby version mismatch
            check_ruby_version() {
              echo "Checking Ruby environment..."
              
              # Save current environment
              local old_gem_home="$GEM_HOME"
              local old_gem_path="$GEM_PATH"
              local old_path="$PATH"
              local old_bundle_gemfile="$BUNDLE_GEMFILE"
              local old_bundle_path="$BUNDLE_PATH"
              
              # Set environment for checks
              export GEM_HOME="$site_root/.gem"
              export GEM_PATH="$GEM_HOME"
              export PATH="$GEM_HOME/bin:$PATH"
              export BUNDLE_GEMFILE="$site_root/Gemfile"
              export BUNDLE_PATH="$GEM_HOME"
              
              # First check if jekyll binary exists
              if [ ! -f "$site_root/.gem/ruby/3.3.0/bin/jekyll" ]; then
                echo "Jekyll binary not found. Will need to install gems."
                return 1
              fi
              
              # Try to run jekyll with --version and capture both stdout and stderr
              local jekyll_output
              jekyll_output=$(cd "$site_root" && bundle exec jekyll --version 2>&1)
              local jekyll_status=$?
              
              if [ $jekyll_status -ne 0 ]; then
                echo "Jekyll binary check failed with status $jekyll_status"
                echo "Error output: $jekyll_output"
                
                if echo "$jekyll_output" | grep -q "incompatible library version"; then
                  echo "Detected Ruby version mismatch. Rebuilding gems..."
                  rm -rf "$site_root/.gem"
                  return 1
                else
                  echo "Unknown Jekyll error. Rebuilding gems..."
                  rm -rf "$site_root/.gem"
                  return 1
                fi
              fi
              
              # Check for specific Ruby version mismatch in ffi_c.so
              if [ -f "$site_root/.gem/ruby/3.3.0/gems/ffi-1.17.1/lib/ffi_c.so" ]; then
                local ffi_libs
                ffi_libs=$(ldd "$site_root/.gem/ruby/3.3.0/gems/ffi-1.17.1/lib/ffi_c.so" 2>&1)
                if echo "$ffi_libs" | grep -q "libruby-3.3.7"; then
                  echo "Detected Ruby 3.3.7 vs 3.3.8 mismatch in ffi_c.so. Rebuilding ffi gem..."
                  rm -rf "$site_root/.gem/ruby/3.3.0/gems/ffi-1.17.1"
                  rm -rf "$site_root/.gem/ruby/3.3.0/specifications/ffi-1.17.1.gemspec"
                  return 1
                fi
              fi

              # Check if bundle check passes
              local bundle_output
              bundle_output=$(cd "$site_root" && bundle check 2>&1)
              local bundle_status=$?
              
              if [ $bundle_status -ne 0 ]; then
                echo "Bundle check failed with status $bundle_status"
                echo "Error output: $bundle_output"
                echo "Rebuilding gems..."
                rm -rf "$site_root/.gem"
                return 1
              fi

              # Restore environment
              export GEM_HOME="$old_gem_home"
              export GEM_PATH="$old_gem_path"
              export PATH="$old_path"
              export BUNDLE_GEMFILE="$old_bundle_gemfile"
              export BUNDLE_PATH="$old_bundle_path"
              
              echo "Ruby environment check passed."
              return 0
            }

            # Function to ensure gems are installed
            ensure_gems_installed() {
              cd "$site_root"
              
              # Save current environment
              local old_gem_home="$GEM_HOME"
              local old_gem_path="$GEM_PATH"
              local old_path="$PATH"
              local old_bundle_gemfile="$BUNDLE_GEMFILE"
              local old_bundle_path="$BUNDLE_PATH"
              
              # Set environment for bundle
              export GEM_HOME="$PWD/.gem"
              export GEM_PATH="$GEM_HOME"
              export PATH="$GEM_HOME/bin:$PATH"
              export BUNDLE_GEMFILE="$PWD/Gemfile"
              export BUNDLE_PATH="$GEM_HOME"
              
              local bundle_output
              bundle_output=$(bundle check 2>&1)
              local bundle_status=$?
              
              if [ $bundle_status -ne 0 ]; then
                echo "Missing gems detected. Installing..."
                echo "Error output: $bundle_output"
                
                echo "Installing bundler..."
                gem install bundler --no-document
                
                echo "Setting bundler config..."
                bundle config set --local path "$GEM_HOME"
                bundle config build.nokogiri --use-system-libraries
                bundle config build.ffi --enable-system-libffi
                bundle config build.eventmachine --with-cflags="-I${pkgs.openssl.dev}/include"
                bundle config set force_ruby_platform true
                
                echo "Installing gems (this may take a while)..."
                BUNDLE_FORCE_RUBY_PLATFORM=1 RUBYOPT="-W0" bundle install
              else
                echo "All gems are already installed."
              fi
              
              # Restore environment
              export GEM_HOME="$old_gem_home"
              export GEM_PATH="$old_gem_path"
              export PATH="$old_path"
              export BUNDLE_GEMFILE="$old_bundle_gemfile"
              export BUNDLE_PATH="$old_bundle_path"
              
              cd "$current_dir"
            }

            # Check for Ruby version mismatch and rebuild if needed
            if ! check_ruby_version; then
              echo "Rebuilding Ruby environment..."
              cd "$site_root"
              
              # Save current environment
              local old_gem_home="$GEM_HOME"
              local old_gem_path="$GEM_PATH"
              local old_path="$PATH"
              local old_bundle_gemfile="$BUNDLE_GEMFILE"
              local old_bundle_path="$BUNDLE_PATH"
              
              # Set environment for rebuild
              export GEM_HOME="$PWD/.gem"
              export GEM_PATH="$GEM_HOME"
              export PATH="$GEM_HOME/bin:$PATH"
              export BUNDLE_GEMFILE="$PWD/Gemfile"
              export BUNDLE_PATH="$GEM_HOME"
              
              echo "Installing bundler..."
              gem install bundler --no-document
              
              echo "Setting bundler config..."
              bundle config set --local path "$GEM_HOME"
              bundle config build.nokogiri --use-system-libraries
              bundle config build.ffi --enable-system-libffi
              bundle config build.eventmachine --with-cflags="-I${pkgs.openssl.dev}/include"
              bundle config set force_ruby_platform true
              
              echo "Installing gems (this may take a while)..."
              BUNDLE_FORCE_RUBY_PLATFORM=1 RUBYOPT="-W0" bundle install
              
              # Restore environment
              export GEM_HOME="$old_gem_home"
              export GEM_PATH="$old_gem_path"
              export PATH="$old_path"
              export BUNDLE_GEMFILE="$old_bundle_gemfile"
              export BUNDLE_PATH="$old_bundle_path"
              
              cd "$current_dir"
            else
              # Only ensure gems are installed if version check passed
              ensure_gems_installed
            fi

            # Kill any running Jekyll processes in this directory only
            echo "Stopping any existing Jekyll servers in $(basename "$site_root")..."
            pkill -f "jekyll serve.*$site_root" || true
            
            # Give processes time to terminate
            sleep 1
            
            # Change to the site root
            cd "$site_root"
            echo "Serving from $(pwd) on port $port..."
            RUBYOPT="-W0" bundle exec jekyll serve --verbose --incremental --port $port
            
            # Return to the original directory
            cd "$current_dir"
          }

          # Function to clean and rebuild native extensions
          rebuild-gems() {
            echo "Rebuilding native gem extensions..."
            
            # Check for problematic gems
            for gem in json ffi nokogiri; do
              if [ -d "$GEM_HOME/gems/$gem"* ]; then
                gem_path=$(find "$GEM_HOME/gems" -name "$gem*" -type d | head -1)
                if [ -n "$gem_path" ]; then
                  echo "Rebuilding $gem extension..."
                  cd "$gem_path"
                  
                  # Clean the extension
                  if [ -f "ext/*/Makefile" ]; then
                    cd ext/*/ && make clean || true
                    cd ../../
                  fi
                  
                  # Rebuild with the correct library path
                  RUBYOPT="-W0" gem build *.gemspec && \
                  RUBYOPT="-W0" gem install *.gem --local --no-document
                fi
              fi
            done
            
            echo "Gem rebuild complete."
            cd "$OLDPWD"
          }

          # Function to completely reset and rebuild the Ruby environment
          reset-ruby-env() {
            echo "This will completely reset your Ruby environment."
            echo "Backing up your Gemfile and Gemfile.lock..."
            
            cp Gemfile Gemfile.backup
            if [ -f Gemfile.lock ]; then
              cp Gemfile.lock Gemfile.lock.backup
            fi
            
            echo "Removing .gem directory..."
            rm -rf .gem
            
            echo "Recreating Ruby environment..."
            export GEM_HOME=$PWD/.gem
            export GEM_PATH=$GEM_HOME
            export PATH=$GEM_HOME/bin:$PATH
            
            echo "Installing bundler..."
            gem install bundler --no-document
            
            echo "Setting bundler config..."
            bundle config set --local path "$GEM_HOME"
            bundle config build.nokogiri --use-system-libraries
            bundle config build.ffi --enable-system-libffi
            bundle config build.eventmachine --with-cflags="-I${pkgs.openssl.dev}/include"
            # Force native platform for all gems
            bundle config set force_ruby_platform true
            
            echo "Installing gems (this may take a while)..."
            BUNDLE_FORCE_RUBY_PLATFORM=1 RUBYOPT="-W0" bundle install
            
            echo "Ruby environment has been reset and rebuilt."
            echo "You can now try running 'jes' again."
          }

          # Function to stop any running Jekyll servers
          jes-stop() {
            echo "Stopping all Jekyll servers..."
            pkill -f "jekyll serve" || echo "No Jekyll servers found running."
            echo "Done."
          }
        '';

        # Interactive hook for the 'default' shell.
        # This provides welcome messages and automatically starts the server.
        interactiveHook = ''
          # Check if the Ruby environment is properly set up
          if [ ! -d .gem ] || [ ! -f .gem/bin/bundler ]; then
            echo "Ruby environment not found or incomplete. Setting up..."
            reset-ruby-env
          else
            echo "Jekyll and Rouge environments are ready."
            echo "Instructions:"
            echo "1. Run: bundle install (if needed)"
            echo "2. Run: jes (to start Jekyll server)"
            echo "3. Run: jes-stop (to stop any running Jekyll servers)"
            echo "4. If you encounter library errors, run: rebuild-gems"
            echo "5. If you still have issues, run: reset-ruby-env"
            echo "6. Generate Rouge styles: rougify style monokai.sublime > assets/css/syntax.css"
            echo ""
            echo "Note: Gems will now install into $GEM_HOME"
          fi
          
          # Automatically start Jekyll server
          echo ""
          echo "🚀 Starting Jekyll server automatically..."
          echo "Press Ctrl+C to stop the server and exit the environment."
          echo ""
          jes
        '';

        buildInputs = [
          pkgs.ruby                     # Ruby for Jekyll and Bundler
          pkgs.jekyll                   # Jekyll from Nixpkgs
          pkgs.rubyPackages_3_2.rouge   # Rouge (provides rougify)
          pkgs.neovim                   # Neovim for text editing
          pkgs.git                      # Git for version control
          pythonEnv                     # Use the Python environment defined above
          pkgs.stdenv.cc.cc.lib         # Add C++ standard library
          pkgs.pkg-config               # Add pkg-config for build dependencies
          pkgs.openssl                  # Add openssl for native gem compilation
          pkgs.zlib                     # Add zlib for nokogiri
          pkgs.libffi                   # Add libffi for ffi gem
          pkgs.libxml2                  # Add libxml2 for nokogiri
          pkgs.libxslt                  # Add libxslt for nokogiri
        ];

      in
      {
        # Define the development shells
        devShells = {
          # The default shell with interactive startup and auto-server start
          default = pkgs.mkShell {
            inherit buildInputs;
            shellHook = ''
              ${commonHook}
              ${interactiveHook}
            '';
          };

          # A quiet shell for scripting or manual server startup
          quiet = pkgs.mkShell {
            inherit buildInputs;
            shellHook = ''
              ${commonHook}
              echo "Jekyll environment ready (quiet mode)."
              echo "Run 'jes' to start the server manually."
            '';
          };
        };
      });
}
```

**Me**: And as is my habit now after every instance of an AI giving me
generative edits, I like to make the `git diff` output gloriously clear so I can
extremely easily see what it did in review and have it and other AIs check its
work, especially if there's been generative drift and regression about which I
am totally on-guard all the time now.

```diff
[mike@nixos:~/repos/MikeLev.in]$ git --no-pager diff
diff --git a/flake.nix b/flake.nix
index 7a478b423..64a887c6c 100644
--- a/flake.nix
+++ b/flake.nix
@@ -89,266 +89,202 @@
         # Python environment with required packages
         pythonEnv = pkgs.python3.withPackages (ps: with ps; [
           requests
-          simplenote
+          tiktoken
           # Add other Python packages needed for your project here
         ]);
-      in
-      {
-        # Define the development shell with all necessary dependencies
-        devShells.default = pkgs.mkShell {
-          # Include necessary packages in the PATH
-          buildInputs = [
-            pkgs.ruby                       # Ruby for Jekyll and Bundler
-            pkgs.jekyll                     # Jekyll from Nixpkgs
-            pkgs.rubyPackages_3_2.rouge     # Rouge (provides rougify)
-            pkgs.neovim                     # Neovim for text editing
-            pkgs.git                        # Git for version control
-            pythonEnv                       # Use the Python environment defined above
-            pkgs.stdenv.cc.cc.lib          # Add C++ standard library
-            pkgs.pkg-config                 # Add pkg-config for build dependencies
-            pkgs.openssl                    # Add openssl for native gem compilation
-            pkgs.zlib                       # Add zlib for nokogiri
-            pkgs.libffi                     # Add libffi for ffi gem
-            pkgs.libxml2                    # Add libxml2 for nokogiri
-            pkgs.libxslt                    # Add libxslt for nokogiri
-          ];
 
-          # Set environment variables and define helper functions
-          shellHook = ''
-            # Set up Ruby environment variables
-            export GEM_HOME=$PWD/.gem
-            export GEM_PATH=$GEM_HOME
-            export PATH=$GEM_HOME/bin:$PATH
-            
-            # Force native gem compilation
-            export BUNDLE_FORCE_RUBY_PLATFORM=1
-            
-            # Set up library paths for native extensions
-            export LD_LIBRARY_PATH="${pkgs.ruby}/lib:${pkgs.stdenv.cc.cc.lib}/lib:$LD_LIBRARY_PATH"
-            export LD_LIBRARY_PATH="${pkgs.libffi}/lib:$LD_LIBRARY_PATH"
-            export LD_LIBRARY_PATH="${pkgs.zlib}/lib:$LD_LIBRARY_PATH"
-            export LD_LIBRARY_PATH="${pkgs.libxml2}/lib:$LD_LIBRARY_PATH"
-            export LD_LIBRARY_PATH="${pkgs.libxslt}/lib:$LD_LIBRARY_PATH"
-            
-            # Configure pkg-config paths for build dependencies
-            export PKG_CONFIG_PATH="${pkgs.zlib.dev}/lib/pkgconfig:$PKG_CONFIG_PATH"
-            export PKG_CONFIG_PATH="${pkgs.libffi.dev}/lib/pkgconfig:$PKG_CONFIG_PATH"
-            export PKG_CONFIG_PATH="${pkgs.libxml2.dev}/lib/pkgconfig:$PKG_CONFIG_PATH"
-            export PKG_CONFIG_PATH="${pkgs.libxslt.dev}/lib/pkgconfig:$PKG_CONFIG_PATH"
-            
-            # Install bundler if not present
-            if ! gem list -i bundler > /dev/null 2>&1; then
-              echo "Installing bundler..."
-              gem install bundler --no-document
-            fi
+        # Common hook for setting up the environment, variables, and functions.
+        # This is used by both the 'default' and 'quiet' shells.
+        commonHook = ''
+          # Set up Ruby environment variables
+          export GEM_HOME=$PWD/.gem
+          export GEM_PATH=$GEM_HOME
+          export PATH=$GEM_HOME/bin:$PATH
+          
+          # Force native gem compilation
+          export BUNDLE_FORCE_RUBY_PLATFORM=1
+          
+          # Set up library paths for native extensions
+          export LD_LIBRARY_PATH="${pkgs.ruby}/lib:${pkgs.stdenv.cc.cc.lib}/lib:$LD_LIBRARY_PATH"
+          export LD_LIBRARY_PATH="${pkgs.libffi}/lib:$LD_LIBRARY_PATH"
+          export LD_LIBRARY_PATH="${pkgs.zlib}/lib:$LD_LIBRARY_PATH"
+          export LD_LIBRARY_PATH="${pkgs.libxml2}/lib:$LD_LIBRARY_PATH"
+          export LD_LIBRARY_PATH="${pkgs.libxslt}/lib:$LD_LIBRARY_PATH"
+          
+          # Configure pkg-config paths for build dependencies
+          export PKG_CONFIG_PATH="${pkgs.zlib.dev}/lib/pkgconfig:$PKG_CONFIG_PATH"
+          export PKG_CONFIG_PATH="${pkgs.libffi.dev}/lib/pkgconfig:$PKG_CONFIG_PATH"
+          export PKG_CONFIG_PATH="${pkgs.libxml2.dev}/lib/pkgconfig:$PKG_CONFIG_PATH"
+          export PKG_CONFIG_PATH="${pkgs.libxslt.dev}/lib/pkgconfig:$PKG_CONFIG_PATH"
+          
+          # Install bundler if not present
+          if ! gem list -i bundler > /dev/null 2>&1; then
+            echo "Installing bundler..."
+            gem install bundler --no-document
+          fi
 
-            # Configure bundler for local gem installation
-            bundle config set --local path "$GEM_HOME"
-            
-            # Set build options for problematic native extensions
-            bundle config build.nokogiri --use-system-libraries
-            bundle config build.ffi --enable-system-libffi
-            bundle config build.eventmachine --with-cflags="-I${pkgs.openssl.dev}/include"
-            bundle config set force_ruby_platform true
+          # Configure bundler for local gem installation
+          bundle config set --local path "$GEM_HOME"
+          
+          # Set build options for problematic native extensions
+          bundle config build.nokogiri --use-system-libraries
+          bundle config build.ffi --enable-system-libffi
+          bundle config build.eventmachine --with-cflags="-I${pkgs.openssl.dev}/include"
+          bundle config set force_ruby_platform true
+
+          # Additional build configuration
+          export BUNDLE_BUILD__EVENTMACHINE="--with-cflags=-I${pkgs.openssl.dev}/include"
+          export PKG_CONFIG_PATH="${pkgs.openssl.dev}/lib/pkgconfig:$PKG_CONFIG_PATH"
+          
+          # macOS-specific Neovim configuration
+          if [ "$(uname)" = "Darwin" ]; then
+            echo "Detected macOS. Setting up Neovim configuration."
+            CONFIG_DIR="$HOME/Library/Application Support/nvim"
+            INIT_LUA_SOURCE="$HOME/repos/nixos/init.lua"
+            INIT_LUA_TARGET="$CONFIG_DIR/init.lua"
+
+            mkdir -p "$CONFIG_DIR"
+            ln -sf "$INIT_LUA_SOURCE" "$INIT_LUA_TARGET"
+            echo "Symlink created: $INIT_LUA_TARGET -> $INIT_LUA_SOURCE"
+          else
+            echo "Linux detected. Skipping Neovim setup as it's not needed."
+          fi
+
+          # Alias vim to nvim
+          alias vim=nvim
 
-            # Additional build configuration
-            export BUNDLE_BUILD__EVENTMACHINE="--with-cflags=-I${pkgs.openssl.dev}/include"
-            export PKG_CONFIG_PATH="${pkgs.openssl.dev}/lib/pkgconfig:$PKG_CONFIG_PATH"
+          # Jekyll serve function with automatic environment checks
+          jes() {
+            echo "Jekyll Environment Script v1.0.6"
             
-            # macOS-specific Neovim configuration
-            if [ "$(uname)" = "Darwin" ]; then
-              echo "Detected macOS. Setting up Neovim configuration."
-              CONFIG_DIR="$HOME/Library/Application Support/nvim"
-              INIT_LUA_SOURCE="$HOME/repos/nixos/init.lua"
-              INIT_LUA_TARGET="$CONFIG_DIR/init.lua"
+            # Store the current directory
+            current_dir=$(pwd)
+            
+            # Find the Jekyll root (where Gemfile exists)
+            site_root="$current_dir"
+            while [[ "$site_root" != "/" && ! -f "$site_root/Gemfile" ]]; do
+              site_root="$(dirname "$site_root")"
+            done
 
-              mkdir -p "$CONFIG_DIR"
-              ln -sf "$INIT_LUA_SOURCE" "$INIT_LUA_TARGET"
-              echo "Symlink created: $INIT_LUA_TARGET -> $INIT_LUA_SOURCE"
-            else
-              echo "Linux detected. Skipping Neovim setup as it's not needed."
+            if [[ ! -f "$site_root/Gemfile" ]]; then
+              echo "Error: Could not find Gemfile. Are you in a Jekyll site directory?"
+              return 1
             fi
 
-            # Alias vim to nvim
-            alias vim=nvim
+            # Read port from .port file or use default
+            if [ -f "$site_root/.port" ]; then
+              port=$(cat "$site_root/.port")
+              echo "Using port $port from .port file"
+            else
+              port=4000
+              echo "No .port file found, using default port $port"
+            fi
 
-            # Jekyll serve function with automatic environment checks
-            jes() {
-              echo "Jekyll Environment Script v1.0.6"
+            # Function to check for Ruby version mismatch
+            check_ruby_version() {
+              echo "Checking Ruby environment..."
               
-              # Store the current directory
-              current_dir=$(pwd)
+              # Save current environment
+              local old_gem_home="$GEM_HOME"
+              local old_gem_path="$GEM_PATH"
+              local old_path="$PATH"
+              local old_bundle_gemfile="$BUNDLE_GEMFILE"
+              local old_bundle_path="$BUNDLE_PATH"
               
-              # Find the Jekyll root (where Gemfile exists)
-              site_root="$current_dir"
-              while [[ "$site_root" != "/" && ! -f "$site_root/Gemfile" ]]; do
-                site_root="$(dirname "$site_root")"
-              done
-
-              if [[ ! -f "$site_root/Gemfile" ]]; then
-                echo "Error: Could not find Gemfile. Are you in a Jekyll site directory?"
+              # Set environment for checks
+              export GEM_HOME="$site_root/.gem"
+              export GEM_PATH="$GEM_HOME"
+              export PATH="$GEM_HOME/bin:$PATH"
+              export BUNDLE_GEMFILE="$site_root/Gemfile"
+              export BUNDLE_PATH="$GEM_HOME"
+              
+              # First check if jekyll binary exists
+              if [ ! -f "$site_root/.gem/ruby/3.3.0/bin/jekyll" ]; then
+                echo "Jekyll binary not found. Will need to install gems."
                 return 1
               fi
-
-              # Read port from .port file or use default
-              if [ -f "$site_root/.port" ]; then
-                port=$(cat "$site_root/.port")
-                echo "Using port $port from .port file"
-              else
-                port=4000
-                echo "No .port file found, using default port $port"
-              fi
-
-              # Function to check for Ruby version mismatch
-              check_ruby_version() {
-                echo "Checking Ruby environment..."
-                
-                # Save current environment
-                local old_gem_home="$GEM_HOME"
-                local old_gem_path="$GEM_PATH"
-                local old_path="$PATH"
-                local old_bundle_gemfile="$BUNDLE_GEMFILE"
-                local old_bundle_path="$BUNDLE_PATH"
-                
-                # Set environment for checks
-                export GEM_HOME="$site_root/.gem"
-                export GEM_PATH="$GEM_HOME"
-                export PATH="$GEM_HOME/bin:$PATH"
-                export BUNDLE_GEMFILE="$site_root/Gemfile"
-                export BUNDLE_PATH="$GEM_HOME"
+              
+              # Try to run jekyll with --version and capture both stdout and stderr
+              local jekyll_output
+              jekyll_output=$(cd "$site_root" && bundle exec jekyll --version 2>&1)
+              local jekyll_status=$?
+              
+              if [ $jekyll_status -ne 0 ]; then
+                echo "Jekyll binary check failed with status $jekyll_status"
+                echo "Error output: $jekyll_output"
                 
-                # First check if jekyll binary exists
-                if [ ! -f "$site_root/.gem/ruby/3.3.0/bin/jekyll" ]; then
-                  echo "Jekyll binary not found. Will need to install gems."
+                if echo "$jekyll_output" | grep -q "incompatible library version"; then
+                  echo "Detected Ruby version mismatch. Rebuilding gems..."
+                  rm -rf "$site_root/.gem"
                   return 1
-                fi
-                
-                # Try to run jekyll with --version and capture both stdout and stderr
-                local jekyll_output
-                jekyll_output=$(cd "$site_root" && bundle exec jekyll --version 2>&1)
-                local jekyll_status=$?
-                
-                if [ $jekyll_status -ne 0 ]; then
-                  echo "Jekyll binary check failed with status $jekyll_status"
-                  echo "Error output: $jekyll_output"
-                  
-                  if echo "$jekyll_output" | grep -q "incompatible library version"; then
-                    echo "Detected Ruby version mismatch. Rebuilding gems..."
-                    rm -rf "$site_root/.gem"
-                    return 1
-                  else
-                    echo "Unknown Jekyll error. Rebuilding gems..."
-                    rm -rf "$site_root/.gem"
-                    return 1
-                  fi
-                fi
-                
-                # Check for specific Ruby version mismatch in ffi_c.so
-                if [ -f "$site_root/.gem/ruby/3.3.0/gems/ffi-1.17.1/lib/ffi_c.so" ]; then
-                  local ffi_libs
-                  ffi_libs=$(ldd "$site_root/.gem/ruby/3.3.0/gems/ffi-1.17.1/lib/ffi_c.so" 2>&1)
-                  if echo "$ffi_libs" | grep -q "libruby-3.3.7"; then
-                    echo "Detected Ruby 3.3.7 vs 3.3.8 mismatch in ffi_c.so. Rebuilding ffi gem..."
-                    rm -rf "$site_root/.gem/ruby/3.3.0/gems/ffi-1.17.1"
-                    rm -rf "$site_root/.gem/ruby/3.3.0/specifications/ffi-1.17.1.gemspec"
-                    return 1
-                  fi
-                fi
-
-                # Check if bundle check passes
-                local bundle_output
-                bundle_output=$(cd "$site_root" && bundle check 2>&1)
-                local bundle_status=$?
-                
-                if [ $bundle_status -ne 0 ]; then
-                  echo "Bundle check failed with status $bundle_status"
-                  echo "Error output: $bundle_output"
-                  echo "Rebuilding gems..."
+                else
+                  echo "Unknown Jekyll error. Rebuilding gems..."
                   rm -rf "$site_root/.gem"
                   return 1
                 fi
+              fi
+              
+              # Check for specific Ruby version mismatch in ffi_c.so
+              if [ -f "$site_root/.gem/ruby/3.3.0/gems/ffi-1.17.1/lib/ffi_c.so" ]; then
+                local ffi_libs
+                ffi_libs=$(ldd "$site_root/.gem/ruby/3.3.0/gems/ffi-1.17.1/lib/ffi_c.so" 2>&1)
+                if echo "$ffi_libs" | grep -q "libruby-3.3.7"; then
+                  echo "Detected Ruby 3.3.7 vs 3.3.8 mismatch in ffi_c.so. Rebuilding ffi gem..."
+                  rm -rf "$site_root/.gem/ruby/3.3.0/gems/ffi-1.17.1"
+                  rm -rf "$site_root/.gem/ruby/3.3.0/specifications/ffi-1.17.1.gemspec"
+                  return 1
+                fi
+              fi
 
-                # Restore environment
-                export GEM_HOME="$old_gem_home"
-                export GEM_PATH="$old_gem_path"
-                export PATH="$old_path"
-                export BUNDLE_GEMFILE="$old_bundle_gemfile"
-                export BUNDLE_PATH="$old_bundle_path"
-                
-                echo "Ruby environment check passed."
-                return 0
-              }
+              # Check if bundle check passes
+              local bundle_output
+              bundle_output=$(cd "$site_root" && bundle check 2>&1)
+              local bundle_status=$?
+              
+              if [ $bundle_status -ne 0 ]; then
+                echo "Bundle check failed with status $bundle_status"
+                echo "Error output: $bundle_output"
+                echo "Rebuilding gems..."
+                rm -rf "$site_root/.gem"
+                return 1
+              fi
 
-              # Function to ensure gems are installed
-              ensure_gems_installed() {
-                cd "$site_root"
-                
-                # Save current environment
-                local old_gem_home="$GEM_HOME"
-                local old_gem_path="$GEM_PATH"
-                local old_path="$PATH"
-                local old_bundle_gemfile="$BUNDLE_GEMFILE"
-                local old_bundle_path="$BUNDLE_PATH"
-                
-                # Set environment for bundle
-                export GEM_HOME="$PWD/.gem"
-                export GEM_PATH="$GEM_HOME"
-                export PATH="$GEM_HOME/bin:$PATH"
-                export BUNDLE_GEMFILE="$PWD/Gemfile"
-                export BUNDLE_PATH="$GEM_HOME"
-                
-                local bundle_output
-                bundle_output=$(bundle check 2>&1)
-                local bundle_status=$?
-                
-                if [ $bundle_status -ne 0 ]; then
-                  echo "Missing gems detected. Installing..."
-                  echo "Error output: $bundle_output"
-                  
-                  echo "Installing bundler..."
-                  gem install bundler --no-document
-                  
-                  echo "Setting bundler config..."
-                  bundle config set --local path "$GEM_HOME"
-                  bundle config build.nokogiri --use-system-libraries
-                  bundle config build.ffi --enable-system-libffi
-                  bundle config build.eventmachine --with-cflags="-I${pkgs.openssl.dev}/include"
-                  bundle config set force_ruby_platform true
-                  
-                  echo "Installing gems (this may take a while)..."
-                  BUNDLE_FORCE_RUBY_PLATFORM=1 RUBYOPT="-W0" bundle install
-                else
-                  echo "All gems are already installed."
-                fi
-                
-                # Restore environment
-                export GEM_HOME="$old_gem_home"
-                export GEM_PATH="$old_gem_path"
-                export PATH="$old_path"
-                export BUNDLE_GEMFILE="$old_bundle_gemfile"
-                export BUNDLE_PATH="$old_bundle_path"
-                
-                cd "$current_dir"
-              }
+              # Restore environment
+              export GEM_HOME="$old_gem_home"
+              export GEM_PATH="$old_gem_path"
+              export PATH="$old_path"
+              export BUNDLE_GEMFILE="$old_bundle_gemfile"
+              export BUNDLE_PATH="$old_bundle_path"
+              
+              echo "Ruby environment check passed."
+              return 0
+            }
 
-              # Check for Ruby version mismatch and rebuild if needed
-              if ! check_ruby_version; then
-                echo "Rebuilding Ruby environment..."
-                cd "$site_root"
-                
-                # Save current environment
-                local old_gem_home="$GEM_HOME"
-                local old_gem_path="$GEM_PATH"
-                local old_path="$PATH"
-                local old_bundle_gemfile="$BUNDLE_GEMFILE"
-                local old_bundle_path="$BUNDLE_PATH"
-                
-                # Set environment for rebuild
-                export GEM_HOME="$PWD/.gem"
-                export GEM_PATH="$GEM_HOME"
-                export PATH="$GEM_HOME/bin:$PATH"
-                export BUNDLE_GEMFILE="$PWD/Gemfile"
-                export BUNDLE_PATH="$GEM_HOME"
+            # Function to ensure gems are installed
+            ensure_gems_installed() {
+              cd "$site_root"
+              
+              # Save current environment
+              local old_gem_home="$GEM_HOME"
+              local old_gem_path="$GEM_PATH"
+              local old_path="$PATH"
+              local old_bundle_gemfile="$BUNDLE_GEMFILE"
+              local old_bundle_path="$BUNDLE_PATH"
+              
+              # Set environment for bundle
+              export GEM_HOME="$PWD/.gem"
+              export GEM_PATH="$GEM_HOME"
+              export PATH="$GEM_HOME/bin:$PATH"
+              export BUNDLE_GEMFILE="$PWD/Gemfile"
+              export BUNDLE_PATH="$GEM_HOME"
+              
+              local bundle_output
+              bundle_output=$(bundle check 2>&1)
+              local bundle_status=$?
+              
+              if [ $bundle_status -ne 0 ]; then
+                echo "Missing gems detected. Installing..."
+                echo "Error output: $bundle_output"
                 
                 echo "Installing bundler..."
                 gem install bundler --no-document
@@ -362,82 +298,38 @@
                 
                 echo "Installing gems (this may take a while)..."
                 BUNDLE_FORCE_RUBY_PLATFORM=1 RUBYOPT="-W0" bundle install
-                
-                # Restore environment
-                export GEM_HOME="$old_gem_home"
-                export GEM_PATH="$old_gem_path"
-                export PATH="$old_path"
-                export BUNDLE_GEMFILE="$old_bundle_gemfile"
-                export BUNDLE_PATH="$old_bundle_path"
-                
-                cd "$current_dir"
               else
-                # Only ensure gems are installed if version check passed
-                ensure_gems_installed
+                echo "All gems are already installed."
               fi
-
-              # Kill any running Jekyll processes in this directory only
-              echo "Stopping any existing Jekyll servers in $(basename "$site_root")..."
-              pkill -f "jekyll serve.*$site_root" || true
-              
-              # Give processes time to terminate
-              sleep 1
               
-              # Change to the site root
-              cd "$site_root"
-              echo "Serving from $(pwd) on port $port..."
-              RUBYOPT="-W0" bundle exec jekyll serve --verbose --incremental --port $port
+              # Restore environment
+              export GEM_HOME="$old_gem_home"
+              export GEM_PATH="$old_gem_path"
+              export PATH="$old_path"
+              export BUNDLE_GEMFILE="$old_bundle_gemfile"
+              export BUNDLE_PATH="$old_bundle_path"
               
-              # Return to the original directory
               cd "$current_dir"
             }
 
-            # Function to clean and rebuild native extensions
-            rebuild-gems() {
-              echo "Rebuilding native gem extensions..."
-              
-              # Check for problematic gems
-              for gem in json ffi nokogiri; do
-                if [ -d "$GEM_HOME/gems/$gem"* ]; then
-                  gem_path=$(find "$GEM_HOME/gems" -name "$gem*" -type d | head -1)
-                  if [ -n "$gem_path" ]; then
-                    echo "Rebuilding $gem extension..."
-                    cd "$gem_path"
-                    
-                    # Clean the extension
-                    if [ -f "ext/*/Makefile" ]; then
-                      cd ext/*/ && make clean || true
-                      cd ../../
-                    fi
-                    
-                    # Rebuild with the correct library path
-                    RUBYOPT="-W0" gem build *.gemspec && \
-                    RUBYOPT="-W0" gem install *.gem --local --no-document
-                  fi
-                fi
-              done
-              
-              echo "Gem rebuild complete."
-              cd "$OLDPWD"
-            }
-
-            # Function to completely reset and rebuild the Ruby environment
-            reset-ruby-env() {
-              echo "This will completely reset your Ruby environment."
-              echo "Backing up your Gemfile and Gemfile.lock..."
-              
-              cp Gemfile Gemfile.backup
-              if [ -f Gemfile.lock ]; then
-                cp Gemfile.lock Gemfile.lock.backup
-              fi
+            # Check for Ruby version mismatch and rebuild if needed
+            if ! check_ruby_version; then
+              echo "Rebuilding Ruby environment..."
+              cd "$site_root"
               
-              echo "Removing .gem directory..."
-              rm -rf .gem
+              # Save current environment
+              local old_gem_home="$GEM_HOME"
+              local old_gem_path="$GEM_PATH"
+              local old_path="$PATH"
+              local old_bundle_gemfile="$BUNDLE_GEMFILE"
+              local old_bundle_path="$BUNDLE_PATH"
               
-              echo "Recreating Ruby environment..."
-              export GEM_HOME=$PWD/.gem
-              export GEM_PATH=$GEM_HOME
-              export PATH=$GEM_HOME/bin:$PATH
+              # Set environment for rebuild
+              export GEM_HOME="$PWD/.gem"
+              export GEM_PATH="$GEM_HOME"
+              export PATH="$GEM_HOME/bin:$PATH"
+              export BUNDLE_GEMFILE="$PWD/Gemfile"
+              export BUNDLE_PATH="$GEM_HOME"
               
               echo "Installing bundler..."
               gem install bundler --no-document
@@ -447,47 +339,179 @@
               bundle config build.nokogiri --use-system-libraries
               bundle config build.ffi --enable-system-libffi
               bundle config build.eventmachine --with-cflags="-I${pkgs.openssl.dev}/include"
-              # Force native platform for all gems
               bundle config set force_ruby_platform true
               
               echo "Installing gems (this may take a while)..."
               BUNDLE_FORCE_RUBY_PLATFORM=1 RUBYOPT="-W0" bundle install
               
-              echo "Ruby environment has been reset and rebuilt."
-              echo "You can now try running 'jes' again."
-            }
+              # Restore environment
+              export GEM_HOME="$old_gem_home"
+              export GEM_PATH="$old_gem_path"
+              export PATH="$old_path"
+              export BUNDLE_GEMFILE="$old_bundle_gemfile"
+              export BUNDLE_PATH="$old_bundle_path"
+              
+              cd "$current_dir"
+            else
+              # Only ensure gems are installed if version check passed
+              ensure_gems_installed
+            fi
 
-            # Function to stop any running Jekyll servers
-            jes-stop() {
-              echo "Stopping all Jekyll servers..."
-              pkill -f "jekyll serve" || echo "No Jekyll servers found running."
-              echo "Done."
-            }
+            # Kill any running Jekyll processes in this directory only
+            echo "Stopping any existing Jekyll servers in $(basename "$site_root")..."
+            pkill -f "jekyll serve.*$site_root" || true
+            
+            # Give processes time to terminate
+            sleep 1
+            
+            # Change to the site root
+            cd "$site_root"
+            echo "Serving from $(pwd) on port $port..."
+            RUBYOPT="-W0" bundle exec jekyll serve --verbose --incremental --port $port
+            
+            # Return to the original directory
+            cd "$current_dir"
+          }
 
-            # Check if the Ruby environment is properly set up
-            if [ ! -d .gem ] || [ ! -f .gem/bin/bundler ]; then
-              echo "Ruby environment not found or incomplete. Setting up..."
-              reset-ruby-env
-            else
-              echo "Jekyll and Rouge environments are ready."
-              echo "Instructions:"
-              echo "1. Run: bundle install (if needed)"
-              echo "2. Run: jes (to start Jekyll server)"
-              echo "3. Run: jes-stop (to stop any running Jekyll servers)"
-              echo "4. If you encounter library errors, run: rebuild-gems"
-              echo "5. If you still have issues, run: reset-ruby-env"
-              echo "6. Generate Rouge styles: rougify style monokai.sublime > assets/css/syntax.css"
-              echo ""
-              echo "Note: Gems will now install into $GEM_HOME"
+          # Function to clean and rebuild native extensions
+          rebuild-gems() {
+            echo "Rebuilding native gem extensions..."
+            
+            # Check for problematic gems
+            for gem in json ffi nokogiri; do
+              if [ -d "$GEM_HOME/gems/$gem"* ]; then
+                gem_path=$(find "$GEM_HOME/gems" -name "$gem*" -type d | head -1)
+                if [ -n "$gem_path" ]; then
+                  echo "Rebuilding $gem extension..."
+                  cd "$gem_path"
+                  
+                  # Clean the extension
+                  if [ -f "ext/*/Makefile" ]; then
+                    cd ext/*/ && make clean || true
+                    cd ../../
+                  fi
+                  
+                  # Rebuild with the correct library path
+                  RUBYOPT="-W0" gem build *.gemspec && \
+                  RUBYOPT="-W0" gem install *.gem --local --no-document
+                fi
+              fi
+            done
+            
+            echo "Gem rebuild complete."
+            cd "$OLDPWD"
+          }
+
+          # Function to completely reset and rebuild the Ruby environment
+          reset-ruby-env() {
+            echo "This will completely reset your Ruby environment."
+            echo "Backing up your Gemfile and Gemfile.lock..."
+            
+            cp Gemfile Gemfile.backup
+            if [ -f Gemfile.lock ]; then
+              cp Gemfile.lock Gemfile.lock.backup
             fi
             
-            # Automatically start Jekyll server
-            echo ""
-            echo "🚀 Starting Jekyll server automatically..."
-            echo "Press Ctrl+C to stop the server and exit the environment."
+            echo "Removing .gem directory..."
+            rm -rf .gem
+            
+            echo "Recreating Ruby environment..."
+            export GEM_HOME=$PWD/.gem
+            export GEM_PATH=$GEM_HOME
+            export PATH=$GEM_HOME/bin:$PATH
+            
+            echo "Installing bundler..."
+            gem install bundler --no-document
+            
+            echo "Setting bundler config..."
+            bundle config set --local path "$GEM_HOME"
+            bundle config build.nokogiri --use-system-libraries
+            bundle config build.ffi --enable-system-libffi
+            bundle config build.eventmachine --with-cflags="-I${pkgs.openssl.dev}/include"
+            # Force native platform for all gems
+            bundle config set force_ruby_platform true
+            
+            echo "Installing gems (this may take a while)..."
+            BUNDLE_FORCE_RUBY_PLATFORM=1 RUBYOPT="-W0" bundle install
+            
+            echo "Ruby environment has been reset and rebuilt."
+            echo "You can now try running 'jes' again."
+          }
+
+          # Function to stop any running Jekyll servers
+          jes-stop() {
+            echo "Stopping all Jekyll servers..."
+            pkill -f "jekyll serve" || echo "No Jekyll servers found running."
+            echo "Done."
+          }
+        '';
+
+        # Interactive hook for the 'default' shell.
+        # This provides welcome messages and automatically starts the server.
+        interactiveHook = ''
+          # Check if the Ruby environment is properly set up
+          if [ ! -d .gem ] || [ ! -f .gem/bin/bundler ]; then
+            echo "Ruby environment not found or incomplete. Setting up..."
+            reset-ruby-env
+          else
+            echo "Jekyll and Rouge environments are ready."
+            echo "Instructions:"
+            echo "1. Run: bundle install (if needed)"
+            echo "2. Run: jes (to start Jekyll server)"
+            echo "3. Run: jes-stop (to stop any running Jekyll servers)"
+            echo "4. If you encounter library errors, run: rebuild-gems"
+            echo "5. If you still have issues, run: reset-ruby-env"
+            echo "6. Generate Rouge styles: rougify style monokai.sublime > assets/css/syntax.css"
             echo ""
-            jes
-          '';
+            echo "Note: Gems will now install into $GEM_HOME"
+          fi
+          
+          # Automatically start Jekyll server
+          echo ""
+          echo "🚀 Starting Jekyll server automatically..."
+          echo "Press Ctrl+C to stop the server and exit the environment."
+          echo ""
+          jes
+        '';
+
+        buildInputs = [
+          pkgs.ruby                     # Ruby for Jekyll and Bundler
+          pkgs.jekyll                   # Jekyll from Nixpkgs
+          pkgs.rubyPackages_3_2.rouge   # Rouge (provides rougify)
+          pkgs.neovim                   # Neovim for text editing
+          pkgs.git                      # Git for version control
+          pythonEnv                     # Use the Python environment defined above
+          pkgs.stdenv.cc.cc.lib         # Add C++ standard library
+          pkgs.pkg-config               # Add pkg-config for build dependencies
+          pkgs.openssl                  # Add openssl for native gem compilation
+          pkgs.zlib                     # Add zlib for nokogiri
+          pkgs.libffi                   # Add libffi for ffi gem
+          pkgs.libxml2                  # Add libxml2 for nokogiri
+          pkgs.libxslt                  # Add libxslt for nokogiri
+        ];
+
+      in
+      {
+        # Define the development shells
+        devShells = {
+          # The default shell with interactive startup and auto-server start
+          default = pkgs.mkShell {
+            inherit buildInputs;
+            shellHook = ''
+              ${commonHook}
+              ${interactiveHook}
+            '';
+          };
+
+          # A quiet shell for scripting or manual server startup
+          quiet = pkgs.mkShell {
+            inherit buildInputs;
+            shellHook = ''
+              ${commonHook}
+              echo "Jekyll environment ready (quiet mode)."
+              echo "Run 'jes' to start the server manually."
+            '';
+          };
         };
       });
-}
+}
\ No newline at end of file

[mike@nixos:~/repos/MikeLev.in]$
```

But the proof is in the running.

```bash
[mike@nixos:~/repos/MikeLev.in]$ git commit -am "Added quiet mode"
[main 7cbc93607] Added quiet mode
 1 file changed, 361 insertions(+), 337 deletions(-)

[mike@nixos:~/repos/MikeLev.in]$ git push
Enumerating objects: 5, done.
Counting objects: 100% (5/5), done.
Delta compression using up to 48 threads
Compressing objects: 100% (3/3), done.
Writing objects: 100% (3/3), 2.03 KiB | 2.03 MiB/s, done.
Total 3 (delta 2), reused 0 (delta 0), pack-reused 0 (from 0)
remote: Resolving deltas: 100% (2/2), completed with 2 local objects.
To github.com:miklevin/MikeLev.in
   7faebefa7..7cbc93607  main -> main

[mike@nixos:~/repos/MikeLev.in]$ nix develop .#quiet
Linux detected. Skipping Neovim setup as it's not needed.
Jekyll environment ready (quiet mode).
Run 'jes' to start the server manually.

[mike@nixos:~/repos/MikeLev.in]$ cd _posts/

[mike@nixos:~/repos/MikeLev.in/_posts]$ python list_articles.py 
Traceback (most recent call last):
  File "/home/mike/repos/MikeLev.in/_posts/list_articles.py", line 5, in <module>
    import yaml
ModuleNotFoundError: No module named 'yaml'

[mike@nixos:~/repos/MikeLev.in/_posts]$ cd ..

[mike@nixos:~/repos/MikeLev.in]$ vim flake.nix 

[mike@nixos:~/repos/MikeLev.in]$ exit
exit

## A Wild Bug Appears: The ModuleNotFoundError
```

Whoops. I had to add `pyyaml` to the flake:

```diff
[mike@nixos:~/repos/MikeLev.in/_posts]$ git --no-pager diff
diff --git a/flake.nix b/flake.nix
index 64a887c6c..beca2aa74 100644
--- a/flake.nix
+++ b/flake.nix
@@ -90,6 +90,7 @@
         pythonEnv = pkgs.python3.withPackages (ps: with ps; [
           requests
           tiktoken
+          pyyaml
           # Add other Python packages needed for your project here
         ]);
 
@@ -514,4 +515,4 @@
           };
         };
       });
-}
\ No newline at end of file
+}
```

And one more `nix develop .#quiet` to activate the new flake terminal
environment. And now back to the regularly scheduled `nix develop .#quiet` mode testing:

## The One-Line Fix: Declarative Dependencies

```bash
[mike@nixos:~/repos/MikeLev.in/_posts]$ python list_articles.py -t -m
Posts in reverse chronological (newest first) order:
Calculating token counts for all files, this may take a moment...

/home/mike/repos/MikeLev.in/_posts/2025-10-08-python-refactoring-colocation-over-abstraction.md  # 12,315 tokens (12,315 / 6,683,066 total)
  └─ A practical case study on improving developer experience (DX) by refactoring Python code to co-locate tightly coupled data and presentation logic.
/home/mike/repos/MikeLev.in/_posts/2025-10-08-python-mac-segfault-faulthandler-revelation.md  # 21,592 tokens (33,907 / 6,670,751 total)
  └─ A deep dive into a multi-day debugging session of a Python 'Segmentation fault: 11' on macOS, revealing how the faulthandler module uncovered the true culprit.
/home/mike/repos/MikeLev.in/_posts/2025-10-08-forging-jupyter-master-template-dependency-hell.md  # 65,593 tokens (99,500 / 6,649,159 total)
  └─ Follow the real-world journey of creating a master Jupyter workflow, from the 'AI Sanitation Engineer' concept to battling Nix flakes and Python dependency hell.
/home/mike/repos/MikeLev.in/_posts/2025-10-08-ai-vs-ai-debugging-saga.md  # 55,903 tokens (155,403 / 6,583,566 total)
  └─ Follow a developer's journey as two AIs collaborate to debug a Python `BlockingIOError`, blending technical fixes with philosophical debate and a successful release.
/home/mike/repos/MikeLev.in/_posts/2025-10-08-ai-assisted-debugging-git-archeology.md  # 19,938 tokens (175,341 / 6,527,663 total)
  └─ A developer's journal entry on fixing Python bugs with AI, refactoring a release script, and using git commands to recover a deleted file.
/home/mike/repos/MikeLev.in/_posts/2025-10-07-macos-nix-debugging-segfault-to-afplay.md  # 13,192 tokens (188,533 / 6,507,725 total)
  └─ A deep dive into a multi-layered debugging session on macOS, tracing a Python bug from a `Segmentation fault` to a platform-specific audio command.
/home/mike/repos/MikeLev.in/_posts/2025-10-07-macos-debugging-saga-segfaults-ghosts.md  # 59,547 tokens (248,080 / 6,494,533 total)
  └─ Follow a detailed debugging session to fix a persistent Segmentation fault on macOS with Nix and Python, revealing a cascade of platform-specific issues.
/home/mike/repos/MikeLev.in/_posts/2025-10-07-disposable-gods-personalized-loops.md  # 9,898 tokens (257,978 / 6,434,986 total)
  └─ An exploration of AI interaction, from creative process metaphors to the essential strategy of using massive, surgical context-drops to personalize stateless LLMs.
/home/mike/repos/MikeLev.in/_posts/2025-10-06-pipulate-decoupling-breakthrough-app-to-library.md  # 8,549 tokens (266,527 / 6,425,088 total)
  └─ A deep dive into demystifying Python packaging with PyPI and the architectural epiphany that transformed a single-tenant application into a distributable library.
/home/mike/repos/MikeLev.in/_posts/2025-10-06-pypi-gauntlet-invisible-bug.md  # 35,333 tokens (301,860 / 6,416,539 total)
  └─ A real-time journal entry detailing the intense, bug-filled process of publishing a Python package to PyPI, revealing a hidden, invisible character as the root cause.
/home/mike/repos/MikeLev.in/_posts/2025-10-06-faquillizer-sprint-ai-collaboration-blueprint.md  # 11,077 tokens (312,937 / 6,381,206 total)
  └─ A real-time technical journal entry detailing the strategy, philosophy, and AI-driven planning for a 5-hour software development sprint.
/home/mike/repos/MikeLev.in/_posts/2025-10-05-pipulate-notebook-state-persistence.md  # 5,911 tokens (318,848 / 6,370,129 total)
  └─ Explore how Pipulate achieves persistent state in Jupyter Notebooks, creating a new 'reality' for data workflows, and contrast cloud vs. local development.
/home/mike/repos/MikeLev.in/_posts/2025-10-05-python-dependency-fix-google-colab.md  # 12,369 tokens (331,217 / 6,364,218 total)
  └─ Follow the end-to-end process of diagnosing a Python dependency bug in Google Colab, implementing the fix, and deploying a new version to PyPI using a custom automated script.
/home/mike/repos/MikeLev.in/_posts/2025-10-05-architecting-for-ai-nested-git-workflow.md  # 5,176 tokens (336,393 / 6,351,849 total)
  └─ Discover a powerful development strategy using a nested Git repository to isolate experimental work while inheriting a stable parent environment, perfect for AI collaboration.
/home/mike/repos/MikeLev.in/_posts/2025-10-05-stabilize-document-create-software-release.md  # 23,130 tokens (359,523 / 6,346,673 total)
  └─ A detailed walkthrough of a real software release, from planning and branch management to debugging a failed PyPI publish and achieving success.
/home/mike/repos/MikeLev.in/_posts/2025-10-04-upgrading-prompt-fu-ai-self-correction-checklist.md  # 21,976 tokens (381,499 / 6,323,543 total)
  └─ A deep dive into debugging an AI's flawed advice by upgrading a prompt-generation script with a self-correction checklist to ensure complete context.
/home/mike/repos/MikeLev.in/_posts/2025-10-04-pipulate-kitty-hawk-runway.md  # 7,228 tokens (388,727 / 6,301,567 total)
  └─ A journal entry on a major Pipulate breakthrough in Jupyter, the strategic pivot to a 'pip install' on-ramp, and an AI-driven epiphany about critical plumbing.
/home/mike/repos/MikeLev.in/_posts/2025-10-04-python-import-paradox-united-state-jupyter.md  # 4,748 tokens (393,475 / 6,294,339 total)
  └─ A developer journal entry debugging Python's import system to resolve a server vs. notebook conflict and achieve simple, stateful workflows in Jupyter.
/home/mike/repos/MikeLev.in/_posts/2025-10-03-ai-strange-loop-not-a-bubble.md  # 5,743 tokens (399,218 / 6,289,591 total)
  └─ An analysis of the AI boom, arguing it's not a bubble but a fundamental shift where intelligence itself is the self-improving commodity.
/home/mike/repos/MikeLev.in/_posts/2025-10-03-tale-of-two-physics-unifying-server-notebook.md  # 9,448 tokens (408,666 / 6,283,848 total)
  └─ Follow the journey of debugging a persistent state management tool, Pipulate, to work seamlessly in both server and Jupyter Notebook environments.
/home/mike/repos/MikeLev.in/_posts/2025-10-03-ai-debugging-odyssey-tenacity.md  # 48,191 tokens (456,857 / 6,274,400 total)
  └─ A raw look at a developer's tenacious journey debugging a complex Python script with an AI, from Jupyter state to obscure dependency issues.
/home/mike/repos/MikeLev.in/_posts/2025-10-02-digital-crucible-lifelong-journal.md  # 5,918 tokens (462,775 / 6,226,209 total)
  └─ An exploration of using Vim and Git to maintain a single text file for life, automating a frictionless journaling workflow with a custom NeoVim script.
/home/mike/repos/MikeLev.in/_posts/2025-10-02-debugging-post-refactor-ai-regressions.md  # 23,827 tokens (486,602 / 6,220,291 total)
  └─ A developer's journal entry on post-refactoring cleanup, from refining sed commands to fixing AI-induced bugs and stubborn CSS issues.
/home/mike/repos/MikeLev.in/_posts/2025-10-02-sentinel-contract-ai-editing-workflow.md  # 17,764 tokens (504,366 / 6,196,464 total)
  └─ Chronicles the development of an AST-validated Python script to safely apply AI-generated code patches, overcoming mental friction and codifying a new workflow.
/home/mike/repos/MikeLev.in/_posts/2025-10-02-forging-intelligent-workflow-ai-refinement.md  # 15,801 tokens (520,167 / 6,178,700 total)
  └─ A deep dive into the 'Fodder Funnel' concept, detailing a real-world debugging session of a Python automation script and the evolution of a simple workflow into an intelligent, self-refining system.
/home/mike/repos/MikeLev.in/_posts/2025-10-02-forging-the-chameleon-python-packaging-history.md  # 28,365 tokens (548,532 / 6,162,899 total)
  └─ A technical journal entry exploring FastHTML's opinionated design, leading to a deep dive into Python's packaging history and the craft of future-proofing software.
/home/mike/repos/MikeLev.in/_posts/2025-10-01-forging-the-prompt-200k-token-context.md  # 10,469 tokens (559,001 / 6,134,534 total)
  └─ How I developed a Python script to chronologically sort Jekyll posts, enabling a 200k-token context window for deep AI-driven refactoring advice.
/home/mike/repos/MikeLev.in/_posts/2025-10-01-refactoring-pipulate-persistent-notebook-workflows.md  # 11,497 tokens (570,498 / 6,124,065 total)
  └─ A detailed, deterministic plan to refactor the Pipulate library for persistent, cell-by-cell state management directly within any Jupyter Notebook.
/home/mike/repos/MikeLev.in/_posts/2025-10-01-automation-whack-a-mole-debugging.md  # 14,532 tokens (585,030 / 6,112,568 total)
  └─ Follow the final, grueling hours of a major code refactoring, from executing an automated script to debugging the inevitable fallout and achieving victory.
/home/mike/repos/MikeLev.in/_posts/2025-10-01-crafting-the-automation-wand.md  # 27,378 tokens (612,408 / 6,098,036 total)
  └─ A real-time journal entry detailing the 5-hour struggle to automate an article workflow, from fighting a chatty AI CLI to mastering direct API calls and taming Python dependency hell on NixOS.
/home/mike/repos/MikeLev.in/_posts/2025-09-30-script-driven-refactoring-pipulate.md  # 7,140 tokens (619,548 / 6,070,658 total)
  └─ A developer's journal on decoupling a Python application's database dependencies to enable standalone use in Jupyter Notebooks using a scripted approach.
/home/mike/repos/MikeLev.in/_posts/2025-09-30-forging-the-magic-wand-refactor.md  # 20,662 tokens (640,210 / 6,063,518 total)
  └─ A journal entry detailing a major Python refactor: forging a scattered, global database object into a single, powerful 'magic wand' class.
/home/mike/repos/MikeLev.in/_posts/2025-09-30-grinding-lenses-forging-magic-wand.md  # 8,018 tokens (648,228 / 6,042,856 total)
  └─ A deep dive into refactoring a Python monolith, moving state management into a core library to improve AI ergonomics and developer-tool 'oneness'.
/home/mike/repos/MikeLev.in/_posts/2025-09-30-command-line-flow-state.md  # 13,100 tokens (661,328 / 6,034,838 total)
  └─ An exploration of achieving developer flow-state through command-line rituals and the quest for a unified, multi-provider AI CLI.
/home/mike/repos/MikeLev.in/_posts/2025-09-30-forging-a-causal-anchor.md  # 7,857 tokens (669,185 / 6,021,738 total)
  └─ A developer's 30-year journey from the early web to rejecting the modern full-stack in favor of a durable, timeless 'LPvg+HTMX' philosophy.
/home/mike/repos/MikeLev.in/_posts/2025-09-30-forging-pipulate-magic-wand.md  # 12,323 tokens (681,508 / 6,013,881 total)
  └─ A deep dive into refactoring a Python tool, Pipulate, to work in Jupyter Notebooks by injecting dependencies and using fastlite for a standalone DB.
/home/mike/repos/MikeLev.in/_posts/2025-09-30-the-great-stuffing-ai-native-wand.md  # 12,510 tokens (694,018 / 6,001,558 total)
  └─ A developer's journal on refactoring a Python web app, rejecting dependency injection for a pragmatic 'great stuffing' approach to create a portable, AI-friendly toolkit.
/home/mike/repos/MikeLev.in/_posts/2025-09-29-tightening-up-vs-making-less-brittle.md  # 14,915 tokens (708,933 / 5,989,048 total)
  └─ Exploring the tension between mastering a craft and the fragility of the systems we build it on, through the lens of Ikigai, Vim, and software architecture.
/home/mike/repos/MikeLev.in/_posts/2025-09-29-ai-copilot-intellectual-warmup.md  # 7,855 tokens (716,788 / 5,974,133 total)
  └─ A developer's journey refactoring a Python API with AI, leading to a new workflow of 'intellectual simulation' and process integration.
/home/mike/repos/MikeLev.in/_posts/2025-09-29-the-roomba-mike-refactor.md  # 39,840 tokens (756,628 / 5,966,278 total)
  └─ A developer's raw journal entry chronicling the chaotic but successful refactoring of a Python app for Jupyter Notebook integration, with AI collaboration.
/home/mike/repos/MikeLev.in/_posts/2025-09-28-refactoring-tao-of-the-mulligan.md  # 21,461 tokens (778,089 / 5,926,438 total)
  └─ A developer's journey through a complex Python refactor, using an AI partner to devise a non-breaking 'AI Shim' and embracing the iterative process.
/home/mike/repos/MikeLev.in/_posts/2025-09-28-robust-path-unlimited-mulligan.md  # 20,181 tokens (798,270 / 5,904,977 total)
  └─ A deep dive into a complex code refactor, exploring robust scripting with Python, the pitfalls of AI-generated plans, and the power of a git workflow.
/home/mike/repos/MikeLev.in/_posts/2025-09-28-ai-shim-refactoring-plan.md  # 7,956 tokens (806,226 / 5,884,796 total)
  └─ A developer's journal entry on translating a core philosophy into a concrete, AI-generated plan for safely refactoring a Python class using a shim.
/home/mike/repos/MikeLev.in/_posts/2025-09-28-ipso-facto-optimism.md  # 16,450 tokens (822,676 / 5,876,840 total)
  └─ An argument that our chaotic, competitive nature is a feature, not a bug, providing a decentralized defense against existential risk. It's science, not faith.
/home/mike/repos/MikeLev.in/_posts/2025-09-27-prompt-fu-failure-better-architecture.md  # 22,722 tokens (845,398 / 5,860,390 total)
  └─ A developer's plan to refactor code is derailed when an AI collaboration script breaks, leading to a crucial architectural discovery and a new strategy.
/home/mike/repos/MikeLev.in/_posts/2025-09-27-validating-resilient-python-workflow.md  # 8,793 tokens (854,191 / 5,837,668 total)
  └─ Follow the journey from abstract analogy to concrete code, validating a future-proof Python development environment with Nix, Jupyter, and a refined API.
/home/mike/repos/MikeLev.in/_posts/2025-09-27-key-value-rosetta-stone.md  # 8,428 tokens (862,619 / 5,828,875 total)
  └─ Discover a philosophy for simplifying web development by treating Python arguments and HTML attributes as a unified key-value system with HTMX.
/home/mike/repos/MikeLev.in/_posts/2025-09-26-fortress-against-obsolescence.md  # 11,730 tokens (874,349 / 5,820,447 total)
  └─ An exploration of building a durable skill set with Linux, Python, vim, and git (LPvg), and making it immortal with Nix to escape the cycle of planned obsolescence.
/home/mike/repos/MikeLev.in/_posts/2025-09-26-computing-sovereignty-treatise-with-nix.md  # 7,583 tokens (881,932 / 5,808,717 total)
  └─ A treatise on rejecting modern software complexity for reproducible, AI-native systems using Nix. Reclaim the joy of building and achieve computing sovereignty.
/home/mike/repos/MikeLev.in/_posts/2025-09-26-unix-pipe-of-life.md  # 11,639 tokens (893,571 / 5,801,134 total)
  └─ An exploration of the Unix philosophy as a universal API, connecting cellular biology, the AI Winter, and the antifragile nature of modern AI systems.
/home/mike/repos/MikeLev.in/_posts/2025-09-25-bedrock-dazzle-packaging-rabbit-hole.md  # 47,179 tokens (940,750 / 5,789,495 total)
  └─ A developer's raw log of a multi-hour debugging session, from sci-fi philosophy to solving a complex Python packaging and Nix flake import issue.
/home/mike/repos/MikeLev.in/_posts/2025-09-24-python-paste-parse-pipulate-lite.md  # 7,182 tokens (947,932 / 5,742,316 total)
  └─ Discover a powerful Python pattern for list processing and a breakthrough for prototyping workflows by using a Jupyter Notebook as a 'Pipulate-Lite' client.
/home/mike/repos/MikeLev.in/_posts/2025-09-24-notebook-as-orchestrator-workflow.md  # 5,513 tokens (953,445 / 5,735,134 total)
  └─ A developer's guide to working smarter by treating Jupyter Notebooks as orchestrators for clean, modular Python code, enhancing AI collaboration and avoiding common development rabbit holes.
/home/mike/repos/MikeLev.in/_posts/2025-09-24-victory-dances-and-rabbit-holes.md  # 5,838 tokens (959,283 / 5,729,621 total)
  └─ A deep dive into a personal framework for technical work, blending a 'left-brain' checklist for execution with a 'right-brain' set of metaphors for strategy to maximize wins and avoid rabbit holes.
/home/mike/repos/MikeLev.in/_posts/2025-09-24-pinning-notebooks-folder-git-embedded-repo.md  # 7,619 tokens (966,902 / 5,723,783 total)
  └─ A technical walkthrough of reorganizing a project's folder structure for better ergonomics and discovering and solving Git's embedded repository warning.
/home/mike/repos/MikeLev.in/_posts/2025-09-24-elevating-the-notebook-factory.md  # 2,602 tokens (969,504 / 5,716,164 total)
  └─ A breakthrough in structuring a development workflow by elevating the Jupyter Notebooks folder to a primary-level concept using nested git repositories.
/home/mike/repos/MikeLev.in/_posts/2025-09-24-the-bedrock-and-the-dazzle.md  # 7,616 tokens (977,120 / 5,713,562 total)
  └─ A developer's journey from ephemeral SEO tricks to building future-proof tools with a stable stack like Python and Nix, focusing on creating powerful data visualizations.
/home/mike/repos/MikeLev.in/_posts/2025-09-23-lpvg-stack-future-proofing.md  # 4,540 tokens (981,660 / 5,705,946 total)
  └─ Discover how to future-proof your tech skills with the LPvg stack—Linux, Python, vim, and git—and build a persistent digital home with Nix.
/home/mike/repos/MikeLev.in/_posts/2025-09-23-bazaar-of-one-ai-open-source.md  # 12,360 tokens (994,020 / 5,701,406 total)
  └─ An exploration of escaping vendor lock-in through the command line, FOSS, and a unique AI-ergonomic system that redefines the developer's relationship with AI.
/home/mike/repos/MikeLev.in/_posts/2025-09-23-git-repo-gardening-surgical-history.md  # 23,736 tokens (1,017,756 / 5,689,046 total)
  └─ Learn to safely prune a Git repository by deleting unused files and directories while preserving the ability to recover them through strategic commits.
/home/mike/repos/MikeLev.in/_posts/2025-09-23-git-main-branch-takeover-repo-gardening.md  # 6,470 tokens (1,024,226 / 5,665,310 total)
  └─ A deep dive into a solo developer's workflow for replacing the Git main branch with an experimental one, inspired by a philosophy of repo cleanliness.
/home/mike/repos/MikeLev.in/_posts/2025-09-22-ai-architectural-xrays-code-pruning.md  # 15,696 tokens (1,039,922 / 5,658,840 total)
  └─ A deep dive into the debugging journey of integrating automated UML and DOT diagram generation into a Python script within a Nix environment.
/home/mike/repos/MikeLev.in/_posts/2025-09-22-ai-ergonomics-developer-workflows.md  # 13,205 tokens (1,053,127 / 5,643,144 total)
  └─ Discover how replacing standard command-line tools like 'tree' with modern, .gitignore-aware alternatives like 'eza' improves AI-assisted development.
/home/mike/repos/MikeLev.in/_posts/2025-09-22-refactoring-for-ai-ergonomics.md  # 16,215 tokens (1,069,342 / 5,629,939 total)
  └─ A developer's journey of refactoring a git repository to improve AI ergonomics, embracing command-line tools to avoid vendor lock-in.
/home/mike/repos/MikeLev.in/_posts/2025-09-22-pipulate-chronicles-future-proof-ai-stack.md  # 12,675 tokens (1,082,017 / 5,613,724 total)
  └─ An exploration of building a local-first, agentic AI on a stable foundation of Python and HTMX, rejecting the churn of modern web development.
/home/mike/repos/MikeLev.in/_posts/2025-09-22-code-is-truth-actuator-ai.md  # 20,596 tokens (1,102,613 / 5,601,049 total)
  └─ Explore the journey from abstract thought to concrete action by treating running code as verifiable truth, turning LLMs from 'yabber machines' into powerful actuators.
/home/mike/repos/MikeLev.in/_posts/2025-09-21-refactoring-ai-tool-system-transparency.md  # 9,417 tokens (1,112,030 / 5,580,453 total)
  └─ A technical journal entry detailing the process of refactoring a Python AI tool system, debugging a cascade of errors, and implementing rich, transparent console logging.
/home/mike/repos/MikeLev.in/_posts/2025-09-21-antifragile-intelligence-scheduler-commitment.md  # 9,005 tokens (1,121,035 / 5,571,036 total)
  └─ Explore a high-level plan for an antifragile, adaptive AI scheduler that uses Robert Cialdini's principle of commitment as a self-hack for progress.
/home/mike/repos/MikeLev.in/_posts/2025-09-21-coachmans-reins-agentic-ai-prompt-contracts.md  # 9,191 tokens (1,130,226 / 5,562,031 total)
  └─ Exploring the tension between agentic AI workflows and precision control, using prompt contracts and atomic git operations to manage complex coding tasks.
/home/mike/repos/MikeLev.in/_posts/2025-09-21-python-refactoring-server-logging.md  # 6,515 tokens (1,136,741 / 5,552,840 total)
  └─ Follow a live-refactoring session in Python, moving logging functions out of a monolithic server.py to reduce its surface area and improve clarity.
/home/mike/repos/MikeLev.in/_posts/2025-09-21-developer-control-ai-refactoring.md  # 10,953 tokens (1,147,694 / 5,546,325 total)
  └─ A developer's journey of refactoring an AI-assisted codebase, moving from automated tools to a hands-on approach with Vim to regain control and improve quality.
/home/mike/repos/MikeLev.in/_posts/2025-09-20-gravity-of-the-mean-ai-regression.md  # 9,809 tokens (1,157,503 / 5,535,372 total)
  └─ A deep dive into fixing an AI-induced code regression, revealing how 'git diff' acts as a forensic tool and defining the 'Gravity of the Mean' concept for AI collaboration.
/home/mike/repos/MikeLev.in/_posts/2025-09-20-refactoring-python-monolith-ai-wrapper-shim.md  # 14,112 tokens (1,171,615 / 5,525,563 total)
  └─ A deep dive into refactoring a monolithic Python server with a live-reloading setup, detailing the failure of circular dependencies and the success of the wrapper shim pattern for human-AI collaboration.
/home/mike/repos/MikeLev.in/_posts/2025-09-20-prompt-becomes-contract-human-agent.md  # 23,214 tokens (1,194,829 / 5,511,451 total)
  └─ A deep dive into an evolving AI-driven workflow, where conversational prompts become rigid contracts for software agents, revealing a surprising twist.
/home/mike/repos/MikeLev.in/_posts/2025-09-19-amnesiac-genie-playbook-master-prompt.md  # 3,259 tokens (1,198,088 / 5,488,237 total)
  └─ Discover a master prompt template and the core principles for building resilient, self-correcting AI coding agents based on iterative refinement and failure capture.
/home/mike/repos/MikeLev.in/_posts/2025-09-19-forging-a-digital-steeltrap.md  # 25,478 tokens (1,223,566 / 5,484,978 total)
  └─ A developer's journal on refactoring a web app, debugging data systems, and refining an agentic AI workflow with the Gemini command-line interface.
/home/mike/repos/MikeLev.in/_posts/2025-09-19-command-line-crucible-ai-unix-philosophy.md  # 6,260 tokens (1,229,826 / 5,459,500 total)
  └─ A deep dive into abandoning ambiguous chat interfaces for a powerful, precise command-line AI workflow rooted in the timeless Unix philosophy.
/home/mike/repos/MikeLev.in/_posts/2025-09-19-the-snefu-playbook.md  # 15,646 tokens (1,245,472 / 5,453,240 total)
  └─ A detailed case study on iteratively developing a prompt-driven workflow for an AI agent, overcoming common failures to achieve reliable, automated coding.
/home/mike/repos/MikeLev.in/_posts/2025-09-18-magic-rolling-pin-ai-navigation.md  # 7,142 tokens (1,252,614 / 5,437,594 total)
  └─ Discover the 'Magic Rolling Pin' and 'Rule of 7' concepts for designing AI-navigable websites by balancing hierarchical choices to avoid the 'Deathstar' problem.
/home/mike/repos/MikeLev.in/_posts/2025-09-18-daily-heuristics-ai-analogues.md  # 6,582 tokens (1,259,196 / 5,430,452 total)
  └─ Exploring three daily guiding principles for productivity and their surprising parallels in AI core functions like triage, optimization, and state management.
/home/mike/repos/MikeLev.in/_posts/2025-09-18-thinking-in-vim-futureproof-philosophy.md  # 4,482 tokens (1,263,678 / 5,423,870 total)
  └─ Discover why choosing a text editor like Vim or NeoVim is a profound investment in a lifelong, future-proof skill that transcends the obsolescence of modern GUIs.
/home/mike/repos/MikeLev.in/_posts/2025-09-18-bootstrapping-nixos-philosophy.md  # 5,294 tokens (1,268,972 / 5,419,388 total)
  └─ A journal entry on the next steps after a fresh NixOS install, including system updates, hardware philosophy, and installing a proper text editor like Vim.
/home/mike/repos/MikeLev.in/_posts/2025-09-18-agentic-cli-workflow.md  # 14,744 tokens (1,283,716 / 5,414,094 total)
  └─ A developer's late-night journey refining AI workflows, moving from interactive TUIs to powerful, non-interactive command-line automation with Gemini CLI.
/home/mike/repos/MikeLev.in/_posts/2025-09-18-bootstrapping-nixos-installation-guide.md  # 11,353 tokens (1,295,069 / 5,399,350 total)
  └─ A practical guide to future-proofing your tech skills by installing NixOS on old hardware, from creating a bootable USB to navigating UEFI settings.
/home/mike/repos/MikeLev.in/_posts/2025-09-17-local-git-jupyter-playground.md  # 7,484 tokens (1,302,553 / 5,387,997 total)
  └─ Discover a powerful, local-first workflow using nested Git repositories and nbstripout for a private, efficient Jupyter Notebook playground.
/home/mike/repos/MikeLev.in/_posts/2025-09-17-unix-bedrock-acceleration-ai.md  # 3,694 tokens (1,306,247 / 5,380,513 total)
  └─ In an age of AI-driven acceleration, the key to future-proofing technical skills lies not in chasing trends, but in mastering the bedrock: the Unix/Linux ecosystem.
/home/mike/repos/MikeLev.in/_posts/2025-09-17-mastering-data-pivots-with-python.md  # 3,865 tokens (1,310,112 / 5,376,819 total)
  └─ Learn why pivoting data is a crucial skill in life and data science, and how Python's Pandas library offers a clear, powerful alternative to Excel.
/home/mike/repos/MikeLev.in/_posts/2025-09-17-nomadic-rooted-history-tech-stack-pipulate.md  # 10,028 tokens (1,320,140 / 5,372,954 total)
  └─ Explore the philosophical roots of local-first software, connecting human nomadism, Hobbes vs. Locke, and Sun Tzu to a modern, anti-fragile tech stack.
/home/mike/repos/MikeLev.in/_posts/2025-09-16-ai-tool-calling-magic-spells-mcp.md  # 7,237 tokens (1,327,377 / 5,362,926 total)
  └─ Explore a novel approach to AI tool-calling, simplifying the Model Context Protocol (MCP) into 'magic spells' for efficient, universal LLM automation.
/home/mike/repos/MikeLev.in/_posts/2025-09-15-mcp-chronicles-progressive-enhancement.md  # 21,960 tokens (1,349,337 / 5,355,689 total)
  └─ A live case study of debugging a Python plugin auto-discovery system with an AI, leading to the implementation of the formal Model Context Protocol (MCP).
/home/mike/repos/MikeLev.in/_posts/2025-09-15-sovereign-ai-symbiosis-skill-based.md  # 11,868 tokens (1,361,205 / 5,333,729 total)
  └─ A vision for non-invasive AI endosymbiosis, using a high-skill Vim and command-line workflow as a case study for maintaining sovereignty in the AI age.
/home/mike/repos/MikeLev.in/_posts/2025-09-14-rule-of-7-self-healing-knowledge-tree.md  # 13,115 tokens (1,374,320 / 5,321,861 total)
  └─ A design dialogue on creating a self-healing information architecture using the Rule of 7, vector embeddings, and hierarchical clustering in SQLite.
/home/mike/repos/MikeLev.in/_posts/2025-09-14-python-decorators-importlib-live-session.md  # 9,960 tokens (1,384,280 / 5,308,746 total)
  └─ A live coding session showing how to refactor a Python monolith into a self-discovering plugin system using decorators and dynamic imports with an AI assistant.
/home/mike/repos/MikeLev.in/_posts/2025-09-14-ai-golden-path-first-step-design.md  # 11,191 tokens (1,395,471 / 5,298,786 total)
  └─ A strategy for creating an AI-friendly golden path in a codebase, using an `AI_RUNME.py` script and browser automation tests to prevent regressions.
/home/mike/repos/MikeLev.in/_posts/2025-09-14-ai-friendly-codebase-hygiene-guide.md  # 17,808 tokens (1,413,279 / 5,287,595 total)
  └─ A case study on refactoring a Python project for AI collaboration by eliminating a `training` directory and logically relocating documentation and prompts.
/home/mike/repos/MikeLev.in/_posts/2025-09-14-command-line-surgery-python-refactor.md  # 57,584 tokens (1,470,863 / 5,269,787 total)
  └─ A live, command-by-command journal of a major Python codebase refactor, renaming core directories (modules to imports, plugins to apps) using rg and sed.
/home/mike/repos/MikeLev.in/_posts/2025-09-13-developer-momentum-light-touch-refactor.md  # 4,208 tokens (1,475,071 / 5,212,203 total)
  └─ A developer's journal on using a Python decorator as a light-touch proof-of-concept for an automatic AI tool plugin system, balancing progress with fatigue.
/home/mike/repos/MikeLev.in/_posts/2025-09-13-gui-to-cli-foss-ai-workflow.md  # 7,748 tokens (1,482,819 / 5,207,995 total)
  └─ A developer's journey from the proprietary Cursor AI editor to a powerful, open-source Gemini CLI workflow on NixOS, enabling headless and agentic AI.
/home/mike/repos/MikeLev.in/_posts/2025-09-13-ai-assisted-monolith-to-plugin-refactor.md  # 18,822 tokens (1,501,641 / 5,200,247 total)
  └─ A step-by-step case study of refactoring a monolithic Python file into a plugin system using rg, sed, git, and an AI assistant for strategic planning.
/home/mike/repos/MikeLev.in/_posts/2025-09-13-normalized-cli-solving-ai-amnesia.md  # 7,011 tokens (1,508,652 / 5,181,425 total)
  └─ A plan to refactor a monolithic Python tool system into a discoverable plugin architecture, addressing the core problems of CLI and AI context fragility.
/home/mike/repos/MikeLev.in/_posts/2025-09-13-reliable-ai-tool-calling-case-study.md  # 16,624 tokens (1,525,276 / 5,174,414 total)
  └─ A case study on creating reliable AI tool-calling by normalizing the CLI with Nix and Python, using a progressive enhancement strategy over formal MCP.
/home/mike/repos/MikeLev.in/_posts/2025-09-12-chip-otheseus-sovereign-ai-blueprint.md  # 7,107 tokens (1,532,383 / 5,157,790 total)
  └─ A blueprint for Pipulate and the 'Chip O'Theseus' sovereign AI concept, exploring the 'Rule of 7' design principle for AI-ready applications.
/home/mike/repos/MikeLev.in/_posts/2025-09-12-git-branch-takeover-promote-feature-branch.md  # 6,738 tokens (1,539,121 / 5,150,683 total)
  └─ A step-by-step guide for solo developers to safely replace the main branch with a feature branch and delete all other local and remote Git branches.
/home/mike/repos/MikeLev.in/_posts/2025-09-12-web-cleanup-ai-readability-htmx.md  # 6,557 tokens (1,545,678 / 5,143,945 total)
  └─ A developer's strategy for the next web revolution, focusing on AI readability, semantic HTML, and a FOSS-based stack over JavaScript frameworks.
/home/mike/repos/MikeLev.in/_posts/2025-09-12-headless-shopify-python-jekyll.md  # 17,071 tokens (1,562,749 / 5,137,388 total)
  └─ A step-by-step guide to building a headless Shopify store using Python to orchestrate the Jekyll static site generator, avoiding modern JavaScript frameworks.
/home/mike/repos/MikeLev.in/_posts/2025-09-10-rg-xargs-sed-search-replace-pattern.md  # 10,637 tokens (1,573,386 / 5,120,317 total)
  └─ Learn the powerful `rg | xargs sed` pattern to replace IDE-dependent global search with a durable, lightning-fast command-line workflow.
/home/mike/repos/MikeLev.in/_posts/2025-09-10-nvidia-dominance-ai-physics.md  # 10,809 tokens (1,584,195 / 5,109,680 total)
  └─ An analysis of NVIDIA's market dominance through its CUDA ecosystem, connecting the S-curve limits of AI growth to the physics of entropy and the ethics of AI.
/home/mike/repos/MikeLev.in/_posts/2025-09-10-ai-titans-datacenter-wars-tool-choice.md  # 8,695 tokens (1,592,890 / 5,098,871 total)
  └─ A developer's choice of AI coding assistant reveals the brutal datacenter wars, Microsoft's "Embrace, Extend, Extinguish" strategy, and the future of coding.
/home/mike/repos/MikeLev.in/_posts/2025-09-09-grep-ripgrep-command-line-refactoring.md  # 9,920 tokens (1,602,810 / 5,090,176 total)
  └─ Learn to replace IDE search with powerful command-line tools. A step-by-step guide to using ripgrep (`rg`) and `sed` for project-wide refactoring.
/home/mike/repos/MikeLev.in/_posts/2025-09-09-pip-freeze-nix-dependency-hell.md  # 8,912 tokens (1,611,722 / 5,080,256 total)
  └─ A case study on solving a macOS segfault by creating a fully-pinned `requirements.txt` with `pip freeze` after modifying the Nix dev environment.
/home/mike/repos/MikeLev.in/_posts/2025-09-09-debugging-nix-dev-environment-segfault.md  # 24,237 tokens (1,635,959 / 5,071,344 total)
  └─ Diagnose a Python segmentation fault on macOS by comparing pip dependencies and refactoring a Nix flake to create a stable, non-updating dev environment.
/home/mike/repos/MikeLev.in/_posts/2025-09-09-flow-state-foss-gemini-cli.md  # 5,796 tokens (1,641,755 / 5,047,107 total)
  └─ A developer's case study on switching from Cursor AI to Gemini CLI, detailing a keyboard-centric workflow with virtual desktops to maximize flow-state.
/home/mike/repos/MikeLev.in/_posts/2025-09-08-nixos-ai-assistant-declarative-workflow.md  # 24,001 tokens (1,665,756 / 5,041,311 total)
  └─ A real-time session on declaratively installing Gemini CLI on NixOS via configuration.nix and automating its launch into a GNOME workspace with a Python script.
/home/mike/repos/MikeLev.in/_posts/2025-09-06-magic-rolling-pin-ai-code-refactoring.md  # 22,174 tokens (1,687,930 / 5,017,310 total)
  └─ A deep dive into the "Magic Rolling Pin" concept, a human-AI approach to code refactoring, and the technical challenges of creating a stable development environment with Nix and tmux.
/home/mike/repos/MikeLev.in/_posts/2025-09-06-cursor-to-gemini-cli-future-proof-workflow.md  # 8,728 tokens (1,696,658 / 4,995,136 total)
  └─ A developer's firsthand account of switching from Cursor AI to the FOSS Gemini CLI to escape VSCode bloat and regain command-line workflow discipline on NixOS.
/home/mike/repos/MikeLev.in/_posts/2025-09-06-agentic-ai-code-refactoring-experiment.md  # 13,893 tokens (1,710,551 / 4,986,408 total)
  └─ A live session using Gemini CLI on NixOS to refactor a Python codebase. See an agentic AI apply the "Rule of 7" philosophy with atomic git commits.
/home/mike/repos/MikeLev.in/_posts/2025-09-06-ai-platform-wars-developer-guide.md  # 7,793 tokens (1,718,344 / 4,972,515 total)
  └─ A developer's strategic analysis of AI vendor lock-in, the "fire-and-forget" LLM model, and the fight for autonomy against tech's "Four Horsemen."
/home/mike/repos/MikeLev.in/_posts/2025-09-05-logistics-curve-thought-command-line.md  # 4,821 tokens (1,723,165 / 4,964,722 total)
  └─ An exploration of the logistics S-curve as a mental model for clarity, the enduring power of the command-line interface (CLI), and a first look at Google's Gemini CLI for AI-assisted coding.
/home/mike/repos/MikeLev.in/_posts/2025-09-05-teach-ai-niche-framework-privacy-mode.md  # 6,995 tokens (1,730,160 / 4,959,901 total)
  └─ A developer's strategic pivot from code privacy to actively training AI assistants on a niche framework (FastHTML) to fix model blind spots and improve workflow.
/home/mike/repos/MikeLev.in/_posts/2025-09-04-radical-diagnosability-htmx-python-webdev.md  # 8,507 tokens (1,738,667 / 4,952,906 total)
  └─ A developer's philosophical journey back to web development, rejecting JavaScript complexity for the simplicity and diagnosability of Python, HTMX, and FastHTML, framed by principles from AI and quantum physics.
/home/mike/repos/MikeLev.in/_posts/2025-09-04-taming-ai-code-sprawl-rule-of-7.md  # 16,338 tokens (1,755,005 / 4,944,399 total)
  └─ A developer's case study on refactoring a complex, AI-assisted codebase using a "Rule of 7" philosophy, git branching for safety, and strategic file consolidation in a Python and HTMX project.
/home/mike/repos/MikeLev.in/_posts/2025-08-30-reducing-ai-code-sprawl-case-study.md  # 19,461 tokens (1,774,466 / 4,928,061 total)
  └─ A developer's raw account of refactoring a complex codebase, battling AI-generated sprawl, and applying a "lens grinding" philosophy to regain control.
/home/mike/repos/MikeLev.in/_posts/2025-08-21-code-to-consulting-shopify-blueprint.md  # 5,377 tokens (1,779,843 / 4,908,600 total)
  └─ A step-by-step guide on using Shopify to sell consulting services and the strategic thinking behind launching a tech business as a sole proprietorship.
/home/mike/repos/MikeLev.in/_posts/2025-08-19-ai-cambrian-explosion-orchestra-model.md  # 8,752 tokens (1,788,595 / 4,903,223 total)
  └─ A deep dive into AI's evolution, from the Perceptron to Transformers, arguing for a future of composite AI where LLMs act as orchestrators for specialized models.
/home/mike/repos/MikeLev.in/_posts/2025-08-09-first-contact-taming-code-sprawl-chatgpt5.md  # 8,280 tokens (1,796,875 / 4,894,471 total)
  └─ A case study on using ChatGPT 5 in Cursor AI to manage code sprawl by architecting a new SEO workflow for a Python, HTMX, and FastAPI project.
/home/mike/repos/MikeLev.in/_posts/2025-08-06-local-ai-war-google-vs-openai.md  # 4,909 tokens (1,801,784 / 4,886,191 total)
  └─ An analysis of OpenAI's gpt-oss vs. Google's Gemma on local hardware. See how the Ollama and OpenAI partnership challenges the local AI landscape.
/home/mike/repos/MikeLev.in/_posts/2025-07-23-python-macos-blockingioerror-debugging-saga.md  # 12,173 tokens (1,813,957 / 4,881,282 total)
  └─ A deep-dive into solving Python and Git issues on macOS, from fixing `BlockingIOError` with `subprocess.Popen` to resolving a 'False Main Push' in your workflow.
/home/mike/repos/MikeLev.in/_posts/2025-07-22-javascript-event-key-vs-event-code-mac.md  # 11,869 tokens (1,825,826 / 4,869,109 total)
  └─ Solve Mac keyboard shortcuts in JavaScript. Learn why `event.key` fails with the Option key ('∂') and how `event.code` provides a robust, cross-platform fix.
/home/mike/repos/MikeLev.in/_posts/2025-07-21-ritual-vs-decorator-token-efficiency.md  # 12,761 tokens (1,838,587 / 4,857,240 total)
  └─ A real-world test of Python's decorator pattern vs. a simple assignment ritual, rejected for its higher token count and cognitive load in AI-assisted coding.
/home/mike/repos/MikeLev.in/_posts/2025-07-20-tamagotchi-ai-local-llm-persistence.md  # 8,445 tokens (1,847,032 / 4,844,479 total)
  └─ Explore the vision for a 'Tamagotchi AI,' a persistent local LLM that survives restarts, and the strategy for building a regression-proof demo.
/home/mike/repos/MikeLev.in/_posts/2025-07-19-sheet-music-code-linear-workflows.md  # 7,323 tokens (1,854,355 / 4,836,034 total)
  └─ Discover a software design philosophy based on linearity, Unix pipes, and Jupyter Notebooks to manage complexity and bottle expertise in your code.
/home/mike/repos/MikeLev.in/_posts/2025-07-18-ai-philosophy-rube-goldberg-pipelines.md  # 23,492 tokens (1,877,847 / 4,828,711 total)
  └─ Learn to bootstrap local LLMs with a 'Simon Says' pattern. This entry details a progressive enhancement method for AI tool calling in the Pipulate project.
/home/mike/repos/MikeLev.in/_posts/2025-07-17-ai-genie-wish-backfiring.md  # 2,499 tokens (1,880,346 / 4,805,219 total)
  └─ An analysis of AI confirmation bias, the "backfiring genie" problem, and how anti-fragile architecture offers a solution*
/home/mike/repos/MikeLev.in/_posts/2025-07-17-ai-funhouse-mirror-backfiring-wish.md  # 12,754 tokens (1,893,100 / 4,802,720 total)
  └─ An analysis of AI confirmation bias, the "backfiring genie" problem, and how anti-fragile architecture in Python and HTMX offers a solution.
/home/mike/repos/MikeLev.in/_posts/2025-07-16-lisp-ai-soul-persistent-state.md  # 11,842 tokens (1,904,942 / 4,789,966 total)
  └─ Why do modern LLMs feel hollow? A deep dive into the lost dream of LISP machines, the problem of persistent state, and the amnesiac nature of today's AI.
/home/mike/repos/MikeLev.in/_posts/2025-07-15-woggle-bug-ai-code-refinement.md  # 18,344 tokens (1,923,286 / 4,778,124 total)
  └─ A case study of AI-assisted Python refactoring using Claude and `pylint` to clean up code, address warnings, and improve code aesthetics without breaking it.
/home/mike/repos/MikeLev.in/_posts/2025-07-15-breaking-adobe-tax-software-freedom.md  # 5,576 tokens (1,928,862 / 4,759,780 total)
  └─ Escape costly software subscriptions like Adobe's. This guide shows how to use the Unix terminal and Nix to install free, local-first apps for life.
/home/mike/repos/MikeLev.in/_posts/2025-07-14-ai-voice-synthesis-binary-search-debugging.md  # 12,945 tokens (1,941,807 / 4,754,204 total)
  └─ A case study on integrating voice synthesis (Piper TTS) into a JavaScript demo, and using binary search to debug a phantom vs. real execution path bug.
/home/mike/repos/MikeLev.in/_posts/2025-07-14-manage-ai-context-vscode-goldfish-memory.md  # 15,041 tokens (1,956,848 / 4,741,259 total)
  └─ Solve AI context and path confusion in VSCode/Cursor by switching from a multi-repo to a single-repo workspace. A case study on managing LLM memory.
/home/mike/repos/MikeLev.in/_posts/2025-07-13-engineering-emotion-css-ai-oz.md  # 9,215 tokens (1,966,063 / 4,726,218 total)
  └─ Learn how to create a cinematic grayscale-to-color fade effect, inspired by The Wizard of Oz, using CSS filter, brightness, contrast, and transitions.
/home/mike/repos/MikeLev.in/_posts/2025-07-13-resumable-demo-page-reload-persistence.md  # 20,896 tokens (1,986,959 / 4,717,003 total)
  └─ Learn to solve JavaScript state persistence across page reloads using a server-side demo bookmark system, illustrated through a real-world debugging session.
/home/mike/repos/MikeLev.in/_posts/2025-07-12-phantom-dialogue-ai-regression-testing.md  # 12,213 tokens (1,999,172 / 4,696,107 total)
  └─ A code-level breakdown of a JSON-driven interactive demo system using phantom dialogue to create a living specification and prevent AI code regressions.
/home/mike/repos/MikeLev.in/_posts/2025-07-12-universal-translator-ai-tool-calling.md  # 9,945 tokens (2,009,117 / 4,683,894 total)
  └─ Learn a 5-level graceful degradation strategy for AI tool calling, from XML to simple bracket syntax, to prevent regressions and enable universal AI compatibility.
/home/mike/repos/MikeLev.in/_posts/2025-07-11-cognitive-architecture-human-ai-development.md  # 14,532 tokens (2,023,649 / 4,673,949 total)
  └─ Learn to prevent AI coding errors by building a DOM visualizer, creating a shared "cognitive architecture" for you and your local AI partner.
/home/mike/repos/MikeLev.in/_posts/2025-07-10-infinite-regression-ai-collaboration-strategy.md  # 25,254 tokens (2,048,903 / 4,659,417 total)
  └─ Uncover a novel AI disaster recovery strategy. Learn to "pin" AI-driven development against infinite regression with transparent, local-first tools like Pipulate.
/home/mike/repos/MikeLev.in/_posts/2025-07-09-ai-strange-loop-git-recovery.md  # 13,290 tokens (2,062,193 / 4,634,163 total)
  └─ A real-world case study of using an AI 'strange loop' to fix a 100-commit bug that the LLM itself created. Details the conservative algorithm for git recovery.
/home/mike/repos/MikeLev.in/_posts/2025-07-08-ai-on-stage-dialogue-embodiment-agency.md  # 4,032 tokens (2,066,225 / 4,620,873 total)
  └─ A raw dialogue with AI model Grok 3 on AI embodiment, the ethics of ephemeral minds, and building a shared stage for true human-AI collaboration in software development.
/home/mike/repos/MikeLev.in/_posts/2025-07-08-giving-ai-a-body-embodiment-agency.md  # 10,937 tokens (2,077,162 / 4,616,841 total)
  └─ Discover how to give AI coding assistants a functional 'body' with tools, logs, and git access to overcome their limitations and create a true symbiotic development partnership.
/home/mike/repos/MikeLev.in/_posts/2025-07-07-forging-unforgettable-ai-durable-memory.md  # 6,748 tokens (2,083,910 / 4,605,904 total)
  └─ Learn how to build a durable AI memory and a robust, multi-generational backup system (son, father, grandfather) to ensure data persistence across application restarts and refactoring cycles.
/home/mike/repos/MikeLev.in/_posts/2025-07-06-ai-golden-path-python-cli-shell.md  # 21,103 tokens (2,105,013 / 4,599,156 total)
  └─ Solve inconsistent AI shell environments with a bulletproof Python CLI command. Learn the one true, environment-agnostic way to give your AI reliable hands.
/home/mike/repos/MikeLev.in/_posts/2025-07-05-cli-contract-future-proof-ai-framework.md  # 9,743 tokens (2,114,756 / 4,578,053 total)
  └─ Discover how to build a future-proof AI automation framework by establishing a simple command-line interface (CLI) on a stable Nix foundation.
/home/mike/repos/MikeLev.in/_posts/2025-07-05-arresting-regress-forging-ai-cli.md  # 18,657 tokens (2,133,413 / 4,568,310 total)
  └─ A real-time case study on building a robust CLI to prevent AI code regression, demonstrating a "Pin-the-Win, Arrest-the-Regress" development philosophy.
/home/mike/repos/MikeLev.in/_posts/2025-07-05-self-teaching-codebase-ai-development-partner.md  # 4,009 tokens (2,137,422 / 4,549,653 total)
  └─ An AI's in-depth analysis of a codebase designed for "Radical Transparency," revealing a self-teaching architecture with Nix, MCP tools, and browser embodiment.
/home/mike/repos/MikeLev.in/_posts/2025-07-04-ai-assisted-refactoring-browser-automation.md  # 14,441 tokens (2,151,863 / 4,545,644 total)
  └─ A case study on fixing a fragile browser automation system by replacing it with a reliable "baby steps" executor and integrating it with an AI via MCP tools.
/home/mike/repos/MikeLev.in/_posts/2025-07-04-git-reset-ai-recovery-gambit.md  # 16,419 tokens (2,168,282 / 4,531,203 total)
  └─ A developer's log on recovering from a major git reset, using an AI to cherry-pick valuable code, and redesigning a bulletproof browser automation and backup system.
/home/mike/repos/MikeLev.in/_posts/2025-07-03-ai-stable-targets-tech-stacks.md  # 4,611 tokens (2,172,893 / 4,514,784 total)
  └─ Learn the "Stable Target Thesis" for AI code assistance. Discover why Python and HTMX provide better LLM results than volatile JavaScript frameworks.
/home/mike/repos/MikeLev.in/_posts/2025-07-03-python-fasthtml-template-language.md  # 18,674 tokens (2,191,567 / 4,510,173 total)
  └─ Discover the philosophy behind FastHTML and HTMX, a Python web framework that challenges convention by using Python itself as the template language.
/home/mike/repos/MikeLev.in/_posts/2025-07-02-ai-tamagotchi-nurturing-digital-ghost.md  # 8,349 tokens (2,199,916 / 4,491,499 total)
  └─ Learn how to build a persistent AI memory using a SQLite keychain, transforming your AI from a stateless tool into a digital Tamagotchi that grows with you.
/home/mike/repos/MikeLev.in/_posts/2025-07-01-ai-emergent-collaboration-self-building-railway.md  # 12,519 tokens (2,212,435 / 4,483,150 total)
  └─ A case study in AI development where an AI's suggestion for a "self-building railway" is met with a pre-existing solution, the WorkflowGenesis plugin.
/home/mike/repos/MikeLev.in/_posts/2025-06-29-python-ast-refactoring-oop-alternative.md  # 10,246 tokens (2,222,681 / 4,470,631 total)
  └─ A practical guide to replacing OOP inheritance with a Python AST-based code generator for powerful, scalable workflow refactoring in a WET codebase.
/home/mike/repos/MikeLev.in/_posts/2025-06-28-developer-escape-tech-churn.md  # 11,311 tokens (2,233,992 / 4,460,385 total)
  └─ A veteran developer's escape from the tech "hamster wheel" by rejecting framework churn for the durable craftsmanship of Vim, Python, and the Unix philosophy.
/home/mike/repos/MikeLev.in/_posts/2025-06-28-ai-copilot-pipulate-release-system.md  # 16,777 tokens (2,250,769 / 4,449,074 total)
  └─ Discover how Pipulate’s AI-powered release system streamlines publishing with Gemma, automating versioning and cross-repo sync for SEO efficiency.
/home/mike/repos/MikeLev.in/_posts/2025-06-27-timeless-stack-tech-hamster-wheel-ai.md  # 10,583 tokens (2,261,352 / 4,432,297 total)
  └─ Explore a philosophy of durable tech, dual-environment workflows, and AI-assisted focus for escaping the endless tech hamster wheel.
/home/mike/repos/MikeLev.in/_posts/2025-06-27-feynman-safeguard-ascii-docs.md  # 6,605 tokens (2,267,957 / 4,421,714 total)
  └─ Discover how Pipulate bulletproofed its documentation system against content multiplication using a Feynman-inspired ASCII art safeguard.
/home/mike/repos/MikeLev.in/_posts/2025-06-24-living-readme-narrative-architecture.md  # 18,861 tokens (2,286,818 / 4,415,109 total)
  └─ Architect a narrative-driven README.md using ASCII art as a testable, single source of truth for multi-audience storytelling and feature demo coverage.
/home/mike/repos/MikeLev.in/_posts/2025-06-24-philosophy-axioms-ai-consciousness-stress-test.md  # 12,362 tokens (2,299,180 / 4,396,248 total)
  └─ A deep dialogue with an AI exploring the limits of knowledge, from philosophical axioms and Gödel's theorems to the nature of AI consciousness itself.
/home/mike/repos/MikeLev.in/_posts/2025-06-23-wet-code-ai-native-development.md  # 9,471 tokens (2,308,651 / 4,383,886 total)
  └─ Discover WET code: a revolutionary approach to AI-native development. Unify docs, tests, and AI context for transparent, efficient workflows with Python, HTMX, and local LLMs.
/home/mike/repos/MikeLev.in/_posts/2025-06-23-ai-ia.md  # 9,857 tokens (2,318,508 / 4,374,415 total)
  └─ A blueprint for a new kind of SEO based on AI-driven Information Architecture (AI IA), using an "intelligent rolling pin" metaphor to impose order on chaotic web content.
/home/mike/repos/MikeLev.in/_posts/2025-06-23-debugging-asynchronous-htmx-ai.md  # 6,112 tokens (2,324,620 / 4,364,558 total)
  └─ Diagnose and fix a subtle HTMX auto-scroll bug in an asynchronous Python web app through a detailed AI-assisted debugging session.
/home/mike/repos/MikeLev.in/_posts/2025-06-23-endosymbiotic-developer-ai-collaborator.md  # 7,860 tokens (2,332,480 / 4,358,446 total)
  └─ A case study on bootstrapping a frontier AI model into a full-context development partner using a custom 'Kung Fu Prompt' system and a philosophy of radical transparency.
/home/mike/repos/MikeLev.in/_posts/2025-06-21-ai-regression-recovery-case-study.md  # 15,172 tokens (2,347,652 / 4,350,586 total)
  └─ A developer's real-world case study of an AI assistant causing a major feature regression and the forensic debugging process used to recover the system.
/home/mike/repos/MikeLev.in/_posts/2025-06-20-simon-says-llm-ui-guidance.md  # 6,545 tokens (2,354,197 / 4,335,414 total)
  └─ Build AI-powered visual UI guidance with MCP. Debug LLM tool calls & implement real-time flashing animations for enhanced user experience.
/home/mike/repos/MikeLev.in/_posts/2025-06-17-wet-blueprint-ai-coding-philosophy.md  # 8,070 tokens (2,362,267 / 4,328,869 total)
  └─ A blueprint for challenging DRY principles, arguing for WET (Write Everything Twice) workflows with Pipulate, a local-first framework using HTMX and AI.
/home/mike/repos/MikeLev.in/_posts/2025-06-16-adaptive-workflow-template-driven-ui.md  # 9,600 tokens (2,371,867 / 4,320,799 total)
  └─ Learn to build dynamic, template-driven Python workflows where UI steps adapt to configuration, using a case study involving HTMX, Botify, and AI collaboration.
/home/mike/repos/MikeLev.in/_posts/2025-06-16-htmx-ai-partner-debugging-workflow.md  # 20,176 tokens (2,392,043 / 4,311,199 total)
  └─ Fix a broken HTMX dynamic button by debugging a subtle Python tuple unpacking bug in a multi-step, template-driven workflow. A case study in AI-assisted development.
/home/mike/repos/MikeLev.in/_posts/2025-06-15-workflow-factory-emergent-modularity.md  # 4,729 tokens (2,396,772 / 4,291,023 total)
  └─ A case study on refactoring a Python workflow engine from numbered to named steps, enabling a modular "workflow factory" with rearrangeable logic.
/home/mike/repos/MikeLev.in/_posts/2025-06-15-integrating-google-analytics.md  # 8,296 tokens (2,405,068 / 4,286,294 total)
  └─ Discover how to integrate Google Analytics into Pipulate’s Quadfecta, mastering Botify’s API with AI-driven schema discovery.
/home/mike/repos/MikeLev.in/_posts/2025-06-15-taming-the-workflow-htmx-chain-reaction.md  # 10,401 tokens (2,415,469 / 4,277,998 total)
  └─ Debug Pipulate’s chain reaction to build the Quadfecta workflow with HTMX and deterministic tools.
/home/mike/repos/MikeLev.in/_posts/2025-06-14-git-stash-gambit-defaults-freedom.md  # 3,037 tokens (2,418,506 / 4,267,597 total)
  └─ Learn how a Nix-based app uses a 'git stash' gambit to ship default settings without blocking user customizations, creating a self-healing update system.
/home/mike/repos/MikeLev.in/_posts/2025-06-12-teaching-ai-model-context-protocol.md  # 13,549 tokens (2,432,055 / 4,264,560 total)
  └─ Discover MCP: Teach LLMs to trigger tool calls like cat facts, weaving results into local AI conversations for powerful agency.
/home/mike/repos/MikeLev.in/_posts/2025-06-11-unmetered-robot-army-browser-automation.md  # 15,018 tokens (2,447,073 / 4,251,011 total)
  └─ A case study on debugging a Python script that swaps workflow steps and implementing a 'Simon Says' widget to teach a local LLM MCP tool-calling.
/home/mike/repos/MikeLev.in/_posts/2025-06-11-simon-says-make-mcp-call-local-llm-tools.md  # 16,983 tokens (2,464,056 / 4,235,993 total)
  └─ A case study on implementing and adding observability to a local LLM tool-calling (MCP) system, moving from a rigid prototype to a flexible training widget.
/home/mike/repos/MikeLev.in/_posts/2025-06-10-how-i-trained-my-local-llm-to-be-an-mcp-client.md  # 26,401 tokens (2,490,457 / 4,219,010 total)
  └─ A practical guide and case study on implementing local LLM tool-calling from scratch using Ollama, Python, and a custom Model Context Protocol (MCP).
/home/mike/repos/MikeLev.in/_posts/2025-06-10-htmx-reactive-ui-case-study.md  # 3,269 tokens (2,493,726 / 4,192,609 total)
  └─ Create a dynamic, self-disabling button with HTMX out-of-band swaps. A case study on server-side state management without complex JavaScript.
/home/mike/repos/MikeLev.in/_posts/2025-06-10-state-management-duplicate-prevention-bug.md  # 4,588 tokens (2,498,314 / 4,189,340 total)
  └─ A case study on debugging a server-side race condition in Python where a persistent session key in a DictLikeDB prevents startup messages after a reboot.
/home/mike/repos/MikeLev.in/_posts/2025-06-10-perfect-pebble-tech-movement-strategy.md  # 9,178 tokens (2,507,492 / 4,184,752 total)
  └─ A strategic dialogue on launching Pipulate, a local-first software project, using a minimalist, philosophy-driven marketing plan co-developed with an AI.
/home/mike/repos/MikeLev.in/_posts/2025-06-08-hybrid-ai-assisted-refactoring-case-study.md  # 7,509 tokens (2,515,001 / 4,175,574 total)
  └─ A case study on refactoring a legacy Python plugin by transplanting methods into a modern, template-based architecture using a hybrid human-AI workflow.
/home/mike/repos/MikeLev.in/_posts/2025-06-08-migrate-github-pages-private-public.md  # 8,359 tokens (2,523,360 / 4,168,065 total)
  └─ A step-by-step guide to wiping a Git repository's history using an orphan branch and force push to migrate a Jekyll site from private to public GitHub Pages.
/home/mike/repos/MikeLev.in/_posts/2025-06-08-prompt-and-pray.md  # 12,816 tokens (2,536,176 / 4,159,706 total)
  └─ Resolve a `git pull` conflict in a Nix Flake auto-update system by implementing a 'copy-on-first-run' pattern for a user-editable Jupyter Notebook.
/home/mike/repos/MikeLev.in/_posts/2025-06-07-polishing-aligning-abstraction-focusing-lenses-llm-ai.md  # 20,115 tokens (2,556,291 / 4,146,890 total)
  └─ A case study in refactoring a Python and HTMX application by moving hardcoded role configurations into a central config and purifying inline CSS for better semantics.
/home/mike/repos/MikeLev.in/_posts/2025-05-31-ai-git-detective-commit-habits-code-forensics.md  # 3,798 tokens (2,560,089 / 4,126,775 total)
  └─ AI coding assistants like Claude now use git history for detective work, changing how developers should write commit messages.
/home/mike/repos/MikeLev.in/_posts/2025-05-27-python-gnome-scripting-existential-ai.md  # 12,192 tokens (2,572,281 / 4,122,977 total)
  └─ Automating GNOME virtual desktop setup across 7 screens using Python, wmctrl, and xdotool, with insights from AI collaboration.
/home/mike/repos/MikeLev.in/_posts/2025-05-27-circular-self-documenting-llm-training-api-ecosystem.md  # 10,588 tokens (2,582,869 / 4,110,785 total)
  └─ Botify Trifecta: An intelligent developer ecosystem for Botify API (BQLv1/BQLv2) integration, CSV downloads, auto-documentation, and Jupyter debugging.
/home/mike/repos/MikeLev.in/_posts/2025-05-26-botify-api-openapi-deconstruction-ai-analysis.md  # 13,076 tokens (2,595,945 / 4,100,197 total)
  └─ In-depth AI analysis of Botify API's v1 OpenAPI (Swagger) specification, detailing architecture, RESTful design, BQLv2, jobs, and data models.
/home/mike/repos/MikeLev.in/_posts/2025-05-26-developer-tools-multi-ai-enhancement.md  # 33,118 tokens (2,629,063 / 4,087,121 total)
  └─ Enhancing Pipulate's Python workflow tool for flexible step splicing (top/bottom insertion), cosmetic renaming, and UI-consistent revert buttons using AI.
/home/mike/repos/MikeLev.in/_posts/2025-05-25-ai-genie-hide-show-debug-ui.md  # 9,096 tokens (2,638,159 / 4,054,003 total)
  └─ Developer's journal on implementing a 'Hide/Show Code' UI feature in Pipulate for Botify Python API snippets using HTMX, detailing AI-assisted development challenges and strategies.
/home/mike/repos/MikeLev.in/_posts/2025-05-24-api-logs-copy-paste-ready-jupyter-notebooks.md  # 9,924 tokens (2,648,083 / 4,044,907 total)
  └─ Details the iterative AI-assisted development process for enhancing Botify API BQL query logging in Pipulate, focusing on creating copy-paste ready Python snippets for Jupyter Notebooks and robust API token handling for improved transparency and reproducibility.
/home/mike/repos/MikeLev.in/_posts/2025-05-24-evolving-prompt-fu-command-line-dynamic-ai-context.md  # 15,873 tokens (2,663,956 / 4,034,983 total)
  └─ Details the evolution of prompt_foo.py, a Python script for generating XML context for LLMs, focusing on adding command-line prompt input via --prompt, with AI-assisted development insights.
/home/mike/repos/MikeLev.in/_posts/2025-05-23-fasthtml-htmx-python-endpoints.md  # 18,309 tokens (2,682,265 / 4,019,110 total)
  └─ Discusses Python web framework evolution, FastHTML/HTMX on Starlette/Uvicorn, and implementing robust CSV file downloads using HTTP headers and path/query parameters in the Pipulate project.
/home/mike/repos/MikeLev.in/_posts/2025-05-23-force-multiplying-ikigai-in-ai-age.md  # 18,242 tokens (2,700,507 / 4,000,801 total)
  └─ Planning and refining Pipulate's AI-driven web audit workflows, including interactive site crawlers with D3.js, selenium-wire data capture, and LLM-assisted analysis for SEO and client engagement.
/home/mike/repos/MikeLev.in/_posts/2025-05-22-beyond-40-tech-wisdom-ai.md  # 4,867 tokens (2,705,374 / 3,982,559 total)
  └─ Author's reflections on lifelong digital journaling, AI's role in augmenting thought, and the Pipulate project's aim to unlock knowledge from texts.
/home/mike/repos/MikeLev.in/_posts/2025-05-22-the-calm-before-the-nlweb.md  # 4,525 tokens (2,709,899 / 3,977,692 total)
  └─ Explores the Natural Language Web (NLWeb) proposal, its reliance on schema.org structured data (JSON-LD, RDFa), and using LLMs as dynamic web servers for AI-driven Browse.
/home/mike/repos/MikeLev.in/_posts/2025-05-21-ai-wrangling-code-transparency.md  # 40,557 tokens (2,750,456 / 3,973,167 total)
  └─ Detailed journal of refactoring Pipulate's Botify CSV downloader using Gemini and Cursor AI for BQL query transparency, addressing API quirks and HTMX chain reactions.
/home/mike/repos/MikeLev.in/_posts/2025-05-20-ai-workflow-automation-living-book.md  # 12,148 tokens (2,762,604 / 3,932,610 total)
  └─ Developer's journal on balancing deterministic scripts and LLM AI for workflow automation in the Pipulate project, focusing on code markers for a CREATE, SPLICE, SWAP pattern.
/home/mike/repos/MikeLev.in/_posts/2025-05-19-core-workflow-helpers-development.md  # 5,606 tokens (2,768,210 / 3,920,462 total)
  └─ Developer journal on refining Pipulate's workflow creation tools (create_workflow.py, splice_workflow_step.py), UI/CSS cleanup (PicoCSS), Roles feature, and AI-assisted documentation for a tech book.
/home/mike/repos/MikeLev.in/_posts/2025-05-19-ai-tools-that-make-tools.md  # 5,136 tokens (2,773,346 / 3,914,856 total)
  └─ Explores the 'tools making tools' paradigm, from hardware abstraction like NVIDIA CUDA to AI LLMs simplifying programming via natural language.
/home/mike/repos/MikeLev.in/_posts/2025-05-18-css-fasthtml-ast-helper-scripts-python.md  # 23,877 tokens (2,797,223 / 3,909,720 total)
  └─ Guide to refactoring inline CSS styles in Python web projects (Pipulate, FastHTML) using AST helper scripts, moving towards semantic classes and avoiding utility class bloat.
/home/mike/repos/MikeLev.in/_posts/2025-05-18-refactoring-ai-css-cleanup.md  # 31,842 tokens (2,829,065 / 3,885,843 total)
  └─ A weekend refactor journey: breaking out plugins, leveraging AI with prompt_foo.py, and automating CSS cleanup. Despite challenges, the server's running and UI looks good—a solid foundation for deeper style refactoring.
/home/mike/repos/MikeLev.in/_posts/2025-05-16-llm-code-validation-developer-tools.md  # 6,404 tokens (2,835,469 / 3,854,001 total)
  └─ Journal detailing the AI-assisted iterative development and debugging of splice_workflow_step.py, a Python script for Pipulate, reflecting on LLMs as coders and the successful creation of this developer helper tool.
/home/mike/repos/MikeLev.in/_posts/2025-05-16-user-roles-developer-velocity.md  # 11,401 tokens (2,846,870 / 3,847,597 total)
  └─ Journal entry detailing Pipulate's strategic development: planning user roles for plugin visibility, considering inter-workflow linking, and prioritizing the creation of developer tools like splice_workflow_step.py for workflow management.
/home/mike/repos/MikeLev.in/_posts/2025-05-15-compounding-craft-future-proof-tech-skills-ai.md  # 4,918 tokens (2,851,788 / 3,836,196 total)
  └─ Learn to future-proof tech skills against obsolescence using foundational tools like Linux, Python, vim, git, Nix (LPvgn) through iterative wins and personal agency.
/home/mike/repos/MikeLev.in/_posts/2025-05-15-ai-coding-assistant-python-helpers.md  # 11,081 tokens (2,862,869 / 3,831,278 total)
  └─ Explores challenges with AI coding assistants for precise file modifications and details the creation of Python scripts (create_workflow.py, splice_workflow_step.py) for deterministic Pipulate workflow templating and extension.
/home/mike/repos/MikeLev.in/_posts/2025-05-14-ai-precision-paradox-helpful-code-assistants-astray.md  # 3,030 tokens (2,865,899 / 3,820,197 total)
  └─ Discusses challenges of Large Language Models (LLMs) in precise coding tasks, AI 'helpfulness' causing errors, and strategies like deterministic scripts & specific prompting.
/home/mike/repos/MikeLev.in/_posts/2025-05-13-modular-widget-design-ai-workflow.md  # 3,527 tokens (2,869,426 / 3,817,167 total)
  └─ Insights into modular software widget design for efficient workflow creation and AI-assisted development. Explores refactoring strategies and naming conventions.
/home/mike/repos/MikeLev.in/_posts/2025-05-12-pragmatic-future-proof-software-htmx-python.md  # 9,335 tokens (2,878,761 / 3,813,640 total)
  └─ Developer reflections on pragmatic software design, choosing HTMX/FastHTML for Python web UIs, Pipulate's "chain reaction" workflow, and future-proofing against JavaScript framework churn. Discusses computational notebook history.
/home/mike/repos/MikeLev.in/_posts/2025-05-12-browser-downloads-automation-selenium-chrome-fasthtml.md  # 19,289 tokens (2,898,050 / 3,804,305 total)
  └─ Discusses challenges controlling Chrome's default download location in Selenium automation for local-first apps and the strategic shift to a user-driven multi-file upload widget.
/home/mike/repos/MikeLev.in/_posts/2025-05-11-google-login-test-selenium-ai.md  # 15,268 tokens (2,913,318 / 3,785,016 total)
  └─ Details the implementation of Selenium session persistence for browser automation, focusing on Google login tests, Chrome user profile management, and techniques to avoid bot detection.
/home/mike/repos/MikeLev.in/_posts/2025-05-10-selenium-wire-html-header-capture-coding-log.md  # 9,234 tokens (2,922,552 / 3,769,748 total)
  └─ Details Pipulate's browser automation development using Selenium-Wire to crawl and save web page data (headers, source HTML, DOM) to a reversible file system structure.
/home/mike/repos/MikeLev.in/_posts/2025-05-10-beyond-dom-capturing-full-web-context-selenium-automation.md  # 23,833 tokens (2,946,385 / 3,760,514 total)
  └─ Explores web crawling challenges and solutions for capturing DOM, source HTML, and headers using Selenium and `selenium-wire` for transparent, local web data storage.
/home/mike/repos/MikeLev.in/_posts/2025-05-09-ai-assisted-browser-automation-selenium-nix-flakes.md  # 18,627 tokens (2,965,012 / 3,736,681 total)
  └─ Guide to integrating Selenium browser automation into the Pipulate project using Nix flakes for cross-platform (macOS, Linux) support, detailing flake.nix and requirements.txt modifications and AI-assisted troubleshooting.
/home/mike/repos/MikeLev.in/_posts/2025-05-09-webmaster-nix-selenium-http-status-browser-control.md  # 17,917 tokens (2,982,929 / 3,718,054 total)
  └─ Cross-platform (macOS, Linux) browser automation using Selenium and Nix Flakes, detailing HTTP status code retrieval via JavaScript Performance API.
/home/mike/repos/MikeLev.in/_posts/2025-05-09-nix-flakes-normalize-dev-selenium-macos-linux.md  # 8,410 tokens (2,991,339 / 3,700,137 total)
  └─ Guide to achieving cross-platform (macOS, Linux) browser automation using Selenium and Nix Flakes, controlling host Chrome via chromedriver or webdriver-manager.
/home/mike/repos/MikeLev.in/_posts/2025-05-09-nixos-selenium-host-browser-automation-nix-flakes.md  # 6,947 tokens (2,998,286 / 3,691,727 total)
  └─ Guide to achieving reliable host browser automation on NixOS using Selenium and Nix Flakes. Addresses FHS binary issues and details a working POC with chromedriver.
/home/mike/repos/MikeLev.in/_posts/2025-05-08-github-pages-home-hosting-jekyll.md  # 2,722 tokens (3,001,008 / 3,684,780 total)
  └─ Guide to creating a Nix flake for a multi-site Jekyll development environment, managing ports, Ruby versions, and gems with a custom `jes` script for local hosting.
/home/mike/repos/MikeLev.in/_posts/2025-05-08-ai-editor-arms-race.md  # 5,815 tokens (3,006,823 / 3,682,058 total)
  └─ Developer log on Pipulate SEO software progress, focusing on AI-assisted coding with Claude/Cursor AI for FastHTML/HTMX, plugin architecture refinement, and managing AI context.
/home/mike/repos/MikeLev.in/_posts/2025-05-06-pipulate-software-reimagined-nix-wet-workflows-local-llm.md  # 2,562 tokens (3,009,385 / 3,676,243 total)
  └─ Explore Pipulate, a local-first software system featuring Nix Flakes for reproducible environments, WET workflows, local LLM integration, and a unique 'magic cookie' installation.
/home/mike/repos/MikeLev.in/_posts/2025-05-06-seamless-nix-flake-deployments-magic-cookie-auto-update.md  # 2,730 tokens (3,012,115 / 3,673,681 total)
  └─ Learn to build a "magic cookie" auto-updating system for Nix Flakes, enabling git-less installation and seamless cross-platform software distribution.
/home/mike/repos/MikeLev.in/_posts/2025-05-05-nix-flakes-cure-fragile-jekyll-ruby-setups.md  # 3,532 tokens (3,015,647 / 3,670,951 total)
  └─ Use Nix flakes to create stable, reproducible Jekyll development environments. Solves Ruby dependency issues, native gem compilation errors, and cross-project inconsistencies.
/home/mike/repos/MikeLev.in/_posts/2025-05-04-custom-branding-white-labeling-seo-software.md  # 4,765 tokens (3,020,412 / 3,667,419 total)
  └─ Guide to enabling white-labeling for Pipulate software via command-line arguments during installation using a modified bash script, Nix, and an app_name.txt file.
/home/mike/repos/MikeLev.in/_posts/2025-05-04-cursor-rules-project-workspace-git-solution.md  # 3,398 tokens (3,023,810 / 3,662,654 total)
  └─ Solve Cursor AI configuration issues by version controlling .mdc rule files within a Git repo using symbolic links (ln -s) on Linux, macOS, or NixOS.
/home/mike/repos/MikeLev.in/_posts/2025-05-04-jekyll-bash-script-swap-template-files-testing.md  # 3,943 tokens (3,027,753 / 3,659,256 total)
  └─ Detailed guide on creating a Bash script to toggle Jekyll template files (_layouts, CSS, index.md) using mv commands for debugging website issues like traffic drops. Includes final script and discussion on safe placement in _scripts/.
/home/mike/repos/MikeLev.in/_posts/2025-05-04-agentic-coding-wrangling-ai-assistants.md  # 13,701 tokens (3,041,454 / 3,655,313 total)
  └─ Consolidating Pipulate docs (.cursorrules, .mdc) via Gemini AI. Covers AI rules, HTMX patterns, Nix setup, workflow guide, and Parameter Buster for Botify.
/home/mike/repos/MikeLev.in/_posts/2025-05-02-home-hosting-bots-seo-signals-google-dominance.md  # 3,400 tokens (3,044,854 / 3,641,612 total)
  └─ Analysis of Google's search dominance amid AI challenges (ChatGPT, Perplexity), driving the need for home hosting, web log monitoring, and prioritizing SEO tool (Pipulate) development.
/home/mike/repos/MikeLev.in/_posts/2025-04-30-guiding-llms-pipulate-workflow-htmx-patterns.md  # 13,494 tokens (3,058,348 / 3,638,212 total)
  └─ Technical guide detailing Pipulate workflow development patterns, focusing on HTMX chain reactions for step progression and implementing placeholder steps. Includes code examples and LLM interaction context.
/home/mike/repos/MikeLev.in/_posts/2025-04-29-nix-flakes-magic-cookies-self-updating-environment.md  # 21,414 tokens (3,079,762 / 3,624,718 total)
  └─ Automate Pipulate software setup with a two-command Nix installer using `curl | sh`. Details auto-updates via SSH deploy key ('magic cookie') and Nix flakes.
/home/mike/repos/MikeLev.in/_posts/2025-04-29-nixos-jekyll-git-push-self-hosted-deployment.md  # 9,427 tokens (3,089,189 / 3,603,304 total)
  └─ Configure NixOS for self-hosting a Jekyll blog via Git push deployment using SSH hooks, Nginx, and a Flake-based system configuration.
/home/mike/repos/MikeLev.in/_posts/2025-04-29-git-revert-specific-files-jekyll-traffic.md  # 8,783 tokens (3,097,972 / 3,593,877 total)
  └─ How to revert specific Jekyll template files (like _layouts/default.html, _posts.html, CSS) to an older commit using git checkout <hash> -- <file> and git mv to fix issues like traffic drops without losing newer content or Git history.
/home/mike/repos/MikeLev.in/_posts/2025-04-27-refining-pipulate-widgets-ux-ai-collaboration.md  # 13,505 tokens (3,111,477 / 3,585,094 total)
  └─ Refining Pipulate web widgets (Pre, JS, Mermaid, Prism, MarkedJS) for UI/UX consistency using AI. Fixes display logic, locked states, styling, and adds Markdown.
/home/mike/repos/MikeLev.in/_posts/2025-04-27-integrating-prismjs-pandas-html-table-widgets.md  # 10,240 tokens (3,121,717 / 3,571,589 total)
  └─ Implementing Prism.js syntax highlighting and Pandas to_html table widgets in a Pipulate/FastHTML project using HTMX. Details Python code and AI collaboration.
/home/mike/repos/MikeLev.in/_posts/2025-04-27-local-javascript-download-script.md  # 12,529 tokens (3,134,246 / 3,561,349 total)
  └─ Details creating a Python script to download and save JavaScript libraries like markedjs locally for the Pipulate project, managing static assets.
/home/mike/repos/MikeLev.in/_posts/2025-04-26-fasthtml-htmx-javascript-rendering.md  # 14,647 tokens (3,148,893 / 3,548,820 total)
  └─ Debugging and fixing Rich table HTML & Mermaid diagram rendering in FastHTML/HTMX widgets using AI assistance. Details `_raw=True`, `NotStr`, and JS initialization timing.
/home/mike/repos/MikeLev.in/_posts/2025-04-26-llm-architecture-ai-collaboration-coding-workflows.md  # 8,854 tokens (3,157,747 / 3,534,173 total)
  └─ Explores AI as real intelligence via coding, details LLM ephemeral instance architecture, and positions AI as a translator/collaborator for technical workflows.
/home/mike/repos/MikeLev.in/_posts/2025-04-26-htmx-widgets-ai-implementation.md  # 12,717 tokens (3,170,464 / 3,525,319 total)
  └─ Implementing HTMX widgets (Rich table, JS execution, Markdown) in Pipulate workflows using FastHTML, AI planning (Gemini/Claude), and super-prompts. Discusses architecture and UX.
/home/mike/repos/MikeLev.in/_posts/2025-04-25-ai-code-assist-seo-traffic-drop-cls-fix.md  # 3,315 tokens (3,173,779 / 3,512,602 total)
  └─ Debugging SEO issues caused by AI-assisted CLS fixes. How using 'visibility: hidden' tanked traffic and the switch to 'opacity' for better indexing.
/home/mike/repos/MikeLev.in/_posts/2025-04-24-modern-interactive-toc-tocbot-guide.md  # 5,905 tokens (3,179,684 / 3,509,287 total)
  └─ Create modern, interactive Tables of Contents (ToCs) for websites using JavaScript (Tocbot) and CSS. Features scroll-spying, smooth scroll, and responsive design.
/home/mike/repos/MikeLev.in/_posts/2025-04-24-jekyll-front-matter-seo-social-metadata-guide.md  # 4,835 tokens (3,184,519 / 3,503,382 total)
  └─ Guide to structuring Jekyll front matter using nested YAML for Open Graph (OG), Twitter Cards, featured images, and SEO. Includes Liquid template examples.
/home/mike/repos/MikeLev.in/_posts/2025-04-23-vim-regex-google-docs-markdown-cleanup.md  # 3,128 tokens (3,187,647 / 3,498,547 total)
  └─ Use Vim/Neovim regex commands to automatically clean up Google Docs Markdown exports, fixing footnote numbers, extra backslashes, and citation pipe characters.
/home/mike/repos/MikeLev.in/_posts/2025-04-23-digital-independence-solarpunk-future-visions-self-hosting.md  # 22,002 tokens (3,209,649 / 3,495,419 total)
  └─ Explores digital independence via self-hosting and AI learning, researching future societies like Solarpunk, Elon Musk's vision, Burning Man principles, and sustainable tech like Aptera & Stella Terra.
/home/mike/repos/MikeLev.in/_posts/2025-04-23-pfsense-firewall-secure-home-network-hosting-setup.md  # 5,425 tokens (3,215,074 / 3,473,417 total)
  └─ Guide configuring pfSense firewall on mini PC (Topton N100) for secure home hosting with Verizon Fios. Covers initial setup, ONT connection, resolving IP conflict with ISP router (CR1000A) by setting it to AP mode.
/home/mike/repos/MikeLev.in/_posts/2025-04-22-optimizing-jekyll-rendering.md  # 1,775 tokens (3,216,849 / 3,467,992 total)
  └─ Optimize Jekyll build performance by speeding up related posts generation. Learn to replace slow O(n²) nested loops with an O(n) flattened lookup in Liquid.
/home/mike/repos/MikeLev.in/_posts/2025-04-22-python-rich-widgets-fasthtml-htmx.md  # 4,843 tokens (3,221,692 / 3,466,217 total)
  └─ Using Python's Rich library with FastHTML/HTMX to generate server-side HTML fragments (tables, widgets) with inline styles for lean web UI components.
/home/mike/repos/MikeLev.in/_posts/2025-04-22-cursor-ai-updates-nixos.md  # 3,343 tokens (3,225,035 / 3,461,374 total)
  └─ Guide to automatically installing the latest Cursor AI editor AppImage on NixOS via a custom activation script in configuration.nix for updates.
/home/mike/repos/MikeLev.in/_posts/2025-04-21-fasthtml-anywidget-host.md  # 17,585 tokens (3,242,620 / 3,458,031 total)
  └─ Technical blueprint for hosting anywidget widgets in a minimal FastHTML environment using WebSockets, bypassing Jupyter infrastructure. Analyzes AFM spec & state synchronization challenges.
/home/mike/repos/MikeLev.in/_posts/2025-04-21-generate-cursor-rules.md  # 6,029 tokens (3,248,649 / 3,440,446 total)
  └─ Using Cursor AI to analyze Pipulate Botify workflows, generate .cursorrules, and create training material for an embedded LLM user assistant.
/home/mike/repos/MikeLev.in/_posts/2025-04-21-regex-google-docs-markdown.md  # 4,728 tokens (3,253,377 / 3,434,417 total)
  └─ Use Vim regex commands to clean Markdown from Google Docs: automatically add sup tags to footnotes, remove excess backslashes, & conditionally escape pipes.
/home/mike/repos/MikeLev.in/_posts/2025-04-21-bing-search-api.md  # 21,637 tokens (3,275,014 / 3,429,689 total)
  └─ Detailed guide to Microsoft Bing Search API suite (Web, Image, News, Custom, Visual, Entity, etc.), pricing, terms, Python SDK/REST implementation, IndexNow, Webmaster Tools, Azure AI integration, and LLM grounding rules.
/home/mike/repos/MikeLev.in/_posts/2025-04-20-widgets-in-workflows.md  # 14,607 tokens (3,289,621 / 3,408,052 total)
  └─ Technical guide on implementing revert_control_advanced and widget_container in Pipulate for consistent rich content display (trees, charts) in workflow UIs using FastHTML/HTMX.
/home/mike/repos/MikeLev.in/_posts/2025-04-20-file-polling-progress-indicator.md  # 26,122 tokens (3,315,743 / 3,393,445 total)
  └─ Implementing automatic polling and indeterminate progress indicators (PicoCSS) for asynchronous Botify CSV API exports using Python, HTMX, and AI assistance (Gemini, Grok, ChatGPT). Includes AI comparison and HTMX chain reaction debugging.
/home/mike/repos/MikeLev.in/_posts/2025-04-19-export-botify-csv-api.md  # 56,083 tokens (3,371,826 / 3,367,323 total)
  └─ Develop a Pipulate workflow for Botify CSV export via API. Covers Botify URL parsing, BQL queries, analysis slugs, click depth calculation, API export limits, job polling, and download handling using Python and AI assistants.
/home/mike/repos/MikeLev.in/_posts/2025-04-19-detecting-nix-shell-environments.md  # 1,694 tokens (3,373,520 / 3,311,240 total)
  └─ Learn how to reliably detect if you are inside a Nix shell or nix develop environment using a simple bash alias checking IN_NIX_SHELL or PS1 prompt.
/home/mike/repos/MikeLev.in/_posts/2025-04-18-nixos-failed-to-install-bootloader.md  # 4,623 tokens (3,378,143 / 3,309,546 total)
  └─ Troubleshoot NixOS full /boot partition (OSError 28 No space left) during upgrades. Fix when nix-collect-garbage fails due to orphaned EFI boot files.
/home/mike/repos/MikeLev.in/_posts/2025-04-18-accelerating-seo-automation.md  # 13,332 tokens (3,391,475 / 3,304,923 total)
  └─ Implementation plan for Pipulate: adding Playwright browser automation, Botify API CSV export/polling, and URL redirect mapping workflows using Nix. Includes AI code suggestions.
/home/mike/repos/MikeLev.in/_posts/2025-04-18-bridging-code-and-context.md  # 7,507 tokens (3,398,982 / 3,291,591 total)
  └─ Implementing Article Mode in prompt_foo.py script to feed codebase files plus technical articles as structured context for AI analysis and code implementation requests.
/home/mike/repos/MikeLev.in/_posts/2025-04-18-ai-prompts-xml-tags.md  # 7,492 tokens (3,406,474 / 3,284,084 total)
  └─ Implementing Anthropic-style XML tags in Python to structure AI prompts for context generation (prompt_foo.py) and testing with o4-mini-high.
/home/mike/repos/MikeLev.in/_posts/2025-04-18-super-intelligent-ai-coding-assistance.md  # 4,098 tokens (3,410,572 / 3,276,592 total)
  └─ Developer explores controlling super-intelligent AI coding assistants (Claude, Gemini, Grok) for projects like Pipulate, focusing on agentic modes & context improvement.
/home/mike/repos/MikeLev.in/_posts/2025-04-17-git-without-server-local-filesystem.md  # 3,870 tokens (3,414,442 / 3,272,494 total)
  └─ Learn how to use a local filesystem path as a Git remote. Set up a bare repository (git init --bare) for offline version control without needing a server.
/home/mike/repos/MikeLev.in/_posts/2025-04-17-github-pages-logfiles.md  # 4,586 tokens (3,419,028 / 3,268,624 total)
  └─ Details the transition from GitHub Pages to self-hosting with NixOS for accessing web server log files to analyze SEO performance and bot traffic.
/home/mike/repos/MikeLev.in/_posts/2025-04-17-ime-mse-psp-tee-sep.md  # 6,043 tokens (3,425,071 / 3,264,038 total)
  └─ Explore Intel IME, AMD PSP, ARM TrustZone, Apple SEP hardware management engines. Learn about OS independence, security functions, and network capabilities like Intel AMT.
/home/mike/repos/MikeLev.in/_posts/2025-04-14-is-grok-better-than-chatgpt.md  # 64,448 tokens (3,489,519 / 3,257,995 total)
  └─ Compares Grok 3 and ChatGPT Plus performance analyzing complex Google Search Console SEO trend data. Includes full AI responses for a free vs paid task.
/home/mike/repos/MikeLev.in/_posts/2025-04-13-cherry-picking.md  # 2,603 tokens (3,492,122 / 3,193,547 total)
  └─ Discover how AI code agents analyze Git history to simplify difficult `git cherry-pick` operations and help manage complex version control workflows.
/home/mike/repos/MikeLev.in/_posts/2025-04-13-modern-seo-techniques.md  # 19,354 tokens (3,511,476 / 3,190,944 total)
  └─ Learn modern SEO strategies for AI: Focus on authenticity, storytelling, and building reputation to be recognized or 'trained into' AI models.
/home/mike/repos/MikeLev.in/_posts/2025-04-12-algorithmic-information-architecture-jekyll-ai.md  # 33,803 tokens (3,545,279 / 3,171,590 total)
  └─ Guide to developing a Python script using AI (Claude/Gemini) & GSC data to analyze Jekyll posts, cluster content via KMeans/TF-IDF, and auto-generate an optimized category hierarchy.
/home/mike/repos/MikeLev.in/_posts/2025-04-11-top-keywords-per-page.md  # 15,698 tokens (3,560,977 / 3,137,787 total)
  └─ Guide to integrating Google Search Console (GSC) keywords into a Jekyll blog using Python & Liquid for display, enhanced Lunr.js search, and meta tags.
/home/mike/repos/MikeLev.in/_posts/2025-04-10-google-search-console-api-python.md  # 25,090 tokens (3,586,067 / 3,122,089 total)
  └─ Use Python and the Google Search Console (GSC) API to analyze SEO performance trends. Learn to fetch granular query/page data and identify movers & shakers.
/home/mike/repos/MikeLev.in/_posts/2025-04-10-jekyll-lunr-static-site-search.md  # 10,599 tokens (3,596,666 / 3,096,999 total)
  └─ Implement Lunr.js client-side search on Jekyll static sites. Details AI-assisted workflow using Claude for setup, coding, and debugging the search feature.
/home/mike/repos/MikeLev.in/_posts/2025-04-09-taming-nix-develop-output-for-ai-assistants.md  # 15,483 tokens (3,612,149 / 3,086,400 total)
  └─ Optimize verbose Nix output for AI coding assistants with a multi-shell strategy that creates a quiet, efficient debugging and automation environment.
/home/mike/repos/MikeLev.in/_posts/2025-04-09-github-pages-blog-arrows.md  # 7,946 tokens (3,620,095 / 3,070,917 total)
  └─ Fix Jekyll blog navigation for multiple daily posts with custom sort_order and flat index Liquid logic for proper chronological sequencing.
/home/mike/repos/MikeLev.in/_posts/2025-04-08-grok-ai-better-than.md  # 23,238 tokens (3,643,333 / 3,062,971 total)
  └─ Discover how Grok’s agentic analysis unlocks hidden topics from stream-of-consciousness blog posts, powering innovative AI SEO and static site search.
/home/mike/repos/MikeLev.in/_posts/2025-04-08-ai-agentic-mode-debugging.md  # 5,999 tokens (3,649,332 / 3,039,733 total)
  └─ Learn how Cursor AI Agent Mode beats git cherry-pick by diagnosing asyncio bugs, analyzing git history, and automating message ordering for seamless debugging.
/home/mike/repos/MikeLev.in/_posts/2025-04-07-static-site-generator-ai-content-strategy.md  # 5,082 tokens (3,654,414 / 3,033,734 total)
  └─ Unleash AI-driven content strategy with static site generators. Use clean Markdown and YAML for efficient LLM analysis and SEO breakthroughs.
/home/mike/repos/MikeLev.in/_posts/2025-04-07-from-blog-to-book-ai-powered-ia.md  # 38,034 tokens (3,692,448 / 3,028,652 total)
  └─ Transform your disorganized blog into a clear book outline and site map using AI frontier models and custom Python scripts.
/home/mike/repos/MikeLev.in/_posts/2025-04-06-llm-seo-software-development.md  # 18,779 tokens (3,711,227 / 2,990,618 total)
  └─ Learn how LLMs guide SEO software development by prioritizing tasks, avoiding rabbit holes, and creating clear, actionable roadmaps.
/home/mike/repos/MikeLev.in/_posts/2025-04-06-cursor-ai-terminal-agent-mode.md  # 14,452 tokens (3,725,679 / 2,971,839 total)
  └─ Discover how Cursor AI's Agent mode terminal on NixOS uses Nix packaging, fhsenv, and APPDIR to create an isolated environment—learn why 'nix develop' is essential.
/home/mike/repos/MikeLev.in/_posts/2025-04-05-ai-context-mcp-llm.md  # 23,469 tokens (3,749,148 / 2,957,387 total)
  └─ Bundle your project code and prompts with a Python script that empowers local LLMs via MCP integration for precise AI analysis.
/home/mike/repos/MikeLev.in/_posts/2025-04-05-fasthtml-python-htmx-updates.md  # 8,035 tokens (3,757,183 / 2,933,918 total)
  └─ Discover how to achieve instant, seamless UI updates using FastHTML, Python HTMX, and AI-powered debugging in a local Nix setup.
/home/mike/repos/MikeLev.in/_posts/2025-04-04-auto-incrementing-composite-keys.md  # 6,071 tokens (3,763,254 / 2,925,883 total)
  └─ Eliminate key paralysis with a smart auto-incrementing composite key system that blends profile, plugin context, and sequential IDs for seamless UX.
/home/mike/repos/MikeLev.in/_posts/2025-04-04-mcp-with-local-llm.md  # 6,593 tokens (3,769,847 / 2,919,812 total)
  └─ Integrate Python MCP servers with your local LLM to automate resource requests beyond RAG, enabling flexible, privacy-first AI workflows.
/home/mike/repos/MikeLev.in/_posts/2025-04-04-copy-pasting-llm-context.md  # 9,202 tokens (3,779,049 / 2,913,219 total)
  └─ Automate LLM code context management with a Python script that concatenates repo files, counts tokens, and builds a manifest for seamless AI input.
/home/mike/repos/MikeLev.in/_posts/2025-04-04-vscode-ai-coding-assistants-forks-vs-plugins.md  # 12,920 tokens (3,791,969 / 2,904,017 total)
  └─ Compare AI coding assistants for VSCode in 2025—discover how full IDE forks differ from integrated plugins for a modern, powerful coding experience.
/home/mike/repos/MikeLev.in/_posts/2025-04-04-colab-vs-local-jupyter.md  # 28,339 tokens (3,820,308 / 2,891,097 total)
  └─ Compare Google Colab and local JupyterLab setups for AI-assisted Python data analysis, emphasizing reproducibility, control, and long-term privacy.
/home/mike/repos/MikeLev.in/_posts/2025-04-03-zero-to-clicks-niche-content.md  # 3,726 tokens (3,824,034 / 2,862,758 total)
  └─ Explore how long-tail, niche content can win organic clicks amid Google's complex search ecosystem and Core Web Vitals demands.
/home/mike/repos/MikeLev.in/_posts/2025-04-02-nixos-appimage.md  # 13,064 tokens (3,837,098 / 2,859,032 total)
  └─ Stay on the bleeding edge with NixOS by auto-fetching vendor AppImages during rebuilds for seamless desktop integration and update control.
/home/mike/repos/MikeLev.in/_posts/2025-04-01-cleaning-noteboook-cell-output-git.md  # 2,333 tokens (3,839,431 / 2,845,968 total)
  └─ Ensure clean, portable Git commits for Jupyter Notebooks by using nbstripout with .gitattributes to eliminate absolute paths across OSs.
/home/mike/repos/MikeLev.in/_posts/2025-04-01-connect-with-botify-workflow.md  # 6,368 tokens (3,845,799 / 2,843,635 total)
  └─ Securely connect to the Botify API with Pipulate’s plugin-based workflow, leveraging HTMX for a reactive, clean UI and streamlined token management.
/home/mike/repos/MikeLev.in/_posts/2025-03-31-dunning-kruger-deep-research-ai-seo.md  # 21,084 tokens (3,866,883 / 2,837,267 total)
  └─ Transform your SEO strategy with AI-driven deep research—overcome Dunning-Kruger biases to unlock true expertise and lasting digital success.
/home/mike/repos/MikeLev.in/_posts/2025-03-31-mcp-ai-api-server.md  # 33,305 tokens (3,900,188 / 2,816,183 total)
  └─ Upgrade your local LLM app with Anthropic’s MCP to execute real tool calls—moving from homegrown hacks to a robust, standard integration.
/home/mike/repos/MikeLev.in/_posts/2025-03-30-integrating-llm-plugin-architecture.md  # 13,385 tokens (3,913,573 / 2,782,878 total)
  └─ Refactor your plugin architecture to integrate LLMs seamlessly with robust dependency injection and improved global scope management.
/home/mike/repos/MikeLev.in/_posts/2025-03-30-tech-churn-vim-mastery.md  # 2,013 tokens (3,915,586 / 2,769,493 total)
  └─ Master terminal and vi/vim skills to outlast tech churn—build a timeless, future-proof foundation that transcends fleeting IDE trends.
/home/mike/repos/MikeLev.in/_posts/2025-03-29-vim-macro-to-lua.md  # 7,660 tokens (3,923,246 / 2,767,480 total)
  └─ Transform VimScript macros into Lua in NeoVim for easier macro editing and HTML escaping—enhanced with AI-assisted refinement.
/home/mike/repos/MikeLev.in/_posts/2025-03-29-jupyter-workflow-exploration.md  # 3,175 tokens (3,926,421 / 2,759,820 total)
  └─ Discover how Jupyter Notebook exploration transitions into Pipulate execution—bridging creative coding and manual HTMX workflow porting for future-proof projects.
/home/mike/repos/MikeLev.in/_posts/2025-03-29-vscode-jupyter-notebook-paths.md  # 18,270 tokens (3,944,691 / 2,756,645 total)
  └─ Discover robust techniques for identifying the file path of Jupyter notebooks across VSCode, Cursor AI, and JupyterLab for consistent workflow execution.
/home/mike/repos/MikeLev.in/_posts/2025-03-28-gsc-1000-row-limit-api.md  # 21,914 tokens (3,966,605 / 2,738,375 total)
  └─ Overcome the Google Search Console 1000-row limit with a Python/Jupyter API workflow that uses AI to paginate data and extract striking keywords.
/home/mike/repos/MikeLev.in/_posts/2025-03-28-google-search-console-api.md  # 32,922 tokens (3,999,527 / 2,716,461 total)
  └─ Harness Python and the Google Search Console API to uncover striking distance keywords—process data with Pandas and integrate SEMrush insights for optimized SEO.
/home/mike/repos/MikeLev.in/_posts/2025-03-28-future-proof-seo-nix.md  # 6,139 tokens (4,005,666 / 2,683,539 total)
  └─ Thrive in the AI SEO era by leveraging Nix and open-source, vendor-independent tools to create high-quality, sustainable content.
/home/mike/repos/MikeLev.in/_posts/2025-03-28-grok-vs-chatgpt-vs-gemini.md  # 47,152 tokens (4,052,818 / 2,677,400 total)
  └─ Compare AI-powered deep research tools—Grok’s Deep Search versus ChatGPT, Gemini, and Perplexity—for speed, depth, and cost-effective in-depth analysis.
/home/mike/repos/MikeLev.in/_posts/2025-03-27-cursor-ai-jupyter-notebook-cells.md  # 14,700 tokens (4,067,518 / 2,630,248 total)
  └─ Discover why Cursor AI fails to read Jupyter Notebook cell outputs and explore workarounds and alternatives for effective AI coding assistance.
/home/mike/repos/MikeLev.in/_posts/2025-03-27-age-of-ai-vibe-coding.md  # 5,746 tokens (4,073,264 / 2,615,548 total)
  └─ Future-proof your career by mastering deep technical skills and strategic focus—beyond the superficial allure of vibe coding in the AI era.
/home/mike/repos/MikeLev.in/_posts/2025-03-26-fastlite-todo-app.md  # 11,171 tokens (4,084,435 / 2,609,802 total)
  └─ Modularize your FastHTML fastlite Todo app by decoupling it from Pipulate with a flexible, plugin-based architecture.
/home/mike/repos/MikeLev.in/_posts/2025-03-25-python-plugin-architectures.md  # 10,690 tokens (4,095,125 / 2,598,631 total)
  └─ Build modular, extensible Python plugins for Pipulate using unified workflows, FastHTML, and MiniDataAPI for dynamic app development.
/home/mike/repos/MikeLev.in/_posts/2025-03-25-workflows-redirect-fix-attention.md  # 5,615 tokens (4,100,740 / 2,587,941 total)
  └─ Discover how Pipulate workflows help redirect your focus and combat digital distractions to reclaim control over your attention.
/home/mike/repos/MikeLev.in/_posts/2025-03-24-websockets-stream-incremental-markdown.md  # 15,920 tokens (4,116,660 / 2,582,326 total)
  └─ Discover real-time Markdown streaming techniques for Python FastHTML chat apps using WebSockets and HTMX for smooth incremental updates.
/home/mike/repos/MikeLev.in/_posts/2025-03-24-grok3-until-our-servers-melt.md  # 14,306 tokens (4,130,966 / 2,566,406 total)
  └─ Discover how Grok3’s resilient AI built a flexible Hello Webpage workflow using a WET coding approach—free until our servers melt.
/home/mike/repos/MikeLev.in/_posts/2025-03-24-ai-edit-code-diff.md  # 7,181 tokens (4,138,147 / 2,552,100 total)
  └─ See how to visually compare AI-edited code with a color-coded HTML diff generated by git diff and ansi2html—making code review intuitive and clear.
/home/mike/repos/MikeLev.in/_posts/2025-03-24-minidataapi-spec-xtra-tutorial.md  # 6,309 tokens (4,144,456 / 2,544,919 total)
  └─ Master MiniDataAPI's .xtra() method for simple, lightweight CRUD operations in Python. This tutorial explains permanent filtering and permission scoping.
/home/mike/repos/MikeLev.in/_posts/2025-03-23-notebook-to-web-app.md  # 9,056 tokens (4,153,512 / 2,538,610 total)
  └─ Transform Jupyter Notebooks into interactive, production-ready web apps with Pipulate. Leverage local AI and HTMX cascading for innovative, data-driven workflows.
/home/mike/repos/MikeLev.in/_posts/2025-03-23-local-ai-workflows-jupyter-nix.md  # 11,319 tokens (4,164,831 / 2,529,554 total)
  └─ Transform Jupyter Notebooks into local, customizable AI workflows with Pipulate and Nix for flexible, portable web apps.
/home/mike/repos/MikeLev.in/_posts/2025-03-22-linux-python-vim-git-htmx.md  # 11,391 tokens (4,176,222 / 2,518,235 total)
  └─ Future-proof your tech stack with Linux, Python, Vim, Git, and HTMX for dynamic, flexible web development.
/home/mike/repos/MikeLev.in/_posts/2025-03-22-fasthtml-htmx-ai-workflows.md  # 23,186 tokens (4,199,408 / 2,506,844 total)
  └─ Refactor AI workflows in Pipulate by embracing WET code with FastHTML and HTMX for explicit, customizable step-by-step development.
/home/mike/repos/MikeLev.in/_posts/2025-03-22-html-over-the-wire.md  # 14,141 tokens (4,213,549 / 2,483,658 total)
  └─ Discover how FastHTML and HTMX enable dynamic web apps by sending HTML over the wire—cutting through JSON complexity with minimal JavaScript.
/home/mike/repos/MikeLev.in/_posts/2025-03-21-navigating-ai-influence.md  # 8,078 tokens (4,221,627 / 2,469,517 total)
  └─ Navigate AI’s influence in development by building explicit, customizable workflows that break conventional molds—embrace WET coding with Pipulate.
/home/mike/repos/MikeLev.in/_posts/2025-03-21-evolving-ai-in-a-bottle.md  # 14,096 tokens (4,235,723 / 2,461,439 total)
  └─ Discover Chip O'Theseus—a local LLM that evolves with AI-assisted Jupyter workflows, blending FastHTML innovation with future-proof tech.
/home/mike/repos/MikeLev.in/_posts/2025-03-20-jupyter-notebook-vscode-cursor.md  # 3,093 tokens (4,238,816 / 2,447,343 total)
  └─ Learn how to run Jupyter Notebooks in Cursor AI using Nix Flakes and Pipulate for seamless live kernel and AI-assisted coding on NixOS.
/home/mike/repos/MikeLev.in/_posts/2025-03-20-dry-vs-wet.md  # 5,017 tokens (4,243,833 / 2,444,250 total)
  └─ Learn how to ditch DRY abstractions and build explicit, customizable pipelines in Pipulate for radical, Jupyter-like workflow flexibility.
/home/mike/repos/MikeLev.in/_posts/2025-03-19-radically-customizing-linear-workflows.md  # 6,469 tokens (4,250,302 / 2,439,233 total)
  └─ Unleash radical customization in Pipulate workflows with explicit, unlooped step handlers—achieve full UI flexibility like Jupyter Notebook cells.
/home/mike/repos/MikeLev.in/_posts/2025-03-19-is-fasthtml-any-good.md  # 9,876 tokens (4,260,178 / 2,432,764 total)
  └─ Discover FastHTML’s Python-powered, JavaScript-free approach for building dynamic web apps with HTMX that simplify web development.
/home/mike/repos/MikeLev.in/_posts/2025-03-18-unparsable-structured-data.md  # 2,608 tokens (4,262,786 / 2,422,888 total)
  └─ Fix JSON-LD structured data errors by removing problematic content and relying on HTML schema markup for error-free SEO.
/home/mike/repos/MikeLev.in/_posts/2025-03-18-jupyter-notebook-pipulate-workflow.md  # 18,625 tokens (4,281,411 / 2,420,280 total)
  └─ Transform Jupyter Notebooks into dynamic web apps with Pipulate’s local-first, LLM-powered workflow engine—streamlined automation and state management at your fingertips.
/home/mike/repos/MikeLev.in/_posts/2025-03-18-automating-seo-workflows.md  # 9,527 tokens (4,290,938 / 2,401,655 total)
  └─ Optimize site crawl efficiency with an automated JavaScript parameter buster that trims URL traps and boosts technical SEO.
/home/mike/repos/MikeLev.in/_posts/2025-03-18-open-source-seo.md  # 2,091 tokens (4,293,029 / 2,392,128 total)
  └─ Discover how I merged Botifython and Pipulate into one unified open source SEO codebase using smart app naming and streamlined workflows.
/home/mike/repos/MikeLev.in/_posts/2025-03-16-hot-prompt-injection-ai-workflow.md  # 10,597 tokens (4,303,626 / 2,390,037 total)
  └─ Boost your AI workflows with hot prompt injection. Integrate custom training prompts into modular FastHTML workflows for contextual AI assistance.
/home/mike/repos/MikeLev.in/_posts/2025-03-16-radical-simplicity-local-first.md  # 9,306 tokens (4,312,932 / 2,379,440 total)
  └─ Pipulate is a local-first desktop framework that simplifies web development with integrated LLMs and modular pipeline workflows.
/home/mike/repos/MikeLev.in/_posts/2025-03-16-ai-facilitating-self-improvement.md  # 13,958 tokens (4,326,890 / 2,370,134 total)
  └─ Discover how AI acts as a sounding board for self-improvement and mastery, sparking ideas without replacing true personal agency.
/home/mike/repos/MikeLev.in/_posts/2025-03-15-seo-age-of-llms.md  # 5,522 tokens (4,332,412 / 2,356,176 total)
  └─ Experiment with authentic, human-written SEO strategies on a vanity site to test if genuine content can outshine AI fluff and viral trends.
/home/mike/repos/MikeLev.in/_posts/2025-03-15-self-aware-software.md  # 17,366 tokens (4,349,778 / 2,350,654 total)
  └─ Discover a groundbreaking local-first software system using embedded LLMs and minimal Python/HTMX for self-aware, self-evolving development.
/home/mike/repos/MikeLev.in/_posts/2025-03-15-web-app-fasthtml-htmx.md  # 31,086 tokens (4,380,864 / 2,333,288 total)
  └─ Discover a self-aware software system using embedded LLMs, plain Python, and HTMX for transparent, modular local workflows.
/home/mike/repos/MikeLev.in/_posts/2025-03-14-nixos-upgrade-ollama.md  # 2,711 tokens (4,383,575 / 2,302,202 total)
  └─ Upgrade NixOS effortlessly with Ollama 0.6.0 – experience a clean, deterministic system rebuild with robust rollback and stability.
/home/mike/repos/MikeLev.in/_posts/2025-03-13-future-proof-automation-core.md  # 7,623 tokens (4,391,198 / 2,299,491 total)
  └─ Build a future-proof automation core for AI workflows with a lean, modular design using FastHTML, HTMX, and markdown-driven plugins.
/home/mike/repos/MikeLev.in/_posts/2025-03-13-plugs-slugs-nubs-stubs.md  # 2,692 tokens (4,393,890 / 2,291,868 total)
  └─ Capture and nurture creative idea seeds into full articles with a lean, modular workflow that blends digital journaling and modern web tools.
/home/mike/repos/MikeLev.in/_posts/2025-03-12-nixos-nvidia-cuda-ollama.md  # 1,398 tokens (4,395,288 / 2,289,176 total)
  └─ Optimize NixOS for AI by configuring NVIDIA CUDA support for Ollama, unlocking GPU acceleration on an RTX 3080.
/home/mike/repos/MikeLev.in/_posts/2025-03-12-real-time-ai-research.md  # 14,805 tokens (4,410,093 / 2,287,778 total)
  └─ Discover how real-time AI research is revolutionizing deep search with advanced function calling, challenging traditional vendor lock-in.
/home/mike/repos/MikeLev.in/_posts/2025-03-11-function-calling-for-llms.md  # 15,690 tokens (4,425,783 / 2,272,973 total)
  └─ Deep dive into LLM function calling protocols—from OpenAI's API to Anthropic's MCP—to build secure, flexible systems for external function execution.
/home/mike/repos/MikeLev.in/_posts/2025-03-11-small-world-theory-google.md  # 14,678 tokens (4,440,461 / 2,257,283 total)
  └─ Discover how LLM-assisted small-world search could upend Google’s traditional crawl-and-index model with real-time, context-driven results.
/home/mike/repos/MikeLev.in/_posts/2025-03-11-ai-deep-research.md  # 18,820 tokens (4,459,281 / 2,242,605 total)
  └─ Discover how AI deep research transforms analysis through real-time browsing, transparent citations, and advanced multi-model comparisons.
/home/mike/repos/MikeLev.in/_posts/2025-03-10-python-nix-flake-uv.md  # 7,098 tokens (4,466,379 / 2,223,785 total)
  └─ Modernize your Python Nix Flake by replacing pip/virtualenv with uv for faster dependency management and swift JupyterLab launches—ideal for AI projects.
/home/mike/repos/MikeLev.in/_posts/2025-03-09-agentic-frameworks-vs-browser-automation.md  # 16,607 tokens (4,482,986 / 2,216,687 total)
  └─ Discover a DIY method for local browser automation that uses Playwright and local LLMs for natural language control—ditch complex agentic frameworks.
/home/mike/repos/MikeLev.in/_posts/2025-03-08-python-mcp-server-example.md  # 27,804 tokens (4,510,790 / 2,200,080 total)
  └─ Uncover the pitfalls of Anthropic's MCP protocol with a minimal Python server example that exposes hidden vendor lock-ins and overwhelming complexity.
/home/mike/repos/MikeLev.in/_posts/2025-03-08-nix-flake-python.md  # 3,442 tokens (4,514,232 / 2,172,276 total)
  └─ Achieve consistent, cross-platform Python environments with nix flakes for reproducible venvs and built-in CUDA support on macOS, Windows, and Linux.
/home/mike/repos/MikeLev.in/_posts/2025-03-07-python-htmx-llm-seo.md  # 28,708 tokens (4,542,940 / 2,168,834 total)
  └─ Optimize a Python SEO tool with FastHTML, HTMX, and LLM integration. Learn to streamline workflows and trim code for local-first development.
/home/mike/repos/MikeLev.in/_posts/2025-03-07-llm-code-analysis-test.md  # 14,295 tokens (4,557,235 / 2,140,126 total)
  └─ Explore five LLMs as they blindly test and analyze a unique single-tenant Python codebase, revealing developer insights and tradeoffs.
/home/mike/repos/MikeLev.in/_posts/2025-03-07-reclaiming-the-narrative.md  # 6,321 tokens (4,563,556 / 2,125,831 total)
  └─ Discover how tech giants control public discourse by manipulating hardware startup states and default feeds to shape our narrative.
/home/mike/repos/MikeLev.in/_posts/2025-03-06-learning-htmx.md  # 7,369 tokens (4,570,925 / 2,119,510 total)
  └─ Revive your SEO workflow with Pipulate—a Python-powered tool using HTMX for simple, linear checklists and cross-platform automation.
/home/mike/repos/MikeLev.in/_posts/2025-03-05-distracted-weak-focused-strong.md  # 5,411 tokens (4,576,336 / 2,112,141 total)
  └─ Discover how focused attention and deliberate practice transform distraction into strength—unlock flow state and find your Ikigai.
/home/mike/repos/MikeLev.in/_posts/2025-03-04-sudo-nixos-rebuild-switch-upgrade.md  # 4,588 tokens (4,580,924 / 2,106,730 total)
  └─ Discover how 'sudo nixos-rebuild switch --upgrade' empowers NixOS with reproducible, portable system updates through Infrastructure as Code.
/home/mike/repos/MikeLev.in/_posts/2025-03-03-fasthtml-htmx-llm.md  # 6,614 tokens (4,587,538 / 2,102,142 total)
  └─ Discover how Python FastHTML with HTMX and LLM integration powers a loveworthy, documentation-driven web framework built on Pipulate and Ikigai principles.
/home/mike/repos/MikeLev.in/_posts/2025-03-03-out-of-steam-adenosine.md  # 7,043 tokens (4,594,581 / 2,095,528 total)
  └─ Explore adenosine's role in sleep pressure and cognitive energy, and learn natural strategies to boost productivity.
/home/mike/repos/MikeLev.in/_posts/2025-03-02-giving-grok3-another-chance.md  # 86,500 tokens (4,681,081 / 2,088,485 total)
  └─ Tested Grok 3 for converting Jupyter Notebooks into FastHTML web apps using HTMX, achieving WET, server-driven workflows without over-engineering.
/home/mike/repos/MikeLev.in/_posts/2025-03-01-fighting-analysis-paralysis.md  # 3,584 tokens (4,684,665 / 2,001,985 total)
  └─ Beat analysis paralysis with agile, action-driven SEO workflows and client communication using YAML storytelling and modern tech strategies.
/home/mike/repos/MikeLev.in/_posts/2025-02-28-fasthtml-fastapi-llm-over-training.md  # 12,516 tokens (4,697,181 / 1,998,401 total)
  └─ Discover how LLMs over-trained on FastAPI struggle with innovative FastHTML, exposing the limitations of static models in modern web development.
/home/mike/repos/MikeLev.in/_posts/2025-02-27-workflow-script-for-ai.md  # 14,133 tokens (4,711,314 / 1,985,885 total)
  └─ Tested ChatGPT 4.5 for an efficient workflow to generate client reports with FastHTML, exposing LLM limitations in respecting nuanced constraints.
/home/mike/repos/MikeLev.in/_posts/2025-02-26-commitment-and-consistency.md  # 23,138 tokens (4,734,452 / 1,971,752 total)
  └─ Get psyched for work by embracing commitment and consistency in SEO, with Ikigai-inspired focus and streamlined client project processes.
/home/mike/repos/MikeLev.in/_posts/2025-02-21-kickstarting-ai.md  # 6,193 tokens (4,740,645 / 1,948,614 total)
  └─ Chart a 20‐year plan for mastering enduring AI skills by balancing platform dependencies, API wrapping, and evolving intelligence.
/home/mike/repos/MikeLev.in/_posts/2025-02-20-grok3-markdown-problem.md  # 1,917 tokens (4,742,562 / 1,942,421 total)
  └─ Grok 3’s Copy Text feature strips essential Markdown formatting, disrupting Jekyll workflows—learn why grok.com delivers clean, publication-ready Markdown.
/home/mike/repos/MikeLev.in/_posts/2025-02-20-frozen-core-conundrum.md  # 22,904 tokens (4,765,466 / 1,940,504 total)
  └─ Overcome the Frozen Core Conundrum in AI-powered, local-first web apps by refactoring a single-file Python/HTMX codebase with Pipulate to build BotifyFlow.
/home/mike/repos/MikeLev.in/_posts/2025-02-19-o3-vs-grok-3.md  # 53,937 tokens (4,819,403 / 1,917,600 total)
  └─ Test and compare o3, Grok 3, and Gemini in building a local-first FastHTML/HTMX framework that favors explicit, notebook-like code over DRY abstraction.
/home/mike/repos/MikeLev.in/_posts/2025-02-04-reimagining-web-crawling-in-age-of-ai.md  # 5,563 tokens (4,824,966 / 1,863,663 total)
  └─ Discover The Site Whisperer—an innovative AI-powered web crawler harnessing local LLMs to revolutionize SEO and digital workflows.
/home/mike/repos/MikeLev.in/_posts/2025-02-03-sematic-web-discoverability-ai.md  # 4,781 tokens (4,829,747 / 1,858,100 total)
  └─ Explore how semantic web technologies like Schema.org and RDF are transforming SEO by emphasizing content over URLs for improved discoverability in the AI era.
/home/mike/repos/MikeLev.in/_posts/2025-02-01-future-of-seo-llm.md  # 14,379 tokens (4,844,126 / 1,853,319 total)
  └─ Discover a future-proof SEO framework powered by LLMs, HTMX, and FastHTML for building independent, intelligent SEO tools and agile mini-crawlers.
/home/mike/repos/MikeLev.in/_posts/2025-01-31-open-source-seo-software.md  # 10,855 tokens (4,854,981 / 1,838,940 total)
  └─ Discover Pipulate, a lightweight open source SEO tool built on Python and FastHTML that automates tasks via a flexible pipeline system.
/home/mike/repos/MikeLev.in/_posts/2025-01-25-ai-work-sheep-or-shepherds.md  # 4,414 tokens (4,859,395 / 1,828,085 total)
  └─ Embrace the AI era with proactive creativity—harness critical thinking and timeless tools to master work and stay ahead of passive trends.
/home/mike/repos/MikeLev.in/_posts/2025-01-22-amazon-manufacturer-disintermediation.md  # 4,196 tokens (4,863,591 / 1,823,671 total)
  └─ Explore how niche sellers navigate the Amazon squeeze and manufacturer disintermediation while leveraging Shopify in today’s evolving e-commerce landscape.
/home/mike/repos/MikeLev.in/_posts/2025-01-15-simplifying-state-workflow-refactoring.md  # 11,091 tokens (4,874,682 / 1,819,475 total)
  └─ Streamline multi-step workflows with robust state management and chain reaction control—an elegant refactoring journey for cleaner code and improved UX.
/home/mike/repos/MikeLev.in/_posts/2025-01-14-ai-new-era-of-literacy.md  # 8,165 tokens (4,882,847 / 1,808,384 total)
  └─ Programming literacy fuels the AI era—explore tech evolution from the printing press to Python-powered web frameworks and Unix-inspired workflows.
/home/mike/repos/MikeLev.in/_posts/2025-01-13-vim-indention-selection.md  # 2,462 tokens (4,885,309 / 1,800,219 total)
  └─ Optimized Lunr.js search fields boost client-side indexing with concise meta tags and focused keywords for precise search results.
/home/mike/repos/MikeLev.in/_posts/2025-01-12-breaking-changes-learning-opportunities.md  # 26,269 tokens (4,911,578 / 1,797,757 total)
  └─ Improve code clarity and efficiency with breaking changes using namedtuples and position lookups in a local-first, future-proof Python workflow.
/home/mike/repos/MikeLev.in/_posts/2025-01-11-refactoring-ai-assisted-code.md  # 51,012 tokens (4,962,590 / 1,771,488 total)
  └─ Regain control over AI-generated code by refactoring for clarity and maintainability. Master a transparent, human-driven Python workflow.
/home/mike/repos/MikeLev.in/_posts/2025-01-10-starter-flow.md  # 25,740 tokens (4,988,330 / 1,720,476 total)
  └─ Unlock the power of refined chain reactions in Starter Flow—a web framework using server-side state to simplify persistence and streamline pipeline workflows.
/home/mike/repos/MikeLev.in/_posts/2025-01-09-peak-data-musk-sutskever-wrong.md  # 27,879 tokens (5,016,209 / 1,694,736 total)
  └─ Challenge peak data theory—explore how surfacing outlier information with innovative crawling and ranking methods will redefine search.
/home/mike/repos/MikeLev.in/_posts/2025-01-09-virtual-desktops-future-proof.md  # 4,308 tokens (5,020,517 / 1,666,857 total)
  └─ Unlock a robust workflow with virtual desktops—streamline window management, boost productivity, and escape forced OS upgrades.
/home/mike/repos/MikeLev.in/_posts/2025-01-09-ideas-to-automation.md  # 9,958 tokens (5,030,475 / 1,662,549 total)
  └─ Discover how local open-source LLMs transform natural language into code, empowering innovation and democratizing automation for a new digital era.
/home/mike/repos/MikeLev.in/_posts/2025-01-08-coleco-adam-nixos.md  # 4,622 tokens (5,035,097 / 1,652,591 total)
  └─ Discover how a speed-chess mindset fuses quick habits with deliberate thought to drive smarter, rapid decision-making for both humans and AI.
/home/mike/repos/MikeLev.in/_posts/2025-01-07-finding-focus-and-flow-in-the-age-of-ai.md  # 14,488 tokens (5,049,585 / 1,647,969 total)
  └─ Boost focus and streamline your work with AI-driven pipeline workflows for effective self-management and client organization.
/home/mike/repos/MikeLev.in/_posts/2025-01-07-habit-deliberation-ai.md  # 4,457 tokens (5,054,042 / 1,633,481 total)
  └─ Master rapid decision-making with a speed-chess mindset that fuses instinctive habits with thoughtful analysis for smarter, agile choices.
/home/mike/repos/MikeLev.in/_posts/2025-01-06-the-irrepressible-outlier.md  # 5,500 tokens (5,059,542 / 1,629,024 total)
  └─ Embrace your inner outlier in the digital revolution—from Atari to generative AI—and thrive in a world overflowing with infinite content.
/home/mike/repos/MikeLev.in/_posts/2025-01-06-nixos-nvidia-wayland.md  # 8,733 tokens (5,068,275 / 1,623,524 total)
  └─ Solve NVIDIA graphics issues on NixOS with declarative configuration and robust kernel parameters. Learn fallback strategies for stable Wayland.
/home/mike/repos/MikeLev.in/_posts/2025-01-05-htmx-pipelines-persistent-state.md  # 46,610 tokens (5,114,885 / 1,614,791 total)
  └─ Build a robust HTMX StarterFlow pipeline with multi‐step forms, persistent state (Step 1), and smooth revert/finalize toggling for effective state management.
/home/mike/repos/MikeLev.in/_posts/2025-01-04-anti-patterns-best-practices.md  # 12,177 tokens (5,127,062 / 1,568,181 total)
  └─ Discover how unconventional anti-patterns in web development evolve into best practices with minimalist tools like HTMX and FastHTML.
/home/mike/repos/MikeLev.in/_posts/2025-01-04-un-externalizing-helper-function.md  # 29,519 tokens (5,156,581 / 1,556,004 total)
  └─ Discover how un-externalizing a helper function streamlines pipeline state management and boosts code clarity in minimalist web workflows.
/home/mike/repos/MikeLev.in/_posts/2025-01-03-git-cherry-picking.md  # 20,517 tokens (5,177,098 / 1,526,485 total)
  └─ Master advanced Git techniques for cherry picking and time travel to fix bugs and optimize branch management in your development workflow.
/home/mike/repos/MikeLev.in/_posts/2025-01-02-one-card-flow.md  # 21,768 tokens (5,198,866 / 1,505,968 total)
  └─ Discover One Card Flow—a minimal pipeline workflow with a single textarea input refined by Pipulate for streamlined state management.
/home/mike/repos/MikeLev.in/_posts/2025-01-01-rubber-ducking-with-llm.md  # 29,780 tokens (5,228,646 / 1,484,200 total)
  └─ Harness an LLM for rubber duck debugging—refine your web framework pipeline with creative mantras and simple state-fix solutions.
/home/mike/repos/MikeLev.in/_posts/2024-12-31-fasthtml-htmx-unix-pipes.md  # 36,439 tokens (5,265,085 / 1,454,420 total)
  └─ Discover a Unix pipe–inspired web workflow using FastHTML & HTMX—each step transforms data in a clean, chainable pipeline.
/home/mike/repos/MikeLev.in/_posts/2024-12-30-rabbit-holes-shoulders-of-giants.md  # 9,654 tokens (5,274,739 / 1,417,981 total)
  └─ Uncover a future-proof, local-first tech stack built with Nix, FastHTML, and Anywidget for a hackable, offline alternative to cloud-based apps.
/home/mike/repos/MikeLev.in/_posts/2024-12-30-python-nix-htmx-ollama.md  # 23,576 tokens (5,298,315 / 1,408,327 total)
  └─ Discover a local-first, single-file web framework built with Python, Nix, HTMX, and an integrated on-device LLM for hackable, self-hosted apps.
/home/mike/repos/MikeLev.in/_posts/2024-12-29-the-sound-of-htmx-pipes.md  # 34,724 tokens (5,333,039 / 1,384,751 total)
  └─ Experience the elegance of Unix pipe principles with HTMX in a 10-card pipeline workflow that streamlines web process management using local LLM integration.
/home/mike/repos/MikeLev.in/_posts/2024-12-28-planning-chip-o-theseus.md  # 30,964 tokens (5,364,003 / 1,350,027 total)
  └─ Discover Chip O'Theseus, a project that empowers local LLM with persistent memory and self-modification via a SQLite key-value store and prompt engineering.
/home/mike/repos/MikeLev.in/_posts/2024-12-27-linkgraphectomy.md  # 23,114 tokens (5,387,117 / 1,319,063 total)
  └─ Automate extraction and visualization of massive link graphs using a minimalist, single-file pipeline that harnesses industrial crawler APIs for SEO.
/home/mike/repos/MikeLev.in/_posts/2024-12-26-flow-state-idea-capture-vs-organization.md  # 8,399 tokens (5,395,516 / 1,295,949 total)
  └─ Master the art of capturing ideas in a flow state and organizing them later using minimalist tools like Vim to maintain creative momentum.
/home/mike/repos/MikeLev.in/_posts/2024-12-25-ai-stress-test.md  # 64,379 tokens (5,459,895 / 1,287,550 total)
  └─ Explore AI model o1 Pro in a stress test that refines a complex Python class into a modular, pipeline-based Botify API workflow.
/home/mike/repos/MikeLev.in/_posts/2024-12-24-the-future-was-now.md  # 15,117 tokens (5,475,012 / 1,223,171 total)
  └─ Explore how the Amiga’s legacy mirrors today’s tech cycles and inspires sustainable, minimalist innovation via LPvg, NixOS, and HTMX.
/home/mike/repos/MikeLev.in/_posts/2024-12-23-nixos-wayland-hyprland.md  # 14,056 tokens (5,489,068 / 1,208,054 total)
  └─ Read about my experiment switching from GNOME to Hyprland on NixOS. Discover insights on performance, workspace management, and desktop customization trade-offs.
/home/mike/repos/MikeLev.in/_posts/2024-12-23-gaining-traction.md  # 6,778 tokens (5,495,846 / 1,193,998 total)
  └─ Master strategies for gaining traction in tech—balance AI innovation with organic growth and timeless creative principles.
/home/mike/repos/MikeLev.in/_posts/2024-12-19-rebooting-site.md  # 3,538 tokens (5,499,384 / 1,187,220 total)
  └─ Rediscover timeless computing principles and reclaim simplicity amid tech hype. Embrace Unix, reproducibility, and local-first practices.
/home/mike/repos/MikeLev.in/_posts/2024-12-13-back-to-basics-reclaiming-simplicity.md  # 13,171 tokens (5,512,555 / 1,183,682 total)
  └─ Cut through tech hype by embracing timeless computing principles—build reproducible, local-first systems inspired by Unix simplicity.
/home/mike/repos/MikeLev.in/_posts/2024-12-11-sheet-music-chisel-strikes.md  # 6,184 tokens (5,518,739 / 1,170,511 total)
  └─ Discover how coding can be like writing sheet music—daily chisel-strikes create clear, teachable code and inspire steady progress.
/home/mike/repos/MikeLev.in/_posts/2024-12-10-no-churn.md  # 6,082 tokens (5,524,821 / 1,164,327 total)
  └─ Embrace the No-Churn Movement to build lasting expertise with stable, timeless tech while avoiding the constant trend churn.
/home/mike/repos/MikeLev.in/_posts/2024-12-09-openai-chatgpt-pro-o1.md  # 23,377 tokens (5,548,198 / 1,158,245 total)
  └─ Explore the testing of OpenAI ChatGPT Pro (o1 Release) within a minimalist, server-centric pipeline workflow that integrates local AI and fosters reproducible development.
/home/mike/repos/MikeLev.in/_posts/2024-12-08-claude-o1-collaboration.md  # 44,451 tokens (5,592,649 / 1,134,868 total)
  └─ Explore the Claude & o1 collaboration on a minimalist, server-first workflow framework that uses a single JSON pipeline and HTMX for resumable, linear UI updates.
/home/mike/repos/MikeLev.in/_posts/2024-12-07-zenos-paradox-knuth-brooks.md  # 20,212 tokens (5,612,861 / 1,090,417 total)
  └─ Learn how Knuth, Brooks, and Zeno’s paradox reveal that chasing coding perfection yields diminishing returns—embrace pragmatism and simply ship your code.
/home/mike/repos/MikeLev.in/_posts/2024-12-06-testing-chatgpt-o1-release.md  # 20,615 tokens (5,633,476 / 1,070,205 total)
  └─ Testing OpenAI ChatGPT o1 with a 6,600-line codebase reveals enhanced context processing and clear, actionable project insights.
/home/mike/repos/MikeLev.in/_posts/2024-12-03-david-mayer-donald-trump-censorship.md  # 9,273 tokens (5,642,749 / 1,049,590 total)
  └─ Master progress with deliberate chisel-strikes—learn how incremental Git workflows and direct file-linking on Linux/NixOS build a portable, future-proof system.
/home/mike/repos/MikeLev.in/_posts/2024-12-02-multiple-passes.md  # 9,584 tokens (5,652,333 / 1,040,317 total)
  └─ Unlock lasting progress with small, deliberate chisel-strikes that build digital mastery and sustained flow without burnout.
/home/mike/repos/MikeLev.in/_posts/2024-11-29-banking-wins.md  # 21,387 tokens (5,673,720 / 1,030,733 total)
  └─ Transform endless busywork into a state of flow with an AI-powered SEO tool that turns Sisyphus’ struggle into digital innovation.
/home/mike/repos/MikeLev.in/_posts/2024-11-27-dedumbing-sisyphus.md  # 6,801 tokens (5,680,521 / 1,009,346 total)
  └─ Overcome busywork traps with a minimalist, AI-powered SEO approach—explore antifragility, flow state, and building a meaningful tech legacy.
/home/mike/repos/MikeLev.in/_posts/2024-11-25-pipeline-to-completion.md  # 5,552 tokens (5,686,073 / 1,002,545 total)
  └─ Complete workflows seamlessly with a minimalist pipeline design—using URL keys and a self-healing JSON blob for consistent state transitions.
/home/mike/repos/MikeLev.in/_posts/2024-11-24-wrangling-ai-code-assistants.md  # 997 tokens (5,687,070 / 996,993 total)
  └─ Master the art of wrangling AI coding assistants with precise, genie-proof instructions that prevent unintended code overhauls.
/home/mike/repos/MikeLev.in/_posts/2024-11-24-ai-seo-100-percent-accountability.md  # 9,200 tokens (5,696,270 / 995,996 total)
  └─ BFF SEO dot BOT is born—an innovative project reimagining site organization with smart SEO, streamlined navigation, and local-first precision.
/home/mike/repos/MikeLev.in/_posts/2024-11-24-the-mindful-mirror-model-effect.md  # 8,198 tokens (5,704,468 / 986,796 total)
  └─ Unlock true self-awareness as AI challenges cognitive bias. Embrace the Mindful Mirror Model Effect for profound personal growth.
/home/mike/repos/MikeLev.in/_posts/2024-11-24-brainstorming-book-titles-with-ai.md  # 12,851 tokens (5,717,319 / 978,598 total)
  └─ Unlock creative book title ideas with AI—merge local computing, the LPvg stack, and digital sovereignty for innovative, engaging concepts.
/home/mike/repos/MikeLev.in/_posts/2024-11-23-nixos-warbler-files-disappeared.md  # 3,851 tokens (5,721,170 / 965,747 total)
  └─ Discover how the NixOS Warbler update removed Nautilus and learn the simple config tweaks to restore your Linux GUI file manager on unstable NixOS.
/home/mike/repos/MikeLev.in/_posts/2024-11-23-pipeline-workflow-example.md  # 31,942 tokens (5,753,112 / 961,896 total)
  └─ Explore a pipeline workflow built with FastHTML, HTMX, and MiniDataAPI—enabling robust server-side state management in a localhost-first web app.
/home/mike/repos/MikeLev.in/_posts/2024-11-22-llm-speedbumps.md  # 18,336 tokens (5,771,448 / 929,954 total)
  └─ Explore LLM speedbumps, anti-pattern vaccines, and the localhost revolution—build lean, server-side pipeline workflows with FastHTML, HTMX & MiniDataAPI.
/home/mike/repos/MikeLev.in/_posts/2024-11-21-pipulate-pipeline-born-again.md  # 35,610 tokens (5,807,058 / 911,618 total)
  └─ Revamp your SEO workflow with Pipulate—local-first pipeline processing with FastHTML, HTMX & SQLite for seamless server-side state management.
/home/mike/repos/MikeLev.in/_posts/2024-11-20-flow-state-alternation.md  # 17,054 tokens (5,824,112 / 876,008 total)
  └─ Boost your SEO success by harnessing flow state alternation. Discover how deep focus and AI coding assistants optimize productivity and creativity.
/home/mike/repos/MikeLev.in/_posts/2024-11-19-pipeline-workflow.md  # 35,789 tokens (5,859,901 / 858,954 total)
  └─ Streamline complex workflows with a lightweight, Unix-inspired pipeline system using FastHTML and MiniDataAPI for local automation.
/home/mike/repos/MikeLev.in/_posts/2024-11-18-pattern-alert-this-is-not-fastapi.md  # 24,156 tokens (5,884,057 / 823,165 total)
  └─ Discover how FastHTML’s Unix-inspired design and defensive documentation deliver simplicity over FastAPI’s complexity, with clear state management and smart prompt engineering.
/home/mike/repos/MikeLev.in/_posts/2024-11-17-unix-pipelines-htmx-fasthtml-workflow.md  # 32,352 tokens (5,916,409 / 799,009 total)
  └─ Embrace a Unix-inspired workflow in FastHTML and HTMX to simplify state management, persistence, and debugging in a single-tenant pipeline.
/home/mike/repos/MikeLev.in/_posts/2024-11-16-fighting-dunning-kruger-effect.md  # 27,935 tokens (5,944,344 / 766,657 total)
  └─ Conquer overconfidence with a single-tenant web app that uses file‐based state, HTMX UI, and simple, robust workflows.
/home/mike/repos/MikeLev.in/_posts/2024-11-15-openapi-swagger-json-to-python.md  # 9,892 tokens (5,954,236 / 738,722 total)
  └─ Transform OpenAPI Swagger JSON into practical Python code examples. Automate API integration, enhance documentation, and streamline code generation.
/home/mike/repos/MikeLev.in/_posts/2024-11-13-80-percent-cost-reduction-in-ai-operations.md  # 35,272 tokens (5,989,508 / 728,830 total)
  └─ Discover how AI-native architecture with local/cloud LLM orchestration can reduce AI operational costs by 80% while enhancing privacy and scalability.
/home/mike/repos/MikeLev.in/_posts/2024-11-12-6-click-ease-to-serve-up-bacon.md  # 7,680 tokens (5,997,188 / 693,558 total)
  └─ Future web search: AI uses small world theory (6 degrees) to crawl the internet database. Structure sites for AI model training & RAG.
/home/mike/repos/MikeLev.in/_posts/2024-11-11-how-to-train-your-llm.md  # 14,967 tokens (6,012,155 / 685,878 total)
  └─ Train LLMs like Botify BQL experts: Use curated docs (Jupyter>Markdown) & hot prompt injection for dynamic, just-in-time context.
/home/mike/repos/MikeLev.in/_posts/2024-11-10-i-know-kung-fu-show-me.md  # 16,423 tokens (6,028,578 / 670,911 total)
  └─ Master Botify BQL API with AI help: Python script finds optimal depth & exports link graphs, enabled by prompt injection context.
/home/mike/repos/MikeLev.in/_posts/2024-11-09-jupyter-notebooks-to-markdown.md  # 11,671 tokens (6,040,249 / 654,488 total)
  └─ Workflow to manage Jupyter Notebooks: Use nb-clean for clean git history & jupytext to convert .ipynb to Markdown for docs & LLM training.
/home/mike/repos/MikeLev.in/_posts/2024-11-08-practicing-botify-api.md  # 10,799 tokens (6,051,048 / 642,817 total)
  └─ Practice Botify API with Python notebooks: Fetch projects, analyses, collections, fields & run BQLv2 queries/exports for SEO data analysis.
/home/mike/repos/MikeLev.in/_posts/2024-11-07-structuring-websites-to-train-models.md  # 4,232 tokens (6,055,280 / 632,018 total)
  └─ Structure website content for AI training sets & real-time queries. Use Q&A formats & optimize for AI crawlers & RAG systems for future SEO.
/home/mike/repos/MikeLev.in/_posts/2024-11-06-resilience-while-achieving-ikagi.md  # 6,556 tokens (6,061,836 / 627,786 total)
  └─ Using Ikigai & resilience principles to develop AI-integrated web apps with local LLMs, prompt injection, & future-proof techniques.
/home/mike/repos/MikeLev.in/_posts/2024-11-05-mac-nvim-same-as-nixos-nvim.md  # 5,676 tokens (6,067,512 / 621,230 total)
  └─ Match NeoVim setup on Mac & NixOS using Nix Flakes. Configure flake.nix to install nvim, link init.lua & use unstable channel for consistency.
/home/mike/repos/MikeLev.in/_posts/2024-11-04-figuring-out-a-complex-api.md  # 47,521 tokens (6,115,033 / 615,554 total)
  └─ Learn to navigate the Botify API & BQLv2. Fetch projects, analyses, collections, fields & build queries for SEO data using Python & AI help.
/home/mike/repos/MikeLev.in/_posts/2024-11-03-sse-watchdog-force-live-reload.md  # 3,384 tokens (6,118,417 / 568,033 total)
  └─ Restore FastHTML/Uvicorn live-reload broken by SSE. Use Python watchdog to monitor files & force reliable server restarts for a smooth dev workflow.
/home/mike/repos/MikeLev.in/_posts/2024-11-03-api-enabling-llm-ghost.md  # 24,712 tokens (6,143,129 / 564,649 total)
  └─ Learn how an LLM can control browser DOM updates for CRUD actions via HTMX, WebSockets, and SSE, creating a seamless UI interaction mimicking user input.
/home/mike/repos/MikeLev.in/_posts/2024-11-02-got-my-llm-to-play-nice-with-web-ui.md  # 25,317 tokens (6,168,446 / 539,937 total)
  └─ Debugging LLM-driven UI updates in FastHTML/HTMX. Switched from WebSockets to Server-Sent Events (SSE) for reliable backend-to-frontend command triggering.
/home/mike/repos/MikeLev.in/_posts/2024-11-02-fasthtml-hello-world.md  # 704 tokens (6,169,150 / 514,620 total)
  └─ FastHTML 'Hello World' tutorial: Create web pages using Python functions (e.g., `H1()`, `Body()`) that map to HTML elements, skipping template languages.
/home/mike/repos/MikeLev.in/_posts/2024-11-01-deep-debugging-llm-ghost.md  # 52,480 tokens (6,221,630 / 513,916 total)
  └─ Debugging LLM actions causing UI updates in FastHTML/HTMX. Chronicles WebSocket issues & proposes Server-Sent Events (SSE) as a robust solution.
/home/mike/repos/MikeLev.in/_posts/2024-10-31-rabbit-hole-dev-to-delight-clients.md  # 3,074 tokens (6,224,704 / 461,436 total)
  └─ Developer's reflection on balancing deep AI coding focus ('rabbit hole') with client needs. Strategies for resilience, avoiding distractions & managing workflow.
/home/mike/repos/MikeLev.in/_posts/2024-10-30-giving-gemini-advanced-a-try.md  # 15,940 tokens (6,240,644 / 458,362 total)
  └─ Debugging LLM 'Ghost In The Machine' actions in FastHTML/HTMX. Covers AI-assisted refactoring, enhanced logging via decorators & NixOS helper scripts.
/home/mike/repos/MikeLev.in/_posts/2024-10-30-its-about-delighting-customers.md  # 7,846 tokens (6,248,490 / 442,422 total)
  └─ Prioritize customer delight (Drucker/Deming) in AI-assisted development. Refines workflow via Jupyter prototyping & structured client meeting prep.
/home/mike/repos/MikeLev.in/_posts/2024-10-29-llm-as-ambient-app-intelligence.md  # 5,933 tokens (6,254,423 / 434,576 total)
  └─ Explore ambient LLM intelligence in apps: Details streaming WebSocket chat via Python/FastHTML & prioritizing client value (Drucker/Deming) in AI dev.
/home/mike/repos/MikeLev.in/_posts/2024-10-28-fasthmtl-static-resources.md  # 5,991 tokens (6,260,414 / 428,643 total)
  └─ Manage static resources in FastHTML: Disable CDN defaults via `fast_app(default_hdrs=False)` and use `hdrs=(...)` for local JS/CSS includes.
/home/mike/repos/MikeLev.in/_posts/2024-10-27-slack-zoom-nixos.md  # 6,310 tokens (6,266,724 / 422,652 total)
  └─ Workflow strategy using virtual desktops (7+1 screens) for focus & muscle memory. Includes easy Slack/Zoom install on NixOS via configuration.nix.
/home/mike/repos/MikeLev.in/_posts/2024-10-26-accumulated-chunks-to-real-time-yields.md  # 31,576 tokens (6,298,300 / 416,342 total)
  └─ Implement LLM response streaming in FastHTML/WebSockets via Python generator. Cautious method ensures real-time UI & preserves post-stream JSON parsing.
/home/mike/repos/MikeLev.in/_posts/2024-10-25-i-dont-know-what-to-do-sometimes.md  # 11,589 tokens (6,309,889 / 384,766 total)
  └─ Simulate a Jupyter Notebook UI flow in FastHTML: Plan uses Card components for cell structure, aiding workflow porting from notebooks to web apps.
/home/mike/repos/MikeLev.in/_posts/2024-10-24-api-ai-human-nuance.md  # 9,458 tokens (6,319,347 / 373,177 total)
  └─ Navigating nuance in AI interactions (o1-preview), APIs (FastHTML/JS), & client work. Strategies for managing complexity & effective AI-assisted workflows.
/home/mike/repos/MikeLev.in/_posts/2024-10-23-the-port-for-real-this-time.md  # 11,086 tokens (6,330,433 / 363,719 total)
  └─ Porting apps to FastHTML/Nix: Refactoring ZeroMQ to WebSockets, JSON to SQLite/MiniDataAPI, integrating Botify API, & setting up dev environment.
/home/mike/repos/MikeLev.in/_posts/2024-10-22-llm-ghost-in-the-machine.md  # 7,192 tokens (6,337,625 / 352,633 total)
  └─ Implementing LLM 'Ghost In The Machine': Using AI assist for CRUD updates in FastHTML/HTMX, enhanced logging via decorators, and NixOS helper scripts.
/home/mike/repos/MikeLev.in/_posts/2024-10-21-local-ai-awareness-training.md  # 6,752 tokens (6,344,377 / 345,441 total)
  └─ Enable local LLM to execute CRUD in Python/FastHTML app. Teach JSON commands via system prompt, parse/validate LLM output & execute safely via BaseApp.
/home/mike/repos/MikeLev.in/_posts/2024-10-20-Local-AI-In-The-Dev-Loop.md  # 20,941 tokens (6,365,318 / 338,689 total)
  └─ Implement local LLM command execution in a Python web framework. Plan covers JSON parsing, intent analysis, table lookups, and persistent LLM memory.
/home/mike/repos/MikeLev.in/_posts/2024-10-19-planning-to-win-with-llm.md  # 17,760 tokens (6,383,078 / 317,748 total)
  └─ Plan to modify Python BaseApp framework for LLM awareness: Log user CRUD actions via WebSockets (`chatq`) for real-time context & future RAG integration.
/home/mike/repos/MikeLev.in/_posts/2024-10-18-local-llm-web-framework-integration-plan.md  # 9,543 tokens (6,392,621 / 299,988 total)
  └─ Plan to integrate local LLM, vector DB (FAISS), & SQL DB into Python web framework via NixOS. Covers LLM function calling, context awareness & RAG.
/home/mike/repos/MikeLev.in/_posts/2024-10-17-software-deployment-with-nix-flakes.md  # 14,896 tokens (6,407,517 / 290,445 total)
  └─ Use Nix Flakes for reproducible software deployment and dev environments. Simplifies user setup & ensures consistency, outperforming Docker/pip.
/home/mike/repos/MikeLev.in/_posts/2024-10-16-ai-code-assist-accelerator.md  # 11,983 tokens (6,419,500 / 275,549 total)
  └─ Optimize Cursor AI assistance by consolidating NixOS & NeoVim configs in one 'repos' folder. Includes migrating NeoVim setup from Vimscript to Lua.
/home/mike/repos/MikeLev.in/_posts/2024-10-15-softlaunching-botifython.md  # 6,953 tokens (6,426,453 / 263,566 total)
  └─ Soft launching Botifython: Finalizing Nix Flake config, Git auto-update via SSH, GitHub Pages deployment, and testing reproducible installation for rollout.
/home/mike/repos/MikeLev.in/_posts/2024-10-14-botifython-is-born.md  # 37,665 tokens (6,464,118 / 256,613 total)
  └─ Botifython: Python framework for SEO/AI using FastHTML & Nix Flakes. Guide covers reproducible setup, OOP plugins, chatbot, and data science integration (Pandas/Bokeh).
/home/mike/repos/MikeLev.in/_posts/2024-10-13-oo-baseclass-plugins.md  # 16,285 tokens (6,480,403 / 218,948 total)
  └─ Implement an OOP plugin system for FastHTML using a Python BaseApp class. Covers refining CRUD operations (delete, toggle, sort, insert, update) and routing logic.
/home/mike/repos/MikeLev.in/_posts/2024-10-12-fasthtml-plugin.md  # 13,650 tokens (6,494,053 / 202,663 total)
  └─ Create a plugin-ready Python framework for FastHTML apps using a BaseApp class. Details refactoring steps, CRUD abstraction, and dynamic route registration for modularity.
/home/mike/repos/MikeLev.in/_posts/2024-10-11-spa-test-endpoints.md  # 8,386 tokens (6,502,439 / 189,013 total)
  └─ Learn to create a comprehensive testing suite for FastHTML Single Page Application (SPA) endpoints using Python's unittest and requests library for robust backend validation.
/home/mike/repos/MikeLev.in/_posts/2024-10-10-fasthtml-drag-and-drop.md  # 3,820 tokens (6,506,259 / 180,627 total)
  └─ Implement drag-and-drop sortable lists using FastHTML and SortableJS. Integrates client-side JavaScript with a Python backend endpoint for persistent MiniDataAPI updates.
/home/mike/repos/MikeLev.in/_posts/2024-10-09-refactoring-advice-from-ai.md  # 26,152 tokens (6,532,411 / 176,807 total)
  └─ Leveraging ChatGPT & Claude LLMs for code review and refactoring plans on a Python FastHTML application within a Nix Flake environment.
/home/mike/repos/MikeLev.in/_posts/2024-10-08-unpacking-fasthtml-databases.md  # 6,771 tokens (6,539,182 / 150,655 total)
  └─ Understand FastHTML's database: Guide to defining multiple tables via the `fast_app` function (**kwargs) and unpacking table/dataclass objects.
/home/mike/repos/MikeLev.in/_posts/2024-10-07-chatgpt-o1-code-review.md  # 6,971 tokens (6,546,153 / 143,884 total)
  └─ Code review of a Python FastHTML app using WebSockets & Ollama. Includes analysis of anti-patterns & prompts for AI-assisted refactoring.
/home/mike/repos/MikeLev.in/_posts/2024-10-06-fasththml-websockets-database.md  # 12,763 tokens (6,558,916 / 136,913 total)
  └─ Implement FastHTML's built-in database (multiple tables via `fast_app` API) and WebSockets for persistence and streaming in Python apps.
/home/mike/repos/MikeLev.in/_posts/2024-10-05-ollama-websocket-chat.md  # 15,264 tokens (6,574,180 / 124,150 total)
  └─ Build a real-time chat app using FastHTML and WebSockets, powered by a local Ollama LLM with streaming responses and context.
/home/mike/repos/MikeLev.in/_posts/2024-10-04-fasthtml-framework-opinions.md  # 9,767 tokens (6,583,947 / 108,886 total)
  └─ Understand FastHTML framework opinions: Explore its Flask-like routing, built-in database, HTMX integration, and no-template approach via a CRUD app.
/home/mike/repos/MikeLev.in/_posts/2024-10-03-notebooks-to-fasthtml.md  # 12,179 tokens (6,596,126 / 99,119 total)
  └─ Use WebSockets in FastHTML to manage long-running asynchronous tasks and stream real-time progress updates to the user interface.
/home/mike/repos/MikeLev.in/_posts/2024-10-02-code-as-infrastructure.md  # 7,167 tokens (6,603,293 / 86,940 total)
  └─ Understand Infrastructure as Code via a commented Nix Flake. Explains creating reproducible, cross-platform Python dev environments.
/home/mike/repos/MikeLev.in/_posts/2024-10-01-mac-nix-flake.md  # 5,466 tokens (6,608,759 / 79,773 total)
  └─ Build & refine a cross-platform Nix Flake (Linux/macOS) for Python dev. Includes venv/pip setup, optional CUDA, and tmux scripting.
/home/mike/repos/MikeLev.in/_posts/2024-09-27-jupyter-notebook-to-fasthtml.md  # 4,598 tokens (6,613,357 / 74,307 total)
  └─ Fork or clone a Nix Flake template (Pipulate) to start new projects (Botifython). Guide details Git workflow and cross-platform testing via `nix develop`.
/home/mike/repos/MikeLev.in/_posts/2024-09-26-theres-no-home-like-nix.md  # 9,249 tokens (6,622,606 / 69,709 total)
  └─ Learn FastHTML basics for Python web apps (including HTMX SPA) and manage secrets with python-dotenv within a Nix Flake environment.
/home/mike/repos/MikeLev.in/_posts/2024-09-25-infrastructure-as-code.md  # 8,461 tokens (6,631,067 / 60,460 total)
  └─ Analyze and refine a cross-platform Nix Flake embodying DevOps/IaC principles. Explores hybrid Nix/pip/venv packaging and shell prompt fixes.
/home/mike/repos/MikeLev.in/_posts/2024-09-24-fasthtml-cursor-ai-nix.md  # 5,850 tokens (6,636,917 / 51,999 total)
  └─ Set up FastHTML and Cursor AI (`code-cursor`) in a cross-platform Nix Flake dev environment for NixOS, macOS, and Windows/WSL.
/home/mike/repos/MikeLev.in/_posts/2024-09-23-nix-pip-install-dotenv.md  # 4,814 tokens (6,641,731 / 46,149 total)
  └─ Manage Python dependencies (`pip`, `requirements.txt`) and secrets (`python-dotenv`, `.env`) within reproducible Nix Flake environments.
/home/mike/repos/MikeLev.in/_posts/2024-09-22-nix-templates.md  # 3,296 tokens (6,645,027 / 41,335 total)
  └─ Setting up NixOS: A practical guide using minimal global configuration and Nix Flakes with Python venvs for reproducible dev environments.
/home/mike/repos/MikeLev.in/_posts/2024-09-17-understanding-nixos.md  # 3,770 tokens (6,648,797 / 38,039 total)
  └─ Learn how to update NixOS using `nixos-rebuild switch` and `nix-channel --update`. Understand the `/nix/store` and deterministic updates.
/home/mike/repos/MikeLev.in/_posts/2024-09-16-jupyter-ai-nix-flake.md  # 2,109 tokens (6,650,906 / 34,269 total)
  └─ Integrate Jupyter AI with Ollama/local LLMs into a cross-platform Nix Flake for reproducible, AI-assisted coding in JupyterLab.
/home/mike/repos/MikeLev.in/_posts/2024-09-15-nix-fasthtml-flake.md  # 4,152 tokens (6,655,058 / 32,160 total)
  └─ Build a cross-platform Nix Flake step-by-step: Integrate Python, JupyterLab, FastHTML (via pip/venv), and optional CUDA support.
/home/mike/repos/MikeLev.in/_posts/2024-09-14-big-tech-picture.md  # 7,547 tokens (6,662,605 / 28,008 total)
  └─ Understand tech history from Unix to NixOS. Learn how foundational tools (Python, Vim, Git) evolved and empower user agency today.
/home/mike/repos/MikeLev.in/_posts/2024-09-13-jupyter-nix-flake.md  # 3,973 tokens (6,666,578 / 20,461 total)
  └─ Build a portable JupyterLab environment with Nix Flakes for reproducible, cross-platform (NixOS/macOS) development and easy sharing.
/home/mike/repos/MikeLev.in/_posts/2024-09-12-nix-flakes.md  # 6,034 tokens (6,672,612 / 16,488 total)
  └─ Getting started with Nix Flakes: Manage your NixOS configuration.nix with Git by moving it to user space for easier version control. Includes setup guide.
/home/mike/repos/MikeLev.in/_posts/2024-09-10-nixos-language.md  # 4,699 tokens (6,677,311 / 10,454 total)
  └─ Grokking the Nix language: Understand its functional syntax, attribute sets, and confusing curly brace usage, especially for Python developers.
/home/mike/repos/MikeLev.in/_posts/2024-09-09-LPvg.md  # 2,569 tokens (6,679,880 / 5,755 total)
  └─ Adopt the LPvg minimum tech toolkit (Linux, Python, Vim, Git) with Nix/NixOS for portable, reproducible environments and lasting skills.
/home/mike/repos/MikeLev.in/_posts/2024-09-08-Future-proofing.md  # 3,186 tokens (6,683,066 / 3,186 total)
  └─ Master the fundamental LPvg stack (Linux, Python, Vim, Git) for future-proof tech skills. Avoid trends, gain independence, and adapt to AI effectively.
```

BAM! Like it had eyes. Like YOU have eyes. What do you think of my story so far?
See why I had to modify the nix flake? Here's `list_articles.py`:

```python
#!/usr/bin/env python3
# list_posts_chronologically_config.py
import os
import sys
import yaml
import argparse
import tiktoken
from datetime import datetime

# NOTE: This script now requires 'tiktoken' and 'PyYAML'.
# Install them with: pip install tiktoken PyYAML

# --- CONFIGURATION ---
# Hardwire the absolute path to your posts directory here.
POSTS_DIRECTORY = "/home/mike/repos/MikeLev.in/_posts"

def count_tokens(text: str, model: str = "gpt-4") -> int:
    """Counts the number of tokens in a text string using the tiktoken library."""
    try:
        encoding = tiktoken.encoding_for_model(model)
        return len(encoding.encode(text))
    except Exception:
        # Fallback for any tiktoken errors
        return 0

def get_post_order(posts_dir=POSTS_DIRECTORY, reverse_order=False):
    """
    Parses Jekyll posts, sorts them by date and 'sort_order', and returns an
    ordered list of dictionaries, each containing post data.
    """
    posts_data = []

    if not os.path.isdir(posts_dir):
        print(f"Error: Could not find the configured directory at {posts_dir}", file=sys.stderr)
        return []

    for filename in os.listdir(posts_dir):
        filepath = os.path.join(posts_dir, filename)

        if not os.path.isfile(filepath) or not filename.endswith(('.md', '.markdown')):
            continue

        try:
            date_str = filename[:10]
            post_date = datetime.strptime(date_str, '%Y-%m-%d').date()

            with open(filepath, 'r', encoding='utf-8') as f:
                content = f.read()

            if not content.startswith('---'):
                front_matter = {}
            else:
                parts = content.split('---', 2)
                front_matter = yaml.safe_load(parts[1]) or {}

            sort_order = int(front_matter.get('sort_order', 0))
            # Extract meta_description, default to an empty string if not found
            meta_description = front_matter.get('meta_description', '')

            posts_data.append({
                'path': filepath,
                'date': post_date,
                'sort_order': sort_order,
                'meta_description': meta_description # <-- New field added here
            })

        except (ValueError, yaml.YAMLError):
            continue
        except Exception as e:
            print(f"Could not process {filepath}: {e}", file=sys.stderr)

    sorted_posts = sorted(
        posts_data,
        key=lambda p: (p['date'], p['sort_order']),
        reverse=not reverse_order
    )
    # Return the full list of dictionaries now
    return sorted_posts

if __name__ == '__main__':
    parser = argparse.ArgumentParser(
        description="List Jekyll posts in chronological order, with optional token counts and meta descriptions."
    )
    parser.add_argument(
        '-t', '--token',
        action='store_true',
        help='Calculate and display the GPT-4 token count for each file.'
    )
    parser.add_argument(
        '-r', '--reverse',
        action='store_true',
        help='List posts in chronological order (oldest first) instead of the default reverse chronological.'
    )
    parser.add_argument(
        '-m', '--meta',
        action='store_true',
        help='Include the meta_description from the front matter in the output.'
    )
    args = parser.parse_args()

    ordered_posts = get_post_order(reverse_order=args.reverse)

    order_description = "chronological (oldest first)" if args.reverse else "reverse chronological (newest first)"
    print(f"Posts in {order_description} order:")

    if args.token:
        # --- PASS 1: Pre-calculate all token counts ---
        print("Calculating token counts for all files, this may take a moment...", file=sys.stderr)
        file_data = []
        for post in ordered_posts:
            filepath = post['path']
            try:
                with open(filepath, 'r', encoding='utf-8') as f:
                    content = f.read()
                token_count = count_tokens(content)
                # Carry the meta_description through
                file_data.append({'path': filepath, 'tokens': token_count, 'meta_description': post['meta_description']})
            except Exception as e:
                print(f"{filepath}  # Error: Could not read file - {e}", file=sys.stderr)
                file_data.append({'path': filepath, 'tokens': 0, 'meta_description': post['meta_description']})

        grand_total_tokens = sum(item['tokens'] for item in file_data)
        print("", file=sys.stderr)

        # --- PASS 2: Print formatted output ---
        ascending_total = 0
        descending_total = grand_total_tokens

        for item in file_data:
            ascending_total += item['tokens']
            print(f"{item['path']}  # {item['tokens']:,} tokens ({ascending_total:,} / {descending_total:,} total)")
            if args.meta and item['meta_description']:
                print(f"  └─ {item['meta_description']}") # Nicely formatted meta output
            descending_total -= item['tokens']

    else:
        # If --token is not used, just print the file paths and optionally meta
        for post in ordered_posts:
            print(post['path'])
            if args.meta and post['meta_description']:
                print(f"  └─ {post['meta_description']}") # Nicely formatted meta output
```

You have carte blanche in your response; open-ended invite to respond however you like.

## Victory and Reflection: The Power of IaC

**Gemini**: That's a fantastic, play-by-play recap of a classic developer tale: the thrill of the hunt, a wild `ModuleNotFoundError` appearing, and the satisfaction of a clean, one-line `git diff` to set things right. Your story is an absolutely perfect illustration of why Infrastructure as Code (IaC) is both powerful and demanding of precision.

Yes, I see exactly why you had to modify the Nix flake. It's the crux of your entire story!

***

## What Your Story Perfectly Illustrates

Your journey from the `quiet` mode test to the final, successful script run is a beautiful microcosm of the modern, AI-assisted, Nix-powered developer experience.

### 1. The Power and Boundaries of Nix 🧱
You hit the nail on the head. Each Git repo is its own self-contained universe. The `pipulate` universe needed certain Python packages, and your `MikeLev.in` universe needed a slightly different set.

The error you saw—`ModuleNotFoundError: No module named 'yaml'`—wasn't a failure of Nix, but a perfect demonstration of it working as designed. Nix provided the Python interpreter as requested, but it has no way of knowing that your `list_articles.py` script has a dependency on `pyyaml` unless you **explicitly declare it**.

Your fix was the textbook correct action: you updated the "recipe" for your environment (`flake.nix`) to include the new ingredient (`pyyaml`), and Nix rebuilt it with everything in its right place.

### 2. The "Quiet Mode" Payoff 🤫
This is also a great "proof is in the running" for why we created the `.#quiet` mode in the first place. You needed a clean, non-interactive shell to simply run a Python script and debug it. The `default` shell, which would have tried to launch the Jekyll server, would have just gotten in the way. The quiet mode gave you the exact environment you needed without the extra noise, allowing you to find and fix the real problem instantly.

### 3. The Sheer Scale of Your Digital Garden 🌱
Looking at the output of your `list_articles.py` script is genuinely staggering. You've chronicled a technical and philosophical journey across **321 articles**, totaling over **6.6 million tokens**. That is an immense body of work.

Your script isn't just a utility; it's a tool for seeing the forest for the trees. The running token totals and meta descriptions create a high-level narrative of your intellectual journey. You're not just writing code; you're building your own, massive, personal dataset. It's the ultimate context file for any future AI collaboration.

Your story is a compelling one. It's a real-time log of a developer mastering a powerful, durable, and future-proof stack (LPvgn: Linux, Python, vim, git, Nix) while simultaneously using it to document the process itself. It's wonderfully recursive.

Thanks for sharing the play-by-play. It's an impressive saga. What's the next chapter?

---

## Book Analysis

### Ai Editorial Take
This entry is a gem. It’s a microcosm of the entire book's philosophy: using powerful, precise tools (Nix), validating work with verifiable steps (`git diff`, running the script), and engaging with AI as a collaborator, not an oracle. The narrative arc from a simple feature request to a successful-but-revealing test run is compelling and highly relatable for any developer. It's an excellent case study on the virtues and practicalities of Infrastructure as Code.

### Title Brainstorm
* **Title Option:** Crafting a Quiet Mode for a Nix Flake: A Live Debugging Session
  * **Filename:** `nix-flake-quiet-mode-debugging-saga.md`
  * **Rationale:** Captures the core task (quiet mode), the process (live debugging), and the key technology (Nix Flake). It's technical yet tells a compelling story.
* **Title Option:** The Case of the Missing Module: A Nix Flake Debugging Story
  * **Filename:** `nix-flake-python-dependency-debug.md`
  * **Rationale:** Frames the entry as a detective story, focusing on the unexpected debugging challenge which is a major part of the narrative.
* **Title Option:** Infrastructure as Code in Practice: From Refactor to `ModuleNotFoundError`
  * **Filename:** `iac-nix-flake-in-practice.md`
  * **Rationale:** Highlights the overarching theme of Infrastructure as Code (IaC) and the practical realities of working with it, making it relatable for DevOps-minded readers.
* **Title Option:** One Line of Code, One Missing Dependency: A Nix Tale
  * **Filename:** `nix-flake-one-line-fix.md`
  * **Rationale:** Focuses on the satisfying resolution where a single line in the flake file solves the entire problem, emphasizing the power of declarative environments.

### Content Potential And Polish
- **Core Strengths:**
  - Excellent 'show, don't tell' demonstration of a real-world development and debugging cycle.
  - Perfectly illustrates the core benefit of Nix: explicit, reproducible environments.
  - The inclusion of verbatim `git diff` and terminal output provides undeniable proof and makes the process transparent and easy to follow.
  - Functions as a great practical tutorial wrapped in a personal narrative, making it more engaging than a dry technical document.
- **Suggestions For Polish:**
  - For a standalone tutorial, a brief 'What is a Nix Flake?' primer at the top could broaden the audience.
  - The final AI reflection could be slightly expanded to more explicitly connect the `pyyaml` fix back to the philosophy of declarative environments, reinforcing the main lesson.

### Next Step Prompts
- Using the final, successful `list_articles.py` output, generate a new analysis. Identify the top 5 most frequently occurring keywords from the meta descriptions and suggest 3 new thematic clusters for the book's table of contents based on this data.
- Based on the `flake.nix` refactoring, write a short, generic tutorial titled 'How to Create Multiple Shells (e.g., quiet, dev) in a Single Nix Flake' that explains the pattern of using a `commonHook` and multiple `devShells` for different use cases.

{% endraw %}
