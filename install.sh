cp /etc/nixos/hardware-configuration.nix hosts/workstation/
sudo nixos-rebuild switch --impure --flake .#workstation
