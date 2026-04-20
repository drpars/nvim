return {
	filetypes = { "json", "jsonc" }, -- jsonc, yorum satırlarına izin verir
	settings = {
		json = {
			schemas = require("schemastore").json.schemas(),
			validate = { enable = true },
		},
	},
	setup = {
		commands = {
			Format = {
				function()
					vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.api.nvim_buf_line_count(0), 0 })
				end,
			},
		},
	},
}
