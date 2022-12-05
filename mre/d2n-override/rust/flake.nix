{
  inputs = {
    nixpkgs.url = "nixpkgs";

    dream2nix = {
      url = "github:nix-community/dream2nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, dream2nix,...}:
    let
    systems = ["x86_64-linux"];
    forAllSystems = f:
      nixpkgs.lib.genAttrs systems (
        system:
          f system (nixpkgs.legacyPackages.${system})
      );
    projectRoot = builtins.path {
      path = ./.;
      name = "projectRoot";
    };

    d2n-flake = dream2nix.lib.makeFlakeOutputs {
      inherit systems;
      config.projectRoot = projectRoot;
      source = projectRoot;
    };
  in
    dream2nix.lib.dlib.mergeFlakes [
      d2n-flake
      {
        devShells = forAllSystems (system: pkgs: {
          default = d2n-flake.devShells.${system}.default.addConfig {
            packages = [
              pkgs.hello
            ];
          };
        });
      }
    ];
}
