return {
    "xiaopixiao/codewhale.nvim",
    dependencies = { "folke/snacks.nvim" },
    opts = {
        terminal = {
            split_side = "right",
            split_width_percentage = 0.35,
            snacks_win_opts = {
                position = "float",
                width = 0.85,
                height = 0.85,
                border = "rounded",
                backdrop = 80,
                keys = {
                    codewhale_toggle = {
                        "<leader>dd",
                        function(self)
                            self:toggle()
                        end,
                        mode = "t",
                        desc = "Toggle Codewhale",
                    },
                },
            },
        },
    },
    keys = {
        { "<leader>d",  "",                          desc = "+codewhale", mode = { "n", "v" } },
        { "<leader>ds", "<cmd>DeepSeek<cr>",         desc = "Toggle Codewhale" },
        { "<leader>df", "<cmd>DeepSeekFocus<cr>",    desc = "Focus Codewhale" },
        { "<leader>dr", "<cmd>DeepSeekResume<cr>",   desc = "Resume session" },
        { "<leader>dd", "<cmd>DeepSeek<cr>",         desc = "Toggle Codewhale" },
        { "<leader>di", "<cmd>DeepSeekRun<cr>",      desc = "Interactive run" },
    },
}
