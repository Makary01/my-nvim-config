return {
    "jeantimex/ai-cli.nvim",
    event = "VeryLazy",
    config = function()
        require("ai-cli").setup({
            provider = "gemini",
            auto_start = true,
            terminal_cmd = "gemini",
            env = {},
            log_level = "info",
            terminal = {
                split_side = "right",
                split_width_percentage = 0.4,
                auto_close = true,
            },
            diff = {
                accept_key = "ga",
                reject_key = "gr",
            },
        })
    end,
    keys = {
        { "<C-g>", "<cmd>AiCli<cr>",             desc = "Toggle AI CLI", mode = "n" },
        { "<C-g>", [[<C-\><C-n><cmd>AiCli<cr>]], desc = "Toggle AI CLI", mode = "t" },
    },
}
