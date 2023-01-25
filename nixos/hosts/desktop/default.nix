{ config, inputs, pkgs, modulesPath, lib, ... }:

{
  imports = [
    # Stuff for handling Incel CPU and Novideo GPU 
    (modulesPath + "/installer/scan/not-detected.nix")
    inputs.nixos-hardware.nixosModules.common-cpu-intel-cpu-only
    inputs.nixos-hardware.nixosModules.common-gpu-nvidia-nonprime
    inputs.nixos-hardware.nixosModules.common-pc-ssd

    # User stuff
    ../../presets/desktop.nix
    ../../modules/user-bw.nix
    ../../modules/logitech.nix
    ../../modules/virt.nix

  ];

  # Kernel things
  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  # Drives
  fileSystems."/" =
    { device = "/dev/disk/by-uuid/7e2ab1ce-3f37-43d5-ae14-d0bbd7c91408";
      fsType = "ext4";
    };

  fileSystems."/boot" = # Windows boot partition as well, so I pray to God nothing breaks
    { device = "/dev/disk/by-uuid/7022-9C68";
      fsType = "vfat";
    };

  # Bootloader
  boot.loader.grub = {
    enable = true;
    devices = [ "nodev" ];
    efiSupport = true;
    useOSProber = true;
  };

  # Miscellaneous
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  networking.hostName = "incel";
  
  system.autoUpgrade.enable = false;
  services.xserver.displayManager.gdm.autoSuspend = false;

}
