local M = {}

function M.getVisualSelection()
    vim.cmd('noau normal! "vy"')
    local text = vim.fn.getreg('v')
    vim.fn.setreg('v', {})

    text = text:gsub("\n", "")
    return text ~= "" and text or ""
end

return M
