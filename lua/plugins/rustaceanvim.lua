-- rustaceanvim is a filetype plugin, no setup() call, it reads this table when a rust file opens.
-- it automatically starts rust-analyzer, so rust_analyzer must not be in vim.lsp.enable()
vim.g.rustaceanvim = {
    tools = {
        executor = "toggleterm",
        test_executor = "background",
    },
}
