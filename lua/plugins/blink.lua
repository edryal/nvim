return {
  "saghen/blink.cmp",
  dependencies = {
    "rafamadriz/friendly-snippets",
    {
      "folke/lazydev.nvim",
      ft = "lua",
      opts = {
        library = {
          {
            path = "${3rd}/luv/library",
            words = { "vim%.uv" },
          },
        },
      },
    },
  },
  event = "InsertEnter",
  version = "1.*",
  opts = function()
    return {
      keymap = {
        preset = "enter",
      },
      completion = {
        documentation = { auto_show = false },
      },
      signature = {
        enabled = true,
        window = {
          show_documentation = false,
          border = "rounded",
        },
      },
      cmdline = {
        keymap = {
          preset = "cmdline",
        },
        completion = {
          menu = {
            auto_show = true,
          },
          ghost_text = {
            enabled = false,
          },
        },
      },
      appearance = {
        nerd_font_variant = "mono",
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
        per_filetype = {
          lua = { "lazydev", inherit_defaults = true },
        },
        providers = {
          lazydev = { name = "LazyDev", module = "lazydev.integrations.blink", score_offset = 100 },
        },
      },
      fuzzy = { implementation = "prefer_rust_with_warning" },
    }
  end,
  opts_extend = { "sources.default" },
}
