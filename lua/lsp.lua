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

if features.python and features.python.enabled then
    table.insert(lsps, "basedpyright")
end

if features.typescript and features.typescript.enabled then
    table.insert(lsps, "vtsls")
end

-- blink adds completion capabilities by default
-- so we can just add lsp-file-operations capabilities on top
vim.lsp.config("*", {
    capabilities = require("lsp-file-operations").default_capabilities(),
})

vim.lsp.enable(lsps)
vim.lsp.codelens.enable(true)
