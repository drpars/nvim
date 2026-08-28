-- Treesitter düğümlerine göre artımlı seçim.
--
-- Gövde nvim 0.12'nin gömülü `vim.treesitter.select()`'ine devredildi; eskiden
-- burada elle tutulan bir düğüm yığını (~115 satır) vardı ve ölçüldüğünde
-- (2026-08-28) genişletme adımları gömülü olanla **birebir** aynıydı:
-- 2:18 -> 2:14-2:18 -> 2:13-2:19 -> 2:13-2:23. Gömülünün fazlası da var:
-- parser yoksa `vim.lsp.buf.selection_range()`'e düşüyor, elle yazılan sessizce
-- hiçbir şey yapmıyordu.
--
-- Kalan tek yerel parça kapsam zıplaması: gömülü `select()` yalnız bir düğüm
-- yukarı çıkıyor, <M-space> ise SATIR aralığı değişene kadar çıkıyor — yani
-- ifadenin içinde oyalanmadan kapsayan bloğa/fonksiyona atlıyor.
-- Varsayılan `an`/`in` eşlemeleri de yerinde duruyor; bunlar onların
-- <C-space>/<bs> ile kullanılan biçimi.

local function kapsam_zipla()
	local function satirlar()
		return vim.fn.getpos("v")[2], vim.fn.getpos(".")[2]
	end
	local bs, be = satirlar()
	-- 20 üst sınır: kök düğümde select() artık büyümüyor, sonsuz döngü olmasın.
	for _ = 1, 20 do
		vim.treesitter.select("parent")
		local ns, ne = satirlar()
		if ns ~= bs or ne ~= be then
			return
		end
	end
end

vim.keymap.set({ "n", "x" }, "<C-space>", function()
	vim.treesitter.select("parent")
end, { silent = true, desc = "TS: seçimi büyüt" })

vim.keymap.set("x", "<bs>", function()
	vim.treesitter.select("child")
end, { silent = true, desc = "TS: seçimi küçült" })

vim.keymap.set({ "n", "x" }, "<M-space>", kapsam_zipla, { silent = true, desc = "TS: kapsama zıpla" })

-- Kurulu parser'ları listelemek için: :TSInstalledLanguages
-- (Vurgulamayı nvim kendiliğinden AÇMAZ — bunu plugins/treesitter.lua'daki
-- FileType autocmd'ı yapıyor; eski yorum burada tersini söylüyordu.)
