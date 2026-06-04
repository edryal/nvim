require("nvim-dap-virtual-text").setup()

local dap = require("dap")
local dapui = require("dapui")
local util = require("utils.dap-setup")

dapui.setup(util.create_debug_config())
util.setup_dap_listeners(dap, dapui)
util.setup_dap_breakpoint_colors()
util.setup_dap_keymaps()

util.setup_go_debugger()
util.setup_java_debugger(dap)
