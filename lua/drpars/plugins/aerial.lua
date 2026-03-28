return {
	{
		"stevearc/aerial.nvim",
		opts = {},
		-- Optional dependencies
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
			"ibhagwan/fzf-lua",
		},
		config = function()
			require("aerial").setup({})

			-- Tüm fzf-lua picker çağrıları için ortak ayarlar ve fzf argümanlarını tanımlar
			local base_fzf_config = {
				fzf_opts = {
					-- PROMPT'U ÜSTE ALAN DOĞRU AYAR
					["--layout"] = "reverse",
				},
				winopts = {
					border = "rounded",
				},
			}

			-- Yardımcı fonksiyon: Bir profil adı alır ve base_fzf_config ile birleştirir
			local function setup_aerial_picker(profile_name, custom_opts)
				local opts = vim.tbl_deep_extend("force", {}, base_fzf_config)

				if profile_name then
					opts.profile = profile_name
				end

				if custom_opts then
					-- Yeni winopts ve diğer ayarları, base config üzerine yazar
					opts = vim.tbl_deep_extend("force", opts, custom_opts)
				end

				require("aerial").fzf_lua_picker(opts)
			end

			-----------------------------------------------------------
			-- KISAYOL ATAMALARI
			-----------------------------------------------------------

			-- 1. Ivy profile
			vim.keymap.set("n", "<leader>aa", function()
				setup_aerial_picker("ivy", {
					winopts = {
						height = 0.70,
						-- border zaten base_fzf_config'de tanımlı.
						preview = {
							border = "rounded",
							hidden = false,
							-- layout = "horizontal",
						},
					},
				})
			end, { desc = "FZF Aerial Picker (Ivy Style)" })

			-- 2. Default profile
			vim.keymap.set("n", "<leader>ad", function()
				-- Profile yok, sadece base config kullanılır (reverse düzeni içerir)
				setup_aerial_picker(nil, {})
			end, { desc = "FZF Aerial Picker (Default Settings)" })

			-- 3. max-perf profile Floating mode
			vim.keymap.set("n", "<leader>af", function()
				setup_aerial_picker("max-perf", {
					winopts = {
						height = 0.40,
						width = 0.35,
						preview = {
							border = "rounded",
							hidden = true,
							layout = "horizontal",
						},
					},
				})
			end, { desc = "FZF Aerial Picker (Floating Style)" })
		end,
	},
}
