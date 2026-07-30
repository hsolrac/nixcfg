{ ... }:

{
  imports = [
    ../../modules/common/default.nix
    ../../modules/tailscale/default.nix
    ../../modules/blog/default.nix
    ../../modules/cloudflared/default.nix
    ../../modules/pi-hole/default.nix
    ../../modules/znc/default.nix
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
