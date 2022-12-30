{ pkgs, ... }: {
  users.users.bw = {
    isNormalUser = true;
    extraGroups = [ "wheel" "libvirtd" "networkmanager" "adbusers" ];
    shell = pkgs.zsh;
  };

  systemd.tmpfiles.rules = [ "d /home/bw 0700 bw users - -" ];
}
