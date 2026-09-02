{ config, pkgs, inputs, ... }:

{
  systemd.services.blog = {
    description = "Blog Phoenix app";

    wantedBy = [
      "multi-user.target"
    ];

    after = [
      "network.target"
    ];

    serviceConfig = {
      Type = "simple";

      User = "carlos";
      Group = "users";

      ExecStart =
        "${inputs.blog.packages.${pkgs.system}.blog}/bin/blog start";

      Restart = "on-failure";

      RestartSec = 10;

      EnvironmentFile = "/etc/secrets/blog.env";
    };
  };
}
