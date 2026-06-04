local capabilities = require("utils.lsp-setup").setup_capabilities()

return {
	cmd = { "lemminx" },
	filetypes = { "xml", "xsd", "xsl", "xslt", "svg" },
	root_markers = { ".git" },
	capabilities = capabilities,
	single_file_support = true,
}
