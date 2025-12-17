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
			if fn.getbufvar(buf, "&modifiable") ~= 1 then
				return false
			end
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
			}
			return not vim.tbl_contains(excluded_ft, filetype)
		end,
		write_all_buffers = false,
		debounce_delay = 1000,
	},
	config = function(_, opts)
		-- Eklentiyi kur
		require("auto-save").setup(opts)

		-- SİNYAL YAKALAYICI (Senin bulduğun kısım)
		local group = vim.api.nvim_create_augroup("autosave_notifications", {})
		vim.api.nvim_create_autocmd("User", {
			pattern = "AutoSaveWritePost",
			group = group,
			callback = function(event)
				if event.data.saved_buffer ~= nil then
					-- Dosya yolunu kısaltalım (sadece dosya ismi görünsün, çok uzun olmasın)
					local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(event.data.saved_buffer), ":t")

					-- Şık bir bildirim gönder
					vim.notify("AutoSave: " .. filename .. " kaydedildi", vim.log.levels.INFO, {
						title = "AutoSave",
						timeout = 1500,
					})
				end
			end,
		})
	end,
}
--
