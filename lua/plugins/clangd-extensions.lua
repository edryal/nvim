local features = require("settings.features")

if not features.cpp.enabled then
  return {}
end

return {
  "p00f/clangd_extensions.nvim",
  lazy = true,
  opts = {},
}
