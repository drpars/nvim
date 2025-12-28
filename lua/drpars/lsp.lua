local keymap = vim.keymap
local _border = "rounded"

-- [ 1. MODERN UI OVERRIDE ] --------------------------------------------------

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview

---@diagnostic disable-next-line: duplicate-set-field
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
	---@class vim.lsp.util.open_floating_preview.Opts
	---@field winhighlight? string
	opts = opts or {}
	opts.border = opts.border or _border
	opts.winhighlight = opts.winhighlight or "Normal:NormalFloat,FloatBorder:DiagnosticInfo"
	opts.max_height = opts.max_height or 25
	opts.max_width = opts.max_width or 120

	return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- [ 2. LSP ATTACH ] -----------------------------------------------------------
-- Bu blok, bir LSP sunucusu dosyaya bağlandığında çalışır.
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

		opts.desc = "Show documentation"
		keymap.set("n", "K", vim.lsp.buf.hover, opts)

		opts.desc = "Show function signature"
		keymap.set("i", "<C-k>", function()
			vim.lsp.buf.signature_help()
		end, opts)

		opts.desc = "Restart LSP"
		keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
	end,
})

-- [ 3. DIAGNOSTIC CONFIG ] -----------------------------------------------------
-- Hata ve uyarıların (Diagnostics) genel görünümü
local severity = vim.diagnostic.severity

vim.diagnostic.config({
	virtual_text = {
		spacing = 4,
		prefix = "●",
	},
	signs = {
		text = {
			[severity.ERROR] = " ",
			[severity.WARN] = " ",
			[severity.HINT] = "󰠠 ",
			[severity.INFO] = " ",
		},
	},
	-- leader+d ile açılan pencere ayarları
	float = {
		border = _border,
		source = "if_many",
		header = "",
		prefix = "",
		winhighlight = "Normal:NormalFloat,FloatBorder:DiagnosticInfo",
	},
	update_in_insert = false,
	underline = true,
	severity_sort = true,
})
