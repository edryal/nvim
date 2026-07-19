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
util.setup_dap_keymaps()

if features.java and features.java.enabled then
    util.setup_java_debugger()
end

if features.go and features.go.enabled then
    util.setup_go_debugger()
end
