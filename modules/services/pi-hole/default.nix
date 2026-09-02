{ config, lib, pkgs, ... }:

{
  services.pihole-ftl = {
    enable = true;
    openFirewallDNS = true;
    openFirewallWebserver = true;
    settings = {
      webserver.port = "80";
      misc.readOnly = false;

      dns.upstreams = [ "9.9.9.9" "1.1.1.1" ];

      dns.hosts = [ "192.168.2.4 homelab.carl0xs.dev" ];
    };

    lists = [
      {
        url = "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/pro.txt";
        type = "block";
        enabled = true;
        description = "hagezi blocklist";
      }
    ];
  };

  services.pihole-web = {
    enable = true;
    ports = [ 80 ];
  };
}
