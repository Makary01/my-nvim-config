return {
    "marcinjahn/gemini-cli.nvim",
    cmd = "Gemini",
    keys = {
        { "<leader>gg", "<cmd>Gemini toggle<cr>",            desc = "Toggle Gemini CLI" },
        { "<leader>ga", "<cmd>Gemini ask<cr>",               desc = "Ask Gemini",       mode = { "n", "v" } },
        { "<leader>gf", "<cmd>Gemini add_file<cr>",          desc = "Add File" },
        { "<C-q>",      "<C-\\><C-n><cmd>Gemini toggle<cr>", mode = { "t" } },
    },
    dependencies = {
        "folke/snacks.nvim",
    },
    config = true,
}
