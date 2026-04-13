-- relative line numbers
vim.opt.nu = true
vim.opt.relativenumber = true

-- add space before line numbers
vim.opt.signcolumn = "yes:2"

-- 4 space indents
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.backup = false

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.scrolloff = 8

vim.o.splitright = true

vim.o.mouse = 'a'

vim.o.undofile = true

vim.diagnostic.config({
    update_in_insert = false,
    severity_sort = true,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "E",
            [vim.diagnostic.severity.WARN]  = "",
            [vim.diagnostic.severity.INFO]  = "I",
            [vim.diagnostic.severity.HINT]  = "H",
        },
    },


    underline = true,

    -- show virtual text only for errors
    virtual_text = true,

    -- floating diagnostic window config
    float = {
        border = "rounded",
        source = "if_many",
        scope = "cursor",
    },

    jump = {
        float = false,
    },
})

-- how long the cursor must stay still before CursorHold fires
vim.o.updatetime = 250

local diag_hover_group = vim.api.nvim_create_augroup("DiagnosticHover", { clear = true })

vim.api.nvim_create_autocmd("CursorHold", {
    group = diag_hover_group,
    callback = function()
        vim.diagnostic.open_float(nil, {
            focus = false,
            scope = "cursor",
            border = "rounded",
        })
    end,
})

-- highligh yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
})



vim.api.nvim_create_autocmd("BufWinEnter", {
    callback = function()
        if vim.bo[vim.api.nvim_get_current_buf()].filetype == "help" then
            vim.cmd.wincmd("H")
        end
    end,
})

vim.o.winborder = 'rounded'

vim.keymap.set("v", "<Tab>", ">gv", { noremap = true, silent = true })
vim.keymap.set("v", "<S-Tab>", "<gv", { noremap = true, silent = true })

vim.keymap.set("n", "<Tab>", ">>", { noremap = true, silent = true })
vim.keymap.set("n", "<S-Tab>", "<<", { noremap = true, silent = true })

vim.keymap.set("n", "<leader>co", "<cmd>copen<CR>", { noremap = true, silent = true, desc = "Quickfix [O]pen" })
vim.keymap.set("n", "<leader>cc", "<cmd>cclose<CR>", { noremap = true, silent = true, desc = "Quickfix [C]lose" })

vim.keymap.set("n", "<leader>sn", function()
    local src_buf = vim.api.nvim_get_current_buf()
    local src_lines = vim.api.nvim_buf_get_lines(src_buf, 0, -1, false)
    local src_ft = vim.bo[src_buf].filetype

    vim.cmd("vnew")

    vim.bo.buftype = "nofile"
    vim.bo.bufhidden = "wipe"
    vim.bo.swapfile = false
    vim.bo.filetype = src_ft

    vim.cmd("file [Scratch]")

    vim.api.nvim_buf_set_lines(0, 0, -1, false, src_lines)

    vim.bo.modified = false
end, { desc = "New scratch buffer (vsplit) with clone + same filetype" })

local visual_utils = require('utils.visual')
vim.keymap.set("v", "<C-f>", function()
    local text = visual_utils.getVisualSelection()
    vim.fn.feedkeys("/\\c" .. text .. '\r')
end, { noremap = true, silent = true })
vim.keymap.set("n", "<C-f>", function() vim.fn.feedkeys("/\\c") end, { noremap = true, silent = true })

vim.filetype.add({
    pattern = {
        ['.*/*.page'] = 'visualforce',
    },
})

vim.filetype.add({
    pattern = {
        [".*/force%-app/.*/classes/.*%.cls"]      = "apex",
        [".*/force%-app/.*/triggers/.*%.trigger"] = "apex",
    },
})
