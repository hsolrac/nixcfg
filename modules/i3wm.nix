{ config, pkgs, ... }:

let
  username = builtins.getEnv "USER";
in
{

  services.xserver.windowManager.i3.enable = true;
  services.xserver.windowManager.i3.package = pkgs.i3-gaps;

  environment.systemPackages = with pkgs; [
    i3status
    dmenu
  ];

  services.xserver.displayManager.lightdm.greeters.slick.enable = true;

  services.xserver.windowManager.i3.configFile = "/home/${username}/.config/i3/config";
}
