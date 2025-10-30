{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
		rustup

    nodejs_22
    nodePackages.pnpm
    nodePackages.typescript-language-server
  ];
}
