return {
  "folke/which-key.nvim",
  event = "VimEnter",
  opts = {
    spec = {
      {
        mode = { "n" },
        { "<leader>d", group = "Debug" },
        { "<leader>f", group = "Find" },
        { "<leader>w", group = "Window" },
        { "<leader>t", group = "Toggle" },
        { "<leader>n", group = "Notification" },
        { "<leader>o", group = "Open" },
        { "<leader>b", group = "Buffers" },
        { "<leader>cd", group = "Diagnostics" },
        { "<leader>gc", group = "Conflict" },

        -- Java
        { "<leader>m", group = "Maven" },
        { "<leader>jt", group = "Test" },
        { "<leader>jg", group = "Generate" },
        { "<leader>jj", group = "Jacoco" },
      },
      {
        mode = { "n", "v" },
        { "<leader>c", group = "Code" },
        { "<leader>j", group = "Java" },
        { "<leader>g", group = "Git" },
        { "<leader>s", group = "Search" },
        { "<leader>je", group = "Extract" },
      },
    },
  },
}
