local keymap = vim.keymap -- for conciseness

-- 1. Yüzer Pencere (Hover/Signature) Global Ayarları (Modern Yöntem)
-- Bu kısım handlers yerine geçer ve uyarı vermez.
local _border = "rounded"

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		local opts = { buffer = ev.buf, silent = true }

		-- [ KEYMAPS ] -----------------------------------------------------------

		opts.desc = "Show LSP references"
		keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

		opts.desc = "Go to declaration"
		keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

		opts.desc = "Show LSP definition"
		keymap.set("n", "gd", vim.lsp.buf.definition, opts)

		opts.desc = "Show LSP implementations"
		keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

		opts.desc = "Show LSP type definitions"
		keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

		opts.desc = "See available code actions"
		keymap.set({ "n", "v" }, "<F4>", vim.lsp.buf.code_action, opts)

		opts.desc = "Format buffer"
		keymap.set({ "n", "x" }, "<F3>", function()
			vim.lsp.buf.format({ async = true })
		end, opts)

		opts.desc = "Smart rename"
		keymap.set("n", "<F2>", vim.lsp.buf.rename, opts)

		opts.desc = "Show buffer diagnostics"
		keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

		opts.desc = "Show line diagnostics"
		keymap.set("n", "<leader>d", function()
			vim.diagnostic.open_float({ border = _border })
		end, opts)

		opts.desc = "Go to previous diagnostic"
		keymap.set("n", "ğd", function()
			vim.diagnostic.jump({ count = -1, float = { border = _border } })
		end, opts)

		opts.desc = "Go to next diagnostic"
		keymap.set("n", "üd", function()
			vim.diagnostic.jump({ count = 1, float = { border = _border } })
		end, opts)

		-- Hover (Dökümantasyon)
		opts.desc = "Show documentation"
		keymap.set("n", "K", function()
			vim.lsp.buf.hover({
				border = _border,
				max_height = 25,
				max_width = 120,
			})
		end, opts)

		opts.desc = "Restart LSP"
		keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
	end,
})

-- 2. Diagnostic (Teşhis) Ayarları -------------------------------------------
local severity = vim.diagnostic.severity

vim.diagnostic.config({
	virtual_text = true,
	signs = {
		text = {
			[severity.ERROR] = " ",
			[severity.WARN] = " ",
			[severity.HINT] = "󰠠 ",
			[severity.INFO] = " ",
		},
	},
	-- Pencere açıldığında (float) kullanılacak ayarlar:
	float = {
		border = _border,
		source = true, -- Hangi dil sunucusundan geldiğini gösterir
		header = "", -- Başlığı boş bırakır (daha temiz görünür)
		prefix = "",
	},
	update_in_insert = false,
	underline = true,
	severity_sort = true,
})
