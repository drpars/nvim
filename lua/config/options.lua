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

---@diagnostic disable-next-line: unused-function, unused-local
local winyank = function()
	local filename = "~/.local/bin/win32yank.exe"
	-- Expanding ~ to the full home directory path
	local home = os.getenv("HOME")
	---@diagnostic disable-next-line: param-type-mismatch
	local fullPath = filename:gsub("~", home)

	-- Try to open the file in read mode
	local file = io.open(fullPath, "r")

	-- Check if the file exists
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
		-- print("The file exists at: " .. fullPath)
		file:close() -- Close the file
		-- else
		-- print("The file does not exist at: " .. fullPath)
	end
end

-- For wsl copy/paste uncomment next line
-- winyank()
