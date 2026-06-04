-- used when the project is badly designed with multiple modules
local M = {
	git_repos = {
		["logistica"] = vim.fn.expand("~/Projects/c-tower/logistica/"),
		["corelogistca"] = vim.fn.expand("~/Projects/c-tower/corelogistica/"),
	},
}

M.get_static_git_root = function()
	local path = vim.fn.expand("%:p")
	for _, repo_path in pairs(M.git_repos) do
		if path:find(repo_path, 1, true) then
			return repo_path
		end
	end
	return nil
end

return M
