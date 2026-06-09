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
				-- Hunk önizleme (<leader>hp) popup'ını K (LSP hover) ile aynı yuvarlak kenarlıkta göster
				preview_config = {
					border = "rounded",
					style = "minimal",
					relative = "cursor",
					row = 0,
					col = 1,
				},
			})

			-- Highlight ayarı
			vim.api.nvim_set_hl(0, "GitSignsCurrentLineBlame", { link = "Comment" })

			local gs = require("gitsigns")
			local keymap = vim.keymap.set

			-- Next Hunk (Sonraki değişiklik)
			keymap("n", "]h", function()
				gs.nav_hunk("next", { navigation_message = true })
			end, { desc = "Next Git Hunk" })

			-- Prev Hunk (Önceki değişiklik)
			keymap("n", "[h", function()
				gs.nav_hunk("prev", { navigation_message = true })
			end, { desc = "Prev Git Hunk" })

			-- Preview Hunk (Değişikliği önizle) — K (LSP hover) ile aynı kenarlık rengini uygula
			local function style_preview_border(tries)
				for _, win in ipairs(vim.api.nvim_list_wins()) do
					if vim.w[win].gitsigns_preview then
						local cur = vim.wo[win].winhighlight
						if not cur:find("FloatBorder") then
							vim.wo[win].winhighlight = (cur ~= "" and cur .. "," or "")
								.. "FloatBorder:DiagnosticInfo"
						end
						return
					end
				end
				if tries > 0 then
					vim.defer_fn(function()
						style_preview_border(tries - 1)
					end, 20)
				end
			end
			keymap("n", "<leader>hp", function()
				gs.preview_hunk()
				style_preview_border(5)
			end, { desc = "Preview Git Hunk" })

			-- Tek bir tuşla toggle (stage/unstage) yapmak istiyorsan bu yeterli:
			keymap("n", "<leader>hs", gs.stage_hunk, { desc = "Toggle Stage Hunk" })
		end,
	},
}
