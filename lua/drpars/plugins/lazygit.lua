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
		-- Space + gg ile LazyGit'i açar
		{ "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
	},
	config = function()
		vim.g.lazygit_floating_window_winblend = 0
		vim.g.lazygit_floating_window_scaling_factor = 0.9
		vim.g.lazygit_floating_window_corner_chars = { "╭", "╮", "╯", "╰" }
		vim.g.lazygit_floating_window_use_plenary = 0
	end,
}
