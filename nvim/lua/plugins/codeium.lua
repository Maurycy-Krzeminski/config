return{
    "Exafunction/codeium.nvim",
    event = 'BufEnter',
    enabled = false,
    config = function()
        require("codeium").setup({
        })
    end
}
