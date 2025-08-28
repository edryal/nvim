local opts = { noremap = true, silent = true }
local map = vim.api.nvim_set_keymap

-- [[ Stay in Visual ]]
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

-- Fix the issue with Ctrl + Backspace not working
map("i", "<C-BS>", "<C-W>", opts)
-- Try this if the one above doesn't work
-- map('i', '<C-H>', '<C-W>', opts)

-- Don't start macro recronding on Alt + q
map("n", "<A-q>", "", opts)

-- Close Windows quickly with Shift + Q
map("n", "Q", ":only<cr>", opts)

-- ESC to clear highlights after search
map("n", "<Esc>", ":noh<cr> :helpclose<cr>", opts)

-- Easily split windows
map("n", "<leader>wv", ":vsplit<cr>", Expand_Opts("Split Vertical"))
map("n", "<leader>wh", ":split<cr>", Expand_Opts("Split Horizontal"))

-- [[ Code ]]
map("n", "<leader>ct", ":TodoFzfLua<cr>", Expand_Opts("TODOs"))

-- [[ Toggles ]]
map("n", "<leader>td", ":lua vim.diagnostic.enable(not vim.diagnostic.is_enabled())<cr>", Expand_Opts("Diagnostics"))
map("n", "<leader>tr", ":set rnu!<cr>", Expand_Opts("Relative Line Numbers"))

-- [[ Buffers ]]
map("n", "<leader>bo", ":BufDelOthers<cr>", Expand_Opts("Close All Other Buffers"))
map("n", "<leader>bd", ":BufDel<cr>", Expand_Opts("Close Current Buffer"))

-- [[ LSP Basics ]]
vim.api.nvim_create_autocmd("LspAttach", {
  desc = "LSP actions",
  callback = function()
    local bufmap = function(mode, lhs, rhs, desc)
      local lspopts = { desc = desc, noremap = true, silent = true, buffer = true }
      vim.keymap.set(mode, lhs, rhs, lspopts)
    end

    bufmap("n", "L", ":lua vim.lsp.buf.signature_help()<cr>", "Show Signature Help")
    bufmap("n", "K", ":lua vim.lsp.buf.hover()<cr>", "Show Hover information")
    bufmap("n", "gR", ":lua vim.lsp.buf.rename()<cr>", "Rename all references")
    bufmap("n", "gl", ":lua vim.diagnostic.open_float()<cr>", "Floating Diagnostics")
    bufmap("n", "gp", ":lua vim.diagnostic.goto_prev()<cr>", "Go To Previous Diagnostic")
    bufmap("n", "gn", ":lua vim.diagnostic.goto_next()<cr>", "Go To Next Diagnostic")

    bufmap("n", "<leader>ca", ":lua vim.lsp.buf.code_action()<cr>", "Code Action")
    bufmap("v", "<leader>ca", ":lua vim.lsp.buf.code_action()<cr>", "Code Action")
    bufmap("n", "<leader>cf", ":lua require('conform').format({ async = true, lsp_fallback = true })<cr>", "Format")
    -- bufmap("n", "<leader>cf", ":lua vim.lsp.buf.format({async = true})<cr>", "Format")

    bufmap("n", "<leader>cde", ":Trouble diagnostics filter.severity=vim.diagnostic.severity.ERROR<cr>", "All Errors")
    bufmap("n", "<leader>cdb", ":Trouble diagnostics toggle filter.buf=0 focus = true<cr>", "In Buffer")
    bufmap("n", "<leader>cdw", ":Trouble diagnostics toggle focus = true<cr>", "In Workspace")
  end,
})
