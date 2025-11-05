return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "mocha", -- latte, frappe, macchiato, mocha
				transparent_background = true, -- disables setting the background color.
				integrations = {
					cmp = true,
					gitsigns = true,
					nvimtree = true,
					treesitter = true,
					notify = true,
					mini = {
						enabled = true,
						indentscope_color = "",
					},
					barbecue = {
						dim_dirname = true, -- directory name is dimmed by default
						bold_basename = true,
						dim_context = true,
						alt_background = false,
					},
					barbar = true,
					mason = true,
					telescope = {
						enabled = true,
						style = "nvchad",
					},
					fidget = true,
					bufferline = true,
          -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
				},
			})
			vim.cmd.colorscheme("catppuccin-mocha")
		end,
	},
}
