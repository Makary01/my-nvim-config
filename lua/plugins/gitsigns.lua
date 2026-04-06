return {
    'lewis6991/gitsigns.nvim',
    config = function()
        require('gitsigns').setup({
            -- signs                   = {
            --     add          = { text = '▎' },
            --     change       = { text = '▎' },
            --     delete       = { text = '' },
            --     topdelete    = { text = '‾' },
            --     changedelete = { text = '▎' },
            --     untracked    = { text = '▎' },
            -- },
            signs                   = {
                add          = { text = '┃' },
                change       = { text = '┃' },
                delete       = { text = '_' },
                topdelete    = { text = '‾' },
                changedelete = { text = '~' },
                untracked    = { text = '┆' },
            },
            signs_staged            = {
                add          = { text = '┃' },
                change       = { text = '┃' },
                delete       = { text = '_' },
                topdelete    = { text = '‾' },
                changedelete = { text = '~' },
                untracked    = { text = '┆' },
            },
            signcolumn              = true, -- Always show in sign column
            numhl                   = false,
            linehl                  = false,
            sign_priority           = 1,
            watch_gitdir            = {
                interval = 1000,
                follow_files = true
            },
            attach_to_untracked     = true,
            current_line_blame      = true,
            current_line_blame_opts = {
                delay = 500,
            },
            on_attach               = function(bufnr)
                local gs = package.loaded.gitsigns

                -- Optional: keymaps to stage / preview hunks
                vim.keymap.set('n', '<leader>hs', gs.stage_hunk, { buffer = bufnr, desc = '[h]unk [s]tage' })
                vim.keymap.set('n', '<leader>hr', gs.reset_hunk, { buffer = bufnr, desc = '[h]unk [r]eset' })
                vim.keymap.set('n', '<leader>hp', gs.preview_hunk, { buffer = bufnr, desc = '[h]unk [p]review' })
            end
        })
    end
}
