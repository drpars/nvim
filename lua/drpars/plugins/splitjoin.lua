return {
	{
		"bennypowers/splitjoin.nvim",
		lazy = true,
		keys = {
			{ "gk", function() require("splitjoin").join() end, desc = "Join the object under cursor" },
			{ "gj", function() require("splitjoin").split() end, desc = "Split the object under cursor" },
		},
	},
}
