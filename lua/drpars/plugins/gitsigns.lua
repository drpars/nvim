return {
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "▎" },
					change = { text = "▎" },
					delete = { text = "" },
					topdelete = { text = "" },
					changedelete = { text = "▎" },
					untracked = { text = "┆" },
				},
				current_line_blame = true,
				current_line_blame_opts = {
					delay = 500,
					virt_text_pos = "eol",
				},
			})

			local gs = require("gitsigns")

			-- Next Hunk (Sonraki değişiklik)
			vim.keymap.set("n", "üh", function()
				gs.nav_hunk({ navigation_message = true, target = "next" })
			end, { desc = "Next Git Hunk" })

			-- Prev Hunk (Önceki değişiklik)
			vim.keymap.set("n", "ğh", function()
				gs.nav_hunk({ navigation_message = true, target = "prev" })
			end, { desc = "Prev Git Hunk" })

			-- Preview Hunk (Değişikliği önizle)
			vim.keymap.set("n", "<leader>hp", gs.preview_hunk, { desc = "Preview Git Hunk" })

			-- Stage Hunk (İmlecin olduğu bloğu hazırla)
			-- Yeni API: stage_hunk() parametresiz çağrıldığında o anki hunk'ı stage eder.
			vim.keymap.set("n", "<leader>hs", function()
				gs.stage_hunk()
			end, { desc = "Stage Current Hunk" })

			-- Tek bir tuşla toggle (stage/unstage) yapmak istiyorsan bu yeterli:
			vim.keymap.set("n", "<leader>hs", gs.stage_hunk, { desc = "Toggle Stage Hunk" })

			-- Ama işi sağlama almak ve kafa karışıklığını önlemek istersen "Undo"yu ayır:
			-- vim.keymap.set("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Undo Last Stage" })
		end,
		vim.api.nvim_set_hl(0, "GitSignsCurrentLineBlame", { link = "Comment" }),
	},
}
