{ pkgs, ... }: {
  imports = [ ./tools-standard.nix ];

  environment.systemPackages = with pkgs; [
    vscode
    tdesktop
    spotify
    mpv
    wine-staging
    lollypop
    prismlauncher-qt5
    evince
    libimobiledevice
  ];
}
