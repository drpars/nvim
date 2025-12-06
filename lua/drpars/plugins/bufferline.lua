return {
	{
		"akinsho/bufferline.nvim",
		after = "catppuccin",
		-- version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			-- local mocha = require("catppuccin.palettes").get_palette("mocha")
			local bufferline = require("bufferline")
			bufferline.setup({
				options = {
					mode = "buffers",
					style_preset = require("bufferline").style_preset.default, -- bufferline.style_preset.minimal, bufferline.style_preset.default
					themable = true,
					separator_style = "thin", -- "slant" | "slope" | "thick" | "thin" | { 'any', 'any' },
					show_buffer_close_icons = false,
					sort_by = "insert_at_end",
					indicator = {
						icon = "|", -- this should be omitted if indicator style is not 'icon'
						style = "underline", -- 'icon' | 'underline' | 'none',
					},
					show_tab_indicators = false,
					offsets = {
						{
							filetype = "neo-tree",
							text = " File Explorer",
							highlight = "Directory",
							separator = true,
						},
					},
				},
				-- highlights = require("catppuccin.special.bufferline").get_theme({
				-- 	styles = { "italic", "bold" },
				-- 	custom = {
				-- 		all = {
				-- 			fill = { bg = "#1E1E2E" },
				-- 		},
				-- mocha = {
				-- 	background = { fg = mocha.text },
				-- },
				-- latte = {
				-- 	background = { fg = "#000000" },
				-- },
				-- },
				-- }),
			})
		end,
	},
}
