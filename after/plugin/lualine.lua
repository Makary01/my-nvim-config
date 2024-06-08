require('lualine').setup({
    {
        -- include the rest of your setup
        sections = {
            lualine_c = {
                "filename",
                {
                   "require'sf'.get_target_org()",
                   icon = "󰢎",
                },
            },
        },
    }
})
