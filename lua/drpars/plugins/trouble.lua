return {
	{
		"folke/trouble.nvim",
    dependencies = { "folke/todo-comments.nvim" },
		opts = {
      focus = true,
    }, -- for default options, refer to the configuration section for custom setup.
		cmd = "Trouble",
		keys = {
			{ "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
			{ "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
      { "<leader>xq", "<cmd>Trouble quickfix toggle<CR>", desc = "Open trouble quickfix list" },
			{ "<leader>xl", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
      { "<leader>xt", "<cmd>Trouble todo toggle<CR>", desc = "Open todos in trouble" },
		},
	},
}
