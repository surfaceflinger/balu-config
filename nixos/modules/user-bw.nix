{ pkgs, ... }: {
  users.users.bw = {
    isNormalUser = true;
    extraGroups = [ "wheel" "libvirtd" "networkmanager" "adbusers" ];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFVQpl+h2+zHLecJDEc25rl0u5SONJeVaPWWRrcqKxVr root@incel"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOUw20XaCWiQK+ZAo1BE0dmpe9EUDScXyD/vgu+GRumO bw@x280"
    ];
  };

  systemd.tmpfiles.rules = [ "d /home/bw 0700 bw users - -" ];
}
