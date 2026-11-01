local features = require("features")

local tools = {
    "lua-language-server",
    "stylua",
    "bash-language-server",
    "shellcheck",
    "shfmt",
    "json-lsp",
}

local java_tools = {
    "jdtls",
    "java-test",
    "java-debug-adapter",
    "lemminx",
}

local springboot_tools = {
    "vscode-spring-boot-tools",
}

local go_tools = {
    "gopls",
    "goimports",
    "delve",
}

local cpp_tools = {
    "clangd",
    "clang-format",
    "neocmakelsp"
}

local rust_tools = {
    "codelldb",
    "taplo",
}

local python_tools = {
    "basedpyright"
}

local web_tools = {
    "vtsls",
    "css-lsp",
    "html-lsp",
    "biome",
}

local devops_tools = {
    "dockerfile-language-server",
    "docker-compose-language-service",
    "yaml-language-server",
}

local database_tools = {
    "postgres-language-server"
}

if features.java and features.java.enabled then
    vim.list_extend(tools, java_tools)
    if features.java.springboot then
        vim.list_extend(tools, springboot_tools)
    end
end

if features.go and features.go.enabled then
    vim.list_extend(tools, go_tools)
end

if features.cpp and features.cpp.enabled then
    vim.list_extend(tools, cpp_tools)
end

if features.rust and features.rust.enabled then
    vim.list_extend(tools, rust_tools)
end

if features.python and features.python.enabled then
    vim.list_extend(tools, python_tools)
end

if features.web and features.web.enabled then
    vim.list_extend(tools, web_tools)
end

if features.devops and features.devops.enabled then
    vim.list_extend(tools, devops_tools)
end

if features.database and features.database.enabled then
    vim.list_extend(tools, database_tools)
end

require("mason-tool-installer").setup({ ensure_installed = tools })
