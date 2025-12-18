return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2", -- En güncel ve stabil versiyon
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup()

    -- KEYMAPS (Senin drpars/keymaps.lua dosyanla uyumlu mantıkta)
    -- Dosyayı Harpoon listesine ekle
    vim.keymap.set("n", "<leader>ah", function() harpoon:list():add() end, { desc = "Harpoon: Add file" })
    
    -- Harpoon menüsünü aç (Görsel liste)
    vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon: Menu" })

    -- Hızlı zıplama (Mermi hızı!)
    vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end, { desc = "Harpoon: File 1" })
    vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end, { desc = "Harpoon: File 2" })
    vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end, { desc = "Harpoon: File 3" })
    vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end, { desc = "Harpoon: File 4" })
  end,
}
