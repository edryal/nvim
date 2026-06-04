local black = "#1a1b26"
local red = "#d95f73"
local purple = "#c678dd"
local yellow = "#e5c07b"
local orange = "#d19a66"
local green = "#9ece6a"
local blue = "#3d59a1"

require("onedarkpro").setup({
	plugins = { all = true },
	styles = {
		comments = "italic",
		keywords = "bold,italic",
		conditionals = "italic",
	},
	colors = {
		onedark = { bg = black },
	},
	highlights = {
		NvimTreeRootFolder = { link = "Normal", style = "bold" },
		NvimTreeFolderIcon = { fg = red },
		NvimTreeOpenedFolderName = { fg = red },

		-- Java
		["@attribute"] = { fg = yellow, italic = true },
		["@lsp.type.modifier.java"] = { fg = purple },
		["@parameter"] = { fg = orange },
		["@variable.builtin"] = { fg = purple, italic = true },
        ["@function.builtin.java"] = { fg = purple, italic = true }
	},
	options = {
		cursorline = false,
		trasparency = true,
	},
})
