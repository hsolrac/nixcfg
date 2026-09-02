{ config, pkgs, ... }:

{
  services.tailscale.enable = true;
  services.tailscale.extraUpFlags = [ "--ssh" ];

  networking.firewall.allowedUDPPorts = [ 41641 ];

  networking.firewall.interfaces.tailscale0.allowedTCPPorts = [ 22 ];
}
