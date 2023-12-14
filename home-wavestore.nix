{ config, pkgs, ... }:

{
  imports = [
    ./home.nix
  ];

  programs.git = {
    userName = "Alexander Fagrell";
    userEmail = "alexander.fagrell@wavestore.com";
    extraConfig = {
      commit.gpgsign = true;
      user.signingkey = "D7805B5B2AB98C7B";
    };
  };
}
