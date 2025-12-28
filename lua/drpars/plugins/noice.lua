return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = { "MunifTanjim/nui.nvim" },
	opts = {
		cmdline = { enabled = true, view = "cmdline_popup" },
		popupmenu = { enabled = true, backend = "nui" },
		messages = { enabled = true },
		notify = { enabled = true },
		lsp = {
			progress = { enabled = false },
			hover = { enabled = false },
			signature = { enabled = false },
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = false,
				["vim.lsp.util.set_highlight"] = false,
				["vim.lsp.util.open_floating_preview"] = false,
			},
		},
		views = {
			cmdline_popup = {
				position = { row = 5, col = "50%" },
				size = { width = 60, height = "auto" },
				border = {
					style = "rounded",
					padding = { 0, 0 }, -- Üst/Alt ve Sağ/Sol dolguyu tamamen sıfırladık
				},
				win_options = {
					winblend = 0,
					-- Çerçeve rengini resimdeki gibi turkuaz/mavi yapmak için DiagnosticInfo kullandık
					winhighlight = "Normal:NormalFloat,FloatBorder:DiagnosticInfo",
				},
			},
			popupmenu = {
				relative = "editor",
				position = { row = 8, col = "50%" },
				size = { width = 60, height = 10 },
				border = {
					style = "rounded",
					padding = { 0, 0 }, -- Öneri listesindeki boşluğu da sıfırladık
				},
				win_options = {
					winblend = 0,
					winhighlight = "Normal:NormalFloat,FloatBorder:DiagnosticInfo",
				},
			},
		},
	},
}
