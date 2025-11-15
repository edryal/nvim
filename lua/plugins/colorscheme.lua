local colors = require("utils.colors")

return {
  {
    "olimorris/onedarkpro.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      plugins = {
        all = true,
      },
      styles = {
        comments = "italic",
        keywords = "bold,italic",
        conditionals = "italic",
      },
      colors = {
        onedark = { bg = colors.black },
      },
      highlights = {
        NvimTreeRootFolder = { fg = colors.red, style = "bold" },
        NvimTreeFolderIcon = { fg = colors.red },
        NvimTreeOpenedFolderName = { fg = colors.red },

        -- Java
        ["@attribute"] = { fg = colors.yellow, italic = true },
        ["@lsp.type.modifier.java"] = { fg = colors.purple },
        ["@parameter"] = { fg = colors.orange },
        ["@variable.builtin"] = { fg = colors.purple, italic = true },
      },
      options = {
        cursorline = false,
        trasparency = true,
      },
    },
    init = function()
      vim.cmd.colorscheme("onedark")
    end,
  },
  {
    "folke/tokyonight.nvim",
    event = "ColorScheme",
  },
  {
    "nyoom-engineering/oxocarbon.nvim",
  },
  {
    "brenoprata10/nvim-highlight-colors",
    event = "BufEnter",
    keys = {
      { "<leader>th", ":HighlightColors Toggle<cr>", mode = "n", desc = "Color Highlighting", silent = true, noremap = true },
    },
    opts = {
      render = "background",
      enable_hex = true,
      enable_short_hex = true,
      enable_rgb = true,
      enable_hsl = true,
      enable_ansi = true,
      enable_hsl_without_function = true,
      enable_var_usage = true,
      enable_named_colors = true,
      exclude_filetypes = {},
      exclude_buftypes = {},
    },
  },
}
