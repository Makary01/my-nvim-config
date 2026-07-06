return {
    "m4xshen/hardtime.nvim",
    lazy = false,
    dependencies = {
        "MunifTanjim/nui.nvim",
        {
            "rcarriga/nvim-notify",
            opts = {},
            config = function(_, opts)
                local notify = require("notify")
                notify.setup(opts)
                vim.notify = notify
            end,
        },
    },
    opts = {
        callback = function(text)
            require("notify")(text, vim.log.levels.WARN, {
                title = "Hardtime",
            })
        end,
    },
}
