return {
  "stevearc/conform.nvim",
  lazy = true,
  event = "LspAttach",
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        lua = { "stylua" },
        go = { "goimports" },
        python = { "black" },
        cpp = { "clang-format" },
        html = { "prettier" },
        css = { "prettier" },
        json = { "prettier" },
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
      },
    })
  end,
}
