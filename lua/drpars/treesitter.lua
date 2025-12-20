-- 1. ADIM: Eklentisiz Akıllı Seçim Mantığı (selection.lua, range.lua, nodes.lua özeti)
local SmartSelection = {}

-- Nodes Stack yönetimi (nodes.lua'dan)
SmartSelection.stack = {
	entries = {},
	get = function(self, buf)
		local tick = vim.api.nvim_buf_get_changedtick(buf)
		if not self.entries[buf] or self.entries[buf].tick ~= tick then
			self.entries[buf] = { tick = tick, nodes = {} }
		end
		return self.entries[buf].nodes
	end,
	push = function(self, buf, node)
		table.insert(self:get(buf), node)
	end,
	pop = function(self, buf)
		local nodes = self:get(buf)
		if #nodes > 0 then
			table.remove(nodes)
		end
		return nodes[#nodes]
	end,
	last = function(self, buf)
		local nodes = self:get(buf)
		return nodes[#nodes]
	end,
}

-- Görsel aralık yönetimi (range.lua'dan)
SmartSelection.get_node_range = function(node)
	local srow, scol, erow, ecol = node:range()
	if ecol == 0 then
		erow = erow - 1
		local line = vim.api.nvim_buf_get_lines(0, erow, erow + 1, false)[1]
		ecol = math.max(#line, 1)
	end
	return { srow, scol, erow, ecol - 1 }
end

-- Seçim işlemi (selection.lua'dan)
SmartSelection.select = function(node)
	local r = SmartSelection.get_node_range(node)
	if vim.api.nvim_get_mode().mode ~= "v" then
		vim.cmd.normal({ "v", bang = true })
	end
	vim.api.nvim_win_set_cursor(0, { r[1] + 1, r[2] })
	vim.cmd.normal({ "o", bang = true })
	vim.api.nvim_win_set_cursor(0, { r[3] + 1, r[4] })
end

-- Tetikleyici Fonksiyonlar (incremental.lua'dan esinlenildi)
SmartSelection.init = function()
	local buf = vim.api.nvim_get_current_buf()
	local node = vim.treesitter.get_node({ bufnr = buf, ignore_injections = false })
	if node then
		SmartSelection.stack:push(buf, node)
		SmartSelection.select(node)
	end
end

SmartSelection.incremental = function()
	local buf = vim.api.nvim_get_current_buf()
	local last = SmartSelection.stack:last(buf)
	if last and last:parent() then
		local parent = last:parent()
		SmartSelection.stack:push(buf, parent)
		SmartSelection.select(parent)
	else
		SmartSelection.init()
	end
end

SmartSelection.decremental = function()
	local buf = vim.api.nvim_get_current_buf()
	local node = SmartSelection.stack:pop(buf)
	if node then
		SmartSelection.select(node)
	end
end

-- 2. ADIM: Standart Treesitter Kurulumu
local my_parsers = {
	"bash",
	"c",
	"cpp",
	"css",
	"diff",
	"html",
	"hyprlang",
	"javascript",
	"jsdoc",
	"json",
	"jsonc",
	"lua",
	"luadoc",
	"luap",
	"prisma",
	"markdown",
	"markdown_inline",
	"python",
	"query",
	"regex",
	"toml",
	"tsx",
	"dockerfile",
	"gitignore",
	"typescript",
	"vim",
	"vimdoc",
	"yaml",
	"rasi",
}

require("nvim-treesitter.config").setup({
	install_dir = vim.fn.stdpath("data") .. "/site/parser",
	highlight = { enable = true, additional_vim_regex_highlighting = false },
	indent = { enable = true },
	context_commentstring = { enable = true },
	-- Yerleşik incremental_selection'ı kapatıyoruz çünkü yukarıdaki SmartSelection'ı kullanacağız
	incremental_selection = { enable = false },
})

-- Derleyici ayarları (Windows'ta çalışan halini koruyoruz)
require("nvim-treesitter.install").prefer_git = false
require("nvim-treesitter.install").compilers = { "gcc", "clang", "zig" }

-- 3. ADIM: Keymap'leri Tanımlama (C-space ve Backspace)
vim.keymap.set("n", "<C-space>", SmartSelection.init, { silent = true, desc = "TS Smart Init" })
vim.keymap.set("x", "<C-space>", SmartSelection.incremental, { silent = true, desc = "TS Smart Incremental" })
vim.keymap.set("x", "<bs>", SmartSelection.decremental, { silent = true, desc = "TS Smart Decremental" })

-- 4. ADIM: Otomatik Kurulum (Windows kilitlenmesini önlemek için asenkron)
vim.api.nvim_create_autocmd("VimEnter", {
	group = vim.api.nvim_create_augroup("TreesitterFinalInstall", { clear = true }),
	once = true,
	callback = function()
		-- sync=false yaparak wait() donmasını engelliyoruz
		require("nvim-treesitter.install").install(my_parsers, { with_sync = false })
	end,
})
