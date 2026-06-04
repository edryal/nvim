local capabilities = require("utils.lsp-setup").setup_capabilities()

-- TODO: Implement keymaps for lsp code actions,
-- since vtsls is only a wrapper for the vscode lsp.
-- code actions: https://github.com/yioneko/vtsls?tab=readme-ov-file#code-actions

return {
	cmd = { "vtsls", "--stdio" },
	filetypes = {
		"javascript",
		"javascriptreact",
		"javascript.jsx",
		"typescript",
		"typescriptreact",
		"typescript.tsx",
		"jsp",
	},
	root_markers = { "tsconfig.json", "package.json", "jsconfig.json", ".git" },
	capabilities = capabilities,
	settings = {
		complete_function_calls = true,
		vtsls = {
			enableMoveToFileCodeAction = true,
			autoUseWorkspaceTsdk = true,
			experimental = {
				completion = {
					enableServerSideFuzzyMatch = true,
				},
			},
		},
		typescript = {
			updateImportsOnFileMove = { enabled = "always" },
			suggest = {
				completeFunctionCalls = true,
			},
		},
	},
}
