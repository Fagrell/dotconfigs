{ config, pkgs, ... }:

{
  targets.genericLinux.enable = true;

  home.username = "alex";
  home.homeDirectory = "/home/alex";

  home.packages = [
    pkgs.ripgrep
    pkgs.watchexec
    pkgs.eza
    pkgs.tldr
    pkgs.bat
    pkgs.bit
    pkgs.git
    pkgs.cmake
    pkgs.just
    pkgs.cloc
    pkgs.nmap
  ];

  home.stateVersion = "23.11";
  programs.home-manager.enable = true;

  programs.bash = {
    enable = true;
    shellAliases = {
      sw = "home-manager switch && zsh";
    };
  };

  programs.git = {
    enable = true;
    aliases = {
      create = "!git checkout -b \"$1\" $(git rev-parse --abbrev-ref origin/HEAD) #";
      fork = "!git clone \"$1\" . && git config remote.origin.pushurl \"$2\" #";
    };
  };

  programs.zsh = {
    enable = true;
    autocd = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    syntaxHighlighting.enable = true;
    initExtra = ''
      # Bind gpg-agent to this TTY if gpg commands are used.
      export GPG_TTY=$(tty)
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
    };

    history = {
      expireDuplicatesFirst = true;
      save = 100000000;
      size = 1000000000;
    };

    oh-my-zsh = {
        enable = true;
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
          co = "!id=\"\$(gh pr list -L100 | fzf | cut -f1)\"; [ -n \"\${id}\" ] && gh pr checkout \"\${id}\"";
          o = "pr view --web";
        };
    };
  };

}
