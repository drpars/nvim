return {
	{
		"numToStr/Comment.nvim",
		opts = {
			padding = true,
			ignore = "^$",
		},
		config = function()
			require("Comment").setup()
		end,
	},
}
