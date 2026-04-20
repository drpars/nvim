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
			ensure_installed = {
				"stylua",
				"shfmt",
				"shellcheck",
				"clang-format",
				"hyprls",
        "json-lsp",
				"prettier",
				"black",
				"debugpy",
				"flake8",
				"isort",
				"mypy",
				"pylint",
				"eslint_d",
				"codespell",
        "yaml-language-server"
			},
		},
		dependencies = {
			"mason-org/mason.nvim",
		},
	},
}
