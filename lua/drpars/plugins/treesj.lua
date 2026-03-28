-- nvim-treesitter API'sini kullanarak kurulu dilleri güvenli bir şekilde alır.
local function get_installed_ft()
	local parsers_ok, parsers = pcall(require, "nvim-treesitter.parsers")

	if not parsers_ok or not parsers.get_installed_parsers then
		return {}
	end

	return vim.tbl_keys(parsers.get_installed_parsers())
end

return {
	{
		"Wansmer/treesj",
		dependencies = { "nvim-treesitter/nvim-treesitter" },

		-- Eklenti yapılandırması (config)
		config = function()
			-- Kurulum ayarlarını tek bir tabloda topluyoruz
			local setup_opts = {

				-- Dinamik olarak oluşturulan dil listesi
				langs = get_installed_ft(),

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
