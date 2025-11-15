return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    { "theHamsta/nvim-dap-virtual-text", opts = {} },
    "leoluz/nvim-dap-go",
    "mfussenegger/nvim-dap-python",
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")
    local features = require("settings.features")
    local util = require("utils.dap")

    dapui.setup(util.create_debug_config())
    util.setup_dap_listeners(dap, dapui)
    util.setup_dap_breakpoint_colors()
    util.setup_dap_keymaps()

    if features.go.debugger then
      util.setup_go_debugger()
    end

    if features.java.debugger then
      util.setup_java_debugger(dap)
    end

    if features.python.debugger then
      util.setup_python_debugger(dap)
    end
  end,
}
