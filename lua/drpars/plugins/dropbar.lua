return {
	{
		"Bekaboo/dropbar.nvim",
		lazy = false,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		config = function()
			local dropbar = require("dropbar")
			local sources = require("dropbar.sources")
			local utils = require("dropbar.utils")

			vim.api.nvim_set_hl(0, "WinBar", { bg = "NONE" })
			vim.api.nvim_set_hl(0, "WinBarNC", { bg = "NONE" })
			vim.api.nvim_set_hl(0, "DropBarIconKindFile", { fg = "#7aa2f7", bg = "NONE" })
			vim.api.nvim_set_hl(0, "DropBarIconKindFolder", { fg = "#7aa2f7", bg = "NONE" })

			dropbar.setup({
				bar = {
					sources = function(_, _)
						return {
							sources.markdown,
							utils.source.fallback({
								sources.lsp,
								sources.treesitter,
							}), -- Fonksiyon/Metot bilgilerini getirir
						}
					end,
					padding = { left = 1, right = 1 },
					update_debounce = 32,
				},
				icons = {
					ui = {
						bar = {
							separator = "  ", -- eklenti varsayılan ayıracı
						},
					},
				},
				menu = {
					win_configs = {
						border = "rounded",
					},
				},
			})
      vim.keymap.set('n', '<Leader>;', require('dropbar.api').pick, { desc = 'Pick symbols in winbar' })
		end,
	},
}
