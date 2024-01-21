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
in

{
  programs.neovim = {
    enable = true;
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
      telescope-cheat-nvim
      telescope-fzf-native-nvim
      telescope-nvim
      telescope-project-nvim
      telescope-ui-select-nvim
      (fromGitHub "harpoon2" "ThePrimeagen/harpoon")
      nvim-treesitter-context
      nvim-treesitter.withAllGrammars
      nvim-lspconfig

      # Completion
      nvim-cmp
      cmp-buffer
      cmp-cmdline
      cmp-nvim-lsp
      cmp-path
    ];

    extraConfig = let
      luaRequire = module:
        builtins.readFile (builtins.toString
          ./.
          + "/${module}.lua");
      luaConfig = builtins.concatStringsSep "\n" (map luaRequire [
        "harpoon"
        "keymaps"
	"init"
	"options"
	"telescope"
	"treesitter"
	"lsp"
	"toggleterm"

     ]);
    in ''
      lua <<
      ${luaConfig}
    '';
  };
}
