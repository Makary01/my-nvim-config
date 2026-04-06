return {
    'Jezda1337/nvim-html-css',
    dependencies = {
        'nvim-treesitter/nvim-treesitter',
        'nvim-lua/plenary.nvim'
    },
    opts = {
        enable_on = {
            "html",
            "lwc",
        },
        style_sheets = {
            "./node_modules/@salesforce-ux/design-system/assets/styles/salesforce-lightning-design-system.min.css",
            -- "https://unpkg.com/@salesforce-ux/design-system@latest/assets/styles/salesforce-lightning-design-system.min.css",
        },
    },
}
