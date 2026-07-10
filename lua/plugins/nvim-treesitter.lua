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
    "groovy",
    "xml",
    "yaml",
    "markdown",
    "kotlin"
}

treesitter.install(ensure_installed)

vim.api.nvim_create_autocmd("FileType", {
	desc = "Load treesitter parser for the detected language",
	pattern = "*",
	callback = function(args)
		local buf = args.buf
		local filetype = vim.bo[buf].filetype

		local lang = vim.treesitter.language.get_lang(filetype)
		if not lang then
			return
		end

		local ok_add = pcall(vim.treesitter.language.add, lang)
		if not ok_add then
			return
		end

		pcall(vim.treesitter.start, buf, lang)
		vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
})
