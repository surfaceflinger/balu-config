{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [
      (modulesPath + "/installer/scan/not-detected.nix")
      ../../presets/server.nix
      ../../modules/user-bw.nix
    ];

  # HW
  boot = {
    initrd.availableKernelModules = [ "ahci" "ohci_pci" "ehci_pci" "xhci_pci" "usb_storage" "usbhid" "sd_mod" ];
    kernelModules = [ "kvm-amd" ];
  };
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  # Storage
  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/75dd2273-c6d4-4fc6-a2e2-8d293ec86c07";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/E288-9325";
      fsType = "vfat";
    };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/4a240fc7-04ea-4a6d-94da-95a50987631b"; }];

  # Bootloader
  boot.loader.grub = {
    enable = true;
    devices = [ "nodev" ];
    efiSupport = true;
  };

  # Networking
  networking = {
    hostName = "wyse";
    # :(
    firewall.enable = false;
    useDHCP = false;
    networkmanager.enable = true;
  };

  # Vomit. not even trying to understand this shit.
  services.samba = {
    enable = true;
    enableNmbd = false;
    enableWinbindd = false;
    extraConfig = ''
      guest account = bw
      map to guest = Bad User

      load printers = no
      printcap name = /dev/null

      log file = /var/log/samba/client.%I
      log level = 2
    '';

    shares = {
      pliki = {
        "path" = "/srv/share";
        "guest ok" = "yes";
        "read only" = "no";
      };
    };
  };

  systemd.services.qbittorrent-nox = {
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "exec";
      ExecStart = "${pkgs.qbittorrent-nox}/bin/qbittorrent-nox";
      User = "torenciarz";
      Group = "torrent";
    };
    unitConfig = {
      Wants = "network-online.target";
      After = "network-online.target nss-lookup.target";
    };
  };

  users.users.torenciarz = {
    group = "torrent";
    isNormalUser = true;
  };
  users.groups.torrent = { };
}
