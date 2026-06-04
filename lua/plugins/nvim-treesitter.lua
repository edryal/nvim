local treesitter = require("nvim-treesitter")

local ensure_installed = {
	"lua",
	"java",
	"go",
	"python",
	"javascript",
	"typescript",
	"tsx",
	"html",
	"css",
	"json",
	"bash",
	"http",
	"dockerfile",
}

treesitter.install(ensure_installed)

vim.api.nvim_create_autocmd("FileType", {
	desc = "Load treesitter parser for the detected language",
	pattern = "*",
	callback = function(args)
		local buf = args.buf
		local ft = vim.bo[buf].filetype

		local lang = vim.treesitter.language.get_lang(ft)
		if not lang then
			return
		end

		local ok_add = pcall(vim.treesitter.language.add, lang)
		if not ok_add then
			return
		end

		pcall(vim.treesitter.start, buf, lang)
	end,
})
