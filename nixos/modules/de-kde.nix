{ pkgs, ... }: {
  services.xserver = {
    enable = true;
    displayManager.sddm = {
      enable = true;
    };
    desktopManager.plasma5.enable = true;
  };

  # Debloat
  services.xserver.desktopManager.plasma5.excludePackages = with pkgs.libsForQt5; [
    khelpcenter
    print-manager 
    oxygen
  ]

  # Other software
  #environment.systemPackages = with pkgs; [
  # Nothing necessary here so far.
  #];

  fonts = {
    fonts = with pkgs; [
      apple-emoji-linux
      cascadia-code # S-tier font for terminal
      noto-fonts
      noto-fonts-cjk
    ];
    fontconfig.defaultFonts.emoji = [ "Apple Color Emoji" ];
  };

  programs.gamemode.enable = true;
  security.unprivilegedUsernsClone = true;
  services.flatpak.enable = true;
  services.power-profiles-daemon.enable = false;
  programs.dconf.enable = true;
}
