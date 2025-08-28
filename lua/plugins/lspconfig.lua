return {
  {
    "neovim/nvim-lspconfig",
  },
  {
    "mason-org/mason.nvim",
    opts = {},
  },
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "mason-org/mason.nvim",
    },
    config = function()
      local features = require("settings.features")
      local lsps = { "lua_ls", "marksman" }

      local function add(lsp)
        table.insert(lsps, lsp)
      end

      if vim.fn.has("unix") == 1 then
        add("bashls")
      end

      if features.go.enabled then
        add("gopls")
      end

      if features.java.enabled then
        add("jdtls")
        add("lemminx")
      end

      if features.web.enabled then
        add("html")
        add("cssls")
        add("jsonls")
        add("vtsls")
        add("angularls")
      end

      require("mason-lspconfig").setup({
        automatic_enable = false,
        ensure_installed = lsps,
      })

      vim.lsp.enable(lsps)
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
    },
    config = function()
      local features = require("settings.features")
      local tools = { "stylua", "markdown-toc" }

      local function add(tool)
        table.insert(tools, tool)
      end

      if vim.fn.has("unix") == 1 then
        add("shellcheck")
        add("shfmt")
      end

      if features.go.enabled then
        add("goimports")
        if features.go.debugger then
          add("delve")
        end
      end

      if features.java.enabled then
        add("java-test")
        add("vscode-spring-boot-tools")
        if features.java.debugger then
          add("java-debug-adapter")
        end
      end

      if features.web.enabled then
        add("prettier")
      end

      require("mason-tool-installer").setup({
        ensure_installed = tools,
      })
    end,
  },
  {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    config = function()
      require("lsp_lines").setup()

      local function toggle_diagnostic_display()
        require("lsp_lines").toggle()
        local virtual_text = not vim.diagnostic.config().virtual_text
        vim.diagnostic.config({ virtual_text = virtual_text })
      end

      local set = vim.keymap.set
      set("n", "<leader>tl", toggle_diagnostic_display, Expand_Opts("Diagnostics Style"))
    end,
  },
}
