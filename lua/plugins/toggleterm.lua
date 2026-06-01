require("toggleterm").setup({
	shade_terminals = false,
})

function _G.set_terminal_keymaps()
	local opts = { buffer = 0 }
	vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
	vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
end

vim.cmd("autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()")

vim.keymap.set("n", "<leader>ot", "<cmd>ToggleTerm size=16 direction=horizontal<cr>", { desc = "Horizontal Terminal", silent = true })
vim.keymap.set("n", "<leader>of", "<cmd>ToggleTerm direction=float<cr>", { desc = "Floating Terminal", silent = true })
-- vim.keymap.set("n", "<leader>tt", "<cmd>ToggleTermToggleAll<cr>", { desc = "Terminal", silent = true  })
