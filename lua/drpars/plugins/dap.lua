-- Hata ayıklayıcı. debugpy zaten mason ile kuruluyordu (mason.lua) ama onu
-- çağıran hiçbir şey yoktu; bu dosya o boşluğu kapatıyor.
--
-- Tuşlar F5-F12'de, <leader>d* değil: o ad alanı codewhale'in (<leader>ds/df/dr/
-- di/dd) ve <leader>d de LSP satır tanısı. F5/F9/F10/F11 VS Code ile aynı.
return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			{ "rcarriga/nvim-dap-ui", dependencies = { "nvim-neotest/nvim-nio" } },
			"mfussenegger/nvim-dap-python",
		},
		keys = {
			{ "<F5>", function() require("dap").continue() end, desc = "Debug: başlat / devam et" },
			{ "<F6>", function() require("dapui").toggle() end, desc = "Debug: paneli aç/kapat" },
			{ "<F9>", function() require("dap").toggle_breakpoint() end, desc = "Debug: kesme noktası" },
			{ "<F10>", function() require("dap").step_over() end, desc = "Debug: satır atla" },
			{ "<F11>", function() require("dap").step_into() end, desc = "Debug: içine gir" },
			{ "<F12>", function() require("dap").step_out() end, desc = "Debug: dışına çık" },
			{ "<leader>b", function() require("dap").toggle_breakpoint() end, desc = "Debug: kesme noktası" },
			{
				"<leader>B",
				function()
					require("dap").set_breakpoint(vim.fn.input("Koşul: "))
				end,
				desc = "Debug: koşullu kesme noktası",
			},
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			dapui.setup()

			-- debugpy'ı mason'ın kendi venv'inden veriyoruz; bu yorumcu yalnız
			-- adaptörü koşturuyor, hata ayıklanan program kendi venv'ini kullanıyor
			-- (dap-python VIRTUAL_ENV ve .venv/venv/env dizinlerini kendisi buluyor).
			local debugpy = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"
			if vim.uv.fs_stat(debugpy) then
				require("dap-python").setup(debugpy)
			else
				vim.notify("debugpy bulunamadı: " .. debugpy .. " (:Mason ile kur)", vim.log.levels.WARN)
			end

			-- Oturum açılınca panel açılsın, bitince kapansın.
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end

			vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError", numhl = "" })
			vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "DiagnosticWarn", numhl = "" })
			vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DiagnosticInfo", linehl = "Visual" })
		end,
	},
}
