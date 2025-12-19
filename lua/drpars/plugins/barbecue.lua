return {
	{
		"utilyre/barbecue.nvim",
		name = "barbecue",
		version = "*",
		dependencies = {
			"SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("barbecue").setup({
				show_dirname = false, -- Üst klasör ismini gizle
				show_basename = true, -- Dosya ismini göster
				theme = {
					-- 'normal' grubunun bg değerini 'NONE' yaparak arka planı şeffaf yapıyoruz
					normal = { bg = "NONE" },

					-- İstersen diğer kısımların da arka planını garantiye alabilirsin
					dirname = { bg = "NONE" },
					basename = { bg = "NONE", bold = true },
					context = { bg = "NONE" },
				},
			})
			-- WinBar arka planını zorla şeffaf yap
			vim.api.nvim_set_hl(0, "WinBar", { bg = "NONE" })
			vim.api.nvim_set_hl(0, "WinBarNC", { bg = "NONE" })
		end,
	},
}
