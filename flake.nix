{
  description = "NixOS configuration Carl0xs";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
    blog.url = "github:carl0xs/blog";
    deploy-rs.url = "github:serokell/deploy-rs";
    deploy-rs.inputs.nixpkgs.follows = "nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self
    , nixpkgs
    , home-manager
    , nixvim
    , neovim-nightly-overlay
    , deploy-rs
    , sops-nix
    , blog
    , firefox-addons
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      specialArgs = {
        inherit inputs;
        extraHostsFromEnv = builtins.getEnv "EXTRA_HOSTS";
      };
      hostIp = builtins.getEnv "HOST_IP";
    in
    {
      formatter.${system} = pkgs.nixpkgs-fmt;

      deploy.nodes.homelab = {
        hostname = hostIp;

        profiles.system = {
          user = "root";

          path =
            deploy-rs.lib.${system}.activate.nixos
              self.nixosConfigurations.homelab;
        };
      };

      nixosConfigurations = {
        workstation = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = specialArgs;
          modules = [
            home-manager.nixosModules.home-manager
            ./hosts/workstation/default.nix
            ./hosts/workstation/hardware-configuration.nix
          ];
        };

        homelab = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = specialArgs;
          modules = [
            sops-nix.nixosModules.sops
            ./hosts/homelab/default.nix
            ./hosts/homelab/hardware-configuration.nix
          ];
        };
      };
    };
}
