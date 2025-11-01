{ config, lib, pkgs, ...}:

with lib; 

{
	imports = [
		./dev-tools.nix
    ./i3wm.nix
	];
}
