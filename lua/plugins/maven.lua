return {
  "eatgrass/maven.nvim",
  ft = { "java", "xml" },
  cmd = { "Maven", "MavenExec" },
  dependencies = "nvim-lua/plenary.nvim",
  config = function()
    require("maven").setup({
      executable = "mvn",
    })

    local map = vim.api.nvim_set_keymap
    map("n", "<leader>mm", ":Maven<cr>", Expand_Opts("Open Menu"))
    map("n", "<leader>me", ":MavenExec<cr>", Expand_Opts("Execute Manually"))
  end,
}
