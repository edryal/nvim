return {
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "G" },
    keys = { { "<leader>gg", ":Ge:<cr>", mode = "n", desc = "Fugitive", silent = true, noremap = true } },
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "CursorHold",
    keys = {
      { "<leader>gr", ":Gitsigns reset_hunk<cr>", mode = "n", desc = "Reset Hunk", silent = true, noremap = true },
      { "<leader>gR", ":Gitsigns reset_buffer<cr>", mode = "n", desc = "Reset Buffer", silent = true, noremap = true },
      { "<leader>gp", ":Gitsigns preview_hunk<cr>", mode = "n", desc = "Preview Hunk", silent = true, noremap = true },
      { "<leader>gB", ":Gitsigns blame_line<cr>", mode = "n", desc = "Blame Line", silent = true, noremap = true },
    },
    opts = {
      signcolumn = true,
      current_line_blame = true,
      current_line_blame_opts = {
        delay = 1200,
        virtual_text_pos = "eol",
      },
    },
  },
  {
    "akinsho/git-conflict.nvim",
    version = "*",
    cmd = {
      "GitConflictChooseOurs",
      "GitConflictChooseTheirs",
      "GitConflictChooseBoth",
      "GitConflictChooseNone",
      "GitConflictPrevConflict",
      "GitConflictNextConflict",
      "GitConflictListQf",
    },
    keys = {
      { "<leader>gco", ":GitConflictChooseOurs<cr>", mode = "n", desc = "Choose Ours", silent = true, noremap = true },
      { "<leader>gct", ":GitConflictChooseTheirs<cr>", mode = "n", desc = "Choose Theirs", silent = true, noremap = true },
      { "<leader>gcb", ":GitConflictChooseBoth<cr>", mode = "n", desc = "Choose Both", silent = true, noremap = true },
      { "<leader>gc0", ":GitConflictChooseNone<cr>", mode = "n", desc = "Choose None", silent = true, noremap = true },
      { "<leader>gcp", ":GitConflictPrevConflict<cr>", mode = "n", desc = "Previous Conflict", silent = true, noremap = true },
      { "<leader>gcn", ":GitConflictNextConflict<cr>", mode = "n", desc = "Next Conflict", silent = true, noremap = true },
      { "<leader>gcq", ":GitConflictListQf<cr>", mode = "n", desc = "Quickfix List", silent = true, noremap = true },
    },
    config = function()
      require("git-conflict").setup({
        default_mappings = false,
        default_commands = true,
        disable_diagnostics = false,
        list_opener = "copen",
        highlights = {
          incoming = "DiffAdd",
          current = "DiffText",
        },
        debug = false,
      })
    end,
  },
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
    keys = {
      {
        "<leader>gh",
        function()
          local lib = require("diffview.lib")
          local view = lib.get_current_view()
          if view then
            vim.cmd.DiffviewClose()
          else
            vim.cmd.DiffviewFileHistory()
          end
        end,
        mode = "n",
        desc = "Diffview History",
        silent = true,
        noremap = true,
      },
      {
        "<leader>gd",
        function()
          local lib = require("diffview.lib")
          local view = lib.get_current_view()
          if view then
            vim.cmd.DiffviewClose()
          else
            vim.cmd.DiffviewOpen()
          end
        end,
        mode = "n",
        desc = "Diffview",
        silent = true,
        noremap = true,
      },
    },
    opts = {
      use_icons = true,
      enhanced_diff_hl = true, -- See ':h diffview-config-enhanced_diff_hl'
      view = {
        default = { layout = "diff2_horizontal" },
        merge_tool = {
          layout = "diff4_mixed",
          disable_diagnostics = true,
        },
      },
    },
  },
}
