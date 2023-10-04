{ pkgs ? import <nixpkgs> {} }:

let
    ocaml = pkgs.ocamlPackages.ocaml;
    dune = pkgs.ocamlPackages.dune_3;
    findlib = pkgs.ocamlPackages.findlib;
    utop = pkgs.ocamlPackages.utop;
in
pkgs.mkShell {
    buildInputs = [ ocaml dune findlib utop pkgs.opam pkgs.ocamlPackages.ocaml-lsp pkgs.ocamlformat ];

    shellHook = ''
    '';
}
