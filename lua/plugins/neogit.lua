return {
    "NeogitOrg/neogit",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "sindrets/diffview.nvim", -- optional diff integration
    },
    cmd = "Neogit",
    keys = { { "<leader>gs", "<cmd>Neogit<CR>", desc = "Open Neogit" } },
}
