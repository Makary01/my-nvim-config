return {
    'nvim-lualine/lualine.nvim',
    dependencies = {
        'stevearc/overseer.nvim',
        'nvim-tree/nvim-web-devicons'
    },
    config = function()
        --------------------------------------------------------------------
        -- Pretty OIL PATH for lualine
        --------------------------------------------------------------------
        local function pretty_oil_path()
            if vim.bo.filetype ~= "oil" then
                return nil
            end

            local bufname = vim.api.nvim_buf_get_name(0)

            -- Strip the "oil://" prefix to get the actual filesystem path.
            local path = bufname:gsub("^oil://", "")

            -- Make it relative to CWD (looks much nicer)
            local pretty = vim.fn.fnamemodify(path, ":~:.")

            return pretty
        end

        --------------------------------------------------------------------
        -- Make modified / readonly / newfile symbols italic
        --------------------------------------------------------------------
        vim.api.nvim_set_hl(0, "LualineItalic", { italic = true })

        local text_symbols = {
            modified = "[Modified]",
            readonly = "[Read-Only]",
            unnamed  = "[No Name]",
            newfile  = "[New]",
        }

        --------------------------------------------------------------------
        -- LUALINE SETUP
        --------------------------------------------------------------------
        local overseer = require('overseer')
        require('lualine').setup {
            options = {
                icons_enabled = true,
                theme = 'auto',
                component_separators = { left = '', right = '|' },
                globalstatus = true,
            },
            sections = {
                lualine_a = { 'mode' },
                lualine_b = { 'branch', 'diff' },
                lualine_c = {
                    {
                        function()
                            return require('sf').get_target_org()
                        end,
                        icon = "󱘖",
                    },
                    {
                        pretty_oil_path,
                        cond = function() return vim.bo.filetype == "oil" end,
                        symbols = text_symbols
                    },
                    {
                        'filename',
                        path = 1,
                        cond = function() return vim.bo.filetype ~= "oil" end,
                        symbols = text_symbols
                    },
                },

                lualine_x = {
                    'diagnostics',
                    {
                        "overseer",
                        label = "",     -- Prefix for task counts
                        colored = true, -- Color the task icons and counts
                        symbols = {
                            [overseer.STATUS.FAILURE] = "󰅚 ",
                            [overseer.STATUS.CANCELED] = " ",
                            [overseer.STATUS.SUCCESS] = "󰄴 ",
                            [overseer.STATUS.RUNNING] = "󰑮 ",
                        },
                        unique = false, -- Unique-ify non-running task count by name
                        status = nil,   -- List of task statuses to display
                        filter = nil,   -- Function to filter out tasks you don't wish to display
                    },
                },
                lualine_y = {
                    {
                        'filetype',
                        icon_only = true
                    },
                    'lsp_status'
                },
                lualine_z = { 'progress', 'location' },
            },
        }
    end
}
