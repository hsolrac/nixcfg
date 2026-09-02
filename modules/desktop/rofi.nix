{ pkgs, ... }:

{
  programs.rofi = {
    enable = true;
    theme = "gruvbox-dark-hard";
  };

  home.file.".config/rofi/scripts/config.rasi".text = ''
    		@theme "${pkgs.rofi}/share/rofi/themes/gruvbox-dark-hard.rasi"

    		configuration {
    		}
  '';

  home.file.".config/rofi/scripts/github-rofi.sh" = {
    executable = true;
    text = ''
      			#!/usr/bin/env bash

      			USER="carl0xs"
      			URL="https://github.com/$USER/"

      			clone_repository(){
      				local repository=$1
      				if [ -z "$repository" ]; then
      					echo "ERROR: You need to enter the name of the repository you wish to clone."
      				else
      					git clone "$URL$repository"
      				fi
      			}

      			all_my_repositories_short_name(){
      				curl -s "https://api.github.com/users/$USER/repos?per_page=1000" \
      					| grep '"name"' \
      					| sed 's/.*"name": "\(.*\)",/\1/'
      			}

      			rofi_dmenu(){
      				rofi -dmenu -matching fuzzy -no-custom -p "Select a repository > " \
      					-location 0 -bg "#F8F8FF" -fg "#000000" -hlbg "#ECECEC" -hlfg "#0366d6"
      			}

      			main(){
      				repository=$(all_my_repositories_short_name | rofi_dmenu)
      				clone_repository "$repository"
      			}

      			main
      			exit 0
    '';
  };

  home.file.".config/rofi/scripts/repos-rofi.sh" = {
    executable = true;
    text = ''
      			#!/bin/sh
      			set -eu

      			# Set your terminal:
      			terminal="kitty"

      			# Pick repo
      			configs="$(ls -1d "$HOME"/repos/*/ 2>/dev/null | xargs -n1 basename)"
      			[ -n "$configs" ] || exit 0
      			chosen="$(printf '%s\n' $configs | rofi -dmenu -p 'Projects:')"
      			[ -n "$chosen" ] || exit 0
      			dir="$HOME/repos/$chosen"

      			# Nuke any existing st (since you only use one terminal)
      			pkill -x $terminal 2>/dev/null || true
      			sleep 0.1

      			# Launch a clean terminal: attach if exists, else create
      			# exec st -e tmux new-session -As "$chosen" -c "$dir" "nvim ."
      			exec $terminal -e tmux new-session -As "$chosen" -c "$dir"
    '';
  };

  home.file.".config/rofi/scripts/tmux-rofi.sh" = {
    executable = true;
    text = ''
      			#!/bin/sh
      			set -eu

      			sessions="$(tmux list-sessions -F '#S' 2>/dev/null || true)"
      			[ -n "''${sessions}" ] || exit 0

      			rofi_pick_session() {
      				if command -v rofi >/dev/null 2>&1; then
      					rofi -dmenu -i -p 'tmux sessions:' -lines 10 \
      							 -kb-row-down "Down,Control+n,j" -kb-row-up "Up,Control+p,k"
      				else
      					dmenu -i -vi -c -bw 3 -l 10 -h 30 -F -p 'tmux sessions:'
      				fi
      			}
      			dmenu_pick_session() {
      					dmenu -i -vi -c -bw 3 -l 10 -h 30 -F -p 'tmux sessions:'
      			}
      			chosen="$(printf '%s\n' "$sessions" | rofi_pick_session)"

      			[ -n "$chosen" ] || exit 0

      			if [ "''${TMUX-}" ]; then
      				exec tmux switch-client -t "''${chosen}"
      			fi

      			client_tty="$(
      				tmux list-clients -F '#{client_tty} #{client_termname}' 2>/dev/null \
      				| awk '$2 ~ /^st/ { print $1; exit }' || true
      			)"

      			if [ -n "''${client_tty}" ]; then
      				# switch that client to the chosen session
      				tmux switch-client -c "''${client_tty}" -t "''${chosen}"
      				exit 0
      			fi

      			exec st -e tmux attach -t "''${chosen}"
    '';
  };
}
