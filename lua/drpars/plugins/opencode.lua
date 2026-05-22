return {
	"nickjvandyke/opencode.nvim",
	version = "*",
	dependencies = {
		{
			"folke/snacks.nvim",
			optional = true,
			opts = {
				input = {},
				picker = {
					actions = {
						opencode_send = function(...)
							return require("opencode").snacks_picker_send(...)
						end,
					},
					win = {
						input = {
							keys = {
								["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
							},
						},
					},
				},
			},
		},
	},
	config = function()
		vim.g.opencode_opts = {
			server = {
				toggle = function()
					require("opencode.terminal").toggle("opencode --port", {
						split = "right",
						width = math.floor(vim.o.columns * 0.35),
					})
				end,
				start = function()
					require("opencode.terminal").open("opencode --port", {
						split = "right",
						width = math.floor(vim.o.columns * 0.35),
					})
				end,
				stop = function()
					require("opencode.terminal").close()
				end,
			},
		}

		vim.o.autoread = true

		vim.api.nvim_set_hl(0, "NormalTerm", { bg = "none" })
		vim.api.nvim_create_autocmd("TermOpen", {
			group = vim.api.nvim_create_augroup("OpencodeTheme", { clear = true }),
			callback = function()
				vim.api.nvim_win_set_option(0, "winhl", "Normal:NormalTerm")
			end,
		})

		local keymap = vim.keymap.set

		-- keymap({ "n", "x" }, "<C-a>", function()
		-- 	require("opencode").ask("@this: ", { submit = true })
		-- end, { desc = "Ask opencode" })
		-- keymap({ "n", "x" }, "<C-x>", function()
		-- 	require("opencode").select()
		-- end, { desc = "Execute opencode action" })
		keymap({ "n", "t" }, "<C-.>", function()
			require("opencode").toggle()
		end, { desc = "Toggle opencode" })

		keymap("n", "<leader>oo", function()
			require("opencode").toggle()
		end, { desc = "Opencode Toggle" })
		keymap({ "n", "x" }, "<leader>oa", function()
			require("opencode").ask("@this: ", { submit = true })
		end, { desc = "Opencode: Ask" })
		keymap("v", "<leader>oe", function()
			require("opencode").ask("Explain @this in detail", { submit = true })
		end, { desc = "Opencode: Explain" })
		keymap({ "n", "x" }, "<leader>of", function()
			require("opencode").ask("Fix @diagnostics", { submit = true })
		end, { desc = "Opencode: Fix" })
		keymap({ "n", "x" }, "<leader>oc", function()
			require("opencode").prompt("chat")
		end, { desc = "Opencode: Chat" })
	end,
}
