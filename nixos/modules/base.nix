{ config
, pkgs
, lib
, outputs
, ...
}: {
  # zram swap
  zramSwap = {
    enable = true;
    algorithm = "lz4";
  };
  boot.kernel.sysctl."vm.swappiness" = lib.mkDefault "10";

  # tmpfs
  boot.tmpOnTmpfs = true;

  # Regional
  i18n.defaultLocale = lib.mkDefault "en_US.UTF-8";
  console.keyMap = lib.mkDefault "pl";
  time.timeZone = lib.mkDefault "Europe/Warsaw";

  # Other software
  environment.systemPackages = with pkgs; [
    gnupg
  ];
  programs = {
    gnupg.agent.enable = true;
    zsh.enable = true;
  };
  services.journald.extraConfig = "Storage=volatile";

  # Bootloader
  boot.loader = {
    efi.canTouchEfiVariables = true;
    systemd-boot.configurationLimit = lib.mkDefault 5;
    grub = {
      configurationLimit = lib.mkDefault 5;
      useOSProber = true;
    };
  };
  # Disable coredumps
  security.pam.loginLimits = [
    {
      domain = "*";
      item = "core";
      type = "hard";
      value = "0";
    }
  ];
  systemd.coredump.enable = false;

  # kernel tuning
  boot.kernelParams = [
    "efi=disable_early_pci_dma"
    "amd_iommu=on"
    "intel_iommu=on"
    "quiet"
  ];
  boot.consoleLogLevel = 0;

  # better oom handling
  systemd.oomd.enable = false;
  services.earlyoom.enable = true;

  # Nix
  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    settings.auto-optimise-store = true;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  system.stateVersion = "22.11";

  nixpkgs = {
    overlays = [
      outputs.overlays.modifications
      outputs.overlays.additions
    ];
    config.allowUnfree = true;
  };
}
