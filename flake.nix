{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixpkgs-unstable";
    systems.url = "github:nix-systems/default";
    devenv.url = "github:cachix/devenv";
    devenv.inputs.nixpkgs.follows = "nixpkgs";
  };

  nixConfig = {
    extra-trusted-public-keys = "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=";
    extra-substituters = "https://devenv.cachix.org";
  };

  outputs = {
    self,
    nixpkgs,
    devenv,
    systems,
    ...
  } @ inputs: let
    forEachSystem = nixpkgs.lib.genAttrs (import systems);
  in {
    devShells =
      forEachSystem
      (system: let
        pkgs = import nixpkgs {
          inherit system;
          config = {
            allowUnfree = true;
            android_sdk = {accept_license = true;};
          };
        };
      in {
        default = devenv.lib.mkShell {
          inherit inputs pkgs;
          modules = [
            (
              {pkgs, ...}: {
                android = {
                  enable = true;
                  platforms.version = ["34" "35" "36"];
                  abis = ["arm64-v8a" "x86_64"];
                  cmake.version = ["3.22.1"];
                  cmdLineTools.version = "16.0";
                  tools.version = "26.1.1";
                  buildTools.version = ["34.0.0" "35.0.0"];
                  sources.enable = true;
                  systemImages.enable = false;
                  ndk.enable = true;
                  googleAPIs.enable = false;
                  googleTVAddOns.enable = false;
                  emulator.enable = false;
                  android-studio.enable = false;
                  flutter = {
                    enable = true;
                    package = pkgs.flutter;
                  };
                  extraLicenses = [
                    "android-sdk-preview-license"
                    "android-sdk-arm-dbt-license"
                    "google-gdk-license"
                    "intel-android-extra-license"
                  ];
                };

                packages = with pkgs; [
                  jdk17
                  gradle
                ];

                languages.dart = {
                  enable = true;
                  package = pkgs.dart;
                };

                enterShell = ''
                  flutter config --android-sdk $ANDROID_HOME
                  export PATH="$PATH":"$HOME/.pub-cache/bin"
                  export PATH=$PATH:/usr/local/bin
                '';
              }
            )
          ];
        };
      });
  };
}
