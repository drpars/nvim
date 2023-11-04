return {
  {
    "goolord/alpha-nvim",
    config = function()
      require 'alpha'.setup(require 'settings.dashboard'.config)
    end,
  },
  {
    "m4xshen/catppuccinight.nvim",
    name = "catppuccin",
    opts = {
      flavour = "mocha",
      custom_highlights = function(colors)
        return {
          VertSplit = { fg = colors.surface0 },
        }
      end,
    },
    init = function()
      vim.cmd.colorscheme "catppuccin"
    end
  },
  {
    "norcalli/nvim-colorizer.lua",
    init = function()
      require('colorizer').setup()
    end,
  },
  -- Windows Animations --
  {
    "anuvyklack/windows.nvim",
    dependencies = {
      "anuvyklack/middleclass",
      "anuvyklack/animation.nvim"
    },
    config = function()
      vim.o.winwidth = 10
      vim.o.winminwidth = 10
      vim.o.equalalways = false
      require('windows').setup()
    end,
  },
  -- Twilight & Zen Modes --
  {
    "folke/twilight.nvim",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  },
  {
    "folke/zen-mode.nvim",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  },
  -- Transparency --
  {
    'xiyaowong/nvim-transparent'
  },
}
