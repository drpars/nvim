-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{
		-- nvim-treesitter'ın Erken Yüklenmesi ZORUNLUDUR (API sorunlarını önlemek için)
		{
			"nvim-treesitter/nvim-treesitter",
			lazy = false,
			build = ":TSUpdate",
		},

		-- Diğer Treesitter Bağımlıları
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
					enable = true,
					max_lines = 0,
					min_rows = 10,
					zindex = 20,
					mode = "cursor",
				})
			end,
		},
  },

	spec = {
		{ import = "drpars.plugins" } , { import = "drpars.plugins.lsp" },
	},
	ui = { border = "rounded" },
	checker = { enabled = true, notify = false },
	change_detection = { notify = false },
})

-- KRİTİK ÇAĞRI: Treesitter konfigürasyonunu yükle (lua/drpars/treesitter_config.lua dosyasını tetikler)
require("drpars.treesitter")
