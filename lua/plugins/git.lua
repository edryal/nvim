local git_repos = {
  ["logistica"] = vim.fn.expand("~/Projects/c-tower/logistica/"),
  ["corelogistca"] = vim.fn.expand("~/Projects/c-tower/corelogistica/"),
}

local function get_static_git_root()
  local path = vim.fn.expand("%:p")
  for _, repo_path in pairs(git_repos) do
    if path:find(repo_path, 1, true) then
      return repo_path
    end
  end
  return nil
end

return {
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "G" },
    keys = {
      { "<leader>gg", ":Ge:<cr>", mode = "n", desc = "Fugitive", silent = true, noremap = true },
      {
        "<leader>gh",
        function()
          require("fzf-lua").git_branches({
            prompt = "Pick Branch> ",
            cwd = get_static_git_root(),
            actions = {
              ["default"] = function(selected)
                if selected and #selected > 0 then
                  local branch = selected[1]
                  vim.cmd("Gvsplit " .. branch .. ":%")
                end
              end,
            },
          })
        end,
        mode = "n",
        desc = "Fugitive: VSplit file from branch",
        silent = true,
        noremap = true,
      },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "CursorHold",
    keys = {
      { "<leader>gr", ":Gitsigns reset_hunk<cr>", mode = { "n", "v" }, desc = "Reset Hunk", silent = true, noremap = true },
      { "<leader>gR", ":Gitsigns reset_buffer<cr>", mode = "n", desc = "Reset Buffer", silent = true, noremap = true },
      { "<leader>gp", ":Gitsigns preview_hunk<cr>", mode = "n", desc = "Preview Hunk", silent = true, noremap = true },
      { "<leader>gB", ":Gitsigns blame_line<cr>", mode = "n", desc = "Blame Line", silent = true, noremap = true },
      { "gn", ":Gitsigns next_hunk<cr>", mode = "n", desc = "Goto Next Git Hunk", silent = true, noremap = true },
      { "gp", ":Gitsigns prev_hunk<cr>", mode = "n", desc = "Goto Previous Git Hunk", silent = true, noremap = true },
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
        "<leader>gF",
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
        desc = "Diffview File History",
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
  },
}
