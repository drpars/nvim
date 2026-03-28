-- =============================================================================
-- 1. ADIM: Gelişmiş Akıllı Seçim Mantığı (SmartSelection)
-- =============================================================================
local SmartSelection = {}

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
			return table.remove(nodes) -- Çıkarılan node'u döndür.
		end
		return nil
	end,
	last = function(self, buf)
		local nodes = self:get(buf)
		return nodes[#nodes]
	end,
}

SmartSelection.get_node_range = function(node)
	local srow, scol, erow, ecol = node:range()
	if ecol == 0 then
		erow = erow - 1
		local lines = vim.api.nvim_buf_get_lines(0, erow, erow + 1, false)
		local line = lines[1] or ""
		ecol = math.max(#line, 1)
	end
	return { srow, scol, erow, ecol - 1 }
end

SmartSelection.select = function(node)
	local r = SmartSelection.get_node_range(node)
	if vim.api.nvim_get_mode().mode ~= "v" then
		vim.cmd.normal({ "v", bang = true })
	end
	vim.api.nvim_win_set_cursor(0, { r[1] + 1, r[2] })
	vim.cmd.normal({ "o", bang = true })
	vim.api.nvim_win_set_cursor(0, { r[3] + 1, r[4] })
end

SmartSelection.init = function()
	local buf = vim.api.nvim_get_current_buf()
	local node = vim.treesitter.get_node({ bufnr = buf, ignore_injections = false })
	if node then
		SmartSelection.stack:push(buf, node)
		SmartSelection.select(node)
	end
end

-- VİTES 1: Adım Adım Büyütme (Node)
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

-- VİTES 2: Keskin Kapsam Zıplatma (Scope)
SmartSelection.scope_incremental = function()
	local buf = vim.api.nvim_get_current_buf()
	local last = SmartSelection.stack:last(buf)
	if not last then
		SmartSelection.init()
		last = SmartSelection.stack:last(buf)
	end
	if last and last:parent() then
		local parent = last:parent()
		local srow, _, erow, _ = last:range()
		-- Alan genişleyene kadar ağaçta yukarı çık (Scope jumping)
		while parent:parent() do
			local psrow, _, perow, _ = parent:range()
			if psrow ~= srow or perow ~= erow then
				break
			end
			parent = parent:parent()
		end
		SmartSelection.stack:push(buf, parent)
		SmartSelection.select(parent)
	end
end

SmartSelection.decremental = function()
	local buf = vim.api.nvim_get_current_buf()
	local node = SmartSelection.stack:pop(buf)
	if node then
		SmartSelection.select(node)
	end
end

-- =============================================================================
-- 2. ADIM: Standart Treesitter Kurulumu (Tüm Parserlar Dahil)
-- =============================================================================
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

-- Kurulum dizinini düzgün ayarla
local parser_install_dir = vim.fs.normalize(vim.fn.stdpath("data") .. "/site")
vim.opt.runtimepath:append(parser_install_dir)

require("nvim-treesitter.config").setup({
	install_dir = parser_install_dir,
	highlight = { enable = true, additional_vim_regex_highlighting = false },
	indent = { enable = true },
	context_commentstring = { enable = true },
	incremental_selection = { enable = false },
})

-- =============================================================================
-- 3. ADIM: Keymap'ler (C-space ve Alt-space)
-- =============================================================================
vim.keymap.set("n", "<C-space>", SmartSelection.init, { silent = true, desc = "TS Init" })
vim.keymap.set("x", "<C-space>", SmartSelection.incremental, { silent = true, desc = "TS Incremental" })
-- Meta (Alt) + Space: Scope Incremental
vim.keymap.set("x", "<M-space>", SmartSelection.scope_incremental, { silent = true, desc = "TS Scope Jump" })
vim.keymap.set("x", "<bs>", SmartSelection.decremental, { silent = true, desc = "TS Decremental" })

-- =============================================================================
-- 4. ADIM: Otomatik Kurulum (Sync: False yaptık ki açılışta donmasın)
-- =============================================================================
vim.api.nvim_create_autocmd("VimEnter", {
	group = vim.api.nvim_create_augroup("TreesitterFinalInstall", { clear = true }),
	once = true,
	callback = function()
		-- Yeni API'ye göre install fonksiyonu 'nvim-treesitter' modülünde.
		require("nvim-treesitter").install(my_parsers, { with_sync = false })
	end,
})
