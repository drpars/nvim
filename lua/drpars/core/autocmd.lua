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

-- User command to list installed treesitter parsers (runtimepath'teki parser/*.so)
vim.api.nvim_create_user_command("TSInstalledLanguages", function()
	local langs = {}
	for _, p in ipairs(vim.api.nvim_get_runtime_file("parser/*.so", true)) do
		langs[vim.fn.fnamemodify(p, ":t:r")] = true
	end
	vim.print(vim.tbl_keys(langs))
end, { desc = "Kurulu Treesitter ayrıştırıcılarını listeler" })

-- Filetype detection for YUCK (EWW)
vim.filetype.add({ extension = { yuck = "yuck" } })
