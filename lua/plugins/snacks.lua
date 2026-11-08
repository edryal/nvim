-- used only for nice input and notifications
require("snacks").setup({
    input = { enabled = true },
    notifier = { enabled = true },
    styles = {
        input = {
            position = "float",
            height = 1,
            width = 80,
            b = { completion = false },
        },
    },
})

-- Notifications
vim.keymap.set("n", "<leader>nd", function() Snacks.notifier.hide() end, { desc = "Dismiss All Notifications" })
vim.keymap.set("n", "<leader>nh", function() Snacks.notifier.show_history() end, { desc = "Notification History" })

-- Buffers
vim.keymap.set("n", "<leader>bo", function() Snacks.bufdelete.other() end,
    { desc = "Close All Other Buffers", silent = true })

vim.keymap.set("n", "<leader>bd", function() Snacks.bufdelete() end,
    { desc = "Close Current Buffer", silent = true })
