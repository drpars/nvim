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
				biome = {
					-- Yorumlu json: waybar dosyaları jsonc içeriği taşıyor ama adları
					-- .json, biome ise ayrıştırıcıyı nvim filetype'ından değil
					-- uzantıdan seçiyor. Bayrak olmadan modules.json'da exit 1.
					-- Girintiyi conform zaten buffer'dan geçiriyor (space/2), o yüzden
					-- burada yok; eklenen tek stil ayarı line-width.
					append_args = { "--json-parse-allow-comments=true", "--line-width=100" },
				},
				shfmt = {
					-- -i 2: 2 boşluk girinti (Arch/Hyprland scriptleri için idealdir)
					-- -ci: Switch/Case bloklarını içeri kaydırır
					-- -sr: Yönlendirme operatörlerinden (>) sonra boşluk bırakır
					prepend_args = { "-i", "2", "-ci", "-sr" },
				},
			},
			formatters_by_ft = {
				lua = { "stylua" },
				sh = { "shfmt" },
				bash = { "shfmt" },
				-- zsh yok: shfmt zsh bilmiyor (bash/posix/mksh/bats). Sözdizimini
				-- bozmuyor ama bindkey/setopt bloklarındaki elle yapılan sütun
				-- hizalamasını eziyor. ("zshrc" diye bir filetype da yok.)
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				svelte = { "prettier" },
				css = { "prettier" },
				html = { "prettier" },
				json = { "biome" },
				jsonc = { "biome" },
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
