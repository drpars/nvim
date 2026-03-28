return {
	{
		"akinsho/bufferline.nvim",
		lazy = false,
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			local bufferline = require("bufferline")
			bufferline.setup({
				options = {
					mode = "buffers",
					style_preset = bufferline.style_preset.default,
					themable = true,

					-- Birinci değer odaklı, ikinci değer odaksız buffer ayıracıdır.
					separator_style = { "", "" },

					show_buffer_close_icons = false,
					show_close_icon = false,
					sort_by = "insert_at_end",

					indicator = {
						style = "none",
					},

					always_show_bufferline = true,
					show_tab_indicators = false,

					-- Float Neo-tree kullandığın için temiz bir başlangıç
					offsets = {},

					-- İsimlerin birbirine çok yapışmaması için küçük bir padding (isteğe bağlı)
					-- tab_size = 18,
				},
				highlights = {
					-- Arka planı colorscheme şeffaflığına uyduruyoruz
					fill = { bg = "none" },
					background = { bg = "none" },
					buffer_selected = { bg = "none", bold = true },
					-- Ayraçları görsel olarak da tamamen siliyoruz
					separator = { fg = "none", bg = "none" },
					separator_visible = { fg = "none", bg = "none" },
					separator_selected = { fg = "none", bg = "none" },
				},
			})

			-- Bu ayar olmazsa olmazımız
			vim.opt.showtabline = 2
		end,
	},
}
