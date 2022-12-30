{ config
, lib
, ...
}: {
  networking = {
    useDHCP = lib.mkDefault true;
    firewall = {
      enable = lib.mkDefault true;
      allowedTCPPorts = [ ];
      allowedUDPPorts = [ config.services.tailscale.port ];
      trustedInterfaces = [ "tailscale0" ];
      checkReversePath = "loose";
    };
  };
  services.tailscale.enable = true;
}
