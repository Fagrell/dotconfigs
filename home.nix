{ config, pkgs, ... }:

{
  imports = [
    ./neovim/default.nix
  ];

  targets.genericLinux.enable = true;

  home.username = "alex";
  home.homeDirectory = "/home/alex";

  home.packages = [
    pkgs.bat
    pkgs.bit
    pkgs.cargo
    pkgs.chromium
    pkgs.clang
    pkgs.clang-tools
    pkgs.cloc
    pkgs.cmake
    pkgs.dart
    pkgs.delta
    pkgs.direnv
    pkgs.eza
    pkgs.fd
    pkgs.git
    pkgs.inetutils
    pkgs.just
    pkgs.nmap
    pkgs.ripgrep
    pkgs.rust-analyzer
    pkgs.rustc
    pkgs.rustfmt
    pkgs.tldr
    pkgs.unzip
    pkgs.watchexec
    pkgs.xclip
  ];

  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
  home.sessionVariables = {
    CHROME_EXECUTABLE = pkgs.chromium.outPath + "/bin/chromium";
  };

  programs.bash = {
    enable = true;
    shellAliases = {
      sw = "home-manager switch && zsh";
    };
  };

  programs.bat = {
    enable = true;
    config = {
      theme = "mocha";
    };
    themes = {
         mocha = {
          src = pkgs.fetchFromGitHub {
            owner = "catppuccin";
            repo = "bat";
            rev = "d714cc1d358ea51bfc02550dabab693f70cccea0";
            sha256 = "sha256-Q5B4NDrfCIK3UAMs94vdXnR42k4AXCqZz6sRn8bzmf4=";
          };
          file = "themes/Catppuccin Mocha.tmTheme";
       };
    };
  };

  programs.git = {
    enable = true;
    aliases = {
      create = "!git checkout -b \"$1\" $(git rev-parse --abbrev-ref origin/HEAD) #";
      fork = "!git clone \"$1\" . && git config remote.origin.pushurl \"$2\" #";
      grep = "rg";
      realblame = "!git blame -w -C -C -C";
      safeforce = "!git push --force-with-lease";
    };
    delta.enable = true;
    extraConfig = {
      rerere.enabled = true;
      user.useConfigOnly = true;
      branch.sort = "committerdate";
      column.ui = "auto";
      push = {
        autoSetupRemote = true;
        default = "current";
      };
      delta = {
        features = "catppuccin-mocha";
        navigate = true;
        side-by-side = true;
      };
      fetch.pruneTags = true;
      merge = {
        tool = "vimdiff";
        conflictstyle = "diff3";
      };
      diff = {
        tool = "vimdiff";
        prompt = "false";
        algorithm = "histogram";
      };
      difftool = {prompt = false;};
      mergetool = {prompt = false;};
      init = {defaultBranch = "main";};
      gpg.format = "ssh";
      gpg.ssh.allowedSignersFile = "~/.ssh/allowed_signers";
    };
    includes = [
      {
        path = "~/dotconfigs/themes.gitconfig";
      }
      {
        condition = "gitdir:~/dotconfigs/**";
        contents = {
          user.email = "fagrell@outlook.com";
          user.signingkey = "~/.ssh/id_rsa.pub.personal";
          core.sshCommand = "ssh -i ~/.ssh/id_rsa.pub.personal";
        };
      }
    ];
    signing = {
      signByDefault = true;
    };
  };

  programs.zsh = {
    enable = true;
    autocd = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    initExtra = ''
      # Bind gpg-agent to this TTY if gpg commands are used.
      export GPG_TTY=$(tty)
      bindkey -M viins 'kj' vi-cmd-mode
      eval "$(direnv hook zsh)"
    '';
    shellAliases = {
      ls = "eza";
      la = "eza -la";
      eg = "tldr";
      u = "cd ..";
      cat = "bat";
      hm = "home-manager";
      sw = "home-manager switch";
      vs = "codium --no-sandbox";
      tree = "eza --tree";
      dockerid = "docker container ls | awk 'FNR == 2 {print $1}'";
      dockerxsh = "docker exec -it $(dockerid) sh";
      grep = "rg";
      e = "vim .";
    };

    history = {
      expireDuplicatesFirst = true;
      save = 100000000;
      size = 1000000000;
    };

    oh-my-zsh = {
        enable = true;
        plugins = [
          "vi-mode"
          "git"
        ];
    };

    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "powerlevel10k-config";
        src = ~/dotconfigs;
        file = "p10k.zsh";
      }
    ];
  };

  programs.zoxide = {
    enable = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultCommand = "rg --files --no-ignore-vcs --hidden";
  };

  programs.gh = {
    enable = true;
    settings = {
        git_protocol = "ssh";
        prompt = "enabled";
        editor = "!!null code --wait";
        aliases = {
          co = "!GH_FORCE_TTY=49% gh pr list | rg '#' --color=never | fzf --ansi --preview 'GH_FORCE_TTY=$FZF_PREVIEW_COLUMNS gh pr view {1}' | rg '#(\\d+)' -or '$1' | xargs gh pr checkout";
          o = "pr view --web";
        };
    };
  };

}
