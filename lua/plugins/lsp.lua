return {
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v4.x",
		lazy = true,
		config = false,
	},
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = true,
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

	-- Autocompletion
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			{
				"L3MON4D3/LuaSnip",
				version = "v2.*",
				build = "make install_jsregexp",
				init = function()
					local ls = require("luasnip")
					ls.setup({
						-- Required to automatically include base snippets, like "c" snippets for "cpp"
						load_ft_func = require("luasnip_snippets.common.snip_utils").load_ft_func,
						ft_func = require("luasnip_snippets.common.snip_utils").ft_func,
						-- To enable auto expansin
						enable_autosnippets = true,
						-- Uncomment to enable visual snippets triggered using <c-x>
						-- store_selection_keys = '<c-x>',
					})
				end,
			},
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-nvim-lsp-signature-help" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "hrsh7th/cmp-emoji" },
			{ "chrisgrieser/cmp-nerdfont" },
			{ "rafamadriz/friendly-snippets" },
			{ "saadparwaiz1/cmp_luasnip" },
			{
				"mireq/luasnip-snippets",
				dependencies = { "L3MON4D3/LuaSnip" },
				init = function()
					-- Mandatory setup function
					require("luasnip_snippets.common.snip_utils").setup()
				end,
			},
			{ "kdheepak/cmp-latex-symbols" },
			{ "f3fora/cmp-spell" },
			-- { "octaltree/cmp-look" },
			{ "ray-x/cmp-treesitter" },
			{ "onsails/lspkind.nvim" },
		},
		config = function()
			local cmp = require("cmp")
			-- local cmp_format = require("lsp-zero").cmp_format({ details = true })
			-- local lspkind = require("lspkind")
			local cmp_action = require("lsp-zero").cmp_action()

			cmp.setup({
				sources = {
					{ name = "nvim_lsp" },
					{ name = "nvim_lsp_signature_help" },
					{ name = "buffer" },
					{ name = "path" },
					{ name = "emoji" },
					{ name = "nerdfont" },
					{ name = "luasnip" },
					{ name = "latex_symbols" },
					{
						name = "spell",
						option = {
							keep_all_entries = false,
							preselect_correct_word = true,
						},
					},
					-- { name = "look" },
					{ name = "treesitter" },
				},
				mapping = cmp.mapping.preset.insert({
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-u>"] = cmp.mapping.scroll_docs(-4),
					["<C-d>"] = cmp.mapping.scroll_docs(4),
					["<Tab>"] = cmp_action.tab_complete(),
					["<S-Tab>"] = cmp.mapping.select_prev_item({ behavior = "select" }),
				}),
				snippet = {
					expand = function(args)
						vim.snippet.expand(args.body)
					end,
				},
				window = {
					documentation = cmp.config.window.bordered(),
					completion = cmp.config.window.bordered(),
				},
				formatting = {
					fields = { "kind", "abbr", "menu" },
					format = function(entry, vim_item)
						local kind = require("lspkind").cmp_format({ mode = "symbol_text" })(entry, vim_item)
						local strings = vim.split(kind.kind, "%s", { trimempty = true })
						kind.kind = " " .. (strings[1] or "") .. " "
						kind.menu = "    (" .. (strings[2] or "") .. ")"

						return kind
					end,
					-- formatting = cmp_format,
					-- formatting = {
					--   format = lspkind.cmp_format({
					--     mode = "symbol",        -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
					--     show_labelDetails = true, -- show labelDetails in menu. Disabled by default
					--     menu = {
					--       nvim_lsp = "(LSP)",
					--       buffer = "(Buffer)",
					--       path = "(Path)",
					--       emoji = "(Emoji)",
					--       cmdline = "(CMD)",
					--       luasnip = "(Snippets)",
					--       latex_symbols = "(Latex)",
					--       spell = "(Spell)",
					--       treesitter = "(TS)",
					--
					--       tags = '[tag]',
					--       calc = '[calc]',
					--     }
					--   })
					-- }
				},
			})
			-- friendly snippets
			require("luasnip.loaders.from_vscode").lazy_load()
		end,
	},

	-- LSP
	{
		"neovim/nvim-lspconfig",
		cmd = { "LspInfo", "LspInstall", "LspStart" },
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },
			{
				"WhoIsSethDaniel/mason-tool-installer.nvim",
				init = function()
					require("mason-tool-installer").setup({
						ensure_installed = {
							"stylua",
							"shfmt",
							"beautysh",
							"hyprls",
							"clang-format",
							"prettier",
							"black",
							"debugpy",
							"flake8",
							"isort",
							"mypy",
							"pylint",
							"ruff-lsp",
						},
						auto_update = true,
					})
				end,
			},
		},
		config = function()
			local lsp_zero = require("lsp-zero")

			-- lsp_attach is where you enable features that only work
			-- if there is a language server active in the file
			---@diagnostic disable-next-line: unused-local
			local lsp_attach = function(client, bufnr)
				local opts = { buffer = bufnr }

				vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
				vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
				vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
				vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
				vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
				vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
				vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
				vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
				vim.keymap.set({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
				vim.keymap.set("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
			end

			lsp_zero.extend_lspconfig({
				sign_text = true,
				lsp_attach = lsp_attach,
				capabilities = require("cmp_nvim_lsp").default_capabilities(),
			})

			lsp_zero.ui({
				float_border = "rounded",
				sign_text = {
					error = "✘",
					warn = "▲",
					hint = "⚑",
					info = "»",
				},
			})

			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"bashls",
					"clangd",
					"pyright",
					"ruff",
				},
				handlers = {
					-- this first function is the "default handler"
					-- it applies to every language server without a "custom handler"
					function(server_name)
						require("lspconfig")[server_name].setup({})
					end,
				},
			})
		end,
	},
	-- formatter
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				-- Customize or remove this keymap to your liking
				"<leader>f",
				function()
					require("conform").format({ async = true, lsp_fallback = true })
				end,
				mode = "",
				desc = "Format buffer",
			},
		},
		-- Define your formatters
		-- :help conform-formatters
		init = function()
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
					sh = { "shfmt" },
					zsh = { "beautysh" },
					zshrc = { "beautysh" },
					json = { "prettier" },
					css = { "prettier" },
					python = { "isort", "black" },
				},
				default_format_opts = {
					lsp_format = "fallback",
				},
				-- format_on_save = {
				--   -- I recommend these options. See :help conform.format for details.
				--   lsp_format = "fallback",
				--   timeout_ms = 500,
				-- },
				formatters = {
					shfmt = {
						prepend_args = { "-i", "2" },
					},
					black = {
						prepend_args = { "--fast" },
					},
				},
			})
		end,
	},
}
