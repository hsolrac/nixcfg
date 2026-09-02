{ ... }:

{
  imports = [
    ../../modules/common/default.nix
    ../../modules/services/tailscale/default.nix
    ../../modules/services/blog/default.nix
    ../../modules/services/cloudflared/default.nix
    ../../modules/services/pi-hole/default.nix
    ../../modules/services/znc/default.nix
  ];

  # Override common hostname for this specific host
  networking.hostName = "homelab";

  # Legacy BIOS bootloader (most Dell 1st-gen i5 boxes are BIOS-only)
  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = false;
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";

  networking.firewall.enable = true;

  virtualisation.docker.enable = true;
}
