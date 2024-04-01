{
  description = "Algorithmic (aka automatic) differentiation implementation in OCaml";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        isDarwin = pkgs.stdenv.isDarwin;
        # thanks to https://github.com/commercialhaskell/stack/issues/1698#issuecomment-178098712 for the idea
        darwinFrameworks = pkgs.lib.optionals isDarwin (with pkgs.darwin.apple_sdk.frameworks; [
          Cocoa
          CoreServices
        ]);
        ocamlEnv = with pkgs.ocamlPackages; [
          ocaml
          utop
          dune_3
          findlib
          ocaml-lsp
          ocamlformat
        ];
      in
      {
        devShell = pkgs.mkShell {
          buildInputs = ocamlEnv ++ [ pkgs.opam ] ++ darwinFrameworks;
          shellHook = ''
                    export IN_NIX_DEVELOP_SHELL=1

                    export OPAMROOT=$NIX_BUILD_TOP/.opam
                    # unsetting the below env var is required for fixing a thorny issue with `num` install
                    # similar issue & solution thread: https://github.com/ocaml/Zarith/issues/136 
                    unset OCAMLFIND_DESTDIR

                    opam init --bare --disable-sandboxing -y --shell-setup -vv
                    opam option -global depext=false
                    OCAML_VERSION=$(ocaml --version | awk '{printf $5}')
                    opam switch create $OCAML_VERSION
                    eval $(opam env --switch=$OCAML_VERSION)
                    opam install . --deps-only -y -v

                    # figure out what the default shell of this computer is and set it
            		  '' +
          (if isDarwin then
            ''
                    SHELLY=$(dscl . -read /Users/$USER UserShell | awk '{print $2}')
              	    exec $SHELLY
            ''
          else
            ''
                    SHELLY=$(getent passwd $USER | awk -F: '{printf $7}')
                    exec $SHELLY
            '');
        };
      }
    );
}
