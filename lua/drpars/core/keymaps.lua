local keymap = vim.keymap.set
local opts = { silent = true }

-----------------------------------------------------------
-- GENEL AYARLAR & MOD KONTROLÜ
-----------------------------------------------------------

-- Leader Tuşu: Space (Boşluk) tuşunu leader tuşu olarak ayarlar.
keymap("", "<Space>", "<Nop>", opts)

-- Arama Temizleme: i/n modunda ESC'ye basıldığında hem çıkış hem de arama vurgusunu temizleme.
keymap({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- Dosya Kaydetme: Tüm modlarda (i, x, n, s) Ctrl+S ile kaydetme.
keymap({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr>", { desc = "Save file" })

-- Yeniden Çizme/Arama Temizleme: Arama vurgusunu temizler ve pencereyi yeniden çizer.
keymap("n", "<leader>ur", "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>", { desc = "Redraw / clear hlsearch / diff update" })

-- Hepsini Seçme: ggVG yerine gg<S-v>G kullanımı.
keymap("n", "<C-a>", "gg<S-v>G", { desc = "Select All" })

-----------------------------------------------------------
-- PENCERE & BÖLME NAVİGASYONU (Normal Mod)
-----------------------------------------------------------

-- Windows Navigasyonu: Ctrl+h/j/k/l ile pencereler arasında geçiş.
keymap("n", "<C-h>", "<C-w>h", { desc = "Navigate Left" })
keymap("n", "<C-j>", "<C-w>j", { desc = "Navigate Down" })
keymap("n", "<C-k>", "<C-w>k", { desc = "Navigate Up" })
keymap("n", "<C-l>", "<C-w>l", { desc = "Navigate Right" })

-- Yatay Bölme: Yeni pencereyi yatay böler.
keymap("n", "ss", ":split<Return>", opts)

-- Dikey Bölme: Yeni pencereyi dikey böler.
keymap("n", "sv", ":vsplit<Return>", opts)

-- Boyutlandırma (Resize): Alt+Ok tuşlarıyla pencere boyutunu değiştirme.
keymap("n", "<A-Up>", ":resize +1<cr>", { desc = "Resize Up" })
keymap("n", "<A-Down>", ":resize -1<cr>", { desc = "Resize Down" })
keymap("n", "<A-Left>", ":vertical resize -1<cr>", { desc = "Resize Left" })
keymap("n", "<A-Right>", ":vertical resize +1<cr>", { desc = "Resize Right" })

-- Pencereleri Eşitleme: Açık pencerelerin boyutlarını eşitler.
keymap("n", "we", "<cmd>WindowsEqualize<cr>", { silent = true, noremap = true, desc = "Equalize current windows" })
keymap("n", "wm", "<cmd>WindowsMaximize<cr>", { silent = true, noremap = true, desc = "Maximize current window" })

-----------------------------------------------------------
-- BUFFER & DOSYA YÖNETİMİ
-----------------------------------------------------------

-- Buffer Navigasyonu: Shift+h/l ile buffer'lar arasında geçiş.
keymap("n", "<S-l>", ":bnext<cr>", { desc = "Next Buffer" })
keymap("n", "<S-h>", ":bprevious<cr>", { desc = "Previous Buffer" })

-- Buffer Kapatma: MiniBufremove kullanarak buffer'ı kapatma.
keymap("n", "<S-q>", "<cmd>lua MiniBufremove.delete()<cr>", { desc = "Close Buffer" })

-- Yeni Sekme: Leader+n ile yeni boş sekme açma.
keymap("n", "<leader>n", "<cmd> tabnew<cr>", { desc = "New File (Tab)" })

-- Buffer Silme: Leader+o ile mevcut buffer'ı silme.
-- keymap("n", "<leader>o", "<cmd>bd<cr>", { desc = "Close/Delete Buffer" })

-----------------------------------------------------------
-- SATIR TAŞIMA & VİSUAL MOD İŞLEMLERİ
-----------------------------------------------------------

-- Satır Taşıma (Normal Mod): Alt+j/k ile satırı yukarı/aşağı taşıma.
keymap("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
keymap("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })

-- Satır Taşıma (Insert Mod): Alt+j/k ile satırı yukarı/aşağı taşıma.
keymap("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
keymap("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })

-- Satır Taşıma (Visual Mod): Alt+j/k ile seçili bloğu yukarı/aşağı taşıma.
keymap("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
keymap("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- Girintide Kalma: Visual modda (< veya >) sonrası seçimi koruma.
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Yapıştırma Düzeltmesi (Visual Mod): Seçilen metni yapıştırırken, silinen metnin isimsiz kaydediciye yazılmasını engeller.
keymap("v", "p", '"_dP', { remap = false, desc = "Paste without overwriting yank register" })

-----------------------------------------------------------
-- ARAMA & EKLENTİ KISAYOLLARI
-----------------------------------------------------------

-- Lazy: Eklenti yöneticisini açar.
keymap("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- Dashboard: Başlangıç menüsünü açar.
keymap("n", ",", "<cmd>Dashboard<cr>", { desc = "Menu" })

-- Colorizer: Renk kodlarını vurgular/gizler.
keymap("n", "<leader>c", "<cmd>ColorizerToggle<cr>", { desc = "Colorizer Toggle" })

-- Fterm (Terminal): Yüzen terminali açar (Normal mod).
keymap("n", "<C-x>", '<cmd>lua require("FTerm").toggle()<cr>', { desc = "Open Float Term" })

-- Fterm (Terminal): Yüzen terminali kapatır (Terminal mod).
keymap("t", "<C-x>", '<C-\\><C-n><cmd>lua require("FTerm").toggle()<cr>', { desc = "Close Float Term" })

-- Markdown Preview: Markdown dosyasını tarayıcıda önizleme.
keymap("n", "<leader>m", "<cmd>MarkdownPreviewToggle<cr>", { desc = "Markdown Preview Toggle" })

-- Executable: Dosyayı çalıştırılabilir yapar (chmod +x).
keymap("n", "<leader>+", "<cmd>!chmod +x %<cr>", { silent = true, desc = "Make Executable" })

-- Executable: Dosyanın çalıştırılabilir özelliğini kaldırır (chmod -x).
keymap("n", "<leader>-", "<cmd>!chmod -x %<cr>", { silent = true, desc = "Remove Executable" })

-- ZEN & TWILIGHT MODLARI
keymap("n", "<leader>zz", "<cmd>ZenMode<cr>", { desc = "Zen Mode" })
keymap("n", "<leader>zt", "<cmd>Twilight<cr>", { desc = "Twilight Mode" })

-- NEOTREE (Dosya Gezgini)
keymap("n", "<leader>e", ":Neotree toggle<cr>", { desc = "Explorer Toggle" })
keymap("n", "_", ":Neotree current %:p:h:h %:p position=left toggle=true<cr>", { desc = "Explorer (Parent Dir)" })

-----------------------------------------------------------
-- TELESCOPE (Leader + f)
-----------------------------------------------------------

keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find Files" })
keymap("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Recent Files" })
keymap("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live Grep" })
keymap("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Buffers" })
keymap("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help" })
keymap("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", { desc = "Keymaps" })
keymap("n", "<leader>fy", "<cmd>Telescope yank_history<cr>", { desc = "Copy History" })
keymap("n", "fb", "<cmd>:Telescope file_browser path=%:p:h select_buffer=true<cr>", { desc = "Telescope File Browser" })

-- TELESCOPE GIT (Leader + t)
keymap("n", "<leader>ts", "<cmd>Telescope git_status<cr>", { desc = "Git Status" })
keymap("n", "<leader>tc", "<cmd>Telescope git_commits<cr>", { desc = "Git Commits" })
keymap("n", "<leader>tb", "<cmd>Telescope git_branches<cr>", { desc = "Git Branches" })

-----------------------------------------------------------
-- GIT (Leader + g)
-----------------------------------------------------------

keymap("n", "<leader>g", "<cmd>G<cr>", { desc = "Git Fugitive (Ana Pencere)" })
keymap("n", "<leader>gs", "<cmd>Git status<cr>", { desc = "Git Status" })
keymap("n", "<leader>gc", "<cmd>G commit<cr>", { desc = "Git Commit" })
keymap("n", "<leader>gp", "<cmd>G push<cr>", { desc = "Git Push" })
keymap("n", "<leader>gd", "<cmd>Gvdiffsplit<cr>", { desc = "Git Diff Vertical" })
