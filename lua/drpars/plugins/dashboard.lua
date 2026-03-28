return {
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
							action = "Telescope file_browser path=~/.config/nvim/lua/drpars",
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
