{ pkgs ? import <nixpkgs> {} }:

let
  version = "1.2.0";
in
pkgs.vimUtils.buildVimPlugin {
  pname = "heap-nvim";
  inherit version;
  
  src = ./.;
  
  dontBuild = true;
  
  installCheckPhase = ''
    # Make sure the necessary directories exist
    test -d $src/colors
    test -d $src/lua
    test -d $src/plugin
  '';

  meta = with pkgs.lib; {
    description = "A dark theme for Neovim based on the Heap VS Code theme";
    homepage = "https://github.com/valonmullolli/heap-nvim";
    license = licenses.mit;
    maintainers = [ ];
    mainProgram = "nvim";
  };
}