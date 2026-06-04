require("lualine").setup({
	options = {
		component_separators = { left = "|", right = "|" },
		-- section_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		-- disabled_filetypes = {
		-- 	statusline = { "NvimTree", "fugitive", "nvim-undotree", "toggleterm" },
		-- },
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = {
			{
				"filename",
				-- 0: Just the filename
				-- 1: Relative path
				-- 2: Absolute path
				path = 0,
			},
		},
		lualine_x = { "encoding", "filetype", "lsp_status" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
})
