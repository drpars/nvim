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
keymap("n", "<C-h>", "<C-w>h", { desc = "Navigate Left" }, opts)
keymap("n", "<C-j>", "<C-w>j", { desc = "Navigate Down" }, opts)
keymap("n", "<C-k>", "<C-w>k", { desc = "Navigate Up" }, opts)
keymap("n", "<C-l>", "<C-w>l", { desc = "Navigate Right" }, opts)

-- Resize with arrows --
keymap("n", "<A-Up>", ":resize -2<cr>", { desc = "Resize Up" }, opts)
keymap("n", "<A-Down>", ":resize +2<cr>", { desc = "Resize Down" }, opts)
keymap("n", "<A-Left>", ":vertical resize -2<cr>", { desc = "Resize Left" }, opts)
keymap("n", "<A-Right>", ":vertical resize +2<cr>", { desc = "Resize Right" }, opts)

-- Navigate buffers --
keymap("n", "<S-l>", ":bnext<cr>", { desc = "Next Buffer" }, opts)
keymap("n", "<S-h>", ":bprevious<cr>", { desc = "Previous Buffer" }, opts)

-- Close buffers --
keymap("n", "<S-q>", "<cmd>Bdelete!<cr>", { desc = "Close Buffer" }, opts)

-- Clear Highlights --
keymap("n", "<leader>h", "<cmd>nohlsearch<cr>", { desc = "Remove Highlight Search" }, opts)

-- Colorizer --
keymap("n", "<leader>l", "<cmd>ColorizerToggle<cr>", { desc = "Colorizer" }, opts)

-- TransparentToggle --
keymap("n", "TT", ":TransparentToggle<cr>", { noremap = true, desc = "Make Transparent" })

-- Fterm --
keymap('n', '<C-x>f', '<cmd>lua require("FTerm").toggle()<cr>', { desc = "Open Float Term" }, opts)
keymap('t', '<C-x>f', '<C-\\><C-n><cmd>lua require("FTerm").toggle()<cr>', { desc = "Close Float Term" }, opts)

-- Windows Animation --
keymap("n", "<C-w>e", "<cmd>WindowsEqualize<cr>", { silent = true, noremap = true, desc = "Equalize current windows" })
keymap("n", "<C-w>m", "<cmd>WindowsMaximize<cr>", { silent = true, noremap = true, desc = "Maximize current window" })

-- With Leader --
-- Custom --
keymap("n", "<leader>n", "<cmd> tabnew<cr>", { desc = "New File" }, opts)
keymap("n", "<leader>,", "<cmd>Alpha<cr>", { desc = "Menu" }, opts)
keymap("n", "<leader>o", "<cmd>bd<cr>", { desc = "Back" }, opts)

-- e -- NvimTree --
keymap("n", "<leader>e", ":NvimTreeToggle<cr>", { desc = "Explorer" }, opts)

-- f -- Telescope --
keymap("n", "<leader>f", "<cmd>Telescope find_files<cr>", { desc = "Find Files" }, opts)
keymap("n", "<leader>fc", "<cmd>Telescope colorscheme<cr>", { desc = "Colorscheme" }, opts)
keymap("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Help" }, opts)
keymap("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help" }, opts)
keymap("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", { desc = "Keymaps" }, opts)
keymap("n", "<leader>fo", "<cmd>Telescope oldfiles<cr>", { desc = "Recent Files" }, opts)
-- f -- Telescope Git --
keymap("n", "<leader>fgs", "<cmd>Telescope git_status<cr>", { desc = "Telescope Git Status" }, opts)
keymap("n", "<leader>fgc", "<cmd>Telescope git_commits<cr>", { desc = "Telescope Git Commits" }, opts)
keymap("n", "<leader>fgb", "<cmd>Telescope git_branches<cr>", { desc = "Telescope Git Branches" }, opts)

-- g -- Git --
keymap("n", "<leader>g", "<cmd>G<cr>", { desc = "Git Fugitive" }, opts)
keymap("n", "<leader>gs", "<cmd>Git status<cr>", { desc = "Git Status" }, opts)
keymap("n", "<leader>gc", "<cmd>G commit<cr>", { desc = "Git Commit" }, opts)
keymap("n", "<leader>gp", "<cmd>G push<cr>", { desc = "Git Push" }, opts)
keymap("n", "<leader>gd", "<cmd>Gvdiffsplit<cr>", { desc = "Git Diff Vertical" }, opts)

-- t -- TroubleToggle --
keymap("n", "<leader>tt", "<cmd>TroubleToggle<cr>", { silent = true, noremap = true, desc = "Open Troubles" })
keymap("n", "<leader>tw", "<cmd>TroubleToggle workspace_diagnostics<cr>", { silent = true, noremap = true, desc = "Workspace Diagnostic" })
keymap("n", "<leader>td", "<cmd>TroubleToggle document_diagnostics<cr>", { silent = true, noremap = true, desc = "Document Diagnostic" })
keymap("n", "<leader>tl", "<cmd>TroubleToggle loclist<cr>", { silent = true, noremap = true, desc = "Trouble Locklist" })
keymap("n", "<leader>tq", "<cmd>TroubleToggle quickfix<cr>", { silent = true, noremap = true, desc = "Trouble Quickfix" })
keymap("n", "tR", "<cmd>TroubleToggle lsp_references<cr>", { silent = true, noremap = true, desc = "Lsp References" })

-- z -- Twilight & Zen Mode --
keymap("n", "<leader>zz", "<cmd>ZenMode<cr>", { desc = "Zen Mode" }, opts)
keymap("n", "<leader>zt", "<cmd>Twilight<cr>", { desc = "Twilight Mode" }, opts)

-- x -- Make Executable File --
keymap("n", "<leader>x", "<cmd>!chmod +x %<cr>", { silent = true, desc = "Make Executable" })
keymap("n", "<leader>rx", "<cmd>!chmod -x %<cr>", { silent = true, desc = "Remove Executable" })

-- Visual Mode --
-- Move Line --
keymap("v", "J", ":m '>+1<cr>gv=gv", { desc = "Move line or word" })
keymap("v", "K", ":m '<-2<cr>gv=gv", { desc = "Move line or word" })

-- Stay in Indent Mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

