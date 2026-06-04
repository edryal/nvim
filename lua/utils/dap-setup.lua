local M = {}

M.create_debug_config = function()
	return {
		layouts = {
			{
				elements = { "scopes", "breakpoints" },
				size = 0.3,
				position = "left",
			},
			{
				elements = { "repl" },
				size = 0.3,
				position = "bottom",
			},
		},
	}
end

M.setup_dap_listeners = function(dap, dapui)
	dap.listeners.before.attach.dapui_config = function()
		dapui.open()
	end
	dap.listeners.before.launch.dapui_config = function()
		dapui.open()
	end
	dap.listeners.before.event_terminated.dapui_config = function()
		dapui.close()
	end
	dap.listeners.before.event_exited.dapui_config = function()
		dapui.close()
	end
end

M.setup_dap_breakpoint_colors = function()
	-- local black = "#1a1b26"
	local red = "#d95f73"
	-- local purple = "#c678dd"
	local yellow = "#e5c07b"
	local orange = "#d19a66"
	local green = "#9ece6a"
	local blue = "#3d59a1"

	vim.api.nvim_set_hl(0, "DapSignRed", { fg = red })
	vim.api.nvim_set_hl(0, "DapSignGreen", { fg = green })
	vim.api.nvim_set_hl(0, "DapSignBlue", { fg = blue })
	vim.api.nvim_set_hl(0, "DapSignOrange", { fg = orange })
	vim.api.nvim_set_hl(0, "DapSignYellow", { fg = yellow })

	vim.fn.sign_define(
		"DapBreakpoint",
		{ text = "", texthl = "DapSignRed", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
	)
	vim.fn.sign_define(
		"DapStopped",
		{ text = "", texthl = "DapSignGreen", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
	)
	vim.fn.sign_define(
		"DapBreakpointCondition",
		{ text = "", texthl = "DapSignBlue", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
	)
	vim.fn.sign_define(
		"DapBreakpointRejected",
		{ text = "", texthl = "DapSignOrange", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
	)
	vim.fn.sign_define(
		"DapLogPoint",
		{ text = "", texthl = "DapSignYellow", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
	)
end

M.setup_dap_keymaps = function()
	vim.keymap.set("n", "<leader>ds", "<cmd>lua require'dap'.continue()<cr>", { desc = "Start/Continue" })
	vim.keymap.set("n", "<leader>dd", "<cmd>lua require'dapui'.toggle()<cr>", { desc = "Dap UI" })
	vim.keymap.set("n", "<leader>dt", "<cmd>lua require'dap'.terminate()<cr>", { desc = "Terminate Session" })
	vim.keymap.set("n", "<leader>da", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", { desc = "Add Breakpoint" })
	vim.keymap.set("n", "<leader>dc", "<cmd>lua require'dap'.clear_breakpoints()<cr>", { desc = "Clear Breakpoints" })
	vim.keymap.set("n", "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", { desc = "Step Over" })
	vim.keymap.set("n", "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", { desc = "Step Into" })
	vim.keymap.set("n", "<leader>du", "<cmd>lua require'dap'.step_out()<cr>", { desc = "Step Out" })
	vim.keymap.set("n", "<leader>tv", "<cmd>DapVirtualTextToggle<cr>", { desc = "Dap Virtual Text" })
end

M.setup_go_debugger = function()
	vim.api.nvim_create_autocmd("FileType", {
		pattern = "go",
		callback = function()
			require("dap-go").setup({
				delve = {
					path = "dlv",
					initialize_timeout_sec = 20,
					port = "${port}",
					args = {},
					build_flags = {},
					detached = vim.fn.has("win32") == 0,
					cwd = nil,
				},
				tests = {
					verbose = false,
				},
			})
		end,
	})
end

M.setup_java_debugger = function(dap)
	vim.api.nvim_create_autocmd("FileType", {
		pattern = "java",
		callback = function()
			dap.configurations.java = {
				{
					type = "java",
					request = "launch",
					console = "internalConsole",
					shortenCommandLine = "argfile",
					name = "Launch Application",
					vmArgs = "-Xmx2g ",
				},
			}
		end,
	})
end

return M
