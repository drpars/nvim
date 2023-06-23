return {
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    opts = {
      open_mapping = [[<c-x>]],
      shade_terminals = false
    }
  },
  {
    "numToStr/FTerm.nvim",
    config = function()
      require 'FTerm'.setup({
        blend = 18,
        dimensions = {
        }
      })
    end,
  },
}
