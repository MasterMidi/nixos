{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  documentation = {
    enable = true;
    doc.enable = false;
    man.enable = true;
    dev.enable = false;
  };

  # environment.etc = {
  #   "nix/flake-channels/nixpkgs".source = inputs.nixpkgs;
  #   "nix/flake-channels/home-manager".source = inputs.home-manager;
  # };

  nix = {
    # set the path for channels compat
    # nixPath = [
    #   "nixpkgs=/etc/nix/flake-channels/nixpkgs"
    #   "home-manager=/etc/nix/flake-channels/home-manager"
    # ];

    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 7d";
    };

    optimise = {
      automatic = true;
      dates = ["daily"];
    };

    package = pkgs.nixUnstable; # use the newest vwersion of the nix package manager

    # pin the registry to avoid downloading and evaling a new nixpkgs version every time using 'nix shell nixpkgs#...'
    # registry = lib.mapAttrs (_: v: {flake = v;}) inputs;

    # Free up to 1GiB whenever there is less than 100MiB left.
    extraOptions = ''
      keep-outputs = true
      warn-dirty = false
      keep-derivations = true
      min-free = ${toString (100 * 1024 * 1024)}
      max-free = ${toString (1024 * 1024 * 1024)}
    '';

    settings = {
      experimental-features = ["nix-command" "flakes" "auto-allocate-uids"];
      auto-optimise-store = true;
      builders-use-substitutes = true;
      max-jobs = "auto";
      substituters = [
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
      ];

      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
  };
  system.autoUpgrade.enable = false;
}
