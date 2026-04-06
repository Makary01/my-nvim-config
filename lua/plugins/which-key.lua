return {
    "folke/which-key.nvim",
    opts = {
        filter = function(mapping)
            return mapping.desc and mapping.desc ~= ""
        end,
    },
}
