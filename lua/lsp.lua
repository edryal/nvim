local features = require("features")

local lsps = { "lua_ls", "bashls", "lemminx", "jsonls" }

if features.go and features.go.enabled then
    table.insert(lsps, "gopls")
end

-- TODO: add clangd-extensions in the future?
if features.cpp and features.cpp.enabled then
    table.insert(lsps, "clangd")
    table.insert(lsps, "neocmake")
end

vim.lsp.enable(lsps)
vim.lsp.codelens.enable(true)
