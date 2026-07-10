require("which-key").setup({
	spec = {
		{
			mode = { "n" },
			{ "<leader>d", group = "Debug" },
			{ "<leader>f", group = "Find" },
			{ "<leader>w", group = "Window" },
			{ "<leader>t", group = "Toggle" },
			{ "<leader>n", group = "Notifications" },
			{ "<leader>m", group = "Markdown" },
			{ "<leader>o", group = "Open" },
			{ "<leader>b", group = "Buffers" },
			{ "<leader>r", group = "Reload" },
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
			{ "<leader>g", group = "Git" },
			{ "<leader>s", group = "Search" },
		},
	},
})
