return {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
        { "nvim-lua/plenary.nvim", branch = "master" },
        {
            "zbirenbaum/copilot.lua",
            config = function()
                require("copilot").setup({
                    suggestion = { enabled = true, auto_trigger = true },
                    panel = { enabled = true },
                })
                vim.keymap.set("i", "<C-Y>", function()
                    require("copilot.suggestion").accept()
                end, { noremap = true, desc = "Copilot Accept Suggestion" })
            end,
        },
    },
    build = "make tiktoken",
    config = function()
        require("CopilotChat").setup()
        vim.keymap.set("n", "<leader>zc", ":CopilotChatToggle<CR>", { desc = "Chat with Copilot" })
        vim.keymap.set("v", "<leader>zc", "<Esc>:CopilotChatToggle<CR>", { desc = "Chat with Copilot" })
        vim.keymap.set("v", "<leader>ze", ":CopilotChatExplain<CR>", { desc = "Explain Code" })
        vim.keymap.set("v", "<leader>zr", ":CopilotChatReview<CR>", { desc = "Review Code" })
        vim.keymap.set("v", "<leader>zf", ":CopilotChatFix<CR>", { desc = "Fix Code Issues" })
        vim.keymap.set("v", "<leader>zo", ":CopilotChatOptimize<CR>", { desc = "Optimize Code" })
        vim.keymap.set("v", "<leader>zd", ":CopilotChatDocs<CR>", { desc = "Generate Docs" })
        vim.keymap.set("v", "<leader>zt", ":CopilotChatTests<CR>", { desc = "Generate Tests" })
        vim.keymap.set("n", "<leader>zm", ":CopilotChatCommit<CR>", { desc = "Generate Commit Message" })
        vim.keymap.set("v", "<leader>zs", ":CopilotChatCommit<CR>", { desc = "Generate Commit for Selection" })
    end
}
