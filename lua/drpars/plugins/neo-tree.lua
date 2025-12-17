return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		lazy = false,
		config = function()
			require("neo-tree").setup({
				-- GÖRSEL AYARLAR: Kapsül ve Yuvarlak Hatlar
				popup_border_style = "rounded",

				default_component_configs = {
					indent = {
						with_markers = true,
						indent_marker = "│",
						last_indent_marker = "└",
					},
					icon = {
						folder_closed = "",
						folder_open = "",
						folder_empty = "󰜌",
						default = "",
					},
					git_status = {
						symbols = {
							added = "✚",
							modified = "",
							deleted = "✖",
							renamed = "󰁯",
							untracked = "",
							ignored = "",
							unstaged = "󰄱",
							staged = "",
							conflict = "",
						},
					},
				},
				window = {
					position = "float", -- "left" yerine "float" ile yüzer pencere yapıyoruz
					width = 35,
					popup = {
						-- Pencerenin ekrandaki yerini ayarlar
						position = { col = "1", row = "2" },
						size = { width = "30%", height = "80%" },
					},
					mappings = {
						["<space>"] = "none", -- Leader ile çakışmaması için
					},
				},
				filesystem = {
					filtered_items = {
						hide_dotfiles = false,
						hide_gitignored = false,
					},
					follow_current_file = {
						enabled = true,
					},
					use_libuv_file_watcher = true,
				},
			})
		end,
	},
}
