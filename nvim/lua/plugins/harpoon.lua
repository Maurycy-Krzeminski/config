return {
	"theprimeagen/harpoon",
  dependencies = { 'nvim-lua/plenary.nvim' },
  enabled = false,
	config = function()
		local keymap = vim.keymap.set
		local mark = require("harpoon.mark")
		local ui = require("harpoon.ui")

		keymap("n", "<leader>a", mark.add_file, {desc = "add file to harpoon"})
		keymap("n", "<C-q>", ui.toggle_quick_menu, {desc = "Harpoon quick menu"})

		keymap("n", "<C-a>", function() ui.nav_file(1) end)
		keymap("n", "<C-s>", function() ui.nav_file(2) end)
		keymap("n", "<C-d>", function() ui.nav_file(3) end)
		keymap("n", "<C-f>", function() ui.nav_file(4) end)


	end
}
