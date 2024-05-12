vim.cmd.colorscheme "catppuccin"

local options = {
  timeoutlen = 800,
  number = true,
  relativenumber = true,

  tabstop = 2,
  softtabstop = 2,
  shiftwidth = 2,

  expandtab = true,
  showtabline = 2,

  smartindent = true,

  wrap = true,

  hlsearch = true,
  incsearch = true,

  termguicolors = true,

  scrolloff = 8,
  signcolumn = "yes",

  colorcolumn = "120",

  updatetime = 50,

  shell = "zsh",

  list = true,
  listchars = { tab = " ", trail = "·", space = "·"},
}


for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.g.netrw_banner = 0

