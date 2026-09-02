{ ... }:

{
  programs.fish = {
    enable = true;

    shellAliases = {
      purevim = "NVIM_APPNAME=purevim nvim";
      gst = "git status --short";
      gps = "git push";
      gpl = "git pull";
      gac = "git add . && git commit";
      gcb = "git checkout -b";
      glg = "git lg";
      gco = "git checkout";
      ls = "ls -lh";
    };

    shellAbbrs = {
      vi = "nvim";
      vim = "nvim";
      pv = "purevim";
      pure = "purevim";
    };

    interactiveShellInit = ''
      set --global fish_color_autosuggestion brblack
      set --global fish_color_cancel -r
      set --global fish_color_command normal
      set --global fish_color_comment red
      set --global fish_color_cwd green
      set --global fish_color_cwd_root red
      set --global fish_color_end green
      set --global fish_color_error brred
      set --global fish_color_escape brcyan
      set --global fish_color_history_current --bold
      set --global fish_color_host normal
      set --global fish_color_host_remote yellow
      set --global fish_color_normal normal
      set --global fish_color_operator brcyan
      set --global fish_color_param cyan
      set --global fish_color_quote yellow
      set --global fish_color_redirection cyan --bold
      set --global fish_color_search_match white --background=brblack
      set --global fish_color_selection white --bold --background=brblack
      set --global fish_color_status red
      set --global fish_color_user brgreen
      set --global fish_color_valid_path --underline
      set --global fish_pager_color_completion normal
      set --global fish_pager_color_description yellow -i
      set --global fish_pager_color_prefix normal --bold --underline
      set --global fish_pager_color_progress brwhite --background=cyan
      set --global fish_pager_color_selected_background -r

      zoxide init fish | source
    '';

    functions = {
      dual_displays = ''
        xrandr --output eDP-1 --primary --auto --output HDMI-1 --auto --right-of eDP-1
      '';

      only_hdmi = ''
        xrandr --output eDP-1 --off --output HDMI-1 --primary --auto
      '';

      todos = ''
                				set -l file_name (date "+%Y-%m-%d.md")
        								set -l current_year (date "+%Y")
                				nvim -p ~/notes/TODO/$current_year/$file_name
                			'';

      nv = ''
                set -l base_dir "$HOME/.config/configs.nvim"
                set -l nvim_dir "$HOME/.config/nvim"
                set -l nvim_backup "$HOME/.config/nvim.backup"

                set -l choice (find $base_dir -mindepth 1 -maxdepth 1 -type d -exec basename {} \; | fzf --prompt="Choose configuration: " --height=20% --reverse)

                if test -z "$choice"
                    echo "No configuration selected."
                    return 1
                end

                set -l choice_dir "$base_dir/$choice"
                echo "Selected: $choice"

                if test -d "$nvim_dir"
                    echo "Creating backup at $nvim_backup"
                    rm -rf "$nvim_backup"
                    mkdir -p "$nvim_backup"
                    rsync -a --delete "$nvim_dir"/ "$nvim_backup"/
                end

                echo "Applying new configuration..."
                rm -rf "$nvim_dir"
                mkdir -p "$nvim_dir"
        	rsync -rl "$choice_dir"/ "$nvim_dir"/

                echo "Now using: $choice"
      '';

      __prompt_git_segment = ''
        command -sq git; or return

        git rev-parse --is-inside-work-tree >/dev/null 2>&1; or return

        set -l branch (git symbolic-ref --quiet --short HEAD 2>/dev/null)
        if test -z "$branch"
          set branch (git rev-parse --short HEAD 2>/dev/null)
        end

        set -l dirty ""
        git diff --quiet --ignore-submodules -- 2>/dev/null; or set dirty "*"

        set_color brmagenta
        echo -n "  $branch$dirty"
        set_color normal
      '';

      __prompt_stack_segment = ''
        set -l icon ""
        set -l ver ""

        if test -f .ruby-version
          set icon ""
          set ver (string trim (cat .ruby-version))
        else if test -f package.json
          set icon ""
          if test -f .nvmrc
            set ver (string trim (cat .nvmrc))
          else if test -f .node-version
            set ver (string trim (cat .node-version))
          end
        else if test -f mix.exs
          set icon ""
          if test -f .tool-versions
            set -l line (string match -r '^elixir\\s+.+$' (cat .tool-versions) | head -n 1)
            test -n "$line"; and set ver (string split -m 2 ' ' $line)[2]
          end
        else if test -f Cargo.toml
          set icon ""
          if test -f rust-toolchain.toml
            set -l line (string match -r 'channel\\s*=\\s*\".+\"' (cat rust-toolchain.toml) | head -n 1)
            if test -n "$line"
              set ver (string replace -r '.*\"(.+)\".*' '$1' $line)
            end
          else if test -f rust-toolchain
            set ver (string trim (cat rust-toolchain))
          end
        else if test -f go.mod
          set icon ""
          set -l line (string match -r '^go\\s+.+$' (cat go.mod) | head -n 1)
          test -n "$line"; and set ver (string split -m 2 ' ' $line)[2]
        end

        test -n "$icon"; or return

        set_color brblue
        if test -n "$ver"
          echo -n " $icon $ver"
        else
          echo -n " $icon"
        end
        set_color normal
      '';

      fish_prompt = ''
        set_color cyan
        echo -n "λ "

        set_color yellow
        echo -n (prompt_pwd)

        __prompt_git_segment
        __prompt_stack_segment

        set_color normal
        echo -n " "
      '';
    };
  };
}
