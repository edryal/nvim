local capabilities = require("utils.lsp").setup_capabilities()

local function custom_attach(client, bufnr)
  require("utils.lsp").attach_navic(client, bufnr)
end

return {
  cmd = { "lemminx" },
  filetypes = { "xml", "xsd", "xsl", "xslt", "svg" },
  root_markers = { ".git" },
  capabilities = capabilities,
  on_attach = custom_attach,
  single_file_support = true,
}
