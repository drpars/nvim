return {
  {
    "m4xshen/catppuccinight.nvim",
    lazy = true,
    name = "catppuccin",
    opts = {
      flavor = "mocha",
      integrations = {
        aerial = true,
        alpha = true,
        cmp = true,
        dashboard = true,
        gitsigns = true,
        headlines = true,
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
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
        neotest = true,
        neotree = true,
        noice = true,
        notify = true,
        semantic_tokens = true,
        telescope = true,
        treesitter = true,
        treesitter_context = true,
        which_key = true,
      },
    },
    -- init = function()
    --   vim.cmd [[colorscheme catppuccin]]
    -- end
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    init = function()
      vim.cmd [[colorscheme tokyonight-night]]
    end
  },
  {
    'dasupradyumna/midnight.nvim',
    lazy = false,
    priority = 1000,
    -- init = function()
    --   vim.cmd [[colorscheme midnight]]
    -- end
  }

}
