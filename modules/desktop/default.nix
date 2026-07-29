{ pkgs, inputs, ... }:

{
  home-manager.sharedModules = [
    inputs.niri.homeModules.niri
    ../kitty/default.nix
    ../rofi/default.nix
    ../walker/default.nix
    ../i3/default.nix
  ];

  home-manager.users.carlos = { pkgs, ... }: {
    home.packages = with pkgs; [
      google-chrome
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
    ];
  };

  # X Server
  services.xserver.enable = true;
  services.xserver.xkb = {
    layout = "br";
    variant = "thinkpad";
  };

  # Fonts
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      nerd-fonts.fira-code
    ];
  };

  # Sound
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Printing
  services.printing.enable = true;

  # Compositor
  services.picom.enable = true;

  # Window Manager
  services.xserver.windowManager.i3.enable = true;

  # GUI Programs
  programs.firefox.enable = true;
  programs.nix-ld.enable = true;
  programs.steam.enable = true;
  programs.gamemode.enable = true;
}
