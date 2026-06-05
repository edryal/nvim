require("toggleterm").setup({
	shade_terminals = false,
})

function _G.set_terminal_keymaps()
	local opts = { buffer = 0, silent = true }
	vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
	vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
end

vim.api.nvim_create_autocmd("TermOpen", {
	pattern = "term://*toggleterm#*",
	callback = function()
		set_terminal_keymaps()
	end,
})

vim.keymap.set(
	"n",
	"<leader>ot",
	"<cmd>ToggleTerm size=16 direction=horizontal<cr>",
	{ desc = "Horizontal Terminal", silent = true }
)

vim.keymap.set("n", "<leader>of", "<cmd>ToggleTerm direction=float<cr>", { desc = "Floating Terminal", silent = true })
-- vim.keymap.set("n", "<leader>tt", "<cmd>ToggleTermToggleAll<cr>", { desc = "Terminal", silent = true  })
