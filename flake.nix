{
  description = "pkarr";

  inputs = { nixpkgs.url = "nixpkgs/nixos-unstable"; };

  outputs = { self, nixpkgs }:
    let
      supportedSystems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" ];
      forAllSystems = f:
        nixpkgs.lib.genAttrs supportedSystems (system: f system);
      pkgsFor = nixpkgs.legacyPackages;
    in {
      packages = forAllSystems
        (system: { default = pkgsFor.${system}.callPackage ./. { }; });
    };
}
