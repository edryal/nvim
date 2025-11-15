local capabilities = require("utils.lsp").setup_capabilities()

local function custom_attach(client, bufnr)
  require("utils.lsp").attach_navic(client, bufnr)
end

return {
  cmd = { "pylsp" },
  filetypes = { "python" },
  root_markers = {
    "pyproject.toml",
    "setup.py",
    "setup.cfg",
    "requirements.txt",
    "Pipfile",
  },
  capabilities = capabilities,
  on_attach = custom_attach,
  single_file_support = true,
  settings = {
    pylsp = {
      configurationSources = { "flake8" },
      plugins = {
        pycodestyle = { enabled = false },
        flake8 = { enabled = true },
        pylsp_mypy = {
          enabled = true,
          live_mode = true,
          strict = false,
          dmypy = false,
          report_progress = true,
        },
        pyflakes = { enabled = false },
        mccabe = { enabled = false },
      },
    },
  },
}
