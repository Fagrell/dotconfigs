{ config, pkgs, lib, ... }:

let
  fromGitHub = ref: repo: pkgs.vimUtils.buildVimPlugin {
    pname = "${lib.strings.sanitizeDerivationName repo}";
    version = ref;
    src = builtins.fetchGit {
      url = "https://github.com/${repo}.git";
      ref = ref;
    };
  };

  luaRequire = module: builtins.readFile (builtins.toString ./. + "/${module}.lua");

  luaConfig = builtins.concatStringsSep "\n" (map luaRequire [
          "harpoon"
          "keymaps"
          "init"
          "options"
          "telescope"
          "treesitter"
          "lsp"
          "toggleterm"
          "wrapping"
          "surround"
  ]);
in
{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;
    defaultEditor = true;

    extraPackages = with pkgs; [
      ltex-ls
      shfmt
      tree-sitter
    ];

    plugins = with pkgs.vimPlugins; [
      catppuccin-nvim
      toggleterm-nvim
      wrapping-nvim
      telescope-fzf-native-nvim
      telescope-nvim
      telescope-project-nvim
      telescope-ui-select-nvim
      (fromGitHub "harpoon2" "ThePrimeagen/harpoon")
      (fromGitHub "main" "WhoIsSethDaniel/toggle-lsp-diagnostics.nvim")
      nvim-treesitter-context
      nvim-treesitter.withAllGrammars
      nvim-lspconfig
      nvim-surround
      plenary-nvim

      # Completion
      nvim-cmp
      cmp-nvim-lsp
    ];

    extraConfig =
    ''
      lua <<
      ${luaConfig}
    '';
  };
}
