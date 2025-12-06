return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
				context_commentstring = {
					enable = true,
					enable_autocmd = false,
				},
				ensure_installed = {
					"bash",
					"c",
					"cpp",
					"css",
					"diff",
					"html",
					"hyprlang",
					"javascript",
					"jsdoc",
					"json",
					"jsonc",
					"lua",
					"luadoc",
					"luap",
					"prisma",
					"markdown",
					"markdown_inline",
					"python",
					"query",
					"regex",
					"toml",
					"tsx",
					"dockerfile",
					"gitignore",
					"typescript",
					"vim",
					"vimdoc",
					"yaml",
					"rasi",
				},
				autotag = { enable = true },
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<C-space>",
						node_incremental = "<C-space>",
						scope_incremental = false,
						node_decremental = "<bs>",
					},
				},
				indent = { enable = true },
			})
			vim.filetype.add({
				pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
			})
			vim.filetype.add({
				pattern = { [".*/rofi/.*%.rasi"] = "rasi" },
			})
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		after = "nvim-treesitter",
	},
}
