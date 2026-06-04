local function custom_attach(bufnr)
	local api = require("nvim-tree.api")

	local function opts(desc)
		return { desc = "NvimTree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end

	-- default mappings
	api.map.on_attach.default(bufnr)

	-- delete useless binds
	vim.keymap.del("n", "m", { buffer = bufnr })
	vim.keymap.del("n", "bd", { buffer = bufnr })
	vim.keymap.del("n", "bt", { buffer = bufnr })
	vim.keymap.del("n", "bmv", { buffer = bufnr })

	-- custom mappings
	vim.keymap.set("n", "<C-t>", api.tree.change_root_to_parent, opts("Up"))
	vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
end

require("nvim-tree").setup({
	on_attach = custom_attach,
	sync_root_with_cwd = true,
	respect_buf_cwd = true,
	renderer = {
		group_empty = true,
		highlight_modified = "name",
	},

	-- ✗  unstaged
	-- ✓  staged
	--   unmerged
	-- ➜  renamed
	-- ★  untracked
	--   deleted
	-- ◌  ignored
	git = {
		enable = true,
		disable_for_dirs = {
			"build",
			"node_modules",
			"target",
		},
	},
	update_focused_file = {
		enable = false,
		update_root = {
			enable = true,
			ignore_list = { "fugitive" },
		},
	},
	view = {
		adaptive_size = true,
	},
	filters = {
		dotfiles = false,
	},
})

vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "Explorer", silent = true })
vim.keymap.set("n", "<leader>ft", "<cmd>NvimTreeFindFile<cr>", { desc = "Find File In NvimTree", silent = true })
