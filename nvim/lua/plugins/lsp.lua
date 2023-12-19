return{
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    dependencies = {
        -- LSP Support
        {'neovim/nvim-lspconfig'}, -- Required
        {
            'williamboman/mason.nvim', -- Optional
            build = function()
                pcall(vim.cmd, 'MasonUpdate')
            end,
        },
        {'williamboman/mason-lspconfig.nvim' }, -- Optional

        -- Autocompletion
        {'hrsh7th/nvim-cmp'}, -- Required
        {'hrsh7th/cmp-buffer'},
        {'hrsh7th/cmp-path'},
        {'saadparwaiz1/cmp_luasnip'},
        {'hrsh7th/cmp-nvim-lsp'}, -- Required
        {'hrsh7th/cmp-nvim-lua'},

        -- Snippets
        {'L3MON4D3/LuaSnip'}, -- Required
        {'rafamadriz/friendly-snippets'},
        {'nvim-java/nvim-java'},
    },

    config = function()
        local lsp = require("lsp-zero")

        lsp.preset("recommended")

        lsp.ensure_installed({
            'tsserver',
            'lua_ls',
            'jdtls',
            'html',
        })

        -- Fix Undefined global 'vim'
        lsp.nvim_workspace()


        local cmp = require('cmp')
        local cmp_select = {behavior = cmp.SelectBehavior.Select}
        local cmp_mappings = lsp.defaults.cmp_mappings({
            ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
            ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
            ['<C-y>'] = cmp.mapping.confirm({ select = true }),
            ["<C-Space>"] = cmp.mapping.complete(),
        })

        cmp_mappings['<Tab>'] = nil
        cmp_mappings['<S-Tab>'] = nil

        lsp.setup_nvim_cmp({
            mapping = cmp_mappings
        })

        lsp.set_preferences({
            suggest_lsp_servers = false,
            sign_icons = {
                error = 'E',
                warn = 'W',
                hint = 'H',
                info = 'I'
            }
        })

        lsp.on_attach(function(client, bufnr)
            local opts = {buffer = bufnr, remap = false}
            local keymap = vim.keymap.set
            opts.desc = "got to definition"
            keymap("n", "gd", function() vim.lsp.buf.definition() end, opts)
            opts.desc = "hover"
            keymap("n", "K", function() vim.lsp.buf.hover() end, opts)
            opts.desc = "workspace symbol"
            keymap("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
            opts.desc = "open float"
            keymap("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
            opts.desc = "got to next"
            keymap("n", "[d", function() vim.diagnostic.goto_next() end, opts)
            opts.desc = "got to prev"
            keymap("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
            opts.desc = "code action"
            keymap("n", "<leader>va", function() vim.lsp.buf.code_action() end, opts)
            opts.desc = "references"
            keymap("n", "<leader>vr", function() vim.lsp.buf.references() end, opts)
            opts.desc = "rename"
            keymap("n", "<leader>vn", function() vim.lsp.buf.rename() end, opts)
            opts.desc = "signature help"
            keymap("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
        end)
--        lsp.skip_server_setup({'jdtls'})
        require('lspconfig').jdtls.setup({})
        lsp.setup()

        vim.diagnostic.config({
            virtual_text = true
        })

    end
}
