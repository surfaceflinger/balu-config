{ ... }: {
  imports = [
    ../modules/anime4k.nix
    ../modules/base.nix
    ../modules/chromium.nix
    ../modules/desktop-environment.nix
    ../modules/mitigations-off.nix
    ../modules/networking-laptop.nix
    ../modules/openssh.nix
    ../modules/sound.nix
    ../modules/tools-desktop.nix
  ];

  services.thermald.enable = true;
  services.tlp = {
    settings = {
      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 0;
    };
  };
}
