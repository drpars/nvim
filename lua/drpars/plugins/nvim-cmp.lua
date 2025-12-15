return {
	{
		"hrsh7th/nvim-cmp",
		-- Sadece Insert moduna girildiğinde yüklenir.
		event = "InsertEnter",
		dependencies = {
			-- LSP'den gelen imza yardımı (fonksiyon parametreleri)
			{ "hrsh7th/cmp-nvim-lsp-signature-help" },
			-- Açık olan buffer'lardan kelime tamamlama
			{ "hrsh7th/cmp-buffer" },
			-- Dosya yolu tamamlama
			{ "hrsh7th/cmp-path" },
			-- Komut satırı (/, :) tamamlama
			{ "hrsh7th/cmp-cmdline" },
			-- Snippet motoru ve koleksiyonu
			{
				"L3MON4D3/LuaSnip",
				version = "2.*", -- Güncel majör versiyon
				build = "make install_jsregexp",
				dependencies = { "rafamadriz/friendly-snippets" },
			},
			-- vscode benzeri ikonlar için
			{ "onsails/lspkind.nvim" },
			-- { "ray-x/cmp-treesitter" }, -- Ağır olduğu için kaldırılması önerilir.
			{ "chrisgrieser/cmp-nerdfont" }, -- Nerdfont ikonlarını kullanır
			{ "kdheepak/cmp-latex-symbols" }, -- LaTeX sembolleri tamamlama
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			-- İmlecin bir boşlukta veya satır başında olup olmadığını kontrol eden yardımcı fonksiyon
			local check_backspace = function()
				local col = vim.fn.col(".") - 1
				return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
			end

			-- VSCode formatındaki snippet'leri yükler
			require("luasnip.loaders.from_vscode").lazy_load({
				-- exclude = { "javascript" }, -- İhtiyacınıza göre hariç tutabilirsiniz
			})

			-----------------------------------------------------------
			-- 🔍 KOMUT SATIRI KURULUMLARI (Cmdline Setup)
			-----------------------------------------------------------

			-- `/` (Arama) komut satırı kurulumu.
			cmp.setup.cmdline("/", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" }, -- Açık buffer'lardan arama terimi tamamlama
				},
			})

			-- `:` (Komut) komut satırı kurulumu.
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" }, -- Dosya yolu tamamlama
				}, {
					{
						name = "cmdline", -- Varsayılan komut tamamlama
						option = {
							ignore_cmds = { "Man", "!" }, -- Belirtilen komutları yoksay
						},
					},
				}),
			})

			-----------------------------------------------------------
			-- ⌨️ GENEL (INSERT MODE) KURULUMU
			-----------------------------------------------------------

			cmp.setup({
				-- Tamamlama Kaynakları (Sıralama önemlidir)
				sources = {
					{ name = "nvim_lsp" }, -- 1. LSP Sunucularından (En Yüksek Öncelik)
					{ name = "nvim_lsp_signature_help" }, -- 2. İmza Yardımı
					{ name = "luasnip" }, -- 3. Snippet'ler
					{ name = "buffer" }, -- 4. Buffer İçeriği
					{ name = "path" }, -- 5. Dosya Yolları
          { name = "lazydev" },
					-- { name = "treesitter" }, -- Kaldırıldı (Performans için)
					{ name = "nerdfont" }, -- Nerd Font ikon tabanlı tamamlama
					{
						name = "latex_symbols", -- LaTeX sembolleri tamamlama
						option = {
							strategy = 0, -- mixed
						},
					},
				},

				-- Eşlemeler (Key Mappings)
				mapping = cmp.mapping.preset.insert({
					["<CR>"] = cmp.mapping.confirm({ select = true }), -- Seçili adayı seç ve onaylayarak yerleştir
					["<C-Space>"] = cmp.mapping.complete(), -- Tamamlamayı manuel tetikle
					["<C-u>"] = cmp.mapping.scroll_docs(-4), -- Dokümantasyonu 4 satır yukarı kaydır
					["<C-d>"] = cmp.mapping.scroll_docs(4), -- Dokümantasyonu 4 satır aşağı kaydır

					-- TAB İşlevi: Hem cmp'de ilerleme hem de snippet'te ilerleme sağlar (Öncelikli)
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							-- 1. Menü açıksa: Sonraki adaya geç
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							-- 2. Menü kapalıysa ve aktif bir snippet'te ilerlenecek yer varsa: Snippet'te ilerle
							luasnip.expand_or_jump()
						elseif check_backspace() then
							-- 3. Satır başında/boşlukta ise: Normal Tab işlevi (girinti)
							fallback()
						else
							-- 4. Aksi takdirde, cmp'yi normal bir şekilde tetikle
							cmp.complete()
						end
					end, { "i", "s" }), -- i: insert mode, s: select mode (snippet)

					-- SHIFT+TAB İşlevi: Hem cmp'de geri gitme hem de snippet'te geri gitme sağlar
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							-- Menü açıksa: Önceki adaya geç
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							-- Menü kapalıysa ve snippet'te geri gidilebiliyorsa: Snippet'te geri git
							luasnip.jump(-1)
						else
							-- Aksi takdirde normal geri gitme
							fallback()
						end
					end, { "i", "s" }),
				}),

				-- Snippet Motoru Ayarı
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},

				-- Pencere Görünümü Ayarları (Kenarlıklı pencereler)
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},

				-- Formatlama (lspkind ile ikonları ve menüleri düzenler)
				formatting = {
					fields = { "kind", "abbr", "menu" },
					format = function(entry, vim_item)
						local kind = require("lspkind").cmp_format({ mode = "symbol_text" })(entry, vim_item)
						local strings = vim.split(kind.kind, "%s", { trimempty = true })

						-- İkonu ve menü (kaynak) bilgisini ayırıp yeniden formatlar
						kind.kind = " " .. (strings[1] or "") .. " "
						kind.menu = "    (" .. (strings[2] or "") .. ")"
						return kind
					end,
				},
			})
		end,
	},
}
