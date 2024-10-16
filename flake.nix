{
  description = "Nix flake for Jekyll environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";  # Update to a desired version
  };

  outputs = { self, nixpkgs }:
    let
      systems = [ "x86_64-linux" ];
    in
    {
      devShells = {
        x86_64-linux.default = let
          pkgs = import nixpkgs { system = "x86_64-linux"; };
        in pkgs.mkShell {
          buildInputs = [
            pkgs.ruby
            pkgs.bundler
            pkgs.jekyll  # Add Jekyll from Nixpkgs
          ];

          shellHook = ''
            if [ ! -f "Gemfile.lock" ]; then
              echo "Setting up Jekyll environment..."
              bundler init
              echo 'gem "jekyll"' >> Gemfile
              bundler install
            fi

            echo "Jekyll environment is ready. Use: jekyll serve --livereload"
          '';
        };
      };
    };
}
