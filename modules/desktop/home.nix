{ inputs, ... }:

{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    backupFileExtension = "hm-bak";

    sharedModules = [
      inputs.nixvim.homeModules.nixvim
      ./fish.nix
      ./git.nix
      ./nvim/default.nix
      ./tmux.nix
      ./kitty.nix
      ./rofi.nix
      ./i3/default.nix
      ./google-chrome.nix
    ];

    users.carlos = { pkgs, ... }: {
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

      home.packages = with pkgs; [
        discord
        libreoffice
        beekeeper-studio
        grim
        slurp
        wl-clipboard
        swaybg
        pavucontrol
        brightnessctl
        pcmanfm
        shared-mime-info
        fuzzel
        i3status-rust
        maim
        xclip
        feh
        tree
        gnumake
        gcc
        jq
        ripgrep
        fzf
        curl
        rsync
        bat
        lazygit
        direnv
        docker
        docker-compose
        usql
        zoxide
        htop
        fastfetch
        bash-language-server
        ranger
        gh
        weechat
        tree-sitter
      ];
    };
  };
}
