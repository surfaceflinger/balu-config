{ lib, ... }: {
  imports = [
    ../modules/anime4k.nix
    ../modules/base.nix
    ../modules/chromium.nix
    ../modules/desktop-environment.nix
    ../modules/mitigations-off.nix
    ../modules/networking-desktop.nix
    ../modules/openssh.nix
    ../modules/sound.nix
    ../modules/tools-desktop.nix
  ];

  powerManagement.cpuFreqGovernor = lib.mkDefault "schedutil";
}
