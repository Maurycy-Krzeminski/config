if not require("config").tsx then
    return{}
end

return {
    -- Add web to treesitter.
    {
        "nvim-treesitter/nvim-treesitter",
        opts = function(_, opts)
            opts.ensure_installed = opts.ensure_installed or {}
            vim.list_extend(opts.ensure_installed, { "tsx" })
        end,
    },
    {

    },
}
