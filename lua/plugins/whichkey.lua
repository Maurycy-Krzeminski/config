return{
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
    end,
    keys = { "<leader>" },
	config = function()
		local which_key = require("which-key")

		which_key.setup({
			plugins = {
				spelling = {
					enabled = true,
					suggestions = 20,
				},
			},
			window = {
				border = "shadow",
				position = "bottom",
--				margin = { 0, 1, 1, 5 },
--				padding = { 1, 2, 1, 2 },
			},
		})

		local opts = {
			prefix = "<leader>",
		}

		local groups = {
			f = { name = "Telescope" },
            n = { name = "Noice" },
			["<tab>"] = { name = "tabs" },
		}

		which_key.register(groups, opts)
	end,
}
