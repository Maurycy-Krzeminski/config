return{
	'nvim-telescope/telescope.nvim',
	dependencies = { 'nvim-lua/plenary.nvim'},
	config = function ()
		local keymap = vim.keymap.set
		local builtin = require('telescope.builtin')
		--local opts = { silent = true }
		local opts = {}
		keymap("n", "<leader>ff", ":Telescope find_files<CR>", opts)
		keymap("n", "<C-p>", function()
			builtin.grep_string({ search = vim.fn.input("Grep > ") })
		end, opts)

		keymap("n", "<leader>fh", ":Telescope help_tags<CR>", opts)
		keymap("n", "<leader>fk", ":Telescope keymaps<CR>", opts)
		keymap('n', '<leader>vh', builtin.help_tags, opts)
	end
}


