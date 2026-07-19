local features = require("features")

local lsps = { "lua_ls", "bashls", "lemminx", "jsonls" }

if features.go and features.go.enabled then
    table.insert(lsps, "gopls")
end

if features.cpp and features.cpp.enabled then
    table.insert(lsps, "clangd")
end

vim.lsp.enable(lsps)
vim.lsp.codelens.enable(true)
