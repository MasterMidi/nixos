{pkgs,...}:

{
  programs.waybar = {
    enable = true;
    settings = {
      bar = {
        position = "top";
        layer = "top";
        spacing = 4;
        height = 30;

        modules-left = [ ];
        modules-center = [ "custom/media" ];
        modules-right = [ "idle_inhibitor" "pulseaudio" "bluetooth" "network" "cpu" "memory" "temperature" "keyboard-state" "clock" "tray" ];
        keyboard-state = {
          numlock = true;
          capslock = true;
          format = "{name} {icon}";
          format-icons = {
            locked = "";
            unlocked = "";
          };
        };
        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = "";
            deactivated = "";
          };
        };
        tray = {
          # "icon-size= 21,
          spacing = 10;
        };
        clock = {
          # "timezone= "America/New_York",
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          format-alt = "{:%Y-%m-%d}";
        };
        cpu = {
          format = "{usage}% ";
          tooltip = false;
        };
        memory = {
          format = "{}% ";
        };
        temperature = {
          # "thermal-zone": 2,
          # "hwmon-path": "/sys/class/hwmon/hwmon2/temp1_input",
          critical-threshold = 80;
          # "format-critical": "{temperatureC}°C {icon}",
          format = "{temperatureC}°C {icon}";
          format-icons = [ "󰉬" "" "󰉪" ];
        };
        network = {
          # interface = "wlp2*"; # (Optional) To force the use of this interface
          format-wifi = "{essid} ({signalStrength}%) ";
          format-ethernet = "{ipaddr}/{cidr} 󰊗";
          tooltip-format = "{ifname} via {gwaddr} 󰊗";
          format-linked = "{ifname} (No IP) 󰊗";
          format-disconnected = "Disconnected ⚠";
          format-alt = "{ifname}: {ipaddr}/{cidr}";
        };
        pulseaudio = {
          scroll-step = 1; # %, can be a float
          format = "{volume}% {icon} {format_source}";
          format-bluetooth = "{volume}% {icon} {format_source}";
          format-bluetooth-muted = "󰅶 {icon} {format_source}";
          format-muted = "󰅶 {format_source}";
          format-source = "{volume}% ";
          format-source-muted = "";
          format-icons = {
            headphone = "";
            hands-free = "󰂑";
            headset = "󰂑";
            phone = "";
            portable = "";
            car = "";
            default = [ "" "" "" ];
          };
          on-click = "pavucontrol";
        };
        "custom/media" = {
          format = "{icon} ♪ {}";
          return-type = "string";
          format-icons = {
            spotify = "";
            default = "🎜";
          };
          escape = true;
          interval = 2;
          exec = "playerctl metadata --player=spotify_player --format 'Now playing: {{ title }} - {{ artist }} - {{ album }}'";
        };
      };
    };
  };
}