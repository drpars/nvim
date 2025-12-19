local languages = {
	"bash",
	"c",
	"cpp",
	"css",
	"diff",
	"html",
	"hyprlang",
	"javascript",
	"jsdoc",
	"json",
	"jsonc",
	"lua",
	"luadoc",
	"luap",
	"prisma",
	"markdown",
	"markdown_inline",
	"python",
	"query",
	"regex",
	"toml",
	"tsx",
	"dockerfile",
	"gitignore",
	"typescript",
	"vim",
	"vimdoc",
	"yaml",
	"rasi",
}

return {
	-- 1. nvim-treesitter (Temel Eklenti)
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
	},

	-- 2. nvim-treesitter-context (Bağlam Eklentisi)
	{
		"nvim-treesitter/nvim-treesitter-context",
		event = "BufReadPost", -- Dosya okunduktan sonra yükle
		config = function()
			require("treesitter-context").setup({
				enable = false,
				max_lines = 0,
				min_rows = 10,
				zindex = 20,
				mode = "cursor",
			})
		end,
	},

	-- 3. MeanderingProgrammer/treesitter-modules.nvim (Yapılandırma Yöneticisi)
	{
		"MeanderingProgrammer/treesitter-modules.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function(_, opts)
			-- 1. Derleyici önceliğini nvim-treesitter'a bildiriyoruz
			require("nvim-treesitter.install").compilers = { "gcc", "clang", "zig" }

			-- 2. Eğer istersen kilit dosyasını (lockfile) atlayıp git kullanmaya zorlayabilirsin
			require("nvim-treesitter.install").prefer_git = true

			-- 3. Modülü 'opts' (ensure_installed vb.) ile başlatıyoruz
			require("treesitter-modules").setup(opts)
		end,

		opts = {
			-- A. Parser Kurulumu
			ensure_installed = languages,

			-- B. Temel Treesitter Modülleri (nvim-treesitter'ın kendi modülleri)
			highlight = { enable = true },
			indent = { enable = true },
			-- fold = { enable = true }, -- Kod katlama modülü - treesitter baz alıyor.
			context_commentstring = { enable = true }, -- Burası doğru konumdur

			-- C. Incremental Selection (Aşamalı Seçim)
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					scope_incremental = false,
					node_decremental = "<bs>",
				},
			},
		},
	},

	-- 4. nvim-ts-autotag
	{
		"windwp/nvim-ts-autotag",
		ft = { "html", "javascript", "typescript", "tsx", "jsx" },
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},
}
