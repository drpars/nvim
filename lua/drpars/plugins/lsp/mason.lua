return {
	{
		"williamboman/mason-lspconfig.nvim",
		opts = {
			-- list of servers for mason to install
			ensure_installed = {
				"lua_ls",
				"bashls",
				"clangd",
				"pyright",
				"ruff",
				"ts_ls",
				"html",
				"cssls",
				"tailwindcss",
				"svelte",
				"graphql",
				"emmet_ls",
				"prismals",
				"eslint",
				"biome",
			},
		},
		dependencies = {
			{
				"mason-org/mason.nvim",
				opts = {
					ui = {
						border = "rounded",
						icons = {
							package_installed = "✓",
							package_pending = "➜",
							package_uninstalled = "✗",
						},
					},
				},
			},
			"neovim/nvim-lspconfig",
		},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		opts = {
			-- Buraya bir araç eklemek onu yalnız KURAR; çağıran bir şey yoksa
			-- sessizce durur. Ölçüldü (2026-08-28) ve çıkarılanlar:
			--   flake8, pylint, mypy -> hiçbir linter eklentisi yok; lint işini
			--     ruff (LSP), tip denetimini pyright yapıyor.
			--   clang-format         -> conform'da c/cpp girdisi yok; biçimlendirme
			--     lsp_format fallback ile clangd'ye gidiyor, o da kendi
			--     clang-format'ını taşıyor.
			--   eslint_d             -> conform onu çağırmıyor; eslint LSP kendi
			--     linter'ıyla geliyor.
			-- Geri kalanların hepsinin çağıran yeri var: formatter.lua (stylua,
			-- shfmt, prettier, black, isort, codespell), after/lsp/bashls.lua
			-- (shellcheck), dap.lua (debugpy), artı LSP olarak kurulu oldukları
			-- için etkinleşenler (hyprls, json-lsp, yaml-language-server).
			ensure_installed = {
				"stylua",
				"shfmt",
				"shellcheck",
				"hyprls",
				"json-lsp",
				"prettier",
				"black",
				"debugpy",
				"isort",
				"codespell",
				"yaml-language-server",
			},
		},
		dependencies = {
			"mason-org/mason.nvim",
		},
	},
}
