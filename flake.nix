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
              hash = "sha256-Go4/7OOhx6GfAEYVRWKuqN0IVcRrcgGr9PkET/P0jns=";
            };
            installPhase = ''
                runHook preInstall
                mkdir -p $out/build
                cp -r build/* $out/build/
                runHook postInstall
            '';
          };

          default = pkgs.writeShellApplication {
            name = packageJSON.name;
            runtimeInputs = [site-src pkgs.python3];
            text = ''
              python -m http.server 8000 -d ${site-src}/build
            '';
          };
        };

        devShell = pkgs.mkShell {
          buildInputs = [pkgs.yarn pkgs.nodejs];
        };
      }
    );
}
