return {
    cmd = function(dispatchers, config)
        local cmd = "vscode-html-language-server"
        local root = (config or {}).root_dir
        if root then
            local local_cmd = vim.fs.joinpath(root, "node_modules/.bin", cmd)
            if vim.fn.executable(local_cmd) == 1 then
                cmd = local_cmd
            end
        end
        return vim.lsp.rpc.start({ cmd, "--stdio" }, dispatchers)
    end,
    filetypes = { "html" },
    root_markers = { "package.json", ".git" },
    init_options = {
        provideFormatter = true,
        embeddedLanguages = { css = true, javascript = true },
        configurationSection = { "html", "css", "javascript" },
    }
}
