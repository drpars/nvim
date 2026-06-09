-- =============================================================================
-- Keymap Cheatsheet
-- Canlı keymap tablosunu okuyup (global + mevcut buffer), `desc`'i olan tüm
-- kısayolları mod mod gruplayarak şık bir floating pencerede gösterir.
-- Hem core/keymaps.lua hem de plugin dosyalarındaki maplar otomatik görünür.
-- Açmak için: :Cheatsheet  /  <leader>k  /  <F1>  /  Dashboard'da "k".
-- =============================================================================
local M = {}

-- Sorgulanacak modlar -> okunabilir grup adı (x/v/s tek "Visual" altında birleşir)
local MODES = { "n", "i", "v", "x", "s", "o", "t", "c" }
local BUCKET = {
	n = "NORMAL",
	i = "INSERT",
	v = "VISUAL",
	x = "VISUAL",
	s = "VISUAL",
	o = "OPERATOR",
	t = "TERMINAL",
	c = "COMMAND",
}
-- Pencere içindeki grup sırası
local ORDER = { "NORMAL", "INSERT", "VISUAL", "OPERATOR", "TERMINAL", "COMMAND" }

-- lhs'i okunabilir hale getir: leader (boşluk) -> <leader>
local function pretty_lhs(lhs)
	local leader = vim.g.mapleader
	if leader and leader ~= "" and lhs:sub(1, #leader) == leader then
		lhs = "<leader>" .. lhs:sub(#leader + 1)
	end
	return lhs
end

-- Tüm desc'li keymapleri topla -> { BUCKET = { {lhs=, desc=}, ... } }
local function collect()
	local groups = {}
	local seen = {} -- bucket .. "\0" .. lhs  (aynı map'i iki modda tekrar etme)
	local buf = vim.api.nvim_get_current_buf()

	for _, mode in ipairs(MODES) do
		local bucket = BUCKET[mode]
		local maps = vim.api.nvim_get_keymap(mode)
		vim.list_extend(maps, vim.api.nvim_buf_get_keymap(buf, mode))
		for _, m in ipairs(maps) do
			-- Neovim'in varsayılan maplerini ele (desc'leri ":help ...-default")
			if m.desc and m.desc ~= "" and not m.desc:match("^:help ") then
				local lhs = pretty_lhs(m.lhsraw and vim.fn.keytrans(m.lhsraw) or m.lhs)
				local key = bucket .. "\0" .. lhs
				-- <Plug> maplerini ele (doğrudan basılmayan dahili eşleşmeler)
				if not seen[key] and not lhs:match("^<Plug>") then
					seen[key] = true
					groups[bucket] = groups[bucket] or {}
					table.insert(groups[bucket], { lhs = lhs, desc = m.desc })
				end
			end
		end
	end

	for _, list in pairs(groups) do
		table.sort(list, function(a, b)
			return a.lhs:lower() < b.lhs:lower()
		end)
	end
	return groups
end

-- Satırları ve highlight bilgilerini üret
local function build_lines(groups)
	-- En geniş lhs'e göre hizalama
	local keyw = 8
	for _, list in pairs(groups) do
		for _, item in ipairs(list) do
			keyw = math.max(keyw, #item.lhs)
		end
	end
	keyw = math.min(keyw, 22)

	local lines, hls = {}, {}
	local function add(text, hl)
		table.insert(lines, text)
		if hl then
			table.insert(hls, { line = #lines - 1, col = 0, end_col = -1, hl = hl })
		end
	end

	add("")
	add("  ⌨  KEYMAP CHEATSHEET", "Title")
	add("")

	for _, name in ipairs(ORDER) do
		local list = groups[name]
		if list and #list > 0 then
			add("  ── " .. name .. " " .. string.rep("─", 40 - #name), "Constant")
			for _, item in ipairs(list) do
				local pad = string.rep(" ", keyw - #item.lhs)
				local line = "    " .. item.lhs .. pad .. "   " .. item.desc
				table.insert(lines, line)
				-- lhs'i vurgula
				table.insert(hls, {
					line = #lines - 1,
					col = 4,
					end_col = 4 + #item.lhs,
					hl = "Function",
				})
			end
			add("")
		end
	end

	add("  " .. string.rep("─", 44), "Comment")
	add("  q / <Esc> kapat   ·   j/k veya <C-d>/<C-u> kaydır", "Comment")
	add("")
	return lines, hls
end

function M.open()
	local groups = collect()
	local lines, hls = build_lines(groups)

	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

	local ns = vim.api.nvim_create_namespace("drpars_cheatsheet")
	for _, h in ipairs(hls) do
		local end_col = h.end_col == -1 and #lines[h.line + 1] or h.end_col
		vim.api.nvim_buf_set_extmark(buf, ns, h.line, h.col, {
			end_col = end_col,
			hl_group = h.hl,
		})
	end

	vim.bo[buf].modifiable = false
	vim.bo[buf].buftype = "nofile"
	vim.bo[buf].bufhidden = "wipe"
	vim.bo[buf].filetype = "cheatsheet"

	-- Pencere boyutu / konumu (ekranın ortasında)
	local width = 0
	for _, l in ipairs(lines) do
		width = math.max(width, vim.fn.strdisplaywidth(l))
	end
	width = math.min(math.max(width + 2, 48), math.floor(vim.o.columns * 0.9))
	local height = math.min(#lines, math.floor(vim.o.lines * 0.8))

	local win = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = width,
		height = height,
		row = math.floor((vim.o.lines - height) / 2 - 1),
		col = math.floor((vim.o.columns - width) / 2),
		style = "minimal",
		border = "rounded",
		title = " Cheatsheet ",
		title_pos = "center",
	})
	vim.wo[win].cursorline = true
	vim.wo[win].wrap = false

	local function close()
		if vim.api.nvim_win_is_valid(win) then
			vim.api.nvim_win_close(win, true)
		end
	end
	for _, key in ipairs({ "q", "<Esc>" }) do
		vim.keymap.set("n", key, close, { buffer = buf, nowait = true, silent = true })
	end
end

-- :Cheatsheet komutu
vim.api.nvim_create_user_command("Cheatsheet", M.open, { desc = "Tüm keymapleri gösteren cheatsheet" })

return M
