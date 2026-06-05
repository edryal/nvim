require("fzf-lua").setup({
	winopts = {
		backdrop = 80,
		preview = {
			scrollbar = "float",
		},
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
	defaults = {
		formatter = { "path.filename_first" },
	},
})

-- Register fzf-lua as the backend for ui.select
require("fzf-lua").register_ui_select()
vim.keymap.set("n", "<leader>,", "<cmd>FzfLua buffers<cr>", { desc = "Open Buffers", silent = true })

-- Find
vim.keymap.set("n", "<leader>ff", "<cmd>FzfLua files<cr>", { desc = "Files", silent = true })
vim.keymap.set("n", "<leader>fq", "<cmd>FzfLua quickfix<cr>", { desc = "Quickfix List", silent = true })
vim.keymap.set("n", "<leader>fl", "<cmd>FzfLua files resume=true<cr>", { desc = "Last Files", silent = true })
vim.keymap.set(
	"n",
	"<leader>fw",
	"<cmd>FzfLua lsp_live_workspace_symbols<cr>",
	{ desc = "Workspace Symbols", silent = true }
)

local function config_files()
	return FzfLua.files({ cwd = vim.fn.stdpath("config") })
end
vim.keymap.set("n", "<leader>fc", config_files, { desc = "Config Files", silent = true })

local function old_cwd_files()
	return FzfLua.oldfiles({ cwd = vim.fn.getcwd() })
end
vim.keymap.set("n", "<leader>fr", old_cwd_files, { desc = "Recent Files", silent = true })

-- Search
vim.keymap.set("n", "<leader>sl", "<cmd>FzfLua live_grep_native<cr>", { desc = "Live Grep", silent = true })
vim.keymap.set("n", "<leader>sr", "<cmd>FzfLua live_grep resume=true<cr>", { desc = "Resume Live Grep", silent = true })
vim.keymap.set("n", "<leader>sw", "<cmd>FzfLua grep_cword<cr>", { desc = "Grep Word", silent = true })
vim.keymap.set("n", "<leader>sb", "<cmd>FzfLua lgrep_curbuf<cr>", { desc = "Live Grep Buffer", silent = true })
vim.keymap.set("v", "<leader>sw", "<cmd>FzfLua grep_cword<cr>", { desc = "Grep Word", silent = true })
vim.keymap.set("v", "<leader>ss", "<cmd>FzfLua grep_visual<cr>", { desc = "Grep Selection", silent = true })

-- Git
local git_util = require("utils.git-root-helper")

vim.keymap.set("n", "<leader>gb", function()
	FzfLua.git_branches({ cwd = git_util.get_static_git_root() })
end, { desc = "Branches", silent = true })

vim.keymap.set("n", "<leader>gs", function()
	FzfLua.git_status({ cwd = git_util.get_static_git_root() })
end, { desc = "Status", silent = true })

vim.keymap.set("n", "<leader>gS", function()
	FzfLua.git_stash({ cwd = git_util.get_static_git_root() })
end, { desc = "Stash", silent = true })

vim.keymap.set("n", "<leader>gC", function()
	FzfLua.git_commits({ cwd = git_util.get_static_git_root() })
end, { desc = "Commits", silent = true })

vim.keymap.set("n", "<leader>fg", function()
	FzfLua.git_files({ cwd = git_util.get_static_git_root() })
end, { desc = "Git Files", silent = true })

-- Lsp
vim.keymap.set("n", "gd", "<cmd>FzfLua lsp_definitions<cr>", { desc = "Goto Definition", silent = true })
vim.keymap.set("n", "gD", "<cmd>FzfLua lsp_declarations<cr>", { desc = "Goto Declaration", silent = true })
vim.keymap.set("n", "gr", "<cmd>FzfLua lsp_references<cr>", { desc = "References", silent = true })
vim.keymap.set("n", "gi", "<cmd>FzfLua lsp_implementations<cr>", { desc = "Goto Implementation", silent = true })
