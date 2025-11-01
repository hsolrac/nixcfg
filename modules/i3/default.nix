{ config, pkgs, ... }:
{
  services.xserver = {
    enable = true;
    displayManager = {
      lightdm.enable = true;
      autoLogin.enable = false;
      defaultSession = "none+i3";
    };
    desktopManager = {
      xterm.enable = false;
    };
    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
      configFile = ./config;
    };
  };

  environment.systemPackages = with pkgs; [
    i3status
    i3blocks  
    
    rofi
    rofi-power-menu
    
    maim
    xclip
    
    pavucontrol
    pulseaudio  
    
    feh
    
    i3-resurrect
    
    xss-lock
    i3lock
    
    networkmanagerapplet
    
    polybar
  ];

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  programs.dconf.enable = true;

  users.users.carlos.extraGroups = [ "video" "audio" "networkmanager" ];
}
