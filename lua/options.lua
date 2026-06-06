vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = false

vim.opt.wrap = false
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.laststatus = 3
vim.opt.showtabline = 0
vim.opt.winborder = "bold"

vim.opt.signcolumn = "yes"
vim.opt.termguicolors = true
vim.opt.cmdheight = 1
vim.opt.showmode = false
vim.opt.showmatch = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/Documents/neovim/undodir"
vim.opt.undofile = true

vim.opt.clipboard:append("unnamedplus")
vim.opt.isfname:append("@-@") -- useful when working with typescript
