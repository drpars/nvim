return {
  {
    "tpope/vim-fugitive"
  },
  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    opts = {
      show_dirname = false,
      show_basename = false,
    },
  },
  {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      require("bufferline").setup {
        options = {
          separator_style = "slant",
          show_buffer_close_icons = false,
          sort_by = "insert_after_current",
          -- highlights = require("catppuccin.groups.integrations.bufferline").get()
          -- mode = "tabs",
          offsets = {
            {
              filetype = "NvimTree",
              text = " File Explorer",
              highlight = "Directory",
              separator = false
            }
          },
        }
      }
    end,
  },
  {
    "echasnovski/mini.bufremove",
    config = function()
      require('mini.bufremove').setup()
    end
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        icons_enabled = true,
        theme = "catppuccin",
        globalstatus = true,
      }
    },
    init = function()
      vim.opt.showmode = false
    end
  },
  {
    'j-hui/fidget.nvim',
    opt = {
    },
  },
  {
    'karb94/neoscroll.nvim',
    config = function()
      require('neoscroll').setup()
    end,
  },
  {
    "anuvyklack/windows.nvim",
    dependencies = {
      "anuvyklack/middleclass",
      "anuvyklack/animation.nvim"
    },
    config = function()
      vim.o.winwidth = 10
      vim.o.winminwidth = 10
      vim.o.equalalways = false
      require('windows').setup()
    end,
  },
  {
    'xiyaowong/nvim-transparent'
  },
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
        -- dimensions = {
        --   height = 0.9,
        --   width = 0.9,
        -- }
      })
    end,
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      views = {
        cmdline_popup = {
          position = {
            row = 5,
            col = "50%",
          },
          size = {
            width = 60,
            height = "auto",
          },
        },
        popupmenu = {
          relative = "editor",
          position = {
            row = 8,
            col = "50%",
          },
          size = {
            width = 60,
            height = 10,
          },
          border = {
            style = "rounded",
            padding = { 0, 1 },
          },
          win_options = {
            winhighlight = { Normal = "Normal", FloatBorder = "FloatBorder" },
          },
        },
      },
      routes = {
        {
          filter = {
            event = "notify",
            find = "No information available",
          },
          opts = { skip = true },
        },
        -- insert or visiual mode notification
        --   {
        --     view = "notify",
        --     filter = { event = "msg_showmode" },
        --   },
        --
      },
      lsp = {
        signature = {
          enabled = false,
        },
        hover = {
          enabled = false,
        },
        progress = {
          enabled = true,
        },
        -- override markdown rendering so that cmp and other plugins use Treesitter
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = true,         -- use a classic bottom cmdline for search
        command_palette = true,       -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false,           -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false,       -- add a border to hover docs and signature help
      },
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      { "MunifTanjim/nui.nvim" },
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      {
        "rcarriga/nvim-notify",
        opts = {
          timeout = 5000,
          background_colour = "#000000"
        },
      },
    }
  },
  {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    config = function()
      local logo = [[
            ▓█████▄  ██▀███   ██▓███   ▄▄▄       ██▀███    ██████             
            ▒██▀ ██▌▓██ ▒ ██▒▓██░  ██▒▒████▄    ▓██ ▒ ██▒▒██    ▒             
            ░██   █▌▓██ ░▄█ ▒▓██░ ██▓▒▒██  ▀█▄  ▓██ ░▄█ ▒░ ▓██▄               
            ░▓█▄   ▌▒██▀▀█▄  ▒██▄█▓▒ ▒░██▄▄▄▄██ ▒██▀▀█▄    ▒   ██▒            
            ░▒████▓ ░██▓ ▒██▒▒██▒ ░  ░ ▓█   ▓██▒░██▓ ▒██▒▒██████▒▒            
             ▒▒▓  ▒ ░ ▒▓ ░▒▓░▒▓▒░ ░  ░ ▒▒   ▓▒█░░ ▒▓ ░▒▓░▒ ▒▓▒ ▒ ░            
             ░ ▒  ▒   ░▒ ░ ▒░░▒ ░       ▒   ▒▒ ░  ░▒ ░ ▒░░ ░▒  ░ ░            
             ░ ░  ░   ░░   ░ ░░         ░   ▒     ░░   ░ ░  ░  ░              
               ░       ░                    ░  ░   ░           ░              
      ]]
      logo = string.rep("\n", 8) .. logo .. "\n\n"
      require('dashboard').setup {
        theme = 'doom', --  theme is doom and hyper default is hyper
        config = {
          header = vim.split(logo, "\n"),
          center = {
            { action = "Telescope find_files", desc = " Find file", icon = " ", key = "f", key_format = " %s" },
            { action = "ene | startinsert", desc = " New file", icon = " ", key = "n", key_format = " %s" },
            { action = "Telescope oldfiles", desc = " Recent files", icon = " ", key = "r", key_format = " %s" },
            { action = "Telescope live_grep", desc = " Find text", icon = " ", key = "g", key_format = " %s" },
            { action = "Telescope file_browser path=~/.config/nvim/lua/config", desc = " Config", icon = " ", key = "c", key_format = " %s" },
            { action = 'lua require("persistence").load()', desc = " Restore Session", icon = " ", key = "s", key_format = " %s" },
            { action = "Lazy", desc = " Lazy", icon = "󰒲 ", key = "l", key_format = " %s" },
            { action = "qa", desc = " Quit", icon = " ", key = "q", key_format = " %s" },
          },
        }, --  config used for theme
        hide = {
        },
        preview = {
        },
      }
    end,
  }
}
