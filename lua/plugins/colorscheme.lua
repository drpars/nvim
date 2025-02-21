return {
  {
    "m4xshen/catppuccinight.nvim",
    lazy = true,
    name = "catppuccin",
    opts = {
      flavor = "mocha",
      integrations = {
        cmp = true,
        dashboard = true,
        gitsigns = true,
        headlines = true,
        fidget = true,
        illuminate = true,
        indent_blankline = { enabled = true },
        leap = true,
        lsp_trouble = true,
        mason = true,
        markdown = true,
        mini = {
          enabled = true,
          indentscope_color = "",
        },
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { "italic" },
            hints = { "italic" },
            warnings = { "italic" },
            information = { "italic" },
            ok = { "italic" },
          },
          underlines = {
            errors = { "underline" },
            hints = { "underline" },
            warnings = { "underline" },
            information = { "underline" },
            ok = { "underline" },
          },
          inlay_hints = {
            background = true,
          },
        },
        neotree = true,
        noice = true,
        notify = true,
        semantic_tokens = true,
        telescope = {
          enabled = true,
          style = "nvchad"
        },
        treesitter = true,
        treesitter_context = true,
      },
      -- transparent_background = true,
    },
    init = function()
      vim.cmd [[colorscheme catppuccin]]
    end
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      -- transparent = false,
      -- styles = {
      --   sidebars = "transparent",
      --   floats = "transparent",
      -- },
    },
    -- init = function()
    --   vim.cmd [[colorscheme tokyonight]]
    -- end
  },
  {
    'dasupradyumna/midnight.nvim',
    lazy = false,
    priority = 1000,
    -- init = function()
    --   vim.cmd [[colorscheme midnight]]
    -- end
  },
  {
    "craftzdog/solarized-osaka.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = false,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        sidebars = "transparent",
        floats = "transparent",
      },
      lualine_bold = true, -- When `true`, section headers in the lualine theme will be bold
    },
    -- init = function()
    --   vim.cmd [[colorscheme solarized-osaka]]
    -- end
  },
  {
    "xiyaowong/nvim-transparent",
    config = function()
      require("transparent").setup({
        -- table: default groups
        groups = {
          'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
          'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
          'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
          'SignColumn', 'CursorLine', 'CursorLineNr', 'StatusLine', 'StatusLineNC',
          'EndOfBuffer',
        },
        -- table: additional groups that should be cleared
        extra_groups = {},
        -- table: groups you don't want to clear
        exclude_groups = {},
        -- function: code to be executed after highlight groups are cleared
        -- Also the user event "TransparentClear" will be triggered
        on_clear = function()
          require("transparent").clear_prefix("BufferLine")
          require("transparent").clear_prefix("NeoTree")
          -- require("transparent").clear_prefix("lualine")
          -- require('transparent').clear_prefix('nvim-tree')
        end,
      })
    end
  }
}
