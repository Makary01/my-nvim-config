return {
    "mg979/vim-visual-multi",
    branch = "master",
    init = function()
        -- disable default mappings
        vim.g.VM_default_mappings = 0

        vim.g.VM_maps = {
            ["Find Under"] = "<A-j>",
            ["Find Subword Under"] = "<A-j>",

            ["Undo"] = "A-J"
        }
    end,
}
