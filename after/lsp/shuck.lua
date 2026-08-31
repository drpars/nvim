-- zsh için LSP. bashls `sh`/`bash` ile sınırlı (after/lsp/bashls.lua) ve zsh'i
-- almıyor; shuck zsh'i gerçekten ayrıştırıyor (0.1.3).
---@type vim.lsp.Config
return {
	-- lspconfig varsayılanı `bash`, `sh`, `zsh` veriyor — YALNIZ zsh'e
	-- daraltılıyor. Gerekçe 2026-08-31'de ölçüldü, tahmin değil: shuck sh/bash'i
	-- gerçekten destekliyor (dialect'ler sh, bash, dash, ksh, mksh, zsh) ama
	-- varsayılan kural kümesi 85 gerçek dosyada (11.441 satır) shellcheck'in ÖZ
	-- ALT KÜMESİ — 32 bulgunun 32'si shellcheck'in de işaretlediği satırda,
	-- 0 yeni bulgu; shellcheck 20 satır fazladan yakalıyor. Editörde ölçülen
	-- bedel aynı satıra ikinci işaret (statusline.sh 3 -> 5 tanı). Tanı dışı
	-- yüzeyde de kazanç yok: documentSymbol 27 ↔ 36, completion dört konumda
	-- yanıt yok/yanıt yok/40/0 ↔ 1/1/3317/4. `--select ALL` shellcheck'i
	-- kapsıyor ama +521 konumun çoğu Google stil ailesi, kalan C158/C159 ise bu
	-- korpusta kasıtlı global'leri işaretliyor. Ölçüm: pars/nvim/NOTLAR.md.
	filetypes = { "zsh" },

	-- Kural ayarı buradan gelmiyor, shuck/shuck.toml'dan. Sebebi ölçüldü
	-- (2026-08-28): `shuck server` `--config` bayrağını **yok sayıyor** — ne
	-- KEY=VALUE ne de dosya yolu biçimi tanıya işliyor (ikisi de 15 tanı), oysa
	-- aynı bayrak `shuck check`'te çalışıyor. Server yalnız dosya sisteminden
	-- keşfettiği ayarı okuyor, o yüzden ayar bir dosya ve yolu env ile veriliyor.
	-- XDG_CONFIG_HOME yerine SHUCK_CONFIG_HOME: ikisi de çalışıyor ama bu
	-- yalnız shuck'ın config kökünü taşıyor.
	cmd_env = {
		SHUCK_CONFIG_HOME = vim.fn.stdpath("config") .. "/shuck",
	},

	-- Biçimlendirme KAPALI. shuck format geçerli zsh üretiyor ama bindkey/setopt
	-- bloklarındaki elle yapılmış sütun hizalamasını eziyor (ölçüldü: .zshrc
	-- kopyasında 70 satır fark). Kapatılmazsa <F3> (vim.lsp.buf.format) onu
	-- çağırırdı — conform zsh'te LSP'ye düşmüyor, ama <F3> doğrudan LSP.
	on_attach = function(client)
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.documentRangeFormattingProvider = false
	end,
}
