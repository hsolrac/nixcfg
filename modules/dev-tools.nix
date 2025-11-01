{ pkgs, ... }:

{
	environment.systemPackages = with pkgs; [
		rustup
		nodejs_22
		nodePackages.pnpm
		nodePackages.typescript-language-server
		gnumake
    docker 
    docker-compose
	  beekeeper-studio
    usql
    gcc
    jq    
    ripgrep
    fzf
    mongodb-compass
	];
}
