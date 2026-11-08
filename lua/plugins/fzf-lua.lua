require("fzf-lua").setup({
    winopts = {
        backdrop = 80,
        preview = { scrollbar = "float" },
    },
    keymap = {
        builtin = {
            ["ctrl-n"] = "down",
            ["ctrl-p"] = "up",
        },
        fzf = {
            ["home"] = "first",
            ["end"] = "last",
            ["ctrl-z"] = "abort",
            ["ctrl-d"] = "half-page-down",
            ["ctrl-u"] = "half-page-up",
            ["ctrl-a"] = "beginning-of-line",
            ["ctrl-e"] = "end-of-line",
            ["ctrl-q"] = "select-all+accept",
        },
    },
    fzf_colors = true,
    defaults = { formatter = { "path.filename_first" } },
})

-- Register fzf-lua as the backend for ui.select
require("fzf-lua").register_ui_select()
vim.keymap.set("n", "<leader>,", "<cmd>FzfLua buffers<cr>", { desc = "Open Buffers", silent = true })

-- Find
vim.keymap.set("n", "<leader>ff", "<cmd>FzfLua files<cr>", { desc = "Files", silent = true })
vim.keymap.set("n", "<leader>fq", "<cmd>FzfLua quickfix<cr>", { desc = "Quickfix List", silent = true })
vim.keymap.set("n", "<leader>fl", "<cmd>FzfLua files resume=true<cr>", { desc = "Last Files", silent = true })

vim.keymap.set("n", "<leader>fw", "<cmd>FzfLua lsp_live_workspace_symbols<cr>",
    { desc = "Workspace Symbols", silent = true })

vim.keymap.set("n", "<leader>fc", function() FzfLua.files({ cwd = vim.fn.stdpath("config") }) end,
    { desc = "Config Files", silent = true })

vim.keymap.set("n", "<leader>fr", "<cmd>FzfLua oldfiles cwd_only=true include_current_session=true<cr>",
    { desc = "Recent Files", silent = true })

-- Search
vim.keymap.set("n", "<leader>sl", "<cmd>FzfLua live_grep<cr>", { desc = "Live Grep", silent = true })
vim.keymap.set("n", "<leader>sL", "<cmd>FzfLua live_grep_native<cr>", { desc = "Live Grep Native", silent = true })
vim.keymap.set("n", "<leader>sr", "<cmd>FzfLua live_grep resume=true<cr>", { desc = "Resume Live Grep", silent = true })
vim.keymap.set("n", "<leader>sw", "<cmd>FzfLua grep_cword<cr>", { desc = "Grep Word", silent = true })
vim.keymap.set("n", "<leader>sb", "<cmd>FzfLua lgrep_curbuf<cr>", { desc = "Live Grep Buffer", silent = true })
vim.keymap.set("v", "<leader>sw", "<cmd>FzfLua grep_cword<cr>", { desc = "Grep Word", silent = true })
vim.keymap.set("v", "<leader>ss", "<cmd>FzfLua grep_visual<cr>", { desc = "Grep Selection", silent = true })

-- Git
vim.keymap.set("n", "<leader>gb", "<cmd>FzfLua git_branches<cr>", { desc = "Branches", silent = true })
vim.keymap.set("n", "<leader>gs", "<cmd>FzfLua git_status<cr>", { desc = "Status", silent = true })
vim.keymap.set("n", "<leader>gS", "<cmd>FzfLua git_stash<cr>", { desc = "Stash", silent = true })
vim.keymap.set("n", "<leader>gc", "<cmd>FzfLua git_bcommits<cr>", { desc = "File Commits", silent = true })
vim.keymap.set("n", "<leader>gC", "<cmd>FzfLua git_commits<cr>", { desc = "Project Commits", silent = true })
vim.keymap.set("n", "<leader>fg", "<cmd>FzfLua git_files<cr>", { desc = "Git Files", silent = true })

-- Lsp
vim.keymap.set("n", "gd", "<cmd>FzfLua lsp_definitions<cr>", { desc = "Goto Definition", silent = true })
vim.keymap.set("n", "gD", "<cmd>FzfLua lsp_declarations<cr>", { desc = "Goto Declaration", silent = true })
vim.keymap.set("n", "gr", "<cmd>FzfLua lsp_references<cr>", { desc = "References", silent = true })
vim.keymap.set("n", "gi", "<cmd>FzfLua lsp_implementations<cr>", { desc = "Goto Implementation", silent = true })
vim.keymap.set("n", "gT", "<cmd>FzfLua lsp_typedefs<cr>", { desc = "Goto Type Definition", silent = true })
