{
  description = "Nix flake for Jekyll environment with Rouge for syntax highlighting";

  inputs = {
    # Use a stable Nixpkgs version. You can update this to a newer version if needed.
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    # Optionally, specify the flake-utils for multi-system support
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
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
          ];

          # Optional: Set environment variables if needed
          shellHook = ''
            echo "Jekyll and Rouge environments are ready."
            echo "Use: jekyll serve --livereload"
            echo "Use: rougify style monokai.sublime > assets/css/syntax.css"
          '';
        };
      });
}
