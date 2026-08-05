return {
	{
		"mg979/vim-visual-multi",
		branch = "master",
		init = function()
			-- which-key, `[d`/`]h` gibi eşlemelerin ön ekleri için buffer-local
			-- `[` ve `]` tetikleyicileri kurar (which-key/triggers.lua:43).
			-- VM başlarken buffer'da zaten eşleme görürse kendi "Goto Prev/Next"
			-- eşlemesini kurmayı reddedip uyarı basıyor:
			--   b<N>: Could not map: [ (Goto Prev)  ->  <Lua callback>
			-- Sonuç: VM içinde `[`/`]` bölge atlaması çalışmıyor. force_maps,
			-- VM'e "bu tuşlarda kontrolü atla, yine de eşle" der.
			vim.g.VM_force_maps = { "[", "]" }

			-- VM çıkarken kendi buffer eşlemelerini `nunmap <buffer>` ile siliyor
			-- ve which-key tetikleyicisini de götürüyor. which-key kendi iç
			-- kaydını (`_triggers`) hâlâ dolu sandığı için tetikleyiciyi
			-- kendiliğinden geri kurmuyor — buffer switch bile yetmiyor.
			-- `Buf.clear` + `Buf.get` o kaydı sıfırlayıp yeniden bağlar;
			-- which-key aynı yolu kendi de kullanıyor (config.lua:332).
			vim.api.nvim_create_autocmd("User", {
				pattern = "visual_multi_exit",
				group = vim.api.nvim_create_augroup("drpars-vm-whichkey", { clear = true }),
				desc = "VM çıkışında which-key tetikleyicilerini geri kur",
				callback = function()
					local ok, Buf = pcall(require, "which-key.buf")
					if not ok then
						return
					end
					local buf = vim.api.nvim_get_current_buf()
					Buf.clear({ buf = buf })
					Buf.get({ buf = buf })
				end,
			})
		end,
	},
}
