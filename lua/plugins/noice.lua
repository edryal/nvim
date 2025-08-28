return {
  "folke/noice.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
    -- "rcarriga/nvim-notify",
  },
  event = "VeryLazy",
  config = function()
    require("noice").setup({
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
        },
        progress = {
          enabled = false,
        },
        signature = {
          enabled = false,
        },
      },
      presets = {
        bottom_search = true,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = true,
        command_palette = {
          views = {
            cmdline_popup = {
              position = {
                row = "50%",
                col = "50%",
              },
              size = {
                min_width = 60,
                width = "auto",
                height = "auto",
              },
            },
            cmdline_popupmenu = {
              position = {
                row = "67%",
                col = "50%",
              },
            },
          },
        },
      },
    })

    local map = vim.api.nvim_set_keymap
    map("n", "<leader>nh", ":Noice fzf<cr>", Expand_Opts("History"))
    map("n", "<leader>nd", ":NoiceDismiss<cr>", Expand_Opts("Dismiss All"))
  end,
}
