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
        pythonEnv = pkgs.python3.withPackages (ps: with ps; [
          requests
          simplenote
          # Add other Python packages needed for your project here
        ]);
      in
      {
        # Define the development shell
        devShells.default = pkgs.mkShell {
          # Include necessary packages in the PATH
          buildInputs = [
            pkgs.ruby                       # Ruby for Jekyll and Bundler
            pkgs.bundler                    # Bundler to manage Ruby gems
            pkgs.jekyll                     # Jekyll from Nixpkgs
            pkgs.rubyPackages_3_2.rouge     # Rouge (provides rougify)
            pkgs.neovim                     # Neovim for text editing
            pkgs.git                        # Git for version control
            pythonEnv                       # Use the Python environment defined above
            pkgs.stdenv.cc.cc.lib          # Add C++ standard library
            pkgs.pkg-config                 # Add pkg-config for build dependencies
            pkgs.openssl                    # Add openssl for native gem compilation
          ];

          # Set environment variables for native gem compilation
          shellHook = ''
            export BUNDLE_BUILD__EVENTMACHINE="--with-cflags=-I${pkgs.openssl.dev}/include"
            export PKG_CONFIG_PATH="${pkgs.openssl.dev}/lib/pkgconfig"
            
            # Set LD_LIBRARY_PATH to include gcc libs
            # This is crucial for Ruby native extensions (like EventMachine) that need libstdc++
            export LD_LIBRARY_PATH="${pkgs.stdenv.cc.cc.lib}/lib:$LD_LIBRARY_PATH"
            
            # macOS-specific symlink setup for Neovim
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

            # Jekyll serve function with safer livereload approach
            jes() {
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

              # Change to the site root
              cd "$site_root"
              echo "Serving from $(pwd)..."
              bundle exec jekyll serve --livereload
              
              # Return to the original directory
              cd "$current_dir"
            }

            # Display Jekyll and Bundler instructions
            echo "Jekyll and Rouge environments are ready."
            echo "Instructions:"
            echo "1. Use: bundle install       # To install Ruby gems defined in Gemfile"
            echo "2. Use: jes"
            echo "   - Starts a Jekyll development server (with livereload if available)"
            echo "3. Use: rougify style monokai.sublime > assets/css/syntax.css"
            echo "   - Generates Rouge syntax highlighting styles in your CSS."
            echo ""
            echo "If you encounter issues, check the Gemfile and run 'bundle install'."

            # Notes on Ruby Native Extensions in Nix:
            # 1. Native extensions (like EventMachine) require C/C++ libraries at runtime
            # 2. These libraries must be both:
            #    - Listed in buildInputs (for compilation)
            #    - Added to LD_LIBRARY_PATH (for runtime)
            # 3. Common issues include missing libstdc++.so.6, which is provided by gcc-libs
            # 4. The error "pure Ruby reactor" often indicates a missing library path
          '';
        };
      });
}
