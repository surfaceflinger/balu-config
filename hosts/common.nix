{ config
, pkgs
, lib
, ...
}: {
  time.timeZone = lib.mkDefault "Europe/Warsaw";

  # Locale and keymap
  i18n.defaultLocale = lib.mkDefault "en_US.UTF-8";
  console.keyMap = lib.mkDefault "pl";

  # Users
  programs.zsh.enable = true;
  users.users.bw = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
  };

  # Allow unfree
  nixpkgs.config.allowUnfree = true;

  # Other software
  environment.systemPackages = with pkgs; [
    nano
    wget
    gnupg
    gitFull
    neofetch
    zsh-fast-syntax-highlighting
    zip
    p7zip
    unzip
    htop
  ];

  programs.nano.nanorc = ''
    set tabsize 2
    set tabstospaces
    set autoindent on
  '';

  # Hardened profile fixes/overrides/additions
  security = {
    pam.loginLimits = [
      {
        domain = "*";
        item = "core";
        type = "hard";
        value = "0";
      }
    ];
  };
  systemd.coredump.enable = false;

  # Nix
  nix = {
    extraOptions = "experimental-features = nix-command flakes";
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    settings.auto-optimise-store = true;
  };

  # stateVersion
  system.stateVersion = "22.11";
}
