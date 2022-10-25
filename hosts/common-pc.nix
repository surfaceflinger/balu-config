{ config
, pkgs
, ...
}: {
  # zram
  zramSwap.enable = true;

  # Networking
  networking = {
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [ ];
      allowedUDPPorts = [ config.services.tailscale.port ];
      trustedInterfaces = [ "tailscale0" ];
      checkReversePath = "loose";
    };
  };
  services.tailscale.enable = true;

  # Desktop environment
  services.xserver = {
    enable = true;
    displayManager = {
      lightdm.enable = true;
      defaultSession = "xfce+i3";
    };
    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
    };
    desktopManager = {
      xterm.enable = false;
      xfce = {
        enable = true;
        noDesktop = true;
        enableXfwm = false;
      };
    };
  };

  services.xrdp = {
    enable = true;
    defaultWindowManager = "i3";
    openFirewall = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
  };

  # Sound
  security.rtkit.enable = true;
  hardware = {
    pulseaudio.enable = false;
    bluetooth = {
      enable = true;
      powerOnBoot = false;
    };
  };
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Users
  users.users.bw.extraGroups = [ "libvirtd" "networkmanager" ];

  # Other software
  environment.systemPackages = with pkgs; [
    (pkgs.writeScriptBin "youtube-dl" ''exec yt-dlp "$@"'')
    (pkgs.writeScriptBin "screenshot" ''
      #!${pkgs.bash}/bin/bash
      FILE="/home/bw/Screenshots/$(date +%F-%T).png"
      mkdir -p $(dirname $FILE)
      ${pkgs.maim}/bin/maim -s $FILE
      ${pkgs.xclip}/bin/xclip -selection clipboard -t image/png -i $FILE
    '')

    glxinfo
    yt-dlp
    ark
    chromium
    vscode
    tdesktop
    discord
    spotify
    pavucontrol
    mpv
    wine-staging
    gnupg
    whitesur-icon-theme
    alacritty
    rofi
    polybar
    pywal
    feh
    optipng
    python311
    rofimoji
  ];

  fonts.fonts = with pkgs; [
    cantarell-fonts
    cascadia-code
    source-code-pro
    twemoji-color-font
  ];

  programs.gamemode.enable = true;
  services.flatpak.enable = true;
  virtualisation.libvirtd.enable = true;
  programs.gnupg.agent.enable = true;

  # Overlays
  nixpkgs.overlays = [
    (self: super: {
      chromium = super.chromium.override {
        commandLineArgs = "--enable-features=WebUIDarkMode --force-dark-mode";
      };
      polybar = super.polybar.override { i3GapsSupport = true; };
    })
  ];

  # Chromium config
  programs.chromium = {
    enable = true;
    extensions = [
      "nngceckbapebfimnlniiiahkandclblb" # Bitwarden
      "lckanjgmijmafbedllaakclkaicjfmnk" # ClearURLs
      "omkfmpieigblcllmkgbflkikinpkodlk" # enhanced-h264ify
      "pkehgijcmpdhfbdbbnkijodmdjhbjlgp" # Privacy Badger
      "gmdihkflccbodfkfioifolcijgahdgaf" # KellyC Show YouTube Dislikes
      "mafpmfcccpbjnhfhjnllmmalhifmlcie" # TOR Snowflake
      "mnjggcdmjocbbbhaepdhchncahnbgone" # SponsorBlock for YouTube
      "cjpalhdlnbpafiamejdnhcphjbkeiagm" # uBlock Origin
      "jghecgabfgfdldnmbfkhmffcabddioke" # Volume Master
      "dhdgffkkebhmkfjojejmpbldmpobfkfo" # Tampermonkey
      "eimadpbcbfnmbkopoojfekhnkhdbieeh" # Dark Reader
      "edeocnllmaooibmigmielinnjiihifkn" # Rounded Tube
      "ookjlbkiijinhpmnjffcofjonbfbgaoc" # Temple Wallet
    ];
  };
  security.chromiumSuidSandbox.enable = true;
}
