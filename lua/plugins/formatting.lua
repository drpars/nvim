return {
	"stevearc/conform.nvim",
	lazy = false,
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			-- Customize or remove this keymap to your liking
			"<leader>f",
			function()
				require("conform").format({ async = true, lsp_fallback = true })
			end,
			mode = "",
			desc = "Format buffer",
		},
	},
	-- This will provide type hinting with LuaLS
	---@module "conform"
	---@diagnostic disable-next-line
	---@type conform.setupOpts
	opts = {
		-- Define your formatters
		formatters_by_ft = {
			lua = { "stylua" },
			sh = { "shfmt" },
			json = { "prettier" },
			css = { "prettier" },
			-- python = { "" }, --any python formatters doesn't support 3.12 python version
		},
		-- Set default options
		default_format_opts = {
			lsp_format = "fallback",
		},
		-- Set up format-on-save
		-- format_on_save = {
		-- 	-- These options will be passed to conform.format()
		-- 	timeout_ms = 500,
		-- 	lsp_format = "fallback",
		-- },
		-- Customize formatters
		formatters = {
			shfmt = {
				prepend_args = { "-i", "2" },
			},
		},
	},
}
