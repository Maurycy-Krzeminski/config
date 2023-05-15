vim.g.mapleader = " "
local keymap = vim.keymap.set
keymap("n", "<leader>vv", vim.cmd.Ex)
keymap("n", "<leader>f", vim.lsp.buf.format)


