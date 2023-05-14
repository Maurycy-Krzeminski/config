return {
	"theprimeagen/harpoon",

	config = function()
		local keymap = vim.keymap.set
		local mark = require("harpoon.mark")
		local ui = require("harpoon.ui")

		keymap("n", "<leader>a", mark.add_file)
		keymap("n", "<C-q>", ui.toggle_quick_menu)

		keymap("n", "<C-a>", function() ui.nav_file(1) end)
		keymap("n", "<C-s>", function() ui.nav_file(2) end)
		keymap("n", "<C-d>", function() ui.nav_file(3) end)
		keymap("n", "<C-f>", function() ui.nav_file(4) end)


	end
}
