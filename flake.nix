{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    gitignore = {
      url = "github:hercules-ci/gitignore.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    gitignore,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
        packageJSON = pkgs.lib.importJSON ./package.json;
        gitignoreSource = gitignore.lib.gitignoreSource;
      in {
        packages = rec {
            site-src = pkgs.stdenv.mkDerivation rec {
                name = "${packageJSON.name}-site-${version}";
                version = packageJSON.version;
                src = gitignoreSource ./.;
                nativeBuildInputs = with pkgs; [ yarnConfigHook yarnBuildHook yarnInstallHook nodejs yarn ];
                yarnOfflineCache = pkgs.fetchYarnDeps {
                yarnLock = src + "/yarn.lock";
                hash = "sha256-NBV6nALa5ycffxLXy4ArfHn3o/jdxYEUO7z+EK/7Wnk=";
                };
            };

          default = pkgs.writeShellApplication {
            name = packageJSON.name;
            runtimeInputs = [site-src pkgs.nodejs];
            text = ''
                ORIGIN='http://localhost:3000' node build --enable-source-maps
            '';
          };
        };

        devShell = pkgs.mkShell {
          buildInputs = [pkgs.yarn pkgs.nodejs];
        };
      }
    );
}
