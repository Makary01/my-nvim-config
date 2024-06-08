local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, {desc = "Search files"})
vim.keymap.set('n', '<C-p>', builtin.git_files, {desc = "git files"})
vim.keymap.set('n', '<leader>ps', function() builtin.grep_string({ search = vim.fn.input("Grep > ") }); end, {desc = "Grep word"})
vim.keymap.set('n', '<leader>pl', function() builtin.live_grep(); end, {desc = "Live grep"})

require('telescope').setup{
    defaults = {
        file_ignore_patterns = {
            "node_modules",
            ".cls%-meta.xml",
            ".trigger%-meta.xml",
            "~to%-remove",
        }
    }
}
