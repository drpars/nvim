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

-- Disk üzerinde değişen dosyaları (örn. Claude'un yaptığı düzenlemeleri) açık buffer'a
-- anında yansıt. autoread tek başına yetmez; checktime'ı sık tetiklemek gerekir.
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI", "TermClose", "TermLeave" }, {
	group = vim.api.nvim_create_augroup("drpars-auto-reload", { clear = true }),
	desc = "Disk üzerinde değişen dosyayı buffer'a yeniden oku (checktime)",
	callback = function()
		-- Komut satırı modunda checktime hata verir; sadece normal durumda çalıştır.
		if vim.fn.mode() ~= "c" and vim.bo.buftype == "" then
			vim.cmd("checktime")
		end
	end,
})

-- Dosya dıştan değiştiğinde kısa bir bilgi mesajı göster.
vim.api.nvim_create_autocmd("FileChangedShellPost", {
	group = "drpars-auto-reload",
	desc = "Dosya dıştan değişti uyarısı",
	callback = function()
		vim.notify("Dosya disk üzerinde değişti, buffer yeniden yüklendi", vim.log.levels.INFO)
	end,
})

-- Filetype detection for YUCK (EWW)
vim.filetype.add({ extension = { yuck = "yuck" } })
