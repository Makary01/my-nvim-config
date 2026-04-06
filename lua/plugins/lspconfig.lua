return {
    "neovim/nvim-lspconfig",
    dependencies = {
        'mason-org/mason.nvim',
        'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
        local capabilities = require('cmp_nvim_lsp').default_capabilities()

        vim.lsp.config('lua_ls', {
            capabilities = capabilities,

            on_init = function(client)
                if client.workspace_folders then
                    local path = client.workspace_folders[1].name
                    if
                        path ~= vim.fn.stdpath('config')
                        and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
                    then
                        return
                    end
                end

                client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
                    runtime = {
                        -- Tell the language server which version of Lua you're using (most
                        -- likely LuaJIT in the case of Neovim)
                        version = 'LuaJIT',
                        -- Tell the language server how to find Lua modules same way as Neovim
                        -- (see `:h lua-module-load`)
                        path = {
                            'lua/?.lua',
                            'lua/?/init.lua',
                        },
                    },
                    -- Make the server aware of Neovim runtime files
                    workspace = {
                        checkThirdParty = false,
                        library = {
                            vim.env.VIMRUNTIME,
                            -- Depending on the usage, you might want to add additional paths
                            -- here.
                            -- '${3rd}/luv/library',
                            -- '${3rd}/busted/library',
                        },
                        -- Or pull in all of 'runtimepath'.
                        -- NOTE: this is a lot slower and will cause issues when working on
                        -- your own configuration.
                        -- See https://github.com/neovim/nvim-lspconfig/issues/3189
                        -- library = vim.api.nvim_get_runtime_file('', true),
                    },
                })
            end,
        })
        vim.lsp.enable('lua_ls')

        vim.lsp.enable('gopls', {
            capabilities = capabilities
        })

        -- Apex
        local apex_path = vim.fn.stdpath('data') ..
            '/mason/packages/apex-language-server/extension/dist/apex-jorje-lsp.jar'

        vim.lsp.config('apex_ls', {
            apex_jar_path = apex_path,
            apex_enable_semantic_errors = true,       -- Whether to allow Apex Language Server to surface semantic errors
            apex_enable_completion_statistics = true, -- Whether to allow Apex Language Server to collect telemetry on code completion usage
        })

        vim.filetype.add({
            pattern = {
                ['.*/*.cls'] = 'apex',
            },
        })

        vim.lsp.enable('apex_ls')


        vim.lsp.config('visualforce_ls', {
            cmd = {
                'node',
                vim.fn.stdpath('data') ..
                '/mason/packages/visualforce-language-server/extension/dist/visualforceServer.js',
                '--stdio'
            },
            filetypes = { "visualforce" },
            init_options = {
                embeddedLanguages = {
                    css = true,
                    javascript = true
                }
            }
        })

        -- vim.filetype.add({
        --     pattern = {
        --         ['.*/*.page'] = 'visualforce',
        --     },
        -- })

        vim.lsp.enable('visualforce_ls')

        -- LWC
        vim.lsp.enable('ts_ls')

        vim.lsp.config("eslint", {
            capabilities = capabilities,
            on_attach = function(client, bufnr)
                if not base_on_attach then return end

                local skip_fts = {
                    html = true,
                    lwc = true,
                }


                base_on_attach(client, bufnr)
                vim.api.nvim_create_autocmd("BufWritePre", {
                    buffer = bufnr,
                    callback = function()
                        local ft = vim.bo[bufnr].filetype
                        if skip_fts[ft] then
                            return
                        end
                        --vim.cmd("LspEslintFixAll")
                    end,
                })
            end,
        })

        vim.lsp.config('lwc_ls', {
            cmd = { "lwc-language-server", "--stdio" }
        })

        vim.lsp.enable('lwc_ls')

        -- capabilities.textDocument.completion.completionItem.snippetSupport = true

        vim.lsp.config('html', {
            capabilities = capabilities,
        })

        vim.lsp.enable('html')

        vim.lsp.config('cssls', {
            capabilities = capabilities,
        })
        vim.lsp.enable('cssls')

        vim.lsp.config('azure_pipelines_ls', {
            root_markers = {
                "azure-pipelines.yml",
                "bitbucket-pipelines.yml",
            }
        })

        vim.lsp.enable('azure_pipelines_ls')

        vim.lsp.enable('bashls')
    end

}
