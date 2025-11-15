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
  local colors = require("utils.colors")
  vim.api.nvim_set_hl(0, "DapSignRed", { fg = colors.red })
  vim.api.nvim_set_hl(0, "DapSignGreen", { fg = colors.green })
  vim.api.nvim_set_hl(0, "DapSignBlue", { fg = colors.blue })
  vim.api.nvim_set_hl(0, "DapSignOrange", { fg = colors.orange })
  vim.api.nvim_set_hl(0, "DapSignYellow", { fg = colors.yellow })

  vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DapSignRed", linehl = "DapBreakpoint", numhl = "DapBreakpoint" })
  vim.fn.sign_define("DapStopped", { text = "", texthl = "DapSignGreen", linehl = "DapBreakpoint", numhl = "DapBreakpoint" })
  vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "DapSignBlue", linehl = "DapBreakpoint", numhl = "DapBreakpoint" })
  vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "DapSignOrange", linehl = "DapBreakpoint", numhl = "DapBreakpoint" })
  vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DapSignYellow", linehl = "DapBreakpoint", numhl = "DapBreakpoint" })
end

M.setup_dap_keymaps = function()
  local map = vim.api.nvim_set_keymap
  map("n", "<leader>ds", ":lua require'dap'.continue()<cr>", Expand_Opts("Start/Continue"))
  map("n", "<leader>dd", ":lua require'dapui'.toggle()<cr>", Expand_Opts("Dap UI"))
  map("n", "<leader>dt", ":lua require'dap'.terminate()<cr>", Expand_Opts("Terminate Session"))
  map("n", "<leader>da", ":lua require'dap'.toggle_breakpoint()<cr>", Expand_Opts("Add Breakpoint"))
  map("n", "<leader>dc", ":lua require'dap'.clear_breakpoints()<cr>", Expand_Opts("Clear Breakpoints"))
  map("n", "<leader>do", ":lua require'dap'.step_over()<cr>", Expand_Opts("Step Over"))
  map("n", "<leader>di", ":lua require'dap'.step_into()<cr>", Expand_Opts("Step Into"))
  map("n", "<leader>du", ":lua require'dap'.step_out()<cr>", Expand_Opts("Step Out"))
  map("n", "<leader>tv", ":DapVirtualTextToggle<cr>", Expand_Opts("Dap Virtual Text"))
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
        {
          type = "java",
          request = "attach",
          console = "internalConsole",
          shortenCommandLine = "argfile",
          name = "Debug (Attach :: 5005)",
          hostName = "127.0.0.1",
          port = 5005,
        },
      }
    end,
  })
end

M.setup_python_debugger = function(dap)
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "python",
    callback = function()
      require("dap-python").setup("python3")

      local map = vim.api.nvim_set_keymap
      map("n", "<leader>ptm", ":lua require('dap-python').test_method()<cr>", Expand_Opts("Method"))
      map("n", "<leader>ptc", ":lua require('dap-python').test_class()<cr>", Expand_Opts("Class"))
      map("v", "<leader>pts", ":lua require('dap-python').debug_selection()<cr>", Expand_Opts("Selection"))
    end,
  })
end

return M
