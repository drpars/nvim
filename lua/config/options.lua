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

	signcolumn = "yes",
	updatetime = 20,
	scrolloff = 15,
	mouse = "a",

	clipboard = "unnamedplus",

	spell = false,
	spelllang = { "en_us" },
}

for option, value in pairs(options) do
	vim.opt[option] = value
end

vim.g.mapleader = " "
vim.g.maplocalleader = " "

local winyank = function()
  if vim.fn.has('wsl') == 1 then
    local filename = "~/.local/bin/win32yank.exe"
    local home = os.getenv("HOME") or ""  -- Fallback to an empty string if HOME is not set
    local path_separator = package.config:sub(1, 1)  -- Get the correct path separator
    local fullPath = filename:gsub("~", home):gsub("/", path_separator)

    local file, _ = io.open(fullPath, "r")  -- Silence unused err warning
    if file then
      vim.g.clipboard = {
        name = "win32yank-wsl",
        copy = {
          ["+"] = "win32yank.exe -i --crlf",
          ["*"] = "win32yank.exe -i --crlf",
        },
        paste = {
          ["+"] = "win32yank.exe -o --lf",
          ["*"] = "win32yank.exe -o --lf",
        },
        cache_enabled = false,
      }
      file:close()
    else
      vim.notify("win32yank.exe not found at: " .. fullPath, vim.log.levels.WARN)
    end
  end
end

if vim.fn.has("wsl") == 1 then
	winyank()
end
