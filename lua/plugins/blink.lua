local features = require("features")

local per_filetype = {
    lua = { "lazydev", inherit_defaults = true },
}

local providers = {
    lazydev = { name = "LazyDev", module = "lazydev.integrations.blink", score_offset = 100 },
}

if features.database and features.database.enabled then
    per_filetype.sql = { "dadbod", inherit_defaults = true }
    providers.dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" }
end

local blink = require("blink.cmp")

-- Use lua implementation while it builds in the background, then hot-swap to rust
local rust_ready = blink.library_available()
if not rust_ready then
    local function notify(msg, level)
        vim.notify(msg, level, { id = "blink_build", title = "blink.cmp" })
    end

    vim.schedule(function()
        notify("Building Rust matcher, using Lua for now", vim.log.levels.WARN)
    end)

    blink.build()
        :on_resolve(vim.schedule_wrap(function()
            local fuzzy = require("blink.cmp.fuzzy")
            fuzzy.set_implementation("rust")
            fuzzy.has_init_db = false
            notify("Switched to Rust matcher", vim.log.levels.INFO)
        end))
        :on_reject(vim.schedule_wrap(function()
            notify("Build failed, staying on Lua (:BlinkCmp build-log)", vim.log.levels.ERROR)
        end))
end

blink.setup({
    enabled = function()
        return not vim.tbl_contains({ "dap-repl", "dapui-console" }, vim.bo.filetype)
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
            menu = { auto_show = true },
            ghost_text = { enabled = false },
        },
    },
    appearance = { nerd_font_variant = "mono" },
    sources = {
        default = { "lsp", "path", "buffer" },
        per_filetype = per_filetype,
        providers = providers,
    },
    fuzzy = { implementation = rust_ready and "rust" or "lua" },
})
