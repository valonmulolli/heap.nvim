{
  description = "A dark theme for Neovim based on the Heap VS Code theme";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        # Default package import from default.nix
        packages.default = import ./default.nix { inherit pkgs; };
        
        # Backward compatibility
        packages.heap-nvim = self.packages.${system}.default;

        # Development shell import from shell.nix
        devShells.default = import ./shell.nix { inherit pkgs; };
      });
}
