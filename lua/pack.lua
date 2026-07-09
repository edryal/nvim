vim.pack.add({
	-- Dependencies
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/nvim-tree/nvim-web-devicons",
	-- Dependencies

	"https://github.com/mason-org/mason.nvim",
	"https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/mason-org/mason-lspconfig.nvim",
	"https://github.com/antosha417/nvim-lsp-file-operations",
	"https://github.com/olimorris/onedarkpro.nvim",
	"https://github.com/ojroques/nvim-bufdel",
	"https://github.com/tpope/vim-fugitive",
	"https://github.com/lewis6991/gitsigns.nvim",
	"https://github.com/folke/which-key.nvim",
	"https://github.com/nvim-mini/mini.pairs",
	"https://github.com/numToStr/Comment.nvim",
	"https://github.com/rpollard00/endofline-club.nvim",
	"https://github.com/mfussenegger/nvim-jdtls",
	"https://github.com/nvim-tree/nvim-tree.lua",
	"https://github.com/ibhagwan/fzf-lua",
	"https://github.com/folke/snacks.nvim",

	-- auto-completion stuff
	"https://github.com/saghen/blink.lib",
	{ src = "https://github.com/saghen/blink.cmp", branch = "main" },

	-- Pay attention because plugin was archived, remove when it finally breaks
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", branch = "main" },

	-- Fixes the annoying E828 error when writing to an undo file
	-- when you're working in big project with a lot of nested directories
	"https://github.com/pixelastic/vim-undodir-tree",

	"https://github.com/akinsho/toggleterm.nvim",
	"https://github.com/nvim-lualine/lualine.nvim",
	"https://github.com/j-hui/fidget.nvim",
	"https://github.com/MeanderingProgrammer/render-markdown.nvim",

	-- order matters
	"https://github.com/nvim-neotest/nvim-nio",
	"https://github.com/rcarriga/nvim-dap-ui",
	"https://github.com/theHamsta/nvim-dap-virtual-text",
	"https://github.com/mfussenegger/nvim-dap",
	"https://github.com/leoluz/nvim-dap-go",

	-- Optional (don't necessarily need them, but they're nice to have sometimes)
	"https://github.com/hedyhli/outline.nvim",
	"https://github.com/folke/lazydev.nvim",
})

-- Plugins that require configuration
require("plugins.onedarkpro")
require("plugins.vim-fugitive")
require("plugins.gitsigns")
require("plugins.which-key")
require("plugins.comment")
require("plugins.nvim-treesitter")
require("plugins.outline")
require("plugins.lualine")
require("plugins.nvim-tree")
require("plugins.blink")
require("plugins.mini-pairs")
require("plugins.endofline-club")
require("plugins.mason")
require("plugins.mason-lspconfig")
require("plugins.mason-tool-installer")
require("plugins.lsp-file-operations")
require("plugins.fidget")
require("plugins.render-markdown")
require("plugins.fzf-lua")
require("plugins.snacks")
require("plugins.toggleterm")

-- dap
require("plugins.dap")
