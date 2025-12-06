return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "v0.2.0",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope-file-browser.nvim" },
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		config = function()
			require("telescope").setup({
				defaults = {
					mappings = {},
				},
				pickers = {
					find_files = {
						theme = "dropdown",
						layout_config = { width = 0.90 },
					},
					oldfiles = {
						theme = "dropdown",
						layout_config = { width = 0.90 },
					},
					live_grep = {
						theme = "dropdown",
						wrap_results = true,
						layout_config = { width = 0.90 },
					},
					buffers = {
						theme = "dropdown",
						wrap_results = true,
						layout_config = { width = 0.90 },
					},
					help_tags = {
						theme = "dropdown",
						wrap_results = true,
						layout_config = { width = 0.90 },
					},
					keymaps = {
						theme = "dropdown",
						wrap_results = true,
						layout_config = { width = 0.90 },
					},
					-- git_status = {
					-- 	theme = "dropdown",
					-- 	wrap_results = true,
					-- 	layout_config = { width = 0.90 },
					-- },
					-- git_commits = {
					-- 	theme = "dropdown",
					-- 	wrap_results = true,
					-- 	layout_config = { width = 0.90 },
					-- },
					-- git_branches = {
					-- 	theme = "dropdown",
					-- 	wrap_results = true,
					-- 	layout_config = { width = 0.90 },
					-- },
				},
				extensions = {
					file_browser = {
            grouped = true,
						theme = "dropdown",
						previewer = false,
						hidden = true,
						layout_strategy = "horizontal",
						layout_config = { prompt_position = "top", width = 0.90, height = 0.80 },
						sorting_strategy = "ascending",
						-- disables netrw and use telescope-file-browser in its place
						hijack_netrw = true,
						mappings = {},
					},
					fzf = {
						fuzzy = true, -- false will only do exact matching
						override_generic_sorter = true, -- override the generic sorter
						override_file_sorter = true, -- override the file sorter
						case_mode = "smart_case", -- or "ignore_case" or "respect_case"
						-- the default case_mode is "smart_case"
					},
				},
			})
			require("telescope").load_extension("fzf")
			require("telescope").load_extension("file_browser")
		end,
	},
}
