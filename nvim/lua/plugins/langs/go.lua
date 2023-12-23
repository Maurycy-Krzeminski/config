if not require("config").golang then
    return{}
end
return{
    {
        "nvim-treesitter/nvim-treesitter",
        opts = function(_, opts)
            vim.list_extend(opts.ensure_installed, {
                "go",
                "gomod",
                "gowork",
                "gosum",
            })
        end,
    },
    {
        "leoluz/nvim-dap-go",
        config = true,
    },
    {
        "nvim-neotest/neotest-go",
    },
    {
        "mfussenegger/nvim-dap",
        optional = true,
        dependencies = {
            {
                "williamboman/mason.nvim",
                opts = function(_, opts)
                    opts.ensure_installed = opts.ensure_installed or {}
                    vim.list_extend(opts.ensure_installed, { "delve" })
                end,
            },
            {
                "leoluz/nvim-dap-go",
                config = true,
            },
        },
    }
}
