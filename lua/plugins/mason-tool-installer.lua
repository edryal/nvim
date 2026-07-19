local features = require("features")

local tools = {
    "lua-language-server",
    "stylua",
    "bash-language-server",
    "shellcheck",
    "shfmt",
    "prettier",
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

require("mason-tool-installer").setup({ ensure_installed = tools })
