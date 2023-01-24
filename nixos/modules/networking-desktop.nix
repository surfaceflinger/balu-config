{ ... }: {
  imports = [ ./networking-base.nix ];

  networking = {
    useDHCP = true;
    networkmanager.enable = false;
  };

  services.avahi = {
    enable = true;
    publish = {
      enable = true;
      userServices = true;
    };
  };
}
