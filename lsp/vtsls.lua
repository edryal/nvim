local language_settings = {
    updateImportsOnFileMove = { enabled = "always" }, -- needs willRenameFiles, sent by nvim-lsp-file-operations
    suggest = { completeFunctionCalls = true },       -- inserts fn(${1:arg}) placeholders
}

return {
    cmd = { "vtsls", "--stdio" },
    init_options = { hostInfo = "neovim" },
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },

    root_dir = function(bufnr, on_dir)
        local lockfiles = { "package-lock.json", "yarn.lock", "pnpm-lock.yaml", "bun.lockb", "bun.lock" }
        local project_root = vim.fs.root(bufnr, { lockfiles, { ".git" } })

        -- stay out of deno projects
        local deno_root = vim.fs.root(bufnr, { "deno.json", "deno.jsonc" })
        local deno_lock_root = vim.fs.root(bufnr, { "deno.lock" })

        if deno_lock_root and (not project_root or #deno_lock_root > #project_root) then
            return
        end
        if deno_root and (not project_root or #deno_root >= #project_root) then
            return
        end

        on_dir(project_root or vim.fn.getcwd())
    end,

    settings = {
        vtsls = {
            autoUseWorkspaceTsdk = true,
            experimental = {
                completion = { enableServerSideFuzzyMatch = true },
            },
        },
        typescript = language_settings,
        javascript = language_settings,
    },
}
