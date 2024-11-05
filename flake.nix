{
  description = "Nix flake for Jekyll environment with Rouge for syntax highlighting";

  inputs = {
    # Use a stable Nixpkgs version. You can update this to a newer version if needed.
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
          # any other Python packages needed by ai.py
        ]);
      in
      {
        # Define the development shell
        devShells.default = pkgs.mkShell {
          # Include necessary packages in the PATH
          buildInputs = [
            pkgs.ruby
            pkgs.bundler
            pkgs.jekyll            # Jekyll from Nixpkgs
            pkgs.rubyPackages_3_2.rouge  # Rouge (provides rougify)
            pkgs.neovim
            pkgs.git  # Add Git to the development shell
            pythonEnv  # Use the Python environment we defined above
          ];

          # Optional: Set environment variables if needed
          shellHook = ''
            # Create necessary directories
            mkdir -p ~/.config/nvim

            # Create symlink to init.lua
            # Using $HOME ensures this works on both Linux and macOS
            ln -sf $HOME/repos/nixos/init.lua ~/.config/nvim/init.lua

            # Alias vim to nvim
            alias vim=nvim

            echo "Jekyll and Rouge environments are ready."
            echo "Use: jekyll serve --livereload"
            echo "Use: rougify style monokai.sublime > assets/css/syntax.css"
          '';
        };
      });
}
