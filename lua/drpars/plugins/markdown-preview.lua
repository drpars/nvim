return {
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "$HOME/.local/share/nvim/lazy/markdown-preview.nvim/app/install.sh",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }

			-- Çalışılan workspace'te açılsın diye yeni pencere isteniyor; gerekçe
			-- live-preview.lua'da. Buradaki kaldıraç `mkdp_browser` DEĞİL: o yalnız
			-- çalıştırılabilirin adını alıyor, argüman alamıyor (app/lib/util/opener.js
			-- → spawn(command, [url], { shell: false })), "firefox --new-window"
			-- yazılırsa ENOENT olur. `mkdp_browserfunc` url ile çağrılan bir vim
			-- fonksiyonudur (app/server.js → plugin.nvim.call(browserfunc, [url])).
			vim.cmd([[
				function! MkdpOpenInNewWindow(url) abort
					call jobstart(['firefox', '--new-window', a:url], { 'detach': v:true })
				endfunction
			]])
			vim.g.mkdp_browserfunc = "MkdpOpenInNewWindow"
		end,
		ft = { "markdown" },
	},
}
