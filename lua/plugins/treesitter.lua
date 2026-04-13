return { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    config = function()
        local filetypes = {
            'bash',
            'c',
            'diff',
            'html',
            'lua',
            'luadoc',
            'markdown',
            'markdown_inline',
            'query',
            'vim',
            'vimdoc',
            'go',
            'javascript',
            'apex',
            'sosl',
            'soql',
            'sflog',
            'css',
            'yaml'
        }
        require('nvim-treesitter').install(filetypes)
        --vim.treesitter.language.register("visualforce", "visualforce")
        vim.api.nvim_create_autocmd('FileType', {
            pattern = filetypes,
            callback = function() vim.treesitter.start() end,
        })
    end,
}
