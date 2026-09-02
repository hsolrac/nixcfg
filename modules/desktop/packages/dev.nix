{ pkgs, ... }:

{
  home.packages = with pkgs; [
    tree
    gnumake
    gcc
    jq
    ripgrep
    fzf
    curl
    rsync
    bat
    lazygit
    direnv
    docker
    docker-compose
    usql
    zoxide
    htop
    fastfetch
    bash-language-server
    ranger
    gh
    tree-sitter
  ];
}
