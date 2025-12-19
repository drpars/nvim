return {
	"okuuva/auto-save.nvim",
	lazy = false,
	opts = {
		enabled = true,
		trigger_events = {
			immediate_save = { "BufLeave", "FocusLost", "QuitPre", "VimSuspend" },
			defer_save = { "InsertLeave", "TextChanged" },
			cancel_deferred_save = { "InsertEnter" },
		},
		condition = function(buf)
			local fn = vim.fn
			local filetype = fn.getbufvar(buf, "&filetype")
			local buftype = fn.getbufvar(buf, "&buftype")
			local bufname = vim.api.nvim_buf_get_name(buf)

			-- 1. Modifiable değilse kaydetme (Salt okunur dosyalar vb.)
			if fn.getbufvar(buf, "&modifiable") ~= 1 then
				return false
			end

			-- 2. Özel buffer tiplerini ve isimsiz buffer'ları engelle
			-- Normal dosyaların buftype değeri her zaman boştur ("")
			if buftype ~= "" or bufname == "" then
				return false
			end

			-- 3. Dışlanacak dosya tipleri (Filetypes)
			local excluded_ft = {
				"neo-tree",
				"TelescopePrompt",
				"harpoon",
				"lazy",
				"mason",
				"gitcommit",
				"gitrebase",
				"checkhealth",
				"help",
				"terminal",
				"nofile",
				"fugitive",
				"fugitiveblame",
				"qf",
				"nui_input", -- Neo-tree'nin giriş penceresi tipi
			}

			-- Filetype boşsa veya dışlananlar listesindeyse kaydetme
			if filetype == "" or vim.tbl_contains(excluded_ft, filetype) then
				return false
			end

			return true
		end,
		write_all_buffers = false,
		debounce_delay = 1000,
	},
	config = function(_, opts)
		-- Eklentiyi kur
		require("auto-save").setup(opts)

		-- SİNYAL YAKALAYICI (Bildirimler için)
		local group = vim.api.nvim_create_augroup("autosave_notifications", {})
		vim.api.nvim_create_autocmd("User", {
			pattern = "AutoSaveWritePost",
			group = group,
			callback = function(event)
				if event.data.saved_buffer ~= nil then
					-- Dosya ismini al
					local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(event.data.saved_buffer), ":t")

					-- Eğer dosya ismi varsa bildirimi göster
					if filename ~= "" then
						vim.notify("AutoSave: " .. filename .. " kaydedildi", vim.log.levels.INFO, {
							title = "AutoSave",
							timeout = 1000,
						})
					end
				end
			end,
		})
	end,
}
