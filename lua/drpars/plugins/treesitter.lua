-- Treesitter 0.12'de gömülü, nvim-treesitter plugin'i arşivlendi.
-- SmartSelection lua/drpars/treesitter.lua'da tanımlı.
return {
	{
		"windwp/nvim-ts-autotag",
		ft = { "html", "javascript", "typescript", "tsx", "jsx" },
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		event = "BufReadPost",
		config = function()
			require("treesitter-context").setup({
				enable = false,
				max_lines = 0,
				min_rows = 10,
				zindex = 20,
				mode = "cursor",
			})
		end,
	},
}
