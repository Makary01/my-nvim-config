return {
    "nvim-tree/nvim-web-devicons",
    config = function()
        require("nvim-web-devicons").setup {
            override_by_extension = {
                ["cls"] = {
                    icon = "󰢎",
                    color = "#00A1E0",
                    cterm_color = "39",
                    name = "ApexClass",
                },
                ["trigger"] = {
                    icon = "", -- lightning bolt, fits "trigger"
                    color = "#00A1E0",
                    cterm_color = "39",
                    name = "ApexTrigger",
                },
            },
        }
    end
}
