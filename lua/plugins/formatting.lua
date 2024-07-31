return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        -- Customize or remove this keymap to your liking
        "<leader>f",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        mode = "",
        desc = "Format buffer",
      },
    },
    -- Everything in opts will be passed to setup()
    opts = {
      -- Define your formatters
      -- :help conform-formatters
      formatters_by_ft = {
        lua = { "stylua" },
        sh = { "shfmt" },
        json = { "prettier" },
        css = { "prettier" },
        python = { "isort", "black" },
      },
      -- Set up format-on-save
      -- format_on_save = { timeout_ms = 500, lsp_fallback = true },
      -- Customize formatters
      formatters = {
        shfmt = {
          prepend_args = { "-i", "2" },
        },
        black = {
          prepend_args = { "--fast" },
        },
      },
    },
    config = function()
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*",
        callback = function(args)
          require("conform").format({ bufnr = args.buf })
        end,
      })
    end,
    -- init = function()
    -- 	-- If you want the formatexpr, here is the place to set it
    -- 	vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    -- end,
  },
}
