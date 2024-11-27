{ pkgs ? import <nixpkgs> { } }:

with pkgs;
mkShell {
  name = "zsh";
  buildInputs = [
    autoconf
    gnumake
    pkg-config
    ncurses.dev
    stdenv.cc
  ];
}
