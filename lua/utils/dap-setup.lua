local M = {}

M.create_debug_config = function()
    return {
        controls = { enabled = true },
        layouts = {
            {
                elements = { "scopes", "breakpoints", "stacks" },
                size = 0.3,
                position = "left",
            },
            {
                elements = { "repl", "console" },
                size = 0.3,
                position = "bottom",
            },
        }
    }
end

M.setup_dap_listeners = function(dap, dapui)
    dap.listeners.after.event_initialized.dapui_config = function()
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
    local red = "#d95f73"
    local yellow = "#e5c07b"
    local orange = "#d19a66"
    local green = "#9ece6a"
    local blue = "#3d59a1"

    vim.api.nvim_set_hl(0, "DapSignRed", { fg = red })
    vim.api.nvim_set_hl(0, "DapSignGreen", { fg = green })
    vim.api.nvim_set_hl(0, "DapSignBlue", { fg = blue })
    vim.api.nvim_set_hl(0, "DapSignOrange", { fg = orange })
    vim.api.nvim_set_hl(0, "DapSignYellow", { fg = yellow })

    -- Current-line highlight when stopped
    -- vim.api.nvim_set_hl(0, "DapStoppedLine", { bg = "#2d3343" })

    vim.fn.sign_define("DapBreakpoint", {
        text = "\u{f111}", -- solid circle
        texthl = "DapSignRed",
    })
    vim.fn.sign_define("DapBreakpointCondition", {
        text = "\u{f059}", -- question circle
        texthl = "DapSignBlue",
    })
    vim.fn.sign_define("DapBreakpointRejected", {
        text = "\u{f056}", -- minus circle
        texthl = "DapSignOrange",
    })
    vim.fn.sign_define("DapLogPoint", {
        text = "\u{f05a}", -- info circle
        texthl = "DapSignYellow",
    })
    vim.fn.sign_define("DapStopped", {
        text = "\u{f0da}", -- caret right (current execution line)
        texthl = "DapSignGreen",
        linehl = "DapStoppedLine",
        numhl = "DapSignGreen",
    })
end

M.setup_dap_keymaps = function()
    local dap = require("dap")
    vim.keymap.set("n", "<leader>ds", dap.continue, { desc = "Start/Continue" })
    vim.keymap.set("n", "<leader>dt", dap.terminate, { desc = "Terminate Session" })
    vim.keymap.set("n", "<leader>da", dap.toggle_breakpoint, { desc = "Add Breakpoint" })
    vim.keymap.set("n", "<leader>dc", dap.clear_breakpoints, { desc = "Clear Breakpoints" })
    vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Step Over" })
    vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step Into" })
    vim.keymap.set("n", "<leader>du", dap.step_out, { desc = "Step Out" })
    vim.keymap.set("n", "<leader>dd", "<cmd>lua require'dapui'.toggle()<cr>", { desc = "Dap UI" })
    vim.keymap.set("n", "<leader>tv", "<cmd>DapVirtualTextToggle<cr>", { desc = "Dap Virtual Text" })

    vim.api.nvim_create_autocmd("FileType", {
        pattern = { "dap-repl", "dapui_console" },
        callback = function(args)
            vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { buffer = args.buf, desc = "Exit to normal" })
            vim.keymap.set("t", "jk", [[<C-\><C-n>]], { buffer = args.buf, desc = "Exit to normal" })
        end,
    })
end

M.setup_go_debugger = function()
    require("dap-go").setup()
end

M.setup_java_debugger = function()
    local dap = require("dap")
    dap.configurations.java = dap.configurations.java or {}

    -- Update host and port of a real remote jvm
    table.insert(dap.configurations.java, {
        type = "java",
        request = "attach",
        name = "Attach to Remote JVM",
        hostName = "127.0.0.1",
        port = 5005,
    })
end

return M
