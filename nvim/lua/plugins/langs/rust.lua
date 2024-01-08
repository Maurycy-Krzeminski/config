if not require("config").rust then
    return{}
end

return {
    -- Add rust to treesitter.
    {
        "nvim-treesitter/nvim-treesitter",
        opts = function(_, opts)
            opts.ensure_installed = opts.ensure_installed or {}
            vim.list_extend(opts.ensure_installed, { "rust" })
        end,
    },
    {

    },
}
