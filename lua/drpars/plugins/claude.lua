return {
	{
		"coder/claudecode.nvim",
		dependencies = { "folke/snacks.nvim" },
		opts = {
			auto_start = true,
			log_level = "info",
			env = {},
			terminal = {
				provider = "snacks",
				snacks_win_opts = {
					position = "float",
					width = 0.85,
					height = 0.85,
					border = "rounded",
					backdrop = 80,
					-- row = 0.03, -- Üstten %n boşluk
					-- col = 0.95, -- Sağa yasla (1.0 = tam sağ kenar)
					keys = {
						claude_hide = {
							"<leader>cc",
							function(self)
								self:hide()
							end,
							mode = "t",
							desc = "Hide Claude",
						},
					},
				},
			},
		},
		keys = {
			{ "<leader>c", "", desc = "+claude", mode = { "n", "v" } },
			{ "<leader>cc", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
			{ "<leader>cf", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
			{ "<leader>cr", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
			{ "<leader>cb", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add buffer" },
			{ "<leader>cs", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send selection" },
		},
	},
}
