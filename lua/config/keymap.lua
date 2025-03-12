-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true }

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)

-- Modes --
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal Mode --
-- Windows Navigation --
keymap("n", "<C-h>", "<C-w>h", { desc = "Navigate Left" })
keymap("n", "<C-j>", "<C-w>j", { desc = "Navigate Down" })
keymap("n", "<C-k>", "<C-w>k", { desc = "Navigate Up" })
keymap("n", "<C-l>", "<C-w>l", { desc = "Navigate Right" })

-- Resize with arrows --
keymap("n", "<A-Up>", ":resize -1<cr>", { desc = "Resize Up" })
keymap("n", "<A-Down>", ":resize +1<cr>", { desc = "Resize Down" })
keymap("n", "<A-Left>", ":vertical resize -1<cr>", { desc = "Resize Left" })
keymap("n", "<A-Right>", ":vertical resize +1<cr>", { desc = "Resize Right" })

-- Navigate buffers --
keymap("n", "<S-l>", ":bnext<cr>", { desc = "Next Buffer" })
keymap("n", "<S-h>", ":bprevious<cr>", { desc = "Previous Buffer" })
keymap("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })

-- Close buffers --
keymap("n", "<S-q>", "<cmd>lua MiniBufremove.delete()<cr>", { desc = "Close Buffer" })

-- Clear Search --
keymap({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- Clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
keymap("n", "<leader>ur", "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>", { desc = "Redraw / clear hlsearch / diff update" })

-- save file
keymap({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- Select all
keymap("n", "<C-a>", "gg<S-v>G")

-- Split window
keymap("n", "ss", ":split<Return>", opts)
keymap("n", "sv", ":vsplit<Return>", opts)

-- lazy
keymap("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- Colorizer --
keymap("n", "<leader>c", "<cmd>ColorizerToggle<cr>", { desc = "Colorizer" })

-- Fterm --
keymap("n", "<C-x>", '<cmd>lua require("FTerm").toggle()<cr>', { desc = "Open Float Term" })
keymap("t", "<C-x>", '<C-\\><C-n><cmd>lua require("FTerm").toggle()<cr>', { desc = "Close Float Term" })

-- Windows Animation --
keymap("n", "we", "<cmd>WindowsEqualize<cr>", { silent = true, noremap = true, desc = "Equalize current windows" })
keymap("n", "wm", "<cmd>WindowsMaximize<cr>", { silent = true, noremap = true, desc = "Maximize current window" })

-- With Leader --
-- Custom --
keymap("n", "<leader>n", "<cmd> tabnew<cr>", { desc = "New File" })
keymap("n", ",", "<cmd>Dashboard<cr>", { desc = "Menu" })
keymap("n", "<leader>o", "<cmd>bd<cr>", { desc = "Back" })

-- -- e -- Neotree --
keymap("n", "<leader>e", ":Neotree toggle<cr>", { desc = "Explorer" })
keymap("n", "-", ":Neotree current %:p:h:h %:p position=left toggle=true<cr>", { desc = "Explorer" })

-- ff -- Telescope --
keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find Files" })
keymap("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Recent Files" })
keymap("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live Grep" })
keymap("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Buffers" })
keymap("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help" })
keymap("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", { desc = "Keymaps" })
-- f -- Telescope Git --
keymap("n", "<leader>ts", "<cmd>Telescope git_status<cr>", { desc = "Telescope Git Status" })
keymap("n", "<leader>tc", "<cmd>Telescope git_commits<cr>", { desc = "Telescope Git Commits" })
keymap("n", "<leader>tb", "<cmd>Telescope git_branches<cr>", { desc = "Telescope Git Branches" })
-- fb --Telescope file browser
keymap("n", "fb", "<cmd>:Telescope file_browser path=%:p:h select_buffer=true<cr>", { desc = "Telescope File Browser" })

-- g -- Git --
keymap("n", "<leader>g", "<cmd>G<cr>", { desc = "Git Fugitive" })
keymap("n", "<leader>gs", "<cmd>Git status<cr>", { desc = "Git Status" })
keymap("n", "<leader>gc", "<cmd>G commit<cr>", { desc = "Git Commit" })
keymap("n", "<leader>gp", "<cmd>G push<cr>", { desc = "Git Push" })
keymap("n", "<leader>gd", "<cmd>Gvdiffsplit<cr>", { desc = "Git Diff Vertical" })

keymap("n", "<leader>m", "<cmd>MarkdownPreviewToggle<cr>", { desc = "Markdown Preview Toggle" })

-- z -- Twilight & Zen Mode --
keymap("n", "<leader>zz", "<cmd>ZenMode<cr>", { desc = "Zen Mode" })
keymap("n", "<leader>zt", "<cmd>Twilight<cr>", { desc = "Twilight Mode" })

-- x -- Make Executable File --
keymap("n", "<leader>x", "<cmd>!chmod +x %<cr>", { silent = true, desc = "Make Executable" })
keymap("n", "<leader>rx", "<cmd>!chmod -x %<cr>", { silent = true, desc = "Remove Executable" })

-- Visual Mode --
-- Move Line --
keymap("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
keymap("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
keymap("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
keymap("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
keymap("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
keymap("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })
-- Stay in Indent Mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)
