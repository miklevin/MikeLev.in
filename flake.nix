{
  description = "Nix flake for Jekyll environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";  # You can update this to a more recent version if needed
  };

  outputs = { self, nixpkgs }:
    let
      systems = [ "x86_64-linux" ];  # Define the target system(s)
    in
    {
      devShells = {
        # Define a default devShell for x86_64-linux
        x86_64-linux.default = let
          pkgs = import nixpkgs { system = "x86_64-linux"; };
        in pkgs.mkShell {
          nativeBuildInputs = [
            pkgs.bundler  # Ruby's package manager
            pkgs.ruby      # Ruby runtime
          ];

          shellHook = ''
            # Initialize Jekyll environment if Gemfile.lock is missing
            if [ ! -f "Gemfile.lock" ]; then
              echo "Setting up Jekyll environment..."
              bundler init  # Creates a Gemfile if not present
              echo 'gem "jekyll"' >> Gemfile
              bundler install
            fi

            echo "Jekyll environment is ready. Use: jekyll serve --livereload"
          '';
        };
      };

      # Optionally, you can define packages or other outputs here
      # packages.x86_64-linux.default = ...;
    };
}
