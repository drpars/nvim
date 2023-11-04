require("nvim-treesitter.configs").setup({
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
  ensure_installed = {
    "bash",
    "lua",
    "cpp",
    "css",
    "python",
    "json",
    "vim",
    "regex",
    "markdown",
    "markdown_inline",
  },
  -- rainbow = {
  --   enable = true,
  --   disable = {},
  --   extended_mode = false,
  --   max_file_lines = nil,
  -- },
  autotag = { enable = true },
  incremental_selection = { enable = true },
  -- indent = { enable = true },
})
