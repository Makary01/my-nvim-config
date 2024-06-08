vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, {desc = "Explorer"})

vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- "Remove all trailing whitespace by pressing F5
vim.keymap.set("n", "<F5>", ":let _s=@/<Bar>%s/\\s\\+$//e<Bar>let @/=_s<CR>")

-- copy on space + y
vim.keymap.set("v", "<leader>y", "\"+y", {desc = "Copy to clipboard"})

vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set('n', '<C-b>', ':lua vim.lsp.buf.definition()<CR>')

vim.keymap.set('n', '<F3>', ':noh<CR>')
