return {
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },
  {
    'mg979/vim-visual-multi',
    branch = 'master',
  },
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  },
  {
    'bennypowers/splitjoin.nvim',
    lazy = true,
    keys = {
      { 'gk', function() require 'splitjoin'.join() end,  desc = 'Join the object under cursor' },
      { 'gj', function() require 'splitjoin'.split() end, desc = 'Split the object under cursor' },
    },
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      scope = { enabled = false },
      exclude = {
        filetypes = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "lazy",
          "mason",
          "notify",
          "lazyterm",
        },
      },
    }
  },
  {
    "echasnovski/mini.indentscope",
    version = false,
    opts = {
      symbol = "│",
      options = { try_as_border = true },
    },
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "NvimTree",
          "lazy",
          "mason",
          "notify",
          "lazyterm",
        },
        callback = function()
          ---@diagnostic disable-next-line
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  },
  {
    "norcalli/nvim-colorizer.lua",
    init = function()
      require('colorizer').setup()
    end,
  },
  {
    "eandrju/cellular-automaton.nvim"
  },
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
      plugins = {
        gitsigns = true,
      },
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  },
}
