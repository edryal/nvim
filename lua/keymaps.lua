vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- easier wrapped text navigation
vim.keymap.set("n", "j", function()
	return vim.v.count == 0 and "gj" or "j"
end, { desc = "Down (in wrapped text)", expr = true, silent = true })

vim.keymap.set("n", "k", function()
	return vim.v.count == 0 and "gk" or "k"
end, { desc = "Up (in wrapped text)", expr = true, silent = true })

vim.keymap.set("v", "<", "<gv", { desc = "Unindent and keep selection", silent = true })
vim.keymap.set("v", ">", ">gv", { desc = "Indent and keep selection", silent = true })

vim.keymap.set("n", "<Esc>", "<cmd>nohl<cr>", { desc = "Clear highlights", silent = true })

vim.keymap.set("n", "<leader>re", "<cmd>restart<cr>", { desc = "Neovim Config (:restart)", silent = true })
vim.keymap.set("n", "<leader>wv", "<cmd>vsplit<cr>", { desc = "Split Vertical", silent = true })
vim.keymap.set("n", "<leader>wh", "<cmd>split<cr>", { desc = "Split Horizontal", silent = true })
vim.keymap.set("n", "<leader>tr", "<cmd>set rnu!<cr>", { desc = "Relative Line Numbers", silent = true })
vim.keymap.set("n", "<leader>bo", "<cmd>BufDelOthers<cr>", { desc = "Close All Other Buffers", silent = true })
vim.keymap.set("n", "<leader>bd", "<cmd>BufDel<cr>", { desc = "Close Current Buffer", silent = true })

-- Don't record macro on Alt + q
vim.keymap.set("n", "<A-q>", "", { silent = true })

vim.keymap.set("n", "<leader>ou", function()
	vim.cmd.packadd("nvim.undotree")
	require("undotree").open()
end, { desc = "Builtin Undotree", silent = true })

vim.keymap.set("n", "L", "<cmd>lua vim.lsp.buf.signature_help()<cr>", { desc = "Show Signature Help", silent = true })
vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", { desc = "Show Hover information", silent = true })
vim.keymap.set("n", "gR", "<cmd>lua vim.lsp.buf.rename()<cr>", { desc = "Rename all references", silent = true })
vim.keymap.set("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>", { desc = "Floating Diagnostics", silent = true })
vim.keymap.set("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", { desc = "Code Action", silent = true })

vim.keymap.set({ "n", "v" }, "<leader>cf", function()
	vim.lsp.buf.format({ async = true })
end, { desc = "Code Format", silent = true })

vim.keymap.set("n", "gn", function()
	vim.diagnostic.jump({ count = 1 })
end, { desc = "Next Diagnostic", silent = true })

vim.keymap.set("n", "gp", function()
	vim.diagnostic.jump({ count = -1 })
end, { desc = "Prev Diagnostic", silent = true })
