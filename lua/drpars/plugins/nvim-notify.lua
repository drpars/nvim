return {
	"rcarriga/nvim-notify",
	config = function()
		local notify = require("notify")

		notify.setup({
			merge_duplicates = true,
			-- Senin lsp.lua stilinle uyumlu ayarlar
			-- background_colour = "#000000", -- Arka plan rengi (veya temanın rengi)
			fps = 30,
			icons = {
				DEBUG = "",
				ERROR = "",
				INFO = "",
				TRACE = "✎",
				WARN = "",
			},
			level = 2,
			render = "default",
			stages = "fade_in_slide_out", -- Şık bir giriş-çıkış animasyonu
			timeout = 3000, -- 3 saniye sonra kaybolur
			top_down = true, -- Sağ üstten aşağı doğru dizilir

			-- SENİN ÖZEL AYARLARIN:
			window = {
				winblend = 0, -- Tam opak (mat)
				border = "rounded", -- Yuvarlak kenarlık
			},
		})

		-- Neovim'in standart bildirim sistemini nvim-notify'a yönlendiriyoruz
		vim.notify = notify
	end,
}
