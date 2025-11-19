local options = {
	number = true,
	relativenumber = true,
	numberwidth = 4,
	ignorecase = true,
	smartcase = true,

	autoindent = true,
	smartindent = true,
	tabstop = 2,
	shiftwidth = 2,
	expandtab = true,
	showtabline = 0,
	showmatch = true,

	splitbelow = true,
	splitright = true,

	termguicolors = true,
	hidden = true,
	cursorline = true,
	fileencoding = "utf-8",

	backup = false,
	writebackup = false,
	swapfile = false,

	signcolumn = "yes",
	updatetime = 20,
	scrolloff = 15,
	mouse = "a",

	clipboard = "unnamedplus",

	spell = false,
	spelllang = { "en_us" },
}

for option, value in pairs(options) do
	vim.opt[option] = value
end

vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.pumblend = 0
vim.opt.winblend = 0

local winyank = function()
	-- İndirme URL'sini burada tanımlıyoruz
	local WGET_URL = "https://github.com/equalsraf/win32yank/releases/download/v0.1.1/win32yank-x64.zip"
	local HEDEF_DIZIN = vim.fn.stdpath("data") .. "/win32yank/" -- İndirme ve çıkarma için geçici dizin
	local FINAL_PATH = vim.fn.expand("~/.local/bin/win32yank.exe") -- win32yank.exe'nin beklenen nihai yolu
	local PATH_BIN = vim.fn.expand("~/.local/bin/") -- Kopyalanacak dizin

	if vim.fn.has("wsl") == 1 then
		-- 1. Yolu kontrol et: win32yank.exe mevcut mu?
		if vim.fn.filereadable(FINAL_PATH) == 1 then
			-- DOSYA MEVCUT: Clipboard'u ayarla.
			vim.g.clipboard = {
				name = "win32yank-wsl",
				copy = {
					["+"] = "win32yank.exe -i --crlf",
					["*"] = "win32yank.exe -i --crlf",
				},
				paste = {
					["+"] = "win32yank.exe -o --lf",
					["*"] = "win32yank.exe -o --lf",
				},
				cache_enabled = false,
			}
		else
			-- DOSYA MEVCUT DEĞİL: Kurulumu otomatik yap.
			vim.notify("win32yank.exe bulunamadı. Otomatik kurulum başlatılıyor...", vim.log.levels.INFO)
			-- Dizinin varlığını kontrol et ve oluştur
			if vim.fn.isdirectory(PATH_BIN) == 0 then
				vim.fn.mkdir(PATH_BIN, "p")
			end
			-- Geçici dizini oluştur
			vim.fn.mkdir(HEDEF_DIZIN, "p")
			-- İndirme, çıkarma ve kopyalama komutlarını oluştur ve çalıştır.
			-- wget, unzip ve mv (veya cp) komutları gereklidir.
			local komut = string.format(
				[[
                cd %s && \
                wget -O win32yank.zip %s && \
                unzip -o win32yank.zip && \
                mv win32yank.exe %s \
                chmod +x %s
            ]],
				HEDEF_DIZIN,
				WGET_URL,
				PATH_BIN
			)
			-- Komutu çalıştır (vim.fn.system kullanmak daha güvenlidir)
			local sonuc = vim.fn.system(komut)
			-- Hata kontrolü
			if vim.v.shell_error ~= 0 then
				vim.notify("win32yank kurulumunda HATA oluştu. Çıktı: " .. sonuc, vim.log.levels.ERROR)
			else
				vim.notify("win32yank başarıyla kuruldu ve kopyalandı.", vim.log.levels.INFO)
				-- Kurulum başarılıysa, clipboard'u ayarla
				vim.g.clipboard = {
					name = "win32yank-wsl",
					copy = { ["+"] = "win32yank.exe -i --crlf", ["*"] = "win32yank.exe -i --crlf" },
					paste = { ["+"] = "win32yank.exe -o --lf", ["*"] = "win32yank.exe -o --lf" },
					cache_enabled = false,
				}
			end
			-- Geçici dizini temizle
			vim.fn.delete(HEDEF_DIZIN, "rf")
		end
	end
end

if vim.fn.has("wsl") == 1 then
	winyank()
end
