vim.api.nvim_create_autocmd("FileType", {
	desc = "Close specific windows with q",
	pattern = {
		"qf",
		"help",
		"man",
		"lspinfo",
		"notify",
		"nofile",
		"toggleterm",
		"fugitive",
	},
	callback = function()
		vim.cmd([[
          nnoremap <silent> <buffer> q :close<CR>
          set nobuflisted
        ]])
	end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	callback = function()
		vim.hl.on_yank()
	end,
})

local disable_useless_diagnostics = vim.api.nvim_create_augroup("DisableUselessDiagnostics", { clear = true })
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	desc = "Disable diagnostics for specific directories",
	pattern = {
		"**/node_modules",
		"**/target",
	},
	callback = function()
		vim.diagnostic.enable(false)
	end,
	group = disable_useless_diagnostics,
})
