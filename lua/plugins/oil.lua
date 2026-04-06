return {
    'stevearc/oil.nvim',
    opts = {
        confirmation = {
            border = 'double',
        },
        keymaps = {
            ["<C-p>"] = false,
            ["<M-p>"] = "actions.preview",
        },
        view_options = {
            show_hidden = true,
        },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
}
