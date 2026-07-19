local features = require("features")

local plugin_urls = {
    -- only dependencies
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/nvim-tree/nvim-web-devicons",

    -- actual plugins
    "https://github.com/mason-org/mason.nvim",
    "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/antosha417/nvim-lsp-file-operations",
    "https://github.com/ojroques/nvim-bufdel",
    "https://github.com/tpope/vim-fugitive",
    "https://github.com/lewis6991/gitsigns.nvim",
    "https://github.com/folke/which-key.nvim",
    "https://github.com/nvim-mini/mini.pairs",
    "https://github.com/numToStr/Comment.nvim",
    "https://github.com/rpollard00/endofline-club.nvim",
    "https://github.com/nvim-tree/nvim-tree.lua",
    "https://github.com/ibhagwan/fzf-lua",
    "https://github.com/folke/snacks.nvim",
    "https://github.com/saghen/blink.lib",
    { src = "https://github.com/saghen/blink.cmp",                branch = "main" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", branch = "main" },
    "https://github.com/pixelastic/vim-undodir-tree",
    "https://github.com/akinsho/toggleterm.nvim",
    "https://github.com/nvim-lualine/lualine.nvim",
    "https://github.com/j-hui/fidget.nvim",
    -- order matters
    "https://github.com/nvim-neotest/nvim-nio",
    "https://github.com/rcarriga/nvim-dap-ui",
    "https://github.com/theHamsta/nvim-dap-virtual-text",
    "https://github.com/mfussenegger/nvim-dap",
    -- optional
    "https://github.com/hedyhli/outline.nvim",
    "https://github.com/folke/lazydev.nvim",
    -- colorschemes
    "https://github.com/olimorris/onedarkpro.nvim",
    "https://github.com/nyoom-engineering/oxocarbon.nvim",
    "https://github.com/rebelot/kanagawa.nvim",
    "https://github.com/vague-theme/vague.nvim",
    "https://github.com/ellisonleao/gruvbox.nvim",
    { src = "https://github.com/rose-pine/neovim", name = "rose-pine" },
    { src = "https://github.com/catppuccin/nvim",  name = "catppuccin" }
}

if features.markdown and features.markdown.enabled then
    table.insert(plugin_urls, "https://github.com/MeanderingProgrammer/render-markdown.nvim")
end

if features.discord_presence and features.discord_presence.enabled then
    table.insert(plugin_urls, "https://github.com/vyfor/cord.nvim")
end

if features.java and features.java.enabled then
    table.insert(plugin_urls, "https://github.com/mfussenegger/nvim-jdtls")
    if features.java.springboot then
        table.insert(plugin_urls, "https://github.com/JavaHello/spring-boot.nvim")
    end
end

if features.go and features.go.enabled then
    table.insert(plugin_urls, "https://github.com/leoluz/nvim-dap-go")
end

vim.pack.add(plugin_urls)

-- plugins that require configuration and setup
require("plugins.onedarkpro")
require("plugins.kanagawa")
require("plugins.vague")
require("plugins.rose-pine")
require("plugins.catppuccin")
require("plugins.gruvbox")
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
require("plugins.mason-tool-installer")
require("plugins.lsp-file-operations")
require("plugins.fidget")
require("plugins.fzf-lua")
require("plugins.snacks")
require("plugins.toggleterm")

if features.markdown and features.markdown.enabled then
    require("plugins.render-markdown")
end

if features.discord_presence and features.discord_presence.enabled then
    require("plugins.cord")
end

if features.java and features.java.enabled then
    if features.java.springboot then
        require("plugins.spring-boot")
    end
end

require("plugins.nvim-dap")
