local map = vim.keymap.set

local function nmap(l, r, desc)
  map("n", l, r, { desc = desc })
end

local function imap(l, r, desc)
  map("i", l, r, { desc = desc })
end

local function vmap(l, r, desc)
  map("v", l, r, { desc = desc })
end

local function cmap(l, r, desc)
  map("c", l, r, { desc = desc })
end

-- Global ones
vim.g.mapleader = " "
nmap("<leader>pv", vim.cmd.Ex)
imap("kj", "<esc>")
vmap("kj", "<esc>")
cmap("kj", "<C-C>")
nmap("<leader>w", ":write<CR>", "Write")
nmap("<leader>qq", ":quitall<CR>", "Quit")
vmap("J", ":m '>+1<CR>gv=gv")
vmap("K", ":m '<-2<CR>gv=gv")
nmap("n", "nzzzv")
nmap("N", "Nzzzv")
nmap("<A-j>", "<C-d>zz")
nmap("<A-k>", "<C-u>zz")

-- Copy to clipboard
vmap("<leader>y", "\"+y")
nmap("<leader>Y", "\"+g_")
nmap("<leader>y", "\"+y")
nmap("<leader>yy", "\"+yy")

-- Paste from clipboard
nmap("<leader>p", "\"+p")
nmap("<leader>P", "\"+P")
vmap("<leader>p", "\"+p")
vmap("<leader>P", "\"+P")

-- Telescope
local telescope = require("telescope.builtin")

nmap("<leader>ff", telescope.find_files, "Find files")
nmap("<leader>fs", telescope.git_files, "Find files")
nmap("<leader>fr", telescope.oldfiles, "Find recently opened files")
nmap("<leader>fg", telescope.live_grep, "Grep")
nmap("<leader>fb", telescope.buffers, "Find buffers")

-- Harpoon
local harpoon = require("harpoon")

nmap("<leader>a", function() harpoon:list():append() end)
nmap("<leader>h", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

nmap("<leader>j", function() harpoon:list():select(1) end)
nmap("<leader>k", function() harpoon:list():select(2) end)
nmap("<leader>l", function() harpoon:list():select(3) end)
nmap("<leader>;", function() harpoon:list():select(4) end)

nmap("<leader>u", function() harpoon:list():prev() end)
nmap("<leader>i", function() harpoon:list():next() end)

-- LSP
nmap("<leader>td", ":ToggleDiag<CR>")
