return {
    'nvim-telescope/telescope.nvim',
    dependencies = {'nvim-lua/plenary.nvim'},
    config = function()
        local keymap = vim.keymap.set
        local builtin = require('telescope.builtin')
        keymap("n", "<leader>ff", builtin.find_files, {desc = "Find files"})
        keymap("n", "<leader>fg", builtin.git_files, {desc = "Find git files"})
        keymap("n", "<leader>fh", builtin.help_tags, {desc = "Find help tag"})
        keymap("n", "<leader>fk", builtin.keymaps, {desc = "Find keymaps"})
        keymap("n", "<C-p>", builtin.live_grep, {desc = "Find live grep"})

    end
}
