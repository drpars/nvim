return {
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			{ "hrsh7th/cmp-nvim-lsp-signature-help" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "hrsh7th/cmp-cmdline" },
			{
				"L3MON4D3/LuaSnip",
				-- follow latest release.
				version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
				-- install jsregexp (optional!).
				build = "make install_jsregexp",
				dependencies = { "rafamadriz/friendly-snippets" },
			},
			{ "onsails/lspkind.nvim" }, -- vscode-like pictograms
			{ "ray-x/cmp-treesitter" },
			{ "chrisgrieser/cmp-nerdfont" },
			{ "kdheepak/cmp-latex-symbols" },
		},
		config = function()
			local cmp = require("cmp")
			local check_backspace = function()
				local col = vim.fn.col(".") - 1
				return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
			end

			require("luasnip.loaders.from_vscode").lazy_load({
				-- exclude = { "javascript" },
			})

			-- `/` cmdline setup.
			cmp.setup.cmdline("/", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})

			-- `:` cmdline setup.
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{
						name = "cmdline",
						option = {
							ignore_cmds = { "Man", "!" },
						},
					},
				}),
			})

			cmp.setup({
				sources = {
					{ name = "nvim_lsp" },
					{ name = "nvim_lsp_signature_help" },
					{ name = "buffer" },
					{ name = "path" },
					{ name = "luasnip" },
					{ name = "treesitter" },
					{ name = "nerdfont" },
					{
						name = "latex_symbols",
						option = {
							strategy = 0, -- mixed
						},
					},
				},
				mapping = cmp.mapping.preset.insert({
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-u>"] = cmp.mapping.scroll_docs(-4),
					["<C-d>"] = cmp.mapping.scroll_docs(4),
					["<Tab>"] = cmp.mapping(function(fallback)
						local luasnip = require("luasnip")

						if cmp.visible() then
							-- 1. Menü açıksa: Sonraki adaya geç
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							-- 2. Menü kapalıysa ve aktif bir snippet'te ilerlenecek yer varsa: Snippet'te ilerle
							luasnip.expand_or_jump()
						elseif check_backspace() then
							-- 3. Menü kapalıysa ve backspace kontrolü doğruysa: Normal Tab işlevi (girinti)
							fallback()
						else
							-- 4. Aksi takdirde, cmp'yi normal bir şekilde tetikle
							cmp.complete()
						end
					end, { "i", "s" }), -- i: insert mode, s: select mode
					-- <S-Tab> (Shift+Tab) için basit bir atama (Geri Gitme)
					["<S-Tab>"] = cmp.mapping(function(fallback)
						local luasnip = require("luasnip")

						if cmp.visible() then
							-- Menü açıksa: Önceki adaya geç
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							-- Menü kapalıysa ve snippet'te geri gidilebiliyorsa: Snippet'te geri git
							luasnip.jump(-1)
						else
							-- Aksi takdirde normal geri gitme (genellikle çalışmaz veya beklenmez)
							fallback()
						end
					end, { "i", "s" }),
				}),
				snippet = {
					expand = function(args)
						-- vim.snippet.expand(args.body)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				-- formatting = {
				-- 	format = require("lspkind").cmp_format({
				-- 		maxwidth = 50,
				-- 		ellipsis_char = "...",
				-- 	}),
				-- },
				formatting = {
					fields = { "kind", "abbr", "menu" },
					format = function(entry, vim_item)
						local kind = require("lspkind").cmp_format({ mode = "symbol_text" })(entry, vim_item)
						local strings = vim.split(kind.kind, "%s", { trimempty = true })
						kind.kind = " " .. (strings[1] or "") .. " "
						kind.menu = "    (" .. (strings[2] or "") .. ")"
						return kind
					end,
				},
			})
		end,
	},
}
