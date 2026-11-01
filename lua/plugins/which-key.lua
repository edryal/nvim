require("which-key").setup({
    spec = {
        {
            mode = { "n" },
            { "<leader>f",  group = "Find" },
            { "<leader>w",  group = "Window" },
            { "<leader>t",  group = "Toggle" },
            { "<leader>n",  group = "Notifications" },
            { "<leader>m",  group = "Markdown" },
            { "<leader>o",  group = "Open" },
            { "<leader>b",  group = "Buffers" },
            { "<leader>r",  group = "Reload" },
            { "<leader>i",  group = "Image" },
            { "<leader>cd", group = "Diagnostics" },

            -- Java
            { "<leader>jt", group = "Test" },
            { "<leader>jb", group = "Boilerplate" },
            { "<leader>jj", group = "Jacoco" },
        },
        {
            mode = { "n", "v" },
            { "<leader>c", group = "Code" },
            { "<leader>j", group = "Java" },
            { "<leader>r", group = "Rust" },
            { "<leader>g", group = "Git" },
            { "<leader>s", group = "Search" },
        },
    },
})
