return {
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		---@module "ibl"
		---@type ibl.config
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			scope = { enabled = false },
			exclude = {
				filetypes = {
					"help",
					"alpha",
					"dashboard",
					"neo-tree",
					"lazy",
					"mason",
					"notify",
					"lazyterm",
				},
			},
		},
	},
	{
		"echasnovski/mini.indentscope",
		version = false,
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			symbol = "│",
			options = { try_as_border = true },
		},
		init = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = {
					"help",
					"alpha",
					"dashboard",
					"neo-tree",
					"NvimTree",
					"lazy",
					"mason",
					"notify",
					"lazyterm",
				},
				callback = function()
					---@diagnostic disable-next-line
					vim.b.miniindentscope_disable = true
				end,
			})
		end,
	},
}
