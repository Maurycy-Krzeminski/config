local opt = vim.opt
--opt.guicursor = ""

opt.nu = true -- Print line number
opt.relativenumber = true -- Relative line numbers
opt.tabstop = 4 -- Number of spaces tabs count for
opt.softtabstop = 4
opt.shiftwidth = 4 -- Size of an indent
opt.expandtab = true -- Use spaces instead of tabs
opt.smartindent = true -- Insert indents automatically
opt.wrap = false
opt.hlsearch = false
opt.incsearch = true
opt.scrolloff = 8
opt.signcolumn = "yes"
opt.isfname:append("@-@")
--opt.colorcolumn = "80"

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true


-- Decrease update time
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300


-- Save undo history
vim.o.undofile = true


