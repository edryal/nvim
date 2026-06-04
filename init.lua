-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("vim._core.ui2").enable({})

require("options")
require("autocommands")
require("keymaps")
require("pack")
require("lsp")

vim.cmd.colorscheme("onedark")
