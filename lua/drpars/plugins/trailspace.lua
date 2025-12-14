return {
	{
		"nvim-mini/mini.trailspace",
		event = "BufReadPost",
		version = false,
		config = function()
			-- 1. Durum takibi için global değişken
			local is_highlighted = false

			-- 2. Toggle fonksiyonu
			local function toggle_trailspace()
				local mini_trailspace = require("mini.trailspace")

				if is_highlighted then
					mini_trailspace.unhighlight()
					is_highlighted = false
					print("Trailing space highlighting disabled.")
				else
					mini_trailspace.highlight()
					is_highlighted = true
					print("Trailing space highlighting enabled.")
				end
			end

			-- 3. Trim fonksiyonu
			local function trim_all_trailspace_and_lines()
				local mini_trailspace = require("mini.trailspace")
				mini_trailspace.trim()
				mini_trailspace.trim_last_lines()
			end

			-- SETUP
			require("mini.trailspace").setup({
				-- only_in_normal_buffers = true, -- Varsayılan ayardır, isterseniz ekleyebilirsiniz
			})

			-- BAŞLANGIÇTA KAPALI DURUM
			require("mini.trailspace").unhighlight()
			is_highlighted = false

			-----------------------------------------------------------
			-- 🔑 KEYMAP ATAMALARI
			-----------------------------------------------------------

			vim.keymap.set("n", "<leader>bts", toggle_trailspace, { desc = "Toggle Trailing Space Highlight" })
			vim.keymap.set("n", "<leader>btr", trim_all_trailspace_and_lines, {
				silent = true,
				desc = "Trim all trailing whitespace and all trailing empty lines",
			})
		end,
	},
}
