local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, {desc = "Search files"})
vim.keymap.set('n', '<leader>ps', function() builtin.grep_string({ search = vim.fn.input("Grep > ") }); end, {desc = "Grep word"})
vim.keymap.set('n', '<leader>pl', function() builtin.live_grep(); end, {desc = "Live grep"})

local telescope = require('telescope')
telescope.load_extension("recent_files")
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
        }
    }
}

vim.api.nvim_set_keymap("n", "<C-p>",
  [[<cmd>lua require('telescope').extensions.recent_files.pick()<CR>]],
  {noremap = true, silent = true})
