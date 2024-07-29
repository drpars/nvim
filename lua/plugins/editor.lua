return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.5',
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope-file-browser.nvim' },
      { 'nvim-telescope/telescope-fzf-native.nvim',  build = 'make' }
    },
    config = function()
      require('telescope').setup {
        defaults = {
          -- Default configuration for telescope goes here:
          -- config_key = value,
          mappings = {
          }
        },
        pickers = {
          find_files = {
            theme = "dropdown",
            layout_config = { width = 0.90 },
          },
          oldfiles = {
            theme = "dropdown",
            layout_config = { width = 0.90 },
          },
          live_grep = {
            theme = "dropdown",
            wrap_results = true,
            layout_config = { width = 0.90 },
          }
        },
        extensions = {
          file_browser = {
            theme = "dropdown",
            previewer = false,
            hidden = true,
            layout_strategy = "horizontal",
            layout_config = { prompt_position = "top", width = 0.90, height = 0.80 },
            sorting_strategy = "ascending",
            winblend = 0,
            -- disables netrw and use telescope-file-browser in its place
            hijack_netrw = true,
            mappings = {},
          },
          fzf = {
            fuzzy = true,                   -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true,    -- override the file sorter
            case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
          },
        },
      }
      require('telescope').load_extension('fzf')
      require('telescope').load_extension('file_browser')
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup {}
    end,
  },
  -- {
  --   'stevearc/oil.nvim',
  --   opts = {},
  --   -- Optional dependencies
  --   dependencies = { "nvim-tree/nvim-web-devicons" },
  --   keys = {
  --     { "-", function() require('oil').open_float() end },
  --     config = function()
  --       require("oil").setup()
  --     end,
  --   }
  -- },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require('gitsigns').setup {
        signs = {
          add          = { text = '✚' },
          change       = { text = '' },
          delete       = { text = '✖' },
          topdelete    = { text = '✖' },
          changedelete = { text = '~' },
          untracked    = { text = '' },
        },
      }
    end,
  },
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
      { 'gj', function() require 'splitjoin'.join() end,  desc = 'Join the object under cursor' },
      { 'g,', function() require 'splitjoin'.split() end, desc = 'Split the object under cursor' },
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
          "Trouble",
          "trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
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
          "Trouble",
          "trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
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
