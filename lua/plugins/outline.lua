require("outline").setup({
	outline_window = {
		auto_jump = true,
	},
	symbols = {
		filter = {
			jdtls = { "Function", "Class" },
		},
	},
})

vim.keymap.set("n", "<leader>oo", "<cmd>Outline<cr>", { desc = "Outline", silent = true })
