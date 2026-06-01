local tools = {
	"stylua",
	"shellcheck",
	"shfmt",
	"goimports",
	"delve",
	"java-test",
	"vscode-spring-boot-tools",
	"java-debug-adapter",
	"prettier",
}

require("mason-tool-installer").setup({ ensure_installed = tools })
