#!/usr/bin/bash

sh <(curl -L https://nixos.org/nix/install) --no-daemon
. "${HOME}/.nix-profile/etc/profile.d/nix.sh"

nix-channel --add https://github.com/nix-community/home-manager/archive/release-22.05.tar.gz home-manager
nix-channel --add https://nixos.org/channels/nixpkgs-22.05-darwin/ nixpkgs
nix-channel --update
export NIX_PATH="${HOME}/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels${NIX_PATH:+:$NIX_PATH}"
nix-shell '<home-manager>' -A install

for VAR in USER HOME; do
  sed -i "s|\${${VAR}}|${!VAR}|g" "${HOME}/dotconfigs/home.nix"
done
rm "${HOME}/.config/nixpkgs/home.nix"
ln -s ~/dotconfigs/home.nix "${HOME}/.config/nixpkgs/home.nix"
nix-env --set-flag priority 6 nix
echo "[ -f ${HOME}/.nix-profile/etc/profile.d/nix.sh ] && source ${HOME}/.nix-profile/etc/profile.d/nix.sh
      home-manager switch" >> ~/.bashrc
