{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    neovim
    git
    lua-language-server
    stylua
  ];
}