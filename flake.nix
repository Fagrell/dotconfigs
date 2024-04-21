{
  description = "Alex's ";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixpkgs-unstable;
    home.url = github:nix-community/home-manager;
  };

  outputs = { self, nixpkgs, home }:
    homeConfigurations = {
      let
        pkgs = import nixpkgs { };
      homeConfig = import home { pkgs = pkgs; };
      in
      {
        nixpkgs = nixpkgs;
        home = homeConfig;
      };
    };
}
