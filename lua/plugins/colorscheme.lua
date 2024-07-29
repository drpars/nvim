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
        treesitter = true,
        treesitter_context = true,
      },
    },
    init = function()
      vim.cmd [[colorscheme catppuccin]]
    end
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    -- init = function()
    --   vim.cmd [[colorscheme tokyonight-night]]
    -- end
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
