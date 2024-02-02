if not require("config").ai then
    return{}
end

return {
  {
    "sourcegraph/sg.nvim",
    dependencies = { "nvim-lua/plenary.nvim", --[[ "nvim-telescope/telescope.nvim ]] },
        config = function ()
            -- Sourcegraph configuration. All keys are optional
            require("sg").setup {
                -- Pass your own custom attach function
                --    If you do not pass your own attach function, then the following maps are provide:
                --        - gd -> goto definition
                --        - gr -> goto references
            }
        end
    },
}
