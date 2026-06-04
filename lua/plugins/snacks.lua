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

vim.keymap.set("n", "<leader>nd", function()
	Snacks.notifier.hide()
end, { desc = "Dismiss All Notifications" })

vim.keymap.set("n", "<leader>nh", function()
	Snacks.notifier.show_history()
end, { desc = "Notification History" })
