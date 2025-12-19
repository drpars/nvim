return {
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
		config = function()
			require("tokyonight").setup({
				style = "night",
				light_style = "night",
				transparent = true,
				styles = {
					-- Style to be applied to different syntax groups
					-- Value is any valid attr-list value for `:help nvim_set_hl`
					comments = { italic = true },
					keywords = { italic = true },
					functions = {},
					variables = {},
					-- Background styles. Can be "dark", "transparent" or "normal"
					sidebars = "transparent", -- style for sidebars, see below
					floats = "transparent", -- style for floating windows
				},
				plugins = {
					auto = true,
					-- add any plugins here that you want to enable
					-- for all possible plugins, see:
					--   * https://github.com/folke/tokyonight.nvim/tree/main/lua/tokyonight/groups
					-- telescope = true,
				},
			})
			vim.cmd("colorscheme tokyonight-night")
		end,
	},
}

