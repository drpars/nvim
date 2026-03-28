return {
	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		keys = {
			{
				-- Customize or remove this keymap to your liking
				"<leader>f",
				function()
					require("conform").format({
						lsp_fallback = true,
						async = false,
						timeout_ms = 1000,
					})
				end,
				mode = "",
				desc = "Format file or range (in visual mode)",
			},
		},
		opts = {
			formatters = {
				codespell = {
					args = {
						"--ignore-words-list",
						"Sistem,Kullanıcı,Dosya", -- Türkçe kelimelerinizi buraya ekleyin
						"$FILENAME",
					},
				},
			},
			formatters_by_ft = {
				lua = { "stylua" },
				sh = { "shfmt" },
				bash = { "shfmt" },
				zsh = { "shfmt" },
				zshrc = { "shfmt" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				svelte = { "prettier" },
				css = { "prettier" },
				html = { "prettier" },
				json = { "prettier" },
				yaml = { "prettier" },
				markdown = { "prettier" },
				graphql = { "prettier" },
				liquid = { "prettier" },
				python = { "isort", "black" },
				go = { "goimports", "gofmt" },
				rust = { "rustfmt" },
				["*"] = { "codespell" },
				["_"] = { "trim_whitespace" },
			},
			default_format_opts = {
				lsp_format = "fallback",
			},
		},
	},
	-- notify_on_error = true,
	-- notify_no_formatters = true,
}
