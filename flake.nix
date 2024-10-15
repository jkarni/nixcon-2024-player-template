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
      nixosConfigurations.server = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          garnix-lib.nixosModules.garnix
          ./module.nix
          ({ pkgs, ... }: {
            playerConfig = {
              # Your github user:
              githubLogin = "GITHUB_USER";
              # You only need to change this if you changed the forked repo name.
              githubRepo = "nixcon-2024-player-template";
              # The nix derivation that will be used as the server process. It should open a webserver on port 8080.
              webserver = pkgs.hello;
              # If you want to log in to your deployed server, put your SSH key
              # here:
              sshKey = "<YOUR_PUBLIC_SSH_KEY>";
            };
          })
        ];
      };

      # Remove before starting the workshop - this is just for development
      checks = import ./checks.nix { inherit nixpkgs self; };
    };
}
