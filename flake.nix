{
  description = "pi-tps dev shell (bun + node 22)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            bun
            nodejs_22
            git
          ];

          shellHook = ''
            echo "pi-tps devshell: $(node --version), bun $(bun --version)"
            if [ ! -d node_modules ]; then
              echo "hint: bun install --frozen-lockfile"
            fi
          '';
        };
      }
    );
}
