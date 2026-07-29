{ ... }:

{
  home.file.".config/i3status-rust/config.toml".source = ./status-rust.toml;

  home.file.".config/i3/config".text = ''
    set $mod Mod4

    exec_always --no-startup-id feh --bg-fill ~/repos/nixcfg/forest.jpg

    font pango:monospace 8

    exec --no-startup-id i3-resurrect restore
    exec --no-startup-id xss-lock --transfer-sleep-lock -- i3lock --nofork
    exec --no-startup-id nm-applet

    set $refresh_i3status killall -SIGUSR1 i3status-rs

    # Screenshots
    bindsym Shift+Print exec --no-startup-id maim --select | xclip -selection clipboard -t image/png
    bindsym Control+Shift+s exec maim -s | xclip -selection clipboard -t image/png

    floating_modifier $mod

    bindsym $mod+Return exec kitty
    bindsym $mod+Shift+q kill

    # Launchers
    bindsym $mod+d exec "rofi -modi drun,run -show drun"
    bindsym $mod+p exec "~/.config/rofi/scripts/repos-rofi.sh"
    bindsym $mod+t exec "~/.config/rofi/scripts/tmux-rofi.sh"
    bindsym $mod+g exec "~/.config/rofi/scripts/github-rofi.sh"

    # Focus
    bindsym $mod+j focus left
    bindsym $mod+k focus down
    bindsym $mod+l focus up
    bindsym $mod+ccedilla focus right

    # Move window
    bindsym $mod+Shift+j move left
    bindsym $mod+Shift+k move down
    bindsym $mod+Shift+l move up
    bindsym $mod+Shift+ccedilla move right

    bindsym $mod+Shift+Left move left
    bindsym $mod+Shift+Down move down
    bindsym $mod+Shift+Up move up
    bindsym $mod+Shift+Right move right

    # Splits
    bindsym $mod+h split h
    bindsym $mod+v split v

    # Layout
    bindsym $mod+f fullscreen toggle
    bindsym $mod+s layout stacking
    bindsym $mod+w layout tabbed
    bindsym $mod+e layout toggle split
    bindsym $mod+Shift+space floating toggle
    bindsym $mod+space focus mode_toggle
    bindsym $mod+a focus parent

    # Workspaces
    set $ws1 "1"
    set $ws2 "2"
    set $ws3 "3"
    set $ws4 "4"
    set $ws5 "5"
    set $ws6 "6"
    set $ws7 "7"
    set $ws8 "8"
    set $ws9 "9"
    set $ws10 "10"

    bindsym $mod+1 workspace number $ws1
    bindsym $mod+2 workspace number $ws2
    bindsym $mod+3 workspace number $ws3
    bindsym $mod+4 workspace number $ws4
    bindsym $mod+5 workspace number $ws5
    bindsym $mod+6 workspace number $ws6
    bindsym $mod+7 workspace number $ws7
    bindsym $mod+8 workspace number $ws8
    bindsym $mod+9 workspace number $ws9
    bindsym $mod+0 workspace number $ws10

    bindsym $mod+Shift+1 move container to workspace number $ws1
    bindsym $mod+Shift+2 move container to workspace number $ws2
    bindsym $mod+Shift+3 move container to workspace number $ws3
    bindsym $mod+Shift+4 move container to workspace number $ws4
    bindsym $mod+Shift+5 move container to workspace number $ws5
    bindsym $mod+Shift+6 move container to workspace number $ws6
    bindsym $mod+Shift+7 move container to workspace number $ws7
    bindsym $mod+Shift+8 move container to workspace number $ws8
    bindsym $mod+Shift+9 move container to workspace number $ws9
    bindsym $mod+Shift+0 move container to workspace number $ws10

    # Volume
    bindsym XF86AudioRaiseVolume exec --no-startup-id amixer -D pulse sset Master 5%+
    bindsym XF86AudioLowerVolume exec --no-startup-id amixer -D pulse sset Master 5%-
    bindsym XF86AudioMute exec --no-startup-id amixer -D pulse sset Master toggle

    # i3 controls
    bindsym $mod+Shift+c reload
    bindsym $mod+Shift+r restart
    bindsym $mod+Shift+e exec "i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -B 'Yes, exit i3' 'i3-msg exit'"

    # Resize
    mode "resize" {
      bindsym j resize shrink width 10 px or 10 ppt
      bindsym k resize grow height 10 px or 10 ppt
      bindsym l resize shrink height 10 px or 10 ppt
      bindsym ccedilla resize grow width 10 px or 10 ppt

      bindsym Left resize shrink width 10 px or 10 ppt
      bindsym Down resize grow height 10 px or 10 ppt
      bindsym Up resize shrink height 10 px or 10 ppt
      bindsym Right resize grow width 10 px or 10 ppt

      bindsym Return mode "default"
      bindsym Escape mode "default"
      bindsym $mod+r mode "default"
    }

    bindsym $mod+r mode "resize"

    # Assigns
    assign [class="brave-browser"] 2

    # Bar
    bar {
      status_command i3status-rs
    }

    # Window rules
    for_window [class="Pavucontrol"] floating enable, resize set 400px 240px, move position 2140px 40px

    # Gaps & borders
    gaps inner 6
    gaps outer 0
    smart_gaps on
    smart_borders on
    for_window [title="^.*"] border pixel 2
  '';
}
