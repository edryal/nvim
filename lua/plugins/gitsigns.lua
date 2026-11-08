require("gitsigns").setup({ current_line_blame = true })

vim.keymap.set({ "n", "v" }, "<leader>gr", "<cmd>Gitsigns reset_hunk<cr>", { desc = "Reset Hunk", silent = true })
vim.keymap.set("n", "<leader>gR", "<cmd>Gitsigns reset_buffer<cr>", { desc = "Reset Buffer", silent = true })
vim.keymap.set("n", "<leader>gP", "<cmd>Gitsigns preview_hunk<cr>", { desc = "Preview Hunk", silent = true })
vim.keymap.set("n", "<leader>gB", "<cmd>Gitsigns blame_line<cr>", { desc = "Blame Line", silent = true })
vim.keymap.set("n", "<leader>gn", "<cmd>Gitsigns nav_hunk next<cr>", { desc = "Goto Next Hunk", silent = true })
vim.keymap.set("n", "<leader>gp", "<cmd>Gitsigns nav_hunk prev<cr>", { desc = "Goto Previous Hunk", silent = true })
