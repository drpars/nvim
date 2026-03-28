return {
	{
		"j-hui/fidget.nvim",
		version = "*", -- En son kararlı sürümü kullandığından emin ol
		lazy = false,
		priority = 1000,
		opts = {
			progress = {
				-- Sunucu çok hızlı olsa bile mesajı yakalamaya zorla
				ignore_done_already = false,
				display = {
					done_ttl = 5, -- Görünürlüğü garantilemek için süreyi uzat
				},
			},
			notification = {
				window = { winblend = 0 },
			},
		},
	},
}
