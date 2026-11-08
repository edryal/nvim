-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("vim._core.ui2").enable({})

require("options")
require("keymaps")
require("autocommands")
require("pack")
require("lsp")

vim.cmd.colorscheme("vague")
