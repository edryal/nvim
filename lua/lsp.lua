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

if features.web and features.web.enabled then
    vim.list_extend(lsps, { "vtsls", "cssls", "html", "biome" })
end

if features.rust and features.rust.enabled then
    table.insert(lsps, "taplo")
end

-- blink adds completion capabilities by default, add lsp-file-operations on top
vim.lsp.config("*", {
    capabilities = require("lsp-file-operations").default_capabilities(),
})

-- offer UTF-16 only (what most servers use), so servers sharing a buffer agree on positions
vim.lsp.config("*", {
    capabilities = { general = { positionEncodings = { "utf-16" } } },
})

vim.lsp.enable(lsps)
vim.lsp.codelens.enable(true)
