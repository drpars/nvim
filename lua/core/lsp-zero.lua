local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({ buffer = bufnr })
end)

lsp.format_mapping('<leader>rf', {
  format_opts = {
    async = false,
    timeout_ms = 10000,
  },
  servers = {
    ['lua_ls'] = { 'lua' },
    ['null-ls'] = { 'sh' },
    -- if you have a working setup with null-ls
    -- you can specify filetypes it can format.
    -- ['null-ls'] = {'javascript', 'typescript'},
  }
})

lsp.ensure_installed({
  -- Replace these with whatever servers you want to install
  'bashls',
  'lua_ls',
  'pyright'
})

require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

lsp.setup()

local mason_null_ls = require("mason-null-ls")

mason_null_ls.setup({
  ensure_installed = {
    -- Opt to list sources here, when available in mason.
    "shfmt",
    "prettierd",
  },
  automatic_installation = false,
  handlers = {},
})

local null_ls = require('null-ls')
-- local formatting = null_ls.builtins.formatting

null_ls.setup({
  debug = false,
  sources = {
    -- Anything not supported by mason.
    null_ls.builtins.code_actions.gitsigns,
  }
})

-- Lspkind
local lspkind = require("lspkind")
local cmp = require("cmp")
cmp.setup({
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  -- enabled = function()
  --   -- disable completion in comments
  --   local context = require 'cmp.config.context'
  --
  --   -- keep command mode completion enabled
  --   if vim.api.nvim_get_mode().mode == 'c' then
  --     return true
  --   else
  --     return not context.in_treesitter_capture("comment")
  --         and not context.in_syntax_group("Comment")
  --   end
  -- end,
  formatting = {
    format = lspkind.cmp_format({
      mode = "symbol_text",
      maxwidth = 50,
      ellipsis_char = '...',
    }),
  }
})
-- cmp.setup.cmdline({ "/" }, {
--   mapping = cmp.mapping.preset.cmdline(),
--   sources = {
--     { name = "buffer" }
--   }
-- })

-- cmp.setup.cmdline(":", {
--   mapping = cmp.mapping.preset.cmdline(),
--   sources = cmp.config.sources({ { name = "path" } },
--     { { name = "cmdline" } })
-- })
