return {
	"brianhuster/live-preview.nvim",
	dependencies = {
		"nvim-telescope/telescope.nvim",
		"ibhagwan/fzf-lua",
		"folke/snacks.nvim",
	},
	opts = {
		dynamic_root = true, -- dosya cwd dışında olsa bile çalışır, URL'de sadece dosya adı olur
	},
	keys = {
		{ "<leader>p",  "",                             desc = "+preview", mode = { "n", "v" } },
		{ "<leader>pp", "<cmd>LivePreview pick<cr>",    desc = "Live Preview (picker)" },
		{ "<leader>ps", "<cmd>LivePreview start<cr>",   desc = "Start on current file" },
		{ "<leader>pq", "<cmd>LivePreview close<cr>",   desc = "Stop Live Preview" },
	},
}
