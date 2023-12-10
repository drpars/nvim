return {
  {
    {
      'VonHeikemen/lsp-zero.nvim',
      branch = 'v3.x',
      lazy = true,
      config = false,
      init = function()
        -- Disable automatic setup, we are doing it manually
        vim.g.lsp_zero_extend_cmp = 0
        vim.g.lsp_zero_extend_lspconfig = 0
      end,
    },
    {
      'williamboman/mason.nvim',
      lazy = false,
      config = true,
    },
    {
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      config = function()
        local mason_tool_installer = require("mason-tool-installer")
        mason_tool_installer.setup({
          ensure_installed = {
            "shfmt",
            "clang-format",
          },
        })
      end
    },

    -- Autocompletion
    {
      'hrsh7th/nvim-cmp',
      event = 'InsertEnter',
      dependencies = {
        {
          'L3MON4D3/LuaSnip',
          build = (not jit.os:find("Windows"))
              and "echo 'NOTE: jsregexp is optional, so not a big deal if it fails to build'; make install_jsregexp"
              or nil,
          dependencies = {
            "rafamadriz/friendly-snippets",
            config = function()
              require("luasnip.loaders.from_vscode").lazy_load()
            end,
          },
          opts = {
            history = true,
            delete_check_events = "TextChanged",
          },
        },
        { "hrsh7th/cmp-buffer" },
        { 'hrsh7th/cmp-path' },
        { "saadparwaiz1/cmp_luasnip" },

      },
      config = function()
        -- Here is where you configure the autocompletion settings.
        local lsp_zero = require('lsp-zero')
        lsp_zero.extend_cmp()

        -- Format buffer with F3
        -- lsp_zero.on_attach(function(client, bufnr)
        --   lsp_zero.default_keymaps({ buffer = bufnr })
        --   local opts = { buffer = bufnr }
        --
        --   vim.keymap.set({ 'n', 'x' }, '<F3>', function()
        --     vim.lsp.buf.format({ async = false, timeout_ms = 10000 })
        --   end, opts)
        -- end)

        -- And you can configure cmp even more, if you want to.
        local cmp = require('cmp')
        local cmp_action = lsp_zero.cmp_action()

        cmp.setup({
          sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = "luasnip" },
            { name = 'path' },
            { name = "buffer" },
          }),
          formatting = lsp_zero.cmp_format(),
          mapping = cmp.mapping.preset.insert({
            ['<C-Space>'] = cmp.mapping.complete(),
          })
        })
      end
    },

    -- LSP
    {
      'neovim/nvim-lspconfig',
      cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
      event = { 'BufWritePost', 'BufReadPre', 'BufReadPost', 'InsertLeave', 'BufNewFile' },
      dependencies = {
        {
          "folke/neoconf.nvim",
          cmd = "Neoconf",
          config = false,
        },
        {
          "folke/neodev.nvim",
          opts = {}
        },
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'williamboman/mason-lspconfig.nvim' },
      },
      config = function()
        -- This is where all the LSP shenanigans will live
        local lsp_zero = require('lsp-zero')
        lsp_zero.extend_lspconfig()

        -- import mason
        local mason = require("mason")

        lsp_zero.on_attach(function(client, bufnr)
          -- see :help lsp-zero-keybindings
          -- to learn the available actions
          lsp_zero.default_keymaps({ buffer = bufnr })
        end)

        require('mason-lspconfig').setup({
          ensure_installed = { "lua_ls", "bashls", "clangd", "pyright" },
          handlers = {
            lsp_zero.default_setup,
            lua_ls = function()
              -- (Optional) Configure lua language server for neovim
              local lua_opts = lsp_zero.nvim_lua_ls()
              require('lspconfig').lua_ls.setup(lua_opts)
            end,
          }
        })

        -- enable mason and configure icons
        mason.setup({
          ui = {
            icons = {
              package_installed = "✓",
              package_pending = "➜",
              package_uninstalled = "✗",
            },
          },
        })
      end
    }
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },
}
