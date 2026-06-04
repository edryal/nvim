local M = {}

M.setup_capabilities = function(custom_overrides)
	local capabilities = vim.lsp.protocol.make_client_capabilities()

	vim.lsp.inlay_hint.enable(false)

	-- Apply any custom overrides passed by the caller
	-- This allows, for example, JDTLS to set snippetSupport = false
	if custom_overrides then
		capabilities = vim.tbl_deep_extend("force", capabilities, custom_overrides)
	end

	-- Integrate blink.cmp capabilities
	if pcall(require, "blink.cmp") then
		capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)
	else
		vim.notify("blink.cmp not found, skipping blink capabilities.", vim.log.levels.WARN)
	end

	return capabilities
end

return M
