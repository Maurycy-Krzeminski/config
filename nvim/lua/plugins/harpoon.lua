return {
    "theprimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        local harpoon = require("harpoon")
        -- REQUIRED
        harpoon:setup()

        -- KEYMAPS
        local keymap = vim.keymap.set
        keymap("n", "<leader>a", function() harpoon:list():append() end, {desc = "add file to harpoon"})
        keymap("n", "<C-q>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, {desc = "Harpoon quick menu"})
        keymap("n", "<C-a>", function() harpoon:list():select(1) end, {desc = "Harpoon select 1"})
        keymap("n", "<C-s>", function() harpoon:list():select(2) end, {desc = "Harpoon select 2"})
        keymap("n", "<C-d>", function() harpoon:list():select(3) end, {desc = "Harpoon select 3"})
        keymap("n", "<C-f>", function() harpoon:list():select(4) end, {desc = "Harpoon select 4"})


	end
}
