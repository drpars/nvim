return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
	config = function()
		local harpoon = require("harpoon")
    local keymap = vim.keymap.set
		harpoon:setup({})

		-- --- TEMEL AYARLAR VE KISAYOLLAR ---

		-- Dosyayı Harpoon listesine ekle (Add)
		keymap("n", "<leader>ah", function()
			harpoon:list():add()
			vim.notify("File added to Harpoon", vim.log.levels.INFO, { title = "Harpoon" })
		end, { desc = "Harpoon: Add file" })

		-- Standart Harpoon Menüsünü Aç (Düzenleme yapmak için: dd ile silme, yer değiştirme vb.)
		keymap("n", "<C-A-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon: Quick Menu" })

		-- --- HIZLI ERİŞİM (LEADER + SAYI) ---
		keymap("n", "<leader>1", function() harpoon:list():select(1) end, { desc = "Harpoon: File 1" })
		keymap("n", "<leader>2", function() harpoon:list():select(2) end, { desc = "Harpoon: File 2" })
		keymap("n", "<leader>3", function() harpoon:list():select(3) end, { desc = "Harpoon: File 3" })
		keymap("n", "<leader>4", function() harpoon:list():select(4) end, { desc = "Harpoon: File 4" })

		-- --- TELESCOPE ENTEGRASYONU ---
		-- Harpoon listesini Telescope içerisinde görmek ve aramak için
		local conf = require("telescope.config").values
		local function toggle_telescope(harpoon_files)
			local file_paths = {}
			for _, item in ipairs(harpoon_files.items) do
				table.insert(file_paths, item.value)
			end

			require("telescope.pickers")
				.new({}, {
					prompt_title = "Harpoon List",
					finder = require("telescope.finders").new_table({
						results = file_paths,
					}),
					previewer = conf.file_previewer({}),
					sorter = conf.generic_sorter({}),
				})
				:find()
		end

		-- Telescope ile Harpoon'u aç (Kısayol: Control + Alt + h)
		keymap("n", "<C-A-h>", function() toggle_telescope(harpoon:list()) end, { desc = "Harpoon: Open with Telescope" })
	end,
}
