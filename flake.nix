{
  description = "NixCon 2024 - NixOS on garnix: Production-grade hosting as a game";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  inputs.garnix-lib = {
    url = "github:garnix-io/garnix-lib";
    inputs = {
      nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      garnix-lib,
      ...
    }:
    let
      system = "x86_64-linux";
    in
    {
      packages.x86_64-linux.default =
       let pkgs = nixpkgs.legacyPackages.x86_64-linux;
        in pkgs.haskellPackages.callCabal2nix "pkg" ./. {};
      nixosConfigurations.server = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          garnix-lib.nixosModules.garnix
          ./module.nix
          ({ pkgs, ... }: {
            playerConfig = {
              # Your github user:
              githubLogin = "jkarni";
              # You only need to change this if you changed the forked repo name.
              githubRepo = "nixcon-2024-player-template";
              # You only need to change this if you changed the forked repo name.
              webserver = self.packages.x86_64-linux.default;
              # If you want to log in to your deployed server, put your SSH key
              # here:
              sshKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIVpNqdbM7uE1xkKoXztoaAtKtDHoqHS3DrzxYKsDgxa jkarni@garnix.io";
            };
          })
        ];
      };

      # Remove before starting the workshop - this is just for development
      checks = import ./checks.nix { inherit nixpkgs self; };
    };
}
