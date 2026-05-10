return {
  "hedyhli/outline.nvim",
  lazy = true,
  cmd = { "Outline", "OutlineOpen" },
  keys = {
    { "<leader>oo", ":Outline<cr>", mode = "n", desc = "Outline", silent = true, noremap = true },
  },
  opts = {
    outline_window = {
      auto_jump = true,
    },
    symbols = {
      filter = {
        jdtls = { "Function", "Class" },
      },
    },
  },
}
