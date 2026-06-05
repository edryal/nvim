require("gitsigns").setup({
	signcolumn = true,
	current_line_blame = true,
	current_line_blame_opts = {
		delay = 1200,
		virtual_text_pos = "eol",
	},
})

vim.keymap.set({ "n", "v" }, "<leader>gr", "<cmd>Gitsigns reset_hunk<cr>", { desc = "Reset Hunk", silent = true })
vim.keymap.set("n", "<leader>gR", "<cmd>Gitsigns reset_buffer<cr>", { desc = "Reset Buffer", silent = true })
vim.keymap.set("n", "<leader>gP", "<cmd>Gitsigns preview_hunk<cr>", { desc = "Preview Hunk", silent = true })
vim.keymap.set("n", "<leader>gB", "<cmd>Gitsigns blame_line<cr>", { desc = "Blame Line", silent = true })
vim.keymap.set("n", "<leader>gn", "<cmd>Gitsigns next_hunk<cr>", { desc = "Goto Next Hunk", silent = true })
vim.keymap.set("n", "<leader>gp", "<cmd>Gitsigns prev_hunk<cr>", { desc = "Goto Previous Hunk", silent = true })
