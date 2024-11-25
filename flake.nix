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
          ];

          # Optional: Set environment variables and instructions for users
          shellHook = ''
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

            # Display Jekyll and Bundler instructions
            echo "Jekyll and Rouge environments are ready."
            echo "Instructions:"
            echo "1. Use: bundle install       # To install Ruby gems defined in Gemfile"
            echo "2. Use: bundle exec jekyll serve --livereload"
            echo "   - Starts a Jekyll development server with live reload support."
            echo "3. Use: rougify style monokai.sublime > assets/css/syntax.css"
            echo "   - Generates Rouge syntax highlighting styles in your CSS."
            echo ""
            echo "If you encounter issues, check the Gemfile and run 'bundle install'."
          '';
        };
      });
}
