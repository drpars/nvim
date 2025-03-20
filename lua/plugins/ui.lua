return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
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
						theme = "dropdown",
						previewer = false,
						hidden = true,
						layout_strategy = "horizontal",
						layout_config = { prompt_position = "top", width = 0.90, height = 0.80 },
						sorting_strategy = "ascending",
						winblend = 0,
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
	{
		"akinsho/bufferline.nvim",
		after = "catppuccin",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			local mocha = require("catppuccin.palettes").get_palette("mocha")
			require("bufferline").setup({
				options = {
					style_preset = require("bufferline").style_preset.default, -- bufferline.style_preset.minimal, bufferline.style_preset.default
					separator_style = "thin", -- "slant" | "slope" | "thick" | "thin" | { 'any', 'any' },
					show_buffer_close_icons = false,
					sort_by = "insert_after_current",
					indicator = {
						icon = "▎", -- this should be omitted if indicator style is not 'icon'
						style = "underline", -- 'icon' | 'underline' | 'none',
					},
					offsets = {
						{
							filetype = "neo-tree",
							text = " File Explorer",
							-- text = function()
							--   return vim.fn.getcwd()
							-- end,
							highlight = "Directory",
							separator = true,
						},
					},
				},
				highlights = require("catppuccin.groups.integrations.bufferline").get({
					styles = { "italic", "bold" },
					custom = {
						-- all = {
						-- 	fill = { bg = "#000000" },
						-- },
						mocha = {
							background = { fg = mocha.text },
						},
						-- latte = {
						-- 	background = { fg = "#000000" },
						-- },
					},
				}),
			})
		end,
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
			-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
			{
				"s1n7ax/nvim-window-picker",
				version = "2.*",
				config = function()
					require("window-picker").setup({
						filter_rules = {
							include_current_win = false,
							autoselect_one = true,
							-- filter using buffer options
							bo = {
								-- if the file type is one of following, the window will be ignored
								filetype = { "neo-tree", "neo-tree-popup", "notify" },
								-- if the buffer type is one of following, the window will be ignored
								buftype = { "terminal", "quickfix" },
							},
						},
					})
				end,
			},
		},
		config = function()
			require("neo-tree").setup({
				default_component_configs = {
					icon = {
						default = "",
						highlight = "NeoTreeFileIcon",
					},
				},
				window = {
					position = "left",
				},
				filesystem = {
					filtered_items = {
						hide_dotfiles = false,
					},
					follow_current_file = {
						enabled = true, -- This will find and focus the file in the active buffer every time
					},
					use_libuv_file_watcher = true, -- This will use the OS level file watchers to detect changes
				},
			})
		end,
	},
	{
		"echasnovski/mini.bufremove",
		config = function()
			require("mini.bufremove").setup()
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			options = {
				icons_enabled = true,
				theme = "catppuccin",
				globalstatus = true,
			},
		},
		init = function()
			vim.opt.showmode = false
		end,
	},
	{
		"utilyre/barbecue.nvim",
		name = "barbecue",
		version = "*",
		dependencies = {
			"SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons", -- optional dependency
		},
		opts = {
			show_dirname = false,
			show_basename = false,
		},
	},
	{
		"j-hui/fidget.nvim",
		-- tag = "*", -- Make sure to update this to something recent!
		opt = {},
		config = function()
			require("fidget").setup({
				notification = {
					window = {
						winblend = 0,
					},
				},
			})
		end,
	},
	{
		"karb94/neoscroll.nvim",
		config = function()
			require("neoscroll").setup({})
		end,
	},
	{
		"anuvyklack/windows.nvim",
		dependencies = {
			"anuvyklack/middleclass",
			"anuvyklack/animation.nvim",
		},
		config = function()
			vim.o.winwidth = 10
			vim.o.winminwidth = 10
			vim.o.equalalways = false
			require("windows").setup()
		end,
	},
	{
		"numToStr/FTerm.nvim",
		config = function()
			local is_windows = vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1

			local cmd
			if is_windows then
				cmd = "pwsh" -- Use PowerShell on native Windows
      else
        cmd = "zsh" -- Use zsh on other OS
			end
			require("FTerm").setup({
				cmd = cmd, -- Set the command based on the OS
				blend = 0, -- Ensure this is `blend`, not `blend` (typo in your original code)
				-- dimensions = {
				--   height = 0.9,
				--   width = 0.9,
				-- }
			})
		end,
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			views = {
				cmdline_popup = {
					position = {
						row = 5,
						col = "50%",
					},
					size = {
						width = 60,
						height = "auto",
					},
				},
				popupmenu = {
					relative = "editor",
					position = {
						row = 8,
						col = "50%",
					},
					size = {
						width = 60,
						height = 10,
					},
					border = {
						style = "rounded",
						padding = { 0, 1 },
					},
					win_options = {
						winhighlight = { Normal = "Normal", FloatBorder = "FloatBorder" },
					},
				},
			},
			routes = {
				{
					filter = {
						event = "notify",
						find = "No information available",
					},
					opts = { skip = true },
				},
			},
			lsp = {
				signature = {
					enabled = false,
				},
				hover = {
					enabled = false,
				},
				-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
				},
			},
			-- you can enable a preset for easier configuration
			presets = {
				bottom_search = false, -- use a classic bottom cmdline for search
				command_palette = true, -- position the cmdline and popupmenu together
				long_message_to_split = true, -- long messages will be sent to a split
				inc_rename = false, -- enables an input dialog for inc-rename.nvim
				lsp_doc_border = false, -- add a border to hover docs and signature help
			},
		},
		dependencies = {
			{ "MunifTanjim/nui.nvim" },
			{
				"rcarriga/nvim-notify",
				opts = {
					render = "wrapped-compact",
					stages = "static",
				},
			},
		},
	},
	{
		"nvimdev/dashboard-nvim",
		event = "VimEnter",
		config = function()
			require("dashboard").setup({
				theme = "doom", --  theme is doom and hyper default is hyper
				config = {
					header = {
						"",
						"",
						"",
						"",
						"",
						"",
						"",
						"▓█████▄  ██▀███   ██▓███   ▄▄▄       ██▀███    ██████ ",
						"▒██▀ ██▌▓██ ▒ ██▒▓██░  ██▒▒████▄    ▓██ ▒ ██▒▒██    ▒ ",
						"░██   █▌▓██ ░▄█ ▒▓██░ ██▓▒▒██  ▀█▄  ▓██ ░▄█ ▒░ ▓██▄   ",
						"░▓█▄   ▌▒██▀▀█▄  ▒██▄█▓▒ ▒░██▄▄▄▄██ ▒██▀▀█▄    ▒   ██▒",
						"░▒████▓ ░██▓ ▒██▒▒██▒ ░  ░ ▓█   ▓██▒░██▓ ▒██▒▒██████▒▒",
						" ▒▒▓  ▒ ░ ▒▓ ░▒▓░▒▓▒░ ░  ░ ▒▒   ▓▒█░░ ▒▓ ░▒▓░▒ ▒▓▒ ▒ ░",
						" ░ ▒  ▒   ░▒ ░ ▒░░▒ ░       ▒   ▒▒ ░  ░▒ ░ ▒░░ ░▒  ░ ░",
						" ░ ░  ░   ░░   ░ ░░         ░   ▒     ░░   ░ ░  ░  ░  ",
						"   ░       ░                    ░  ░   ░           ░  ",
						" ░                                                    ",
						"",
						"",
						"",
					},
					center = {
						{
							action = "Telescope find_files",
							desc = " Find file",
							icon = " ",
							key = "f",
							key_format = " %s",
						},
						{
							action = "ene | startinsert",
							desc = " New file",
							icon = " ",
							key = "n",
							key_format = " %s",
						},
						{
							action = "Telescope oldfiles",
							desc = " Recent files",
							icon = " ",
							key = "r",
							key_format = " %s",
						},
						{
							action = "Telescope live_grep",
							desc = " Find text",
							icon = " ",
							key = "g",
							key_format = " %s",
						},
						{
							action = "Telescope file_browser path=~/.config/nvim/lua/config",
							desc = " Config",
							icon = " ",
							key = "c",
							key_format = " %s",
						},
						{
							action = 'lua require("persistence").load()',
							desc = " Restore Session",
							icon = " ",
							key = "s",
							key_format = " %s",
						},
						{ action = "Lazy", desc = " Lazy", icon = "󰒲 ", key = "l", key_format = " %s" },
						{ action = "qa", desc = " Quit", icon = " ", key = "q", key_format = " %s" },
					},
				}, --  config used for theme
				hide = {},
				preview = {},
			})
		end,
	},
}
