{ config, pkgs, ... }:

{
  imports =
    [ 
      /etc/nixos/hardware-configuration.nix
  	  ./modules
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  networking.extraHosts = ''
  '';

	virtualisation.vmware.host.enable = true; 

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  time.timeZone = "America/Sao_Paulo";

  i18n.defaultLocale = "pt_BR.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };

  services.xserver.enable = true;

  services.xserver.xkb = {
    layout = "br";
    variant = "thinkpad";
  };

  services.printing.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable docker.
 virtualisation.docker.enable = true; 

  users.users.carlos = {
    isNormalUser = true;
    description = "carlos";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
		shell = pkgs.fish;
    packages = with pkgs; [
      tree
    ];
  };

  users.defaultUserShell = pkgs.fish;
  programs.firefox.enable = true;
  programs.fish.enable = true;

  nixpkgs.config.permittedInsecurePackages = [
     "beekeeper-studio-5.3.4"
  ];

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    neovim
    wget
    git 
    unzip 
    gzip 
    tmux
    google-chrome 
    kitty
    discord
    direnv
    nix-direnv
    postman
    libreoffice
    maim
    flameshot
    xclip
    feh
    tmuxinator
    picom
    pavucontrol
		nixfmt
  ];

  services.openssh.enable = true;

  system.stateVersion = "25.05";
}
