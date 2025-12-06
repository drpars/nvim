return {
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
}
