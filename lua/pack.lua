local features = require("features")

local plugin_urls = {
    -- only dependencies
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/nvim-tree/nvim-web-devicons",

    -- actual plugins
    "https://github.com/mason-org/mason.nvim",
    "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
    "https://github.com/antosha417/nvim-lsp-file-operations",
    "https://github.com/tpope/vim-fugitive",
    "https://github.com/lewis6991/gitsigns.nvim",
    "https://github.com/folke/which-key.nvim",
    "https://github.com/nvim-mini/mini.pairs",
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
    "https://github.com/3rd/image.nvim",
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
    if features.java.lsp == "jdtls" then
        table.insert(plugin_urls, "https://github.com/mfussenegger/nvim-jdtls")
        if features.java.springboot then
            table.insert(plugin_urls, "https://github.com/JavaHello/spring-boot.nvim")
        end
    elseif features.java.lsp == "intellij" then
        table.insert(plugin_urls, "https://github.com/JetBrains/intellij-lsp.nvim")
    end
end

if features.go and features.go.enabled then
    table.insert(plugin_urls, "https://github.com/leoluz/nvim-dap-go")
end

if features.rust and features.rust.enabled then
    table.insert(plugin_urls, { src = "https://github.com/mrcjkb/rustaceanvim", version = vim.version.range("^9") })
    table.insert(plugin_urls, { src = "https://github.com/saecki/crates.nvim", version = "stable" })
end

if features.database and features.database.enabled then
    table.insert(plugin_urls, "https://github.com/tpope/vim-dadbod")
    table.insert(plugin_urls, "https://github.com/kristijanhusak/vim-dadbod-ui")
    table.insert(plugin_urls, "https://github.com/kristijanhusak/vim-dadbod-completion")
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
require("plugins.nvim-treesitter")
require("plugins.outline")
require("plugins.lazydev")
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
require("plugins.image")

if features.markdown and features.markdown.enabled then
    require("plugins.render-markdown")
end

if features.discord_presence and features.discord_presence.enabled then
    require("plugins.cord")
end

if features.java and features.java.enabled then
    if features.java.lsp == "jdtls" and features.java.springboot then
        require("plugins.spring-boot")
    elseif features.java.lsp == "intellij" then
        require("plugins.intellij")
    end
end

if features.rust and features.rust.enabled then
    require("plugins.rustaceanvim")
    require("plugins.crates")
end

if features.database and features.database.enabled then
    require("plugins.dadbod")
end

require("plugins.nvim-dap")
