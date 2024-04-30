{ config, pkgs, ... }:

{
  imports = [
    ./home.nix
  ];

  programs.git = {
    userName = "Alexander Fagrell";
    userEmail = "alexander.fagrell@wavestore.com";
    signing = {
      key = "/home/alex/.ssh/id_wavestore.pub";
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
