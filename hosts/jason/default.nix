# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  pkgs,
  config,
  lib,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./containers
    ./gaming.nix
    ./graphical.nix
    ./media-server.nix
    ./security.nix
    ./sound.nix
    ./system.nix
    ./virtualization.nix
  ];

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.mutableUsers = true;
  users.users.michael = {
    isNormalUser = true;
    description = "Michael Andreas Graversen";
    extraGroups = [
      "networkmanager"
      "wheel"
      "input"
      "podman"
      "docker"
      "uinput" # for ydotool
      "dialout" # for arduino and other serial devices
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    easyeffects # Audio equalizer and effects
    barrier # Software KVM
    gparted # has to be a systempackage or it wont open
    openrgb # RGB control
    lact
    graphite-cursors
    qbitmanage
    onlyoffice-bin
    docker-compose
    podman-compose
    polkit_gnome
    pulseaudio
    tree
    lm_sensors
    git
  ];

  services.tailscale.enable = true;

  services.mullvad-vpn.enable = true;

  programs.nix-ld.enable = true;

  services.fstrim.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    # pinentryPackage = pkgs.pinentry-gnome3;
  };
  services.dbus.packages = [pkgs.gcr];

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall = {
    allowedTCPPorts = [
      57621 # Spotify sync local devices
      24800 # input-leap
    ];
    allowedUDPPorts = [
      5353 # Spotfify discover Connect devices
      24800 # input-leap
    ];
  };

  metrics.netdata = {
    enable = true;
    disableWebUI = true;
  };
}
