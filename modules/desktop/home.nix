{ inputs, ... }:

{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    backupFileExtension = "hm-bak";

    sharedModules = [
      inputs.nixvim.homeModules.nixvim
      ./packages/gui.nix
      ./packages/dev.nix
      ./fish.nix
      ./git.nix
      ./nvim/default.nix
      ./tmux.nix
      ./kitty.nix
      ./rofi.nix
      ./i3/default.nix
      ./google-chrome.nix
      ./firefox.nix
    ];

    users.carlos = { ... }: {
      home.username = "carlos";
      home.homeDirectory = "/home/carlos";
      home.stateVersion = "25.05";

      home.sessionPath = [
        "$HOME/.npm-global/bin"
        "$HOME/.local/share/pnpm"
      ];

      home.sessionVariables = {
        PNPM_HOME = "$HOME/.local/share/pnpm";
      };
    };
  };
}
