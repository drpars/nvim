return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons", -- optional, but recommended
			-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
		},
    lazy = false,
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
}
