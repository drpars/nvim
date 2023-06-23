require("bufferline").setup {
  options = {
    separator_style = "slant",
    -- mode = "tabs",
    offsets = {
      {
        filetype = "NvimTree",
        text = " File Explorer",
        highlight = "Directory",
        separator = false
      }
    },
    sort_by = "insert_after_current",
    -- highlights = require("catppuccin.groups.integrations.bufferline").get()
  }
}
