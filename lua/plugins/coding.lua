return {
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    lazy = true,
    config = false,
    init = function()
      local lsp_zero = require('lsp-zero')
      local mason = require('mason')
      local cmp = require('cmp')
      local cmp_action = require('lsp-zero').cmp_action()
      -- local cmp_format = require('lsp-zero').cmp_format()

      ---@diagnostic disable:unused-local
      lsp_zero.extend_lspconfig()
      lsp_zero.on_attach(function(client, bufnr)
        -- see :help lsp-zero-keybindings
        -- to learn the available actions
        lsp_zero.default_keymaps({ buffer = bufnr })
      end)

      mason.setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
          }
        }
      })
      require('mason-lspconfig').setup({
        ensure_installed = {
          "lua_ls",
          "bashls",
          "clangd",
          "pyright"
        },
        handlers = {
          lsp_zero.default_setup,
        },
      })

      require('luasnip.loaders.from_vscode').lazy_load()
      cmp.setup({
        sources = {
          { name = 'nvim_lsp' },
          { name = 'buffer' },
          { name = "luasnip" },
          { name = 'path' },
          { name = 'nvim_lua' },
        },
        --- (Optional) Show source name in completion menu
        --formatting = cmp_format,
        formatting = {
          fields = { 'abbr', 'kind', 'menu' },
          format = require('lspkind').cmp_format({
            mode = 'symbol_text', -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
            maxwidth = 50,   -- prevent the popup from showing more than provided characters
            ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead
          })
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          -- `Enter` key to confirm completion
          ['<CR>'] = cmp.mapping.confirm({ select = true }),

          -- Ctrl+Space to trigger completion menu
          ['<C-Space>'] = cmp.mapping.complete(),

          -- Navigate between snippet placeholder
          ['<C-f>'] = cmp_action.luasnip_jump_forward(),
          ['<C-b>'] = cmp_action.luasnip_jump_backward(),

          -- Scroll up and down in the completion documentation
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),

          ['<Tab>'] = cmp_action.tab_complete(),
          ['<S-Tab>'] = cmp_action.select_prev_or_fallback(),
        })
      })

      -- :help lspconfig-all
      -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#configurations
      require('lspconfig').lua_ls.setup({})
      require('lspconfig').bashls.setup({})
      require('lspconfig').clangd.setup({})
      require('lspconfig').pyright.setup({})
      lsp_zero.setup_servers({ 'lua_ls', 'bashls', 'clangd', 'pyright' })
    end
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp' },
    }
  },
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },
  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      { 'L3MON4D3/LuaSnip' }
    },
  },
  { "hrsh7th/cmp-buffer" },
  { 'hrsh7th/cmp-path' },
  { "saadparwaiz1/cmp_luasnip" },
  { "rafamadriz/friendly-snippets" },
  { "hrsh7th/cmp-nvim-lua" },
  { "onsails/lspkind.nvim" },
  -- Diagnostic
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  }
}
