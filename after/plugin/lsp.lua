local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
    -- see :help lsp-zero-keybindings
    -- to learn the available actions
    lsp_zero.default_keymaps({buffer = bufnr})
end)

-- to learn how to use mason.nvim
-- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guide/integrate-with-mason-nvim.md
--local capabilities = vim.lsp.protocol.make_client_capabilities()
local capabilities = require('cmp_nvim_lsp').default_capabilities()

local servers = {
    apex_ls = {
        apex_jar_path = vim.fn.expand('$HOME/apex-language-server/apex-jorje-lsp.jar'),
        filetypes = {
            'apexcode',
            'apex',
            'soql',
            'sosl',
        }
    },
    lwc_ls = {
        filetypes = {
            'javascript',
            'html',
            'js-meta.xml'
        },
    },
    lua_ls = {
        -- cmd = {...},
        -- filetypes = { ...},
        -- capabilities = {},
        settings = {
            Lua = {
                completion = {
                    callSnippet = 'Replace',
                },
                -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
                -- diagnostics = { disable = { 'missing-fields' } },
            },
        },
    },
}

require('mason').setup({})
require('mason-lspconfig').setup({
    -- this first function is the "default handler"
    -- it applies to every language server without a "custom handler"
    handlers = {
        function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for tsserver)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
        end,
    },
})

local cmp = require('cmp')
local luasnip = require('luasnip')
luasnip.config.set_config{
    history = true,
    updateevents="Textchanged,TextchangedI"
}
luasnip.config.setup{
    history = true,
    updateevents="Textchanged,TextchangedI"
}


require('luasnip.loaders.from_vscode').lazy_load()

local cmp_select = {behavior = cmp.SelectBehavior.Select}

cmp.setup({
    preselect = 'item',
    updateevents="Textchanged,TextchangedI",
    completion = {
        completeopt = 'menu,menuone,noinsert'
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-j>'] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
                luasnip.expand_or_jump()
            end
        end, { 'i', 's' }),
        ['<C-k>'] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
                luasnip.jump(-1)
            end
        end, { 'i', 's' }),
        ['<C-l>'] = cmp.mapping(function()
            if luasnip.choice_active() then
                luasnip.change_choice(1)
            end
        end, { 'i' }),
    }),
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'path' },
    },
})
