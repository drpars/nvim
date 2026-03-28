return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({
				options = {
					icons_enabled = true,
					theme = "tokyonight",
					-- Kapsül görünümü için ana ayırıcılar
					section_separators = { left = "", right = "" },
					-- Bileşenler arasındaki çizgiyi kaldırıp boşluk bırakıyoruz
					component_separators = { left = "", right = "" },
					-- Alt barın her pencerede değil, en altta tek bir sıra görünmesini sağlar
					globalstatus = true,
					disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
				},
				sections = {
					lualine_a = {
						{ "mode", separator = { left = "" }, right_padding = 2 },
					},
					lualine_b = {
						{ "filename", file_status = true, path = 1 },
						{ "branch", icon = "" },
					},
					lualine_c = {
						{
							"diagnostics",
							symbols = { error = " ", warn = " ", info = " ", hint = "󰌵 " },
						},
					},
					lualine_x = {
						{
							"diff",
							symbols = { added = " ", modified = "󰝤 ", removed = " " },
						},
					},
					lualine_y = {
						"filetype",
						"progress",
						{
							function()
								local buf_ft = vim.bo.filetype -- vim.api.nvim_buf_get_option yerine en modern yol
								local clients = vim.lsp.get_clients({ bufnr = 0 }) -- Sadece mevcut buffer'daki LSP'leri getir

								if next(clients) == nil then
									return "No LSP"
								end

								local client_names = {}
								for _, client in ipairs(clients) do
									-- client.config.filetypes uyarısı için güvenli kontrol
									---@diagnostic disable-next-line: undefined-field
									if client.config and client.config.filetypes then
										---@diagnostic disable-next-line: undefined-field
										if vim.list_contains(client.config.filetypes, buf_ft) then
											table.insert(client_names, client.name)
										end
									end
								end

								if #client_names == 0 then
									return "No LSP"
								else
									return table.concat(client_names, ", ") -- Birden fazla LSP varsa virgülle ayırır
								end
							end,
							icon = " LSP:",
							color = { fg = "#ffffff", gui = "bold" },
						},
					},
					lualine_z = {
						{ "location", separator = { right = "" }, left_padding = 2 },
					},
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { "filename" },
					lualine_x = { "location" },
					lualine_y = {},
					lualine_z = {},
				},
			})
		end,
	},
}
