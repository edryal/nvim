require("toggleterm").setup({
    shade_terminals = false,
})

vim.api.nvim_create_autocmd("TermOpen", {
    pattern = "term://*toggleterm#*",
    callback = function()
        local opts = { buffer = 0, silent = true }
        vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
        vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
    end,
})

vim.keymap.set("n", "<leader>of", "<cmd>ToggleTerm direction=float<cr>", { desc = "Floating Terminal", silent = true })
vim.keymap.set("n", "<leader>ot", "<cmd>ToggleTerm size=16 direction=horizontal<cr>",
    { desc = "Horizontal Terminal", silent = true })
