return {
    cmd = function(dispatchers, config)
        local cmd = "biome"
        local root = (config or {}).root_dir
        if root then
            local local_cmd = vim.fs.joinpath(root, "node_modules/.bin", cmd)
            if vim.fn.executable(local_cmd) == 1 then
                cmd = local_cmd
            end
        end
        return vim.lsp.rpc.start({ cmd, "lsp-proxy" }, dispatchers)
    end,
    filetypes = {
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "json",
        "jsonc",
        "css",
    },
    workspace_required = true,
    root_dir = function(bufnr, on_dir)
        local root = vim.fs.root(bufnr, { "biome.json", "biome.jsonc" })
        if root then
            on_dir(root)
        end
    end
}
