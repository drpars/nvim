return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		-- 1. Bildirim ayarları (Yanked mesajları vb. için)
		notifier = {
			enabled = true,
			timeout = 3000,
			style = "compact", -- Daha sade ve şık görünür
		},
		-- 2. Girdi kutuları (Rename, Code Action seçimi vb. için)
		input = {
			enabled = true,
		},
		-- 3. Görsel Stiller (Noice ve LSP ayarlarınla birebir aynı)
		styles = {
			notification = {
				wo = { winblend = 0 }, -- Mat (Opak)
			},
			input = {
				relative = "editor",
				position = "center",
				border = "rounded", -- Yuvarlak kenar
				winhighlight = "Normal:Normal,FloatBorder:DiagnosticInfo", -- Senin renklerin
			},
		},
	},
	keys = {
		-- Bildirim geçmişini görmek istersen (isteğe bağlı)
		-- { "<leader>nh", function() require("snacks").notifier.show_history() end, desc = "Notification History" },
		-- Git Blame (Kodu kim yazmış görmek istersen)
		-- { "<leader>gb", function() require("snacks").git.blame_line() end, desc = "Git Blame (snacks)" },
	},
}
