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
        local utils_visual = require('utils.visual')

        local open_selected_in_qflist = function(prompt_bufnr)
            actions.send_selected_to_qflist(prompt_bufnr)
            vim.cmd("copen")
        end


        local function feedkey(keys)
            vim.api.nvim_feedkeys(
                vim.api.nvim_replace_termcodes(keys, true, false, true),
                "n",
                false
            )
        end

        local function gd_lsp_or_tag()
            local bufnr = vim.api.nvim_get_current_buf()
            local clients = vim.lsp.get_clients({ bufnr = bufnr })

            local definition_client = nil
            for _, client in ipairs(clients) do
                if client:supports_method("textDocument/definition") then
                    definition_client = client
                    break
                end
            end

            if not definition_client then
                feedkey("<C-]>")
                return
            end

            local params = vim.lsp.util.make_position_params(
                0,
                definition_client.offset_encoding
            )

            vim.lsp.buf_request_all(bufnr, "textDocument/definition", params, function(results)
                local found = false

                for _, res in pairs(results or {}) do
                    if res.result and not vim.tbl_isempty(res.result) then
                        found = true
                        break
                    end
                end

                if found then
                    require("telescope.builtin").lsp_definitions()
                else
                    feedkey("<C-]>")
                end
            end)
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
                pickers = {
                    live_grep = {
                        additional_args = { "--smart-case" },
                    },
                },
            }
        })

        vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = 'Telescope find files' })

        vim.keymap.set("v", "<space>pf", function()
            local text = utils_visual.getVisualSelection()
            builtin.find_files({ default_text = text })
        end, { silent = true, noremap = true, desc = "Telescope find files (selection)" })

        vim.keymap.set('n', '<C-p>', function()
            builtin.oldfiles({ only_cwd = true })
        end, { desc = 'Telescope old files' })

        vim.keymap.set('n', '<leader>ff', builtin.live_grep, { desc = 'Telescope live grep' })

        vim.keymap.set("v", "<leader>ff", function()
            local text = utils_visual.getVisualSelection()
            builtin.grep_string({
                search = text,
            })
        end, { silent = true, noremap = true, desc = 'Telescope live grep' })

        vim.keymap.set("n", "<leader>fb", function()
            builtin.current_buffer_fuzzy_find({})
        end, { desc = "Literal search in current buffer" })

        vim.keymap.set("v", "<leader>fb", function()
            local text = utils_visual.getVisualSelection()
            builtin.current_buffer_fuzzy_find({
                default_text = text
            })
        end, { silent = true, noremap = true, desc = "Literal search in current buffer (selection)" })

        vim.keymap.set("n", "gd", gd_lsp_or_tag, { desc = "LSP definition or tag jump" })
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
