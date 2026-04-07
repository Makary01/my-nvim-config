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
        handlers = {
            hover = {
                bind = "K",
                wrap = true,
                border = "rounded",
                position = "cursor",
            },
        },
        style_sheets = {
            "https://unpkg.com/@salesforce-ux/design-system@2.29.1/assets/styles/salesforce-lightning-design-system.css",
            --"https://unpkg.com/@salesforce-ux/design-system-2@1.0.0/dist/css/slds2.css",
        },
    },
}
