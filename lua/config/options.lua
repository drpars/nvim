-- Map <leader> = the space key
vim.g.mapleader = ' '
vim.g.maplocalleader = " "

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.clipboard = "unnamedplus"

-- use global status line
vim.opt.laststatus = 3

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2

vim.opt.list = true
-- vim.opt.listchars:append "eol:↴"

-- use number of spaces to insert a <Tab>
vim.opt.expandtab = true

vim.opt.splitright = true
vim.opt.splitbelow = true

-- highlight the line number of the cursor
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"
vim.opt.mouse = "a"
vim.opt.cursorline = true
vim.opt.ruler = true

vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

vim.opt.termguicolors = true

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- vim.cmd(
-- Colorscheme
-- duskfox | rose-pine | nightfox | nordfox |
-- catppuccin-latte | catppuccin-frappe | catppuccin-macchiato | catppuccin-mocha
-- "colorscheme catppuccin-mocha"
-- )
