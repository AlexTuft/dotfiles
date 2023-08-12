--------------------------------------------------------------------------------
--- Keymaps
--------------------------------------------------------------------------------

vim.g.mapleader = " "

vim.keymap.set("n", "<leader>e", vim.cmd.Ex, { desc = "Open file [e]xplorer" })


--------------------------------------------------------------------------------
--- Options
--------------------------------------------------------------------------------

-- Line numbers
vim.opt.relativenumber = true
vim.opt.number = true

-- Indenting
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.autoindent = true

-- Display whitespace
vim.opt.list = true
vim.opt.listchars = {
    trail = "•",
}

-- Disable highlight on search
vim.o.hlsearch = false

-- Sync clipboard between OS and Neovim
vim.o.clipboard = "unnamedplus"

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true
