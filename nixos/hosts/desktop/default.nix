{ config, inputs, pkgs, modulesPath, ... }:

{
  imports = [
    # Stuff for handling Incel CPU and Novideo GPU 
    (modulesPath + "/installer/scan/not-detected.nix")
    inputs.nixos-hardware.nixosModules.common-cpu-intel-cpu-only
    inputs.nixos-hardware.nixosModules.common-gpu-nvidia
    inputs.nixos-hardware.nixosModules.common-pc-ssd

    # User stuff
    ../../presets/desktop.nix
    ../../modules/user-bw.nix
    ../../modules/logitech.nix
    ../../modules/virt.nix

  ];

  # Bootloader
  boot.loader.grub = {
    enable = true;
    devices = [ "nodev" ];
    efiSupport = true;
    useOSProber = true;
  };

  # Miscellaneous
  networking.hostName = "incel";
  system.autoUpgrade.enable = false;
  services.xserver.displayManager.gdm.autoSuspend = false;

}