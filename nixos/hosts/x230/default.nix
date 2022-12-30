{ inputs, modulesPath, ... }: {

  imports =
    [
      (modulesPath + "/installer/scan/not-detected.nix")
      inputs.nixos-hardware.nixosModules.lenovo-thinkpad-x230
      inputs.nixos-hardware.nixosModules.common-pc-laptop-ssd
      ../../presets/laptop.nix
      ../../modules/user-bw.nix
    ];

  # HW
  boot.initrd.availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "usb_storage" "sd_mod" "sdhci_pci" ];

  # Storage
  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/2755cd13-9966-411c-9a31-f40d059bfefa";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/FA2D-13CB";
      fsType = "vfat";
    };

  # Bootloader
  boot.loader.grub = {
    enable = true;
    devices = [ "nodev" ];
    efiSupport = true;
  };

  # GPU
  environment.variables = { MESA_LOADER_DRIVER_OVERRIDE = "crocus"; };

  # Networking
  networking.hostName = "x230";
}
