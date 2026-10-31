return {
    cmd = function(dispatchers, config)
        local cmd = "yaml-language-server"
        local root = (config or {}).root_dir
        if root then
            local local_cmd = vim.fs.joinpath(root, "node_modules/.bin", cmd)
            if vim.fn.executable(local_cmd) == 1 then
                cmd = local_cmd
            end
        end
        return vim.lsp.rpc.start({ cmd, "--stdio" }, dispatchers)
    end,
    filetypes = { "yaml", "yaml.docker-compose" },
    root_markers = { ".git" },
    settings = {
        redhat = { telemetry = { enabled = false } },
        yaml = { format = { enable = true } },
    },
    on_init = function(client)
        client.server_capabilities.documentFormattingProvider = true
    end
}
