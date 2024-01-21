vim.cmd("colorscheme catppuccin")

local options = {
  timeoutlen = 800, 
  number = true,
  relativenumber = true,
  
  tabstop = 4,
  softtabstop = 4,
  shiftwidth = 4,

  expandtab = true,
  showtabline = 2,

  smartindent = true,

  wrap = true,

  hlsearch = true,
  incsearch = true,

  termguicolors = true,

  scrolloff = 8,
  signcolumn = "yes",

  colorcolumn = "80",

  updatetime = 50,

  shell = "zsh",
}

for k, v in pairs(options) do
  vim.opt[k] = v
end
