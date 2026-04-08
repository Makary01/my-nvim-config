return {
    'nvim-telescope/telescope.nvim',
    version = '*',
    dependencies = {
        'nvim-lua/plenary.nvim',
        "nvim-tree/nvim-web-devicons",
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },

    config = function()
        local builtin = require('telescope.builtin')
        local actions = require('telescope.actions')

        local open_selected_in_qflist = function(prompt_bufnr)
            actions.send_selected_to_qflist(prompt_bufnr)
            vim.cmd("copen")
        end

        require('telescope').setup({
            defaults = {
                color_devicons = true,
                file_ignore_patterns = {
                    'tags',
                    'sf_cache',
                    '%.cls%-meta%.xml$',
                    '%.trigger%-meta%.xml$',
                },
                path_display = {
                    "filename_first"
                },
                mappings = {
                    i = {
                        ["<C-q>"] = open_selected_in_qflist,
                        ["<C-k>"] = actions.cycle_history_prev,
                        ["<C-j>"] = actions.cycle_history_next,

                    },
                    n = {
                        ["<C-q>"] = open_selected_in_qflist,
                        ["<C-k>"] = actions.cycle_history_prev,
                        ["<C-j>"] = actions.cycle_history_next,
                    },
                },
                history = {
                    path = vim.fn.stdpath('data') .. '/telescope_history',
                    limit = 100,
                },
            }
        })

        vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = 'Telescope find files' })

        vim.keymap.set("v", "<space>pf", function()
            local text = vim.getVisualSelection()
            builtin.find_files({ default_text = text })
        end, { silent = true, noremap = true, desc = "Telescope find files (selection)" })

        vim.keymap.set('n', '<C-p>', function()
            builtin.oldfiles({ only_cwd = true })
        end, { desc = 'Telescope old files' })
        vim.keymap.set('n', '<leader>ff', builtin.live_grep, { desc = 'Telescope live grep' })

        function vim.getVisualSelection()
            vim.cmd('noau normal! "vy"')
            local text = vim.fn.getreg('v')
            vim.fn.setreg('v', {})

            text = string.gsub(text, "\n", "")
            if #text > 0 then
                return text
            else
                return ''
            end
        end

        vim.keymap.set("n", "<leader>ff", function()
            builtin.grep_string({
                search = vim.fn.input("Search › "),
            })
        end, { desc = "Literal search across project" })

        vim.keymap.set("v", "<leader>ff", function()
            local text = vim.getVisualSelection()
            builtin.grep_string({ search = text })
        end, { silent = true, noremap = true, desc = "Literal search across project (selection)" })

        vim.keymap.set("n", "<leader>fb", function()
            builtin.current_buffer_fuzzy_find({
                fuzzy = false,
                case_mode = "smart_case",
            })
        end, { desc = "Literal search in current buffer" })

        vim.keymap.set("v", "<leader>fb", function()
            local text = vim.getVisualSelection()
            builtin.current_buffer_fuzzy_find({
                fuzzy = false,
                default_text = text,
            })
        end, { silent = true, noremap = true, desc = "Literal search in current buffer (selection)" })


        vim.keymap.set("n", "gd", function()
            local params = vim.lsp.util.make_position_params()
            local bufnr = vim.api.nvim_get_current_buf()

            local results = vim.lsp.buf_request_sync(bufnr, "textDocument/definition", params, 500)

            local has_definition = false

            if results then
                for _, res in pairs(results) do
                    local result = res.result
                    if result then
                        if vim.islist(result) then
                            if #result > 0 then
                                has_definition = true
                                break
                            end
                        else
                            -- single Location or LocationLink
                            has_definition = true
                            break
                        end
                    end
                end
            end

            if has_definition then
                builtin.lsp_definitions()
            else
                local key = vim.api.nvim_replace_termcodes("<C-]>", true, false, true)
                vim.api.nvim_feedkeys(key, "n", false)
            end
        end, { desc = "LSP definitions via Telescope, fallback to tag jump" })

        --vim.keymap.set("n", "gd", builtin.lsp_definitions, { desc = 'Telescope go to [d]efinition' })
        vim.keymap.set("n", "gr", builtin.lsp_references, { desc = 'Telescope go to [r]eferences' })
        vim.keymap.set("n", "gi", builtin.lsp_implementations, { desc = 'Telescope go to [i]mplementations' })

        vim.keymap.set("n", "<space>pc", function()
            builtin.find_files {
                cwd = vim.fn.stdpath("config")
            }
        end, { desc = 'Telescope find files in nvim [c]onfig' })

        vim.keymap.set('n', '<leader>q', function()
            builtin.diagnostics({ bufnr = 0 })
        end, { desc = 'Telescope show diagnostics' })
    end,
}
