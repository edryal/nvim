require("render-markdown").setup({
    enabled = true,
    completions = {
        lsp = { enabled = true },
    },
    file_types = { "markdown", "vimwiki" },
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function(args)
        vim.keymap.set("n", "<leader>mp", "<cmd>RenderMarkdown preview<cr>", {
            desc = "Markdown Preview",
            silent = true,
            buffer = args.buf,
        })
        vim.keymap.set("n", "<leader>mt", "<cmd>RenderMarkdown buf_toggle<cr>", {
            desc = "Toggle Buffer Rendering",
            silent = true,
            buffer = args.buf,
        })
        vim.keymap.set("n", "<leader>tm", "<cmd>RenderMarkdown toggle<cr>", {
            desc = "Toggle Markdown Rendering",
            silent = true,
            buffer = args.buf,
        })
    end,
})
