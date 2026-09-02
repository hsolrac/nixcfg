{ pkgs, inputs, ... }:

{
  programs.firefox = {
    enable = true;

    profiles.default = {
      search = {
        force = true;
        default = "DuckDuckGo";
        privateDefault = "DuckDuckGo";
      };

      isDefault = true;
      extensions.force = true;
      extensions.packages =
        with inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system}; [
          ublock-origin
          dearrow
          vimium
          privacy-badger
          refined-github
          stylus
          wayback-machine
          archivebox-exporter
          bitwarden
        ];
    };

    policies = {
      AppAutoUpdate = false;
      BackgroundAppUpdate = false;

      DisableTelemetry = true;

      # Access Restrictions
      BlockAboutConfig = false;
      BlockAboutProfiles = true;
      BlockAboutSupport = true;
    };
  };
}
