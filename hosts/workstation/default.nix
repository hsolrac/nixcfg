{ pkgs, ... }:

{
  imports = [
    ../../modules/common/default.nix
    ../../modules/desktop/default.nix
    ../../modules/services/tailscale/default.nix
  ];

  networking.hostName = "workstation";

  virtualisation.docker.enable = true;

  networking.extraHosts = ''
    127.0.0.1 local.conta.fintera.com.br
    127.0.0.1 local.recebiveis.fintera.com.br
    127.0.0.1 local.financeiro.fintera.com.br
    127.0.0.1 local.faturamento.fintera.com.br
  '';

  nix.settings.trusted-users = [ "root" "carlos" ];

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
    "beekeeper-studio-5.5.3"
  ];
}
