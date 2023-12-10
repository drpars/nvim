local options = {
  number = true,
  relativenumber = true,
  numberwidth = 4,
  ignorecase = true,
  smartcase = true,

  autoindent = true,
  smartindent = true,
  tabstop = 2,
  shiftwidth = 2,
  expandtab = true,
  showtabline = 0,
  showmatch = true,

  splitbelow = true,
  splitright = true,

  termguicolors = true,
  hidden = true,
  cursorline = true,
  fileencoding = "utf-8",

  backup = false,
  writebackup = false,
  swapfile = false,

  updatetime = 20,
  scrolloff = 15,
  mouse = "a",

  clipboard = "unnamedplus",
}

vim.g.mapleader = ' '
vim.g.maplocalleader = " "

for option, value in pairs(options) do
  vim.opt[option] = value
end
