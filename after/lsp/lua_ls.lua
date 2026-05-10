local capabilities = require("utils.lsp").setup_capabilities()

local function custom_attach(client, bufnr)
  require("utils.lsp").attach_navic(client, bufnr)
end

return {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = {
    ".luarc.json",
    ".luarc.jsonc",
    ".luacheckrc",
    ".stylua.toml",
    "stylua.toml",
    "selene.toml",
    "selene.yml",
    ".git",
  },
  capabilities = capabilities,
  -- on_attach = custom_attach,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      telemetry = { enable = false },
    },
  },
}
