{ pkgs, inputs, modulesPath, ... }:

{
  imports =
    [
      (modulesPath + "/installer/scan/not-detected.nix")
      inputs.nixos-hardware.nixosModules.dell-latitude-7490
      inputs.nixos-hardware.nixosModules.common-pc-laptop-ssd
      ../../presets/laptop.nix
      ../../modules/user-bw.nix
    ];

  # HW
  boot = {
    initrd.availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" ];
    kernelModules = [ "kvm-intel" ];
  };

  # Bootloader
  boot.loader.grub = {
    enable = true;
    devices = [ "nodev" ];
    efiSupport = true;
  };

  # Networking
  networking.hostName = "7490";

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
    pywal
    qbittorrent
  ];
}
