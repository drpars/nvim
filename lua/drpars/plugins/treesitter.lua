return {
	{
		-- nvim-treesitter
		{
			"nvim-treesitter/nvim-treesitter",
			lazy = false,
			build = ":TSUpdate",
      config = function ()
        require("drpars.treesitter")
      end
		},

		-- Diğer Treesitter Bağımlıları
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
					enable = true,
					max_lines = 0,
					min_rows = 10,
					zindex = 20,
					mode = "cursor",
				})
			end,
		},
  },
}
