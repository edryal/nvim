require("blink.cmp").build():pwait()
require("blink.cmp").setup({
    enabled = function()
        return not vim.tbl_contains({
            "dap-repl", "dapui-console"
        }, vim.bo.filetype)
    end,
    keymap = {
        preset = "enter",
        ["<A-Space>"] = { "show", "show_documentation", "hide_documentation" },
    },
    completion = {
        documentation = { auto_show = false },
        keyword = { range = "full" },
    },
    signature = {
        enabled = true,
        window = {
            show_documentation = false,
            border = "rounded",
        },
    },
    cmdline = {
        keymap = {
            preset = "cmdline",
            ['<A-space>'] = { 'show', 'fallback' },
        },
        completion = {
            menu = {
                auto_show = true,
            },
            ghost_text = {
                enabled = false,
            },
        },
    },
    appearance = {
        nerd_font_variant = "mono",
    },
    sources = {
        default = { "lsp", "path", "buffer" },
        per_filetype = {
            lua = { "lazydev", inherit_defaults = true },
        },
        providers = {
            lazydev = { name = "LazyDev", module = "lazydev.integrations.blink", score_offset = 100 },
        },
    },
    fuzzy = { implementation = "rust" },
})
