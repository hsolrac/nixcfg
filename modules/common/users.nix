{ pkgs, ... }:

{
  users.users.carlos = {
    isNormalUser = true;
    description = "carlos";
    home = "/home/carlos";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
  };
}
