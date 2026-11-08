require("lazydev").setup({
    library = {
        "nvim-dap-ui",
        { path = "snacks.nvim",        words = { "Snacks" } },
        { path = "fzf-lua",            words = { "FzfLua" } },
        { path = "${3rd}/luv/library", words = { "vim%.uv" }, },
    },
})
