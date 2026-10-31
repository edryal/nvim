local bufnr = vim.api.nvim_get_current_buf()

-- Hover
vim.keymap.set("n", "K", function() vim.cmd.RustLsp({ "hover", "actions" }) end,
    { desc = "Hover Actions", buffer = bufnr })

-- Run / Debug / Test
vim.keymap.set("n", "<leader>rr", function() vim.cmd.RustLsp("runnables") end,
    { desc = "Runnables", buffer = bufnr })

vim.keymap.set("n", "<leader>rd", function() vim.cmd.RustLsp("debuggables") end,
    { desc = "Debuggables", buffer = bufnr })

vim.keymap.set("n", "<leader>rt", function() vim.cmd.RustLsp("testables") end,
    { desc = "Testables", buffer = bufnr })

-- Code
vim.keymap.set("n", "<leader>rm", function() vim.cmd.RustLsp("expandMacro") end,
    { desc = "Expand Macro", buffer = bufnr })

vim.keymap.set("n", "<leader>re", function() vim.cmd.RustLsp("explainError") end,
    { desc = "Explain Error", buffer = bufnr })

-- Navigation
vim.keymap.set("n", "<leader>rc", function() vim.cmd.RustLsp("openCargo") end,
    { desc = "Open Cargo.toml", buffer = bufnr })

vim.keymap.set("n", "<leader>rp", function() vim.cmd.RustLsp("parentModule") end,
    { desc = "Parent Module", buffer = bufnr })
