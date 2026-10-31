-- https://clangd.llvm.org/extensions.html#switch-between-sourceheader
local function switch_source_header(bufnr, client)
    local method = "textDocument/switchSourceHeader"
    if not client:supports_method(method) then
        return vim.notify(method .. " is not supported by clangd here")
    end
    client:request(method, vim.lsp.util.make_text_document_params(bufnr), function(err, result)
        if err then
            error(tostring(err))
        end
        if not result then
            return vim.notify("corresponding file cannot be determined")
        end
        vim.cmd.edit(vim.uri_to_fname(result))
    end, bufnr)
end

-- https://clangd.llvm.org/extensions.html#symbol-info-request
local function symbol_info(bufnr, client)
    local method = "textDocument/symbolInfo"
    if not client:supports_method(method) then
        return vim.notify(method .. " is not supported by clangd here", vim.log.levels.ERROR)
    end
    local params = vim.lsp.util.make_position_params(vim.api.nvim_get_current_win(), client.offset_encoding)
    client:request(method, params, function(err, res)
        if err or not res or #res == 0 then
            return
        end
        local name = "name: " .. res[1].name
        local container = "container: " .. res[1].containerName
        vim.lsp.util.open_floating_preview({ name, container }, "", {
            height = 2,
            width = math.max(#name, #container),
            focusable = false,
            focus = false,
            title = "Symbol Info",
        })
    end, bufnr)
end

return {
    cmd = { "clangd" },
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
    root_markers = {
        ".clangd",
        ".clang-tidy",
        ".clang-format",
        "compile_commands.json",
        "compile_flags.txt",
        "configure.ac",
        ".git",
    },

    -- clangd expects VS Code's language ids for these
    get_language_id = function(_, ft)
        local ids = { objc = "objective-c", objcpp = "objective-cpp", cuda = "cuda-cpp" }
        return ids[ft] or ft
    end,

    capabilities = {
        textDocument = { completion = { editsNearCursor = true } },
        offsetEncoding = { "utf-8", "utf-16" },
    },

    on_init = function(client, init_result)
        if init_result.offsetEncoding then
            client.offset_encoding = init_result.offsetEncoding
        end
    end,

    on_attach = function(client, bufnr)
        vim.api.nvim_buf_create_user_command(bufnr, "LspClangdSwitchSourceHeader", function()
            switch_source_header(bufnr, client)
        end, { desc = "Switch between source/header" })

        vim.api.nvim_buf_create_user_command(bufnr, "LspClangdShowSymbolInfo", function()
            symbol_info(bufnr, client)
        end, { desc = "Show symbol info" })
    end,
}
