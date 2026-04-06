vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set("n", "<leader>pv", "<cmd>Oil<CR>", { desc = 'Oil explorer' })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("v", "<C-c>", "\"+y")
vim.keymap.set("n", "<C-c>", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>y", "\"+y")

vim.keymap.set("n", "<C-z>", "<Nop>", { silent = true })
vim.keymap.set("n", "Q", "<Nop>", { silent = true })

vim.api.nvim_create_user_command("PasteAll", function()
    local text = vim.fn.getreg("+")
    local lines = vim.split(text, "\n", { plain = true })
    vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
end, {})

vim.api.nvim_create_user_command("CopyAll", function()
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    vim.fn.setreg("+", lines)
end, {})
