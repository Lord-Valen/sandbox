{
  inputs = {
    nixpkgs.url = "nixpkgs";
    dream2nix = {
      url = "github:nix-community/dream2nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    dream2nix,
    ...
  }: let
    systems = ["x86_64-linux"];
    forAllSystems = f:
      nixpkgs.lib.genAttrs systems (
        system:
          f system (nixpkgs.legacyPackages.${system})
      );

    d2n-flake = dream2nix.lib.makeFlakeOutputs {
      inherit systems;
      config.projectRoot = ./.;
      source = ./.;
    };
  in
    dream2nix.lib.dlib.mergeFlakes [
      d2n-flake
      {
        devShells = forAllSystems (system: pkgs: {
          default = d2n-flake.devShells.${system}.default.overrideAttrs (old: {
            buildInputs = old.buildInputs ++ [
              pkgs.hello
            ];
          });
        });
      }
    ];
}
