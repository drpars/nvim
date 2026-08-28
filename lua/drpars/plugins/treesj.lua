return {
	{
		"Wansmer/treesj",

		-- Eklenti yapılandırması (config)
		config = function()
			-- Kurulum ayarlarını tek bir tabloda topluyoruz
			local setup_opts = {

				-- `langs` bilerek verilmiyor: o seçenek kurulu parser listesi değil,
				-- dil başına node yapılandırması (preset) bekliyor. treesj kendi
				-- preset'lerini lua/treesj/langs altından zaten yüklüyor.

				-- Temel ayarlar
				use_default_keymaps = false,
				check_support_install = true,

				-- Split/Join ayarları
				split = {
					uri_len_max = 80,
				},
				join = {
					uri_len_max = 120,
				},
			}

			-- Kurulumu yapıyoruz
			require("treesj").setup(setup_opts)

			-- Kısayol Atamaları:
			vim.keymap.set({ "n" }, "<leader>j", require("treesj").join, { desc = "[T]reesitter [J]oin" })
			vim.keymap.set({ "n" }, "<leader>s", require("treesj").split, { desc = "[T]reesitter [S]plit" })
		end,
	},
}
