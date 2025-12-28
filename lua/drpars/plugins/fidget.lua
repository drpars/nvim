return {
	{
		"j-hui/fidget.nvim",
		opt = {},
		config = function()
			require("fidget").setup({
				notification = {
					window = {
						winblend = 0,
						winhighlight = "Normal:Normal,FloatBorder:DiagnosticInfo",
						-- border = "rounded",
					},
				},
			})
		end,
	},
}
