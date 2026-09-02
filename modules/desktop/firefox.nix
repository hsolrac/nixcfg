{ pkgs, inputs, ... }:

{
  programs.firefox = {
    enable = true;

    profiles.default = {
      isDefault = true;
      extensions.force = true;
      extensions.packages =
        with inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system}; [
          ublock-origin
          sponsorblock
          dearrow
          vimium
          privacy-badger
          refined-github
          stylus
          wayback-machine
          archivebox-exporter
        ];
    };
  };
}
