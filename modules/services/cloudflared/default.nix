{ config, lib, pkgs, ... }:

{
  services.cloudflared = {
    enable = true;

    tunnels = {
      "0ba40b0f-1ed4-467f-8de8-8af62c6f6111" = {
        credentialsFile = "/etc/cloudflared/0ba40b0f-1ed4-467f-8de8-8af62c6f6111.json";

        default = "http_status:404";
        ingress = {
          "carl0xs.dev" = "http://localhost:4000";
        };
      };
    };
  };
}
