if not require("config").web then
    return{}
end

return {
    -- Add web to treesitter.
    {
        "nvim-treesitter/nvim-treesitter",
        opts = function(_, opts)
            opts.ensure_installed = opts.ensure_installed or {}
            vim.list_extend(opts.ensure_installed, { "javascript", "jsdoc", "typescript" })
        end,
    },
    -- Automatically add closing tags for HTML and JSX
    {
        "windwp/nvim-ts-autotag",
        event = "VeryLazy",
        opts = {},
    },
}
