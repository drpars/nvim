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

-- User command to list installed treesitter parsers (Neovim 0.12 built-in)
vim.api.nvim_create_user_command("TSInstalledLanguages", function()
	local parsers = vim.treesitter.get_installed_parsers()
	vim.print(vim.tbl_keys(parsers))
end, { desc = "Kurulu Treesitter ayrıştırıcılarını listeler" })

-- Filetype detection for YUCK (EWW)
vim.filetype.add({ extension = { yuck = "yuck" } })
