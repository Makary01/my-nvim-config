return {
    "NeogitOrg/neogit",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "sindrets/diffview.nvim", -- optional diff integration
        "nvim-telescope/telescope.nvim",
    },
    cmd = "Neogit",
    keys = { { "<leader>gs", "<cmd>Neogit<CR>", desc = "Open Neogit" } },
}
