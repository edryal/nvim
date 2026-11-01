local M = {}

M.create_debug_config = function()
    return {
        controls = { enabled = false },
        layouts = {
            {
                -- opens when paused at a breakpoint
                elements = { "scopes", "breakpoints", "stacks" },
                size = 0.3,
                position = "left",
            },
            {
                -- program / test output
                elements = { "repl" },
                size = 0.5,
                position = "bottom",
            },
        },
    }
end

M.setup_dap_listeners = function(dap, dapui)
    -- every session starts with an empty REPL, so it only shows this run's output
    dap.listeners.on_config.dapui_config = function(config)
        dap.repl.clear()
        return config
    end
    dap.listeners.before.attach.dapui_config = function() dapui.open({ layout = 2 }) end
    dap.listeners.before.launch.dapui_config = function() dapui.open({ layout = 2 }) end
    dap.listeners.after.event_stopped.dapui_config = function() dapui.open({ layout = 1 }) end
end

-- <leader>dd: close everything if anything is open, otherwise reopen the output (+ side panel when paused)
M.toggle_ui = function()
    local dap, dapui = require("dap"), require("dapui")
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        local ft = vim.bo[vim.api.nvim_win_get_buf(win)].filetype
        if ft:match("^dapui_") or ft == "dap-repl" then
            return dapui.close()
        end
    end
    dapui.open({ layout = 2 })
    local session = dap.session()
    if session and session.stopped_thread_id then
        dapui.open({ layout = 1 })
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

-- debug keys only exist in buffers of languages that have a debugger enabled (and in the dap-ui panels)
M.setup_dap_keymaps = function(filetypes)
    local pattern = vim.list_extend({ "dap-repl", "dapui_*" }, filetypes)

    vim.api.nvim_create_autocmd("FileType", {
        pattern = pattern,
        callback = function(args)
            local dap = require("dap")
            require("which-key").add({ { "<leader>d", group = "Debug", buffer = args.buf } })

            vim.keymap.set("n", "<leader>ds", dap.continue, { desc = "Start/Continue", buffer = args.buf })
            vim.keymap.set("n", "<leader>dt", dap.terminate, { desc = "Terminate Session", buffer = args.buf })
            vim.keymap.set("n", "<leader>da", dap.toggle_breakpoint, { desc = "Add Breakpoint", buffer = args.buf })
            vim.keymap.set("n", "<leader>dc", dap.clear_breakpoints, { desc = "Clear Breakpoints", buffer = args.buf })
            vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Step Over", buffer = args.buf })
            vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step Into", buffer = args.buf })
            vim.keymap.set("n", "<leader>du", dap.step_out, { desc = "Step Out", buffer = args.buf })
            vim.keymap.set("n", "<leader>dd", M.toggle_ui, { desc = "Dap UI", buffer = args.buf })
            vim.keymap.set("n", "<leader>tv", "<cmd>DapVirtualTextToggle<cr>",
                { desc = "Dap Virtual Text", buffer = args.buf })
        end,
    })

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

M.setup_cpp_debugger = function()
    local dap = require("dap")
    dap.adapters.gdb = {
        type = "executable",
        command = "gdb",
        args = {
            "--interpreter=dap",
            "--eval-command", "set print pretty on",
        },
    }

    dap.configurations.cpp = {
        {
            name = "Launch (build/main)",
            type = "gdb",
            request = "launch",
            program = function()
                local co = coroutine.running()
                vim.system({ "./build.sh" }, { text = true }, function(obj)
                    vim.schedule(function()
                        if obj.code ~= 0 then
                            vim.notify("Build failed:\n" .. (obj.stderr or ""), vim.log.levels.ERROR)
                            coroutine.resume(co, dap.ABORT)
                        else
                            coroutine.resume(co, vim.fn.getcwd() .. "/build/main")
                        end
                    end)
                end)
                return coroutine.yield()
            end,
            cwd = "${workspaceFolder}",
            stopAtBeginningOfMainSubprogram = false,
        },
    }

    dap.configurations.c = dap.configurations.cpp
end

M.setup_rust_debugger = function()
    require("dap").listeners.on_config.rust_console = function(config)
        if config.type == "codelldb" and config.terminal == nil then
            config.terminal = "console"
        end
        return config
    end
end

return M
