return {
	{
		"Bekaboo/dropbar.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			local dropbar = require("dropbar")
			local sources = require("dropbar.sources")

			-- WinBar şeffaflığını garantiye alalım
			vim.api.nvim_set_hl(0, "WinBar", { bg = "NONE" })
			vim.api.nvim_set_hl(0, "WinBarNC", { bg = "NONE" })

			dropbar.setup({
				bar = {
					sources = function(_, _)
						local items = {
							-- 'path' kaynağını buraya eklemediğimiz için klasör yolu gözükmez
							sources.markdown, -- Dosya ikonunu ve ismini sağlar
							sources.lsp, -- Fonksiyon, Class vb. sembolleri sağlar
						}
						return items
					end,
				},
				-- Gereksiz boşlukları veya ikonları sadeleştirmek istersen:
				icons = {
					ui = {
						bar = {
							separator = "  ", -- Ayraç ikonu
							extends = "…",
						},
					},
				},
			})
		end,
	},
}
