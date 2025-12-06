local opt = vim.opt

-----------------------------------------------------------
-- GENEL DAVRANIŞ
-----------------------------------------------------------

vim.g.mapleader = " "                       -- Leader Tuşu: Kısayol ön ekini Boşluk tuşu olarak ayarlar.
vim.cmd("let g:netrw_liststyle = 3")        -- Netrw: Dahili dosya gezginini ağaç görünümünde (3) gösterir.

-----------------------------------------------------------
-- SATIR NUMARALARI & GÖRÜNÜM
-----------------------------------------------------------

opt.number = true                           -- Mutlak Satır Numarası: Satır numarasını gösterir.
opt.relativenumber = true                   -- Göreceli Satır Numarası: Aktif satıra göre uzaklığı gösterir (hızlı hareket).
opt.cursorline = true                       -- İmleç Satırı: İmlecin bulunduğu satırı vurgular.
opt.signcolumn = "yes"                      -- İşaret Sütunu: Hata/Git işaret sütununu her zaman görünür tutar.
opt.wrap = false                            -- Satır Kaydırma: Uzun satırların kaydırılmasını (wrap) engeller.
opt.scrolloff = 15                          -- Kenar Boşluğu: İmleç hareket ederken ekranın üst ve altında 15 satır boşluk bırakır.

-----------------------------------------------------------
-- SEKME & GİRİNTİ AYARLARI
-----------------------------------------------------------

opt.tabstop = 2                             -- Sekme Genişliği: Bir sekme için 2 boşluk kullanır.
opt.shiftwidth = 2                          -- Girinti Genişliği: Otomatik girinti için 2 boşluk kullanır.
opt.expandtab = true                        -- Sekmeleri Boşluğa Çevirme: Sekmeleri boşluk karakterine dönüştürür.
opt.autoindent = true                       -- Otomatik Girinti: Yeni satıra geçerken önceki satırın girintisini kopyalar.

-----------------------------------------------------------
-- ARAMA AYARLARI
-----------------------------------------------------------

opt.ignorecase = true                       -- Harf Büyüklüğünü Yok Sayma: Aramada büyük/küçük harf ayrımı yapmaz.
opt.smartcase = true                        -- Akıllı Harf Büyüklüğü: Arama teriminde büyük harf varsa, harfe duyarlı arar.

-----------------------------------------------------------
-- RENKLER & SİSTEM ENTEGRASYONU
-----------------------------------------------------------

opt.termguicolors = true                    -- True Color Desteği: 24-bit renklerin (temaların) doğru çalışması için açılır.
opt.background = "dark"                     -- Arkaplan Rengi: Koyu arkaplan temalarını tercih eder.
opt.clipboard:append("unnamedplus")         -- Sistem Panosu: Kopyalama/yapıştırma işlemlerini sistem panosuyla senkronize eder.

-----------------------------------------------------------
-- DOSYA YÖNETİMİ & PENCERE AYARLARI
-----------------------------------------------------------

opt.swapfile = false                        -- Takas Dosyası: Takas (swap) dosyaları oluşturulmasını devre dışı bırakır.
opt.backup = false                          -- Yedek Dosyası: Yedek dosyası oluşturulmasını devre dışı bırakır.
opt.writebackup = false                     -- Yazma Yedeklemesi: Dosya yazılırken geçici yedek oluşturulmasını devre dışı bırakır.
opt.splitright = true                       -- Dikey Bölme: Dikey bölünmüş pencerelerin sağa açılmasını sağlar.
opt.splitbelow = true                       -- Yatay Bölme: Yatay bölünmüş pencerelerin alta açılmasını sağlar.
