{ pkgs, inputs, ... }:

{
  imports = [
    ./home.nix
  ];

  programs.fish.enable = true;

  # X Server
  services.xserver.enable = true;
  services.xserver.xkb = {
    layout = "br";
    variant = "thinkpad";
  };

  # Fonts
  fonts = {
		fontconfig = {
			defaultFonts = {
				monospace = ["Iosevka"];
			};
		};
    enableDefaultPackages = true;
    packages = with pkgs; [
      nerd-fonts.fira-code
			iosevka
    ];
  };

  # Sound
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Printing
  services.printing.enable = true;

  # Compositor
  services.picom.enable = true;

  # Window Manager
  services.xserver.windowManager.i3.enable = true;

  # GUI Programs
  programs.firefox.enable = true;
  programs.nix-ld.enable = true;
  programs.steam.enable = true;
  programs.gamemode.enable = true;
}
