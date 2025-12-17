return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "v0.2.0",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope-file-browser.nvim" },
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			{ "nvim-tree/nvim-web-devicons" }, -- İkonlar için gerekli
		},
		config = function()
			-- local actions = require("telescope.actions")

			require("telescope").setup({
				defaults = {
					-- GENEL GÖRÜNÜM
					theme = "dropdown",
					layout_strategy = "horizontal",
					layout_config = {
						width = 0.90,
						height = 0.80,
						prompt_position = "top",
						preview_width = 0.5,
					},
					sorting_strategy = "ascending",
					preview = {
						msg_bg_fillchar = " ", -- Boş alanları temiz tutar
					},

					-- METİN AYARLARI
					wrap_results = true, -- Arama listesindeki sonuçları kaydırır
					path_display = { "truncate" }, -- Uzun dosya yollarını kırpar

					-- ÖNİZLEME (Preview) PENCERESİ İÇİN WRAP (SATIR KAYDIRMA)
					buffer_previewer_maker = function(filepath, bufnr, opts)
						opts = opts or {}
						opts.use_ft_detect = opts.use_ft_detect == nil and true or opts.use_ft_detect

						-- Önizleme buffer'ı açıldığında yerel olarak wrap'i aktif et
						vim.api.nvim_buf_call(bufnr, function()
							vim.opt_local.wrap = true
						end)

						require("telescope.previewers").buffer_previewer_maker(filepath, bufnr, opts)
					end,

					-- GÖRSEL: YUVARLATILMIŞ KENARLIKLAR (Noice & LSP uyumlu)
					borderchars = {
						prompt = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
						results = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
						preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
					},
				},
				pickers = {
					find_files = {
						hidden = true, -- .env gibi gizli dosyaları aramaya dahil eder
					},
					live_grep = {
						-- Burada defaults'tan farklı bir şey istersen ekleyebilirsin
					},
				},
				extensions = {
					file_browser = {
						grouped = true,
						hijack_netrw = true,
						hidden = true,
					},
					fzf = {
						fuzzy = true,
						override_generic_sorter = true,
						override_file_sorter = true,
						case_mode = "smart_case",
					},
				},
			})

			-- Uzantıları yükle
			require("telescope").load_extension("fzf")
			require("telescope").load_extension("file_browser")
		end,
	},
}
