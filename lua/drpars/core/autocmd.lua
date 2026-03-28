-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

-- Treesitter ile kurulan ayrıştırıcılar veya çözümleyiciler (parsers)
vim.api.nvim_create_user_command("TSInstalledLanguages", function()
	local installed_parsers = require("nvim-treesitter").get_installed()
	vim.print(installed_parsers)
end, { desc = "Kurulu Treesitter ayrıştırıcılarını listeler" })
