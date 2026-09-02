{ pkgs, ... }:

{
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
    weechat
  ];
}
