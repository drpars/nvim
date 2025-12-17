return {
	"kdheepak/lazygit.nvim",
	cmd = {
		"LazyGit",
		"LazyGitConfig",
		"LazyGitCurrentFile",
		"LazyGitFilter",
		"LazyGitFilterCurrentFile",
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	keys = {
		-- Space + g ile LazyGit'i açar
		{ "<leader>g", "<cmd>LazyGit<cr>", desc = "LazyGit" },
	},
	config = function()
		-- Yuvarlak kenarlıklar ve görsel uyum için
		vim.g.lazygit_floating_window_winblend = 0
		vim.g.lazygit_floating_window_corner_chars = { "╭", "╮", "╯", "╰" }
		vim.g.lazygit_floating_window_use_plenary = 1
	end,
}
