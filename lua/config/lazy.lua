-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    spec = {
        -- import your plugins
        { import = "plugins" },
    },
    -- Remove LuaRocks error
    rocks = { enabled = false },
    checker = { enabled = true },
})


vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        local ok, lazy = pcall(require, "lazy")
        if not ok then
            return
        end

        local updates = lazy.check({
            show = false,
            once = true,
        })

        if #updates > 0 then
            vim.notify(
                ("Lazy: %d plugin update(s) found, syncing…"):format(#updates),
                vim.log.levels.INFO
            )

            lazy.sync({
                show = false,
                on_done = function()
                end,
            })
        end

        vim.notify(
            "Lazy: All plugins are up to date ✅",
            vim.log.levels.INFO
        )
    end,
})
