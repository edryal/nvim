-- GOMODCACHE and GOROOT/src, resolved once in the background
local go_dirs = {}

local function resolve_go_dir(key, envvar, subdir)
    if go_dirs[key] then
        return
    end
    vim.system({ "go", "env", envvar }, { text = true }, function(out)
        local dir = vim.trim(out.stdout or "")
        if out.code == 0 and dir ~= "" then
            go_dirs[key] = dir .. (subdir or "")
        end
    end)
end

local function existing_gopls_root()
    local clients = vim.lsp.get_clients({ name = "gopls" })
    return #clients > 0 and clients[#clients].config.root_dir or nil
end

return {
    cmd = { "gopls" },
    filetypes = { "go", "gomod", "gowork" },

    -- go.work > go.mod > .git; files jumped into from the module cache or the
    -- stdlib reuse the running client instead of spawning a new one
    root_dir = function(bufnr, on_dir)
        resolve_go_dir("mod_cache", "GOMODCACHE")
        resolve_go_dir("std_lib", "GOROOT", "/src")

        local fname = vim.api.nvim_buf_get_name(bufnr)
        for _, dir in pairs(go_dirs) do
            if vim.startswith(fname, dir) then
                local root = existing_gopls_root()
                if root then
                    return on_dir(root)
                end
            end
        end

        on_dir(vim.fs.root(bufnr, "go.work") or vim.fs.root(bufnr, "go.mod") or vim.fs.root(bufnr, ".git"))
    end,

    settings = {
        gopls = {
            usePlaceholders = true,
            semanticTokens = true,
            analyses = {
                shadow = true,
            },
        },
    },
}
