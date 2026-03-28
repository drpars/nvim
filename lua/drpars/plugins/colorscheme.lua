return {
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("tokyonight").setup({
				style = "night",
				transparent = true,
				styles = {
					-- Style to be applied to different syntax groups
					-- Value is any valid attr-list value for `:help nvim_set_hl`
					comments = { italic = true },
					keywords = { italic = true },
					functions = {},
					variables = {},
					-- Background styles. Can be "dark", "transparent" or "normal"
					sidebars = "transparent", -- style for sidebars, see below
					floats = "transparent", -- style for floating windows
				},
				on_colors = function(colors)
					colors.error = "#ff0000"
				end,
				-- Tüm yüzer pencere ve menü stillerini burada topluyoruz
				on_highlights = function(hl, c)
					-- 1. Kenarlıkların rengini DiagnosticInfo (Turkuaz/Mavi) yapıyoruz
					hl.FloatBorder = {
						fg = c.info, -- TokyoNight'ın mavi/turkuaz tonu
					}

					-- 2. Yüzer pencerelerin arka planını tam şeffaf yapıyoruz
					hl.NormalFloat = {
						bg = "none",
						fg = c.fg,
					}

					-- 3. nvim-cmp (tamamlama menüsü) iyileştirmeleri
					hl.Pmenu = { bg = "none" } -- Liste arka planı şeffaf
					hl.PmenuSel = { bg = c.bg_visual, fg = "none" } -- Seçili satır vurgusu

					-- 4. Teleskop ve diğer pencerelerin kenarlık tutarlılığı
					hl.TelescopeBorder = { fg = c.info }
					hl.TelescopeNormal = { bg = "none" }

					-- 5. Noice ve diğer eklentilerin kullandığı genel yüzer alanlar
					hl.NoiceCmdlinePopupBorder = { fg = c.info }
					hl.NoiceCmdlinePopup = { bg = "none" }
				end,
				plugins = {
					auto = true,
					-- add any plugins here that you want to enable
					-- for all possible plugins, see:
					--   * https://github.com/folke/tokyonight.nvim/tree/main/lua/tokyonight/groups
					-- telescope = true,
				},
			})
			vim.cmd("colorscheme tokyonight-night")
		end,
	},
}
