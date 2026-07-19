require('cord').setup()

vim.keymap.set("n", "<leader>td", "<cmd>Cord toggle<cr>", { desc = "Discord Presence", silent = true })
