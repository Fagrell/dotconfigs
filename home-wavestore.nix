{ config, pkgs, ... }:

{
  imports = [
    ./home.nix
  ];

  programs.git = {
    userName = "Alexander Fagrell";
    userEmail = "alexander.fagrell@wavestore.com";
    extraConfig = {
      gpg.format = "ssh";
      commit.gpgsign = true;
      tag.gpgSign = true;
      user.signingkey = "/home/alex/.ssh/id_wavestore.pub";
    };
  };

  programs.gh = {
    settings = {
        aliases = {
          wsclone = "repo clone wavestore-com/$1";
        };
    };
  };

}
