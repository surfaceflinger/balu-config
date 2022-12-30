{ pkgs, ... }: {
  # Chromium config
  environment.systemPackages = [ pkgs.google-chrome ];
  programs.chromium = {
    enable = true;
    extensions = [
      "nngceckbapebfimnlniiiahkandclblb" # Bitwarden
      "lckanjgmijmafbedllaakclkaicjfmnk" # ClearURLs
      "omkfmpieigblcllmkgbflkikinpkodlk" # enhanced-h264ify
      "pkehgijcmpdhfbdbbnkijodmdjhbjlgp" # Privacy Badger
      "gmdihkflccbodfkfioifolcijgahdgaf" # KellyC Show YouTube Dislikes
      "mafpmfcccpbjnhfhjnllmmalhifmlcie" # TOR Snowflake
      "mnjggcdmjocbbbhaepdhchncahnbgone" # SponsorBlock for YouTube
      "cjpalhdlnbpafiamejdnhcphjbkeiagm" # uBlock Origin
      "jghecgabfgfdldnmbfkhmffcabddioke" # Volume Master
      "dhdgffkkebhmkfjojejmpbldmpobfkfo" # Tampermonkey
      "eimadpbcbfnmbkopoojfekhnkhdbieeh" # Dark Reader
      "edeocnllmaooibmigmielinnjiihifkn" # Rounded Tube
    ];
  };
}
