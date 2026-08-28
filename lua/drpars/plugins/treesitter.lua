-- Treesitter motoru Neovim 0.12'de gömülü (vim.treesitter.*); nvim-treesitter'ın
-- ARŞİVLENEN dalı `master` (2025-05-24), `main` ise etkin ve tek işi gramer +
-- sorgu dosyalarını dağıtmak. Vurgulama üç parça istiyor ve nvim yalnız motoru
-- veriyor: parser + queries/<dil>/highlights.scm + vim.treesitter.start().
-- Gömülü gelen parser'lar yalnız c/lua/markdown/vim/vimdoc/query; geri kalan her
-- dil (python dahil) buradan kurulmazsa treesitter'sız kalır — vurgulama eski
-- regex syntax'ına düşer, get_node() nil döner, treesj ve SmartSelection sessizce
-- hiçbir şey yapmaz.
-- SmartSelection lua/drpars/treesitter.lua'da tanımlı.

-- yuck bilerek listede yok: parser'ı ve sorguları tree-sitter-yuck eklentisinden
-- geliyor. jsonc de yok — ayrı gramer değil, filetype olarak json'a eşleniyor.
local diller = {
	"bash",
	"c",
	"css",
	"diff",
	"git_config",
	"gitcommit",
	"gitignore",
	"go",
	"graphql",
	"html",
	"hyprlang",
	"javascript",
	"json",
	"lua",
	"luadoc",
	"markdown",
	"markdown_inline",
	"python",
	"query",
	"regex",
	"rust",
	"scss",
	"svelte",
	"toml",
	"tsx",
	"typescript",
	"vim",
	"vimdoc",
	"yaml",
}

return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false, -- eklenti lazy-load'u desteklemiyor (README)
		build = ":TSUpdate",
		config = function()
			local nts = require("nvim-treesitter")

			-- Taze klonda eksikleri kur; hepsi kuruluysa hiçbir şey yapmaz.
			local kurulu = {}
			for _, l in ipairs(nts.get_installed()) do
				kurulu[l] = true
			end
			local eksik = vim.tbl_filter(function(l)
				return not kurulu[l]
			end, diller)
			if #eksik > 0 then
				nts.install(eksik)
			end

			-- Vurgulamayı başlatan parça. nvim bunu kendiliğinden yapmıyor; gömülü
			-- diller için runtime/ftplugin/{lua,markdown,help,query}.lua yapıyor,
			-- geri kalan her dil için buradaki autocmd.
			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("drpars_treesitter", { clear = true }),
				callback = function(ev)
					local lang = vim.treesitter.language.get_lang(ev.match)
					-- language.add parser yüklenebiliyorsa true, yoksa nil döner:
					-- parser'ı olmayan filetype'larda (neo-tree, dashboard) sessiz kalır.
					if lang and vim.treesitter.language.add(lang) then
						pcall(vim.treesitter.start, ev.buf, lang)
					end
				end,
			})
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		ft = { "html", "javascript", "typescript", "tsx", "jsx" },
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		event = "BufReadPost",
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
}
