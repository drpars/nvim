return {
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "" },
					change = { text = "󰝤" },
					delete = { text = "" },
					topdelete = { text = "✘" },
					changedelete = { text = "" },
					untracked = { text = "󰄱" },
				},
				signs_staged = {
					add = { text = "" },
					change = { text = "󰝤" },
					delete = { text = "" },
					topdelete = { text = "✘" },
					changedelete = { text = "" },
				},
				current_line_blame = true,
				current_line_blame_opts = {
					delay = 1000,
					virt_text_pos = "eol",
				},
			})

			-- Highlight ayarı
			vim.api.nvim_set_hl(0, "GitSignsCurrentLineBlame", { link = "Comment" })

			local gs = require("gitsigns")
			local keymap = vim.keymap.set

			-- Next Hunk (Sonraki değişiklik)
			keymap("n", "üh", function()
				gs.nav_hunk({ navigation_message = true, target = "next" })
			end, { desc = "Next Git Hunk" })

			-- Prev Hunk (Önceki değişiklik)
			keymap("n", "ğh", function()
				gs.nav_hunk({ navigation_message = true, target = "prev" })
			end, { desc = "Prev Git Hunk" })

			-- Preview Hunk (Değişikliği önizle)
			keymap("n", "<leader>hp", gs.preview_hunk, { desc = "Preview Git Hunk" })

			-- Tek bir tuşla toggle (stage/unstage) yapmak istiyorsan bu yeterli:
			keymap("n", "<leader>hs", gs.stage_hunk, { desc = "Toggle Stage Hunk" })
		end,
	},
}
