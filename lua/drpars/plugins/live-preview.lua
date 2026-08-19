return {
	"brianhuster/live-preview.nvim",
	dependencies = {
		"nvim-telescope/telescope.nvim",
		"ibhagwan/fzf-lua",
		"folke/snacks.nvim",
	},
	opts = {
		dynamic_root = true, -- dosya cwd dışında olsa bile çalışır, URL'de sadece dosya adı olur
		-- Çalışılan workspace'te açılsın diye yeni pencere isteniyor. Düz `xdg-open`
		-- (browser = "default" → vim.ui.open) çalışan Firefox örneğine uzak komut
		-- yolluyor, o da sekmeyi kendi penceresinin durduğu workspace'te açıyor;
		-- yeni pencere doğmadığı için Hyprland yerleştirecek bir şey bulamıyor.
		-- Argüman geçebiliyoruz: term_cmd komutu `sh -c` ile koşturuyor.
		browser = "firefox --new-window",
	},
	keys = {
		{ "<leader>p",  "",                             desc = "+preview", mode = { "n", "v" } },
		{ "<leader>pp", "<cmd>LivePreview pick<cr>",    desc = "Live Preview (picker)" },
		{ "<leader>ps", "<cmd>LivePreview start<cr>",   desc = "Start on current file" },
		{ "<leader>pq", "<cmd>LivePreview close<cr>",   desc = "Stop Live Preview" },
	},
}
