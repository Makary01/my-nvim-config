return {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = {
        {
            "mason-org/mason.nvim",
            opts = {
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗"
                    }
                }
            }
        }
    },
    opts = {
        ensure_installed = {
            'apex-language-server',
            'azure-pipelines-language-server',
            'bash-language-server',
            'css-lsp',
            'cssmodules-language-server',
            'gopls',
            'html-lsp',
            'lua-language-server',
            'lwc-language-server',
            'prettier',
            'typescript-language-server',
        }
    }
}
