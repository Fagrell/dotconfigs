#!/usr/bin/bash

sudo apt install zsh 

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

sudo apt install fzf ripgrep entr tmux

rm ~/.tmux.conf ~/.p10k.zsh ~/.zshrc ~/.config/gh/config.yml ~/.fzf.zsh
mkdir -p ~/.config/gh/

ln -s ~/dotconfigs/tmux.conf ~/.tmux.conf
ln -s ~/dotconfigs/p10k.zsh ~/.p10k.zsh
ln -s ~/dotconfigs/zshrc ~/.zshrc
ln -s ~/dotconfigs/config/gh/config.yml ~/.config/gh/config.yml
ln -s ~/dotconfigs/fzf.zsh ~/.fzf.zsh
