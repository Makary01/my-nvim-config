return {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'saadparwaiz1/cmp_luasnip',
        {
            'L3MON4D3/LuaSnip',
            version = 'v2.*',
            build = 'make install_jsregexp',
            dependencies = {
                'rafamadriz/friendly-snippets',
                config = function()
                    require('luasnip.loaders.from_vscode').lazy_load()
                    require('luasnip.loaders.from_lua').lazy_load({
                        paths = "~/.config/nvim/lua/snippets/"
                    })
                end,
            },
        },
        {
            'windwp/nvim-autopairs',
            event = "InsertEnter",
            config = function()
                require('nvim-autopairs').setup({})
            end
        },
    },

    config = function()
        local cmp = require('cmp')
        local cmp_autopairs = require('nvim-autopairs.completion.cmp')
        local luasnip = require('luasnip')

        -- highlight when in snippet
        vim.api.nvim_create_autocmd("ModeChanged", {
            pattern = "*",
            callback = function()
                if luasnip.in_snippet() then
                    vim.wo.colorcolumn = "80"
                else
                    vim.wo.colorcolumn = ""
                end
            end
        })

        cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

        local custom_border = {
            { "╭", "CmpBorder" },
            { "─", "CmpBorder" },
            { "╮", "CmpBorder" },
            { "│", "CmpBorder" },
            { "╯", "CmpBorder" },
            { "─", "CmpBorder" },
            { "╰", "CmpBorder" },
            { "│", "CmpBorder" },
        }

        cmp.setup({
            experimental = {
                ghost_text = true,
            },
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },

            mapping = {
                ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
                ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<Tab>'] = cmp.mapping(function(fallback)
                    if luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
                ['<S-Tab>'] = cmp.mapping(function(fallback)
                    if luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { 'i', 's' })
            },

            window = {
                completion = {
                    border = custom_border,
                },
                documentation = {
                    border = custom_border,
                },
            },


            sources = {
                { name = 'luasnip',  label = 'Snip' },
                { name = 'nvim_lsp', label = 'LSP' },
                { name = 'html-css', label = 'CSS' },
                { name = 'buffer',   label = 'Buf' },
                { name = 'path',     label = 'Path' },
            },

            formatting = {
                fields = { 'abbr', 'icon', 'kind', 'menu' },
                format = function(entry, item)
                    local kind_icons = {
                        Text = "󰉿",
                        Method = "󰆧",
                        Function = "󰊕",
                        Constructor = "",
                        Field = "󰜢",
                        Variable = "󰀫",
                        Class = "󰠱",
                        Interface = "",
                        Module = "",
                        Property = "󰜢",
                        Unit = "󰑭",
                        Value = "󰎠",
                        Enum = "",
                        Keyword = "󰌋",
                        Snippet = "",
                        Color = "󰏘",
                        File = "󰈙",
                        Reference = "󰈇",
                        Folder = "󰉋",
                        EnumMember = "",
                        Constant = "󰏿",
                        Struct = "󰙅",
                        Event = "",
                        Operator = "󰆕",
                        TypeParameter = "",
                    }

                    -- icon + kind name
                    item.kind = string.format("%s %s", kind_icons[item.kind] or "", item.kind)

                    item.menu = ({
                        luasnip  = '[LuaSnip]',
                        nvim_lsp = '[LSP]',
                        buffer   = '[Buf]',
                        path     = '[Path]',
                    })[entry.source.name]

                    return item
                end,
            },
        })
    end,
}
