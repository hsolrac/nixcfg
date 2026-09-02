{
  programs.git = {
    enable = true;
    userEmail = "ch.henriquevinha@gmail.com";
    userName = "Carlos Henrique";

    aliases = {
      lg = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
      st = "status --short";
    };

    settings = {
      color.ui = true;
      core.editor = "nvim";
      pull.rebase = true;
      push.default = "current";
      rerere.enabled = true;
    };
  };
}
