local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, {desc = "Search files"})
vim.keymap.set('n', '<leader>ps', function() builtin.grep_string({ search = vim.fn.input("Grep > ") }); end, {desc = "Grep word"})
vim.keymap.set('n', '<leader>pl', function() builtin.live_grep(); end, {desc = "Live grep"})

vim.keymap.set('n', '<leader>pw', function()
    local word = vim.fn.expand('<cword>')
    builtin.grep_string({ search = " " .. word})
end, {desc = 'Grep current word'})

local telescope = require('telescope')
telescope.setup{
    defaults = {
        file_ignore_patterns = {
            "node_modules",
            ".cls%-meta.xml",
            ".trigger%-meta.xml",
            "~to%-remove",
        },
        path_display = {'smart'},
    },
    extensions = {
        recent_files = {
            only_cwd = true,
            transform_file_path = function (file_path)
                -- remove directories from recent files
                if file_path:match("%.[^\\/]+$") then
                    return file_path
                else
                    return ""
                end
            end
        }
    }
}
-- this has to be after telescope.setup
telescope.load_extension("recent_files")

vim.api.nvim_set_keymap("n", "<C-p>",
  [[<cmd>lua require('telescope').extensions.recent_files.pick()<CR>]],
  {noremap = true, silent = true})
