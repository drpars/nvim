return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {},
		config = function()
			require("lualine").setup({
				options = {
					icons_enabled = true,
					theme = "tokyonight",
					section_separators = { left = "", right = "" },
					-- component_separators = { left = "", right = "" },
          -- globalstatus = true,
				},
			})
		end,
	},
}
