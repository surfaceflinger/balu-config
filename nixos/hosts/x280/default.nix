{ pkgs, inputs, modulesPath, ... }:

{
  imports =
    [
      (modulesPath + "/installer/scan/not-detected.nix")
      inputs.nixos-hardware.nixosModules.lenovo-thinkpad-x280
      inputs.nixos-hardware.nixosModules.common-pc-laptop-ssd
      ../../presets/laptop.nix
      ../../modules/user-bw.nix
    ];

  # HW
  boot = {
    initrd.availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" ];
    kernelModules = [ "kvm-intel" ];
  };

  # Storage
  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/f4485319-de6f-4ad9-8c66-784bcee4798b";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/73F5-D57D";
      fsType = "vfat";
    };

  # Bootloader
  boot.loader.grub = {
    enable = true;
    devices = [ "nodev" ];
    efiSupport = true;
  };

  # Networking
  networking.hostName = "x280";

  # Power management / modern intel_pstate
  services.tlp = {
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
    };
  };

  # Additional packages
  environment.systemPackages = with pkgs; [
    jetbrains.idea-community
    mgba
  ];
}
