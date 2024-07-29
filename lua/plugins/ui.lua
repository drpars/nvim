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
    after = "catppuccin",
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      require("bufferline").setup {
        options = {
          style_preset = require("bufferline").style_preset.minimal, -- or bufferline.style_preset.minimal,
          separator_style = "any",                                   -- "slant" | "slope" | "thick" | "thin" | { 'any', 'any' },
          show_buffer_close_icons = false,
          sort_by = "insert_after_current",
          highlights = {
            require("catppuccin.groups.integrations.bufferline").get(),
            buffer_selected = {
              bold = true,
              italic = true,
            },
          },
          -- mode = "tabs",
          indicator = {
            -- icon = '▎', -- this should be omitted if indicator style is not 'icon'
            style = 'underline' -- 'icon' | 'underline' | 'none',
          },
          offsets = {
            {

              filetype = "NvimTree",
              text = function()
                return vim.fn.getcwd()
              end,
              highlight = "Directory",
              -- text_align = "left"
              -- filetype = "NvimTree",
              -- text = " File Explorer",
              -- highlight = "Directory",
              -- separator = false
            },
            {
              filetype = "neo-tree",
              -- text = " File Explorer",
              text = function()
                return vim.fn.getcwd()
              end,
              highlight = "Directory",
              separator = false
            },
          },
          hover = {
            enabled = true,
            delay = 200,
            reveal = { 'close' }
          },
        }
      }
      vim.g.transparent_groups = vim.list_extend(
        vim.g.transparent_groups or {},
        vim.tbl_map(function(v)
          return v.hl_group
        end, vim.tbl_values(require('bufferline.config').highlights))
      )
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    config = function()
      require("neo-tree").setup({
        enable_git_status = true,
        modified = {
          symbol = "[+]",
          highlight = "NeoTreeModified",
        },
        name = {
          trailing_slash = false,
          use_git_status_colors = true,
          highlight = "NeoTreeFileName",
        },
        buffers = {
          follow_current_file = {
            enabled = true,          -- This will find and focus the file in the active buffer every time
            --              -- the current file is changed while the tree is open.
            leave_dirs_open = true, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
          },
        },
        git_status = {
          symbols = {
            -- Change type
            added     = "✚", -- or "✚", but this is redundant info if you use git_status_colors on the name
            modified  = "", -- or "", but this is redundant info if you use git_status_colors on the name
            deleted   = "✖", -- this can only be used in the git_status source
            renamed   = "󰁕", -- this can only be used in the git_status source
            -- Status type
            untracked = "",
            ignored   = "",
            unstaged  = "󰄱",
            staged    = "",
            conflict  = "",
          }
        },
        symlink_target = {
          enabled = true,
        },
        filesystem = {
          filtered_items = {
            -- visible = true, -- when true, they will just be displayed differently than normal items
            hide_dotfiles = false,
          }
        },
      })
    end
  },
  {
    's1n7ax/nvim-window-picker',
    version = '2.*',
    config = function()
      require 'window-picker'.setup({
        filter_rules = {
          include_current_win = false,
          autoselect_one = true,
          -- filter using buffer options
          bo = {
            -- if the file type is one of following, the window will be ignored
            filetype = { 'neo-tree', "neo-tree-popup", "notify" },
            -- if the buffer type is one of following, the window will be ignored
            buftype = { 'terminal', "quickfix" },
          },
        },
      })
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
      require('neoscroll').setup({})
    end
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
    'xiyaowong/nvim-transparent',
    config = function()
      require("transparent").setup({
        groups = { -- table: default groups
          'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
          'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
          'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
          'SignColumn', 'CursorLine', 'CursorLineNr', 'StatusLine', 'StatusLineNC',
          'EndOfBuffer',
        },
        extra_groups = {     -- table: additional groups that should be cleared
          "NormalFloat",     -- plugins which have float panel such as Lazy, Mason, LspInfo
          "NvimTreeNormal"   -- NvimTree
        },
        exclude_groups = {}, -- table: groups you don't want to clear
      })
      require('transparent').clear_prefix('BufferLine')
      require('transparent').clear_prefix('lualine')
      require('transparent').clear_prefix('NeoTree')
      require('transparent').clear_prefix('nvim-tree')
    end
  },
  {
    "numToStr/FTerm.nvim",
    config = function()
      require 'FTerm'.setup({
        blend = 0,
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
      require('dashboard').setup {
        theme = 'doom', --  theme is doom and hyper default is hyper
        config = {
          header = {
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "▓█████▄  ██▀███   ██▓███   ▄▄▄       ██▀███    ██████ ",
            "▒██▀ ██▌▓██ ▒ ██▒▓██░  ██▒▒████▄    ▓██ ▒ ██▒▒██    ▒ ",
            "░██   █▌▓██ ░▄█ ▒▓██░ ██▓▒▒██  ▀█▄  ▓██ ░▄█ ▒░ ▓██▄   ",
            "░▓█▄   ▌▒██▀▀█▄  ▒██▄█▓▒ ▒░██▄▄▄▄██ ▒██▀▀█▄    ▒   ██▒",
            "░▒████▓ ░██▓ ▒██▒▒██▒ ░  ░ ▓█   ▓██▒░██▓ ▒██▒▒██████▒▒",
            " ▒▒▓  ▒ ░ ▒▓ ░▒▓░▒▓▒░ ░  ░ ▒▒   ▓▒█░░ ▒▓ ░▒▓░▒ ▒▓▒ ▒ ░",
            " ░ ▒  ▒   ░▒ ░ ▒░░▒ ░       ▒   ▒▒ ░  ░▒ ░ ▒░░ ░▒  ░ ░",
            " ░ ░  ░   ░░   ░ ░░         ░   ▒     ░░   ░ ░  ░  ░  ",
            "   ░       ░                    ░  ░   ░           ░  ",
            " ░                                                    ",
            "",
            "",
            "",
          },
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
