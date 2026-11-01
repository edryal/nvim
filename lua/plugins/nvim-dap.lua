local features = require("features")

require("nvim-dap-virtual-text").setup {
    virt_text_pos = "eol",
    display_callback = function(variable)
        if #variable.value > 70 then
            return ' ' .. variable.value:sub(1, 70) .. '...'
        end
        return ' ' .. variable.value
    end,
}

local dap = require("dap")
local dapui = require("dapui")
local util = require("utils.dap-setup")

dapui.setup(util.create_debug_config())
util.setup_dap_listeners(dap, dapui)
util.setup_dap_breakpoint_colors()

-- filetypes that get the <leader>d debug keybinds
local debug_filetypes = {}

if features.java and features.java.enabled then
    util.setup_java_debugger()
    table.insert(debug_filetypes, "java")
end

if features.go and features.go.enabled then
    util.setup_go_debugger()
    table.insert(debug_filetypes, "go")
end

if features.cpp and features.cpp.enabled then
    util.setup_cpp_debugger()
    vim.list_extend(debug_filetypes, { "c", "cpp" })
end

if features.rust and features.rust.enabled then
    util.setup_rust_debugger()
    table.insert(debug_filetypes, "rust")
end

util.setup_dap_keymaps(debug_filetypes)
