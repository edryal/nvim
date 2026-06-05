require("blink.cmp").build():pwait()
require("blink.cmp").setup({
	keymap = { preset = "enter" },
	completion = { documentation = { auto_show = false } },
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
		default = { "lsp", "path", "buffer" },
		per_filetype = {
			lua = { "lazydev", inherit_defaults = true },
		},
		providers = {
			lazydev = { name = "LazyDev", module = "lazydev.integrations.blink", score_offset = 100 },
		},
	},
	fuzzy = { implementation = "rust" },
})
