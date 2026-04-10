return {
    'Makary01/sf.nvim',

    dependencies = {
        'nvim-treesitter/nvim-treesitter',
        'ibhagwan/fzf-lua', -- no need if you don't use listing metadata feature
    },

    config = function()
        local sf = require('sf')

        local get_modified_file_paths = function()
            local uv = vim.uv or vim.loop

            local function is_companion_metadata(path)
                -- Match files like:
                --   MyClass.cls-meta.xml
                --   foo.js-meta.xml
                --   MyTrigger.trigger-meta.xml
                --   Template.email-meta.xml
                --
                -- But DO NOT exclude standalone metadata like:
                --   MyFlow.flow-meta.xml
                -- unless a sibling file without "-meta.xml" actually exists.
                if not path:match("%-meta%.xml$") then
                    return false
                end

                local base = path:gsub("%-meta%.xml$", "")
                return uv.fs_stat(base) ~= nil
            end

            local lines = vim.fn.systemlist({
                "git",
                "status",
                "--short",
                "--untracked-files=all",
                "--",
                "force-app/main/",
            })

            if vim.v.shell_error ~= 0 then
                print("")
                return
            end

            local paths = {}

            for _, line in ipairs(lines) do
                local status = line:sub(1, 2)
                local path = line:sub(4)

                -- Handle rename/copy output like:
                --   R  old/path -> new/path
                -- keep only the destination path
                local renamed_to = path:match(" -> (.+)$")
                if renamed_to then
                    path = renamed_to
                end

                local include =
                    status == "??" or
                    status:find("M", 1, true) or
                    status:find("A", 1, true)

                if include and not is_companion_metadata(path) then
                    table.insert(paths, path)
                end
            end

            return table.concat(paths, " ")
        end

        sf.setup({
            -- Unless you want to customize, no need to copy-paste any of these
            -- They are applied automatically

            -- This plugin has many default hotkey mappings supplied
            -- This flag enable/disable these hotkeys defined
            -- It's highly recommended to set this to `false` and define your own key mappings
            -- Set to `true` if you don't mind any potential key mapping conflicts with your own
            enable_hotkeys = false,

            -- this setting takes effect only when You have "enable_hotkeys = true"(i.e. use default supplied hotkeys).
            -- In the default hotkeys, some hotkeys are on "project level" thus always enabled. Examples: "set default org", "fetch org info".
            -- Other hotkeys are enabled when only metadata filetypes are loaded in the current buffer. Example: "push/retrieve current metadata file"
            -- This list defines what metadata filetypes have the "other hotkeys" enabled.
            -- For example, if you want to push/retrieve css files, it needs to be added into this list.
            hotkeys_in_filetypes = {
                "apex", "sosl", "soql", "javascript", "html", "visualforce", "xml"
            },

            -- When Nvim is initiated, the sf org list is automatically fetched and target_org is set (if available) by `:SF org fetchList`
            -- You can set it to `false` and have a manual control
            fetch_org_list_at_nvim_start = true,

            -- The terminal strategy to use for running tasks.
            -- "integrated" - use the integrated terminal.
            -- "overseer" - use overseer.nvim to run terminal tasks. (requires overseer.nvim as a dependency).
            terminal = "overseer",

            -- Configuration for the integrated terminal
            term_config = {
                blend = 0,        -- background transparency: 0 is fully opaque; 100 is fully transparent
                dimensions = {
                    height = 0.5, -- proportional of the editor height. 0.4 means 40%.
                    width = 0.8,  -- proportional of the editor width. 0.8 means 80%.
                    x = 0.5,      -- starting position of width. Details in `get_dimension()` in raw_term.lua source code.
                    y = 0.9,      -- starting position of height. Details in `get_dimension()` in raw_term.lua source code.
                },
            },

            -- By default, the plugin uses the default package from sfdx-project.json.
            -- If no packages are found, falls back to the value specified in 'default_dir'. If multiple packages are available,
            -- you can override the current working package using |Sf.set_current_package|
            default_dir = '/force-app/main/default/',

            -- the folder this plugin uses to store intermediate data. It's under the sf project root directory.
            plugin_folder_name = '/sf_cache/',

            -- after the test running with code coverage completes, display uncovered line sign automatically.
            -- you can set it to `false`, then manually run toggle_sign command.
            auto_display_code_sign = true,

            -- code coverage sign icon colors
            code_sign_highlight = {
                covered = { fg = "#b7f071" },   -- set `fg = ""` to disable this sign icon
                uncovered = { fg = "#f07178" }, -- set `fg = ""` to disable this sign icon
            },
        })

        local nmap = function(keys, func, desc)
            if desc then
                desc = desc .. " [Sf]"
            end
            vim.keymap.set("n", keys, func, { desc = desc })
        end

        local function nmap_md(keys, fn, desc)
            nmap(keys, function()
                if not vim.tbl_contains(vim.g.sf.hotkeys_in_filetypes, vim.bo.filetype) then
                    vim.notify("Not a Salesforce metadata file", vim.log.levels.INFO)
                    return
                end
                fn()
            end, desc)
        end

        -- Common hotkeys for all files;
        nmap("<leader>ss", sf.set_target_org, "set target_org current workspace")
        nmap("<leader>sS", sf.set_global_target_org, "set global target_org")
        nmap("<leader>sf", sf.fetch_org_list, "fetch orgs info")
        nmap("<leader><leader>", sf.toggle_term, "terminal toggle")
        nmap("<C-c>", sf.cancel, "cancel running command")
        nmap("<leader>s-", sf.go_to_sf_root, "cd into root")
        nmap("<leader>ct", sf.create_ctags, "create ctag file in project root")
        nmap("<leader>ft", sf.create_and_list_ctags, "fzf list updated ctags")
        nmap("<leader>so", sf.org_open, "open target_org")


        vim.keymap.set("v", "<leader>sa", function()
            sf.run_anonymous_stdin(true)
        end, { buffer = true, desc = "run selected content anonymously" })
        nmap("<leader>sa", function() sf.run_anonymous_stdin(false) end, "run this buffer anonymously")

        -- Hotkeys for metadata files only;
        nmap_md("<leader>sO", sf.org_open_current_file, "open file in target_org")
        nmap_md("<leader>sd", sf.diff_in_target_org, "diff in target_org")
        nmap_md("<leader>sD", sf.diff_in_org, "diff in org...")
        nmap_md("<leader>sp", sf.save_and_push, "push current file")
        nmap_md("<leader>sr", sf.retrieve, "retrieve current file")
        nmap_md("<leader>sR", sf.rename_apex_class_remote_and_local, "rename current apex from org and local")
        nmap_md("<leader>sX", sf.delete_current_apex_remote_and_local, "delete current apex from org and local")
        nmap_md("<leader>ta", sf.run_all_tests_in_this_file, "test all in this file")
        nmap_md("<leader>tt", sf.run_current_test, "test this under cursor")
        nmap_md("<leader>to", sf.open_test_select, "open test select buf")
        nmap_md("\\s", sf.toggle_sign, "toggle signs for code coverage")
        nmap("<leader>tr", sf.repeat_last_tests, "repeat last test")
        nmap("<leader>sP", function()
            local file_paths = get_modified_file_paths();
            if file_paths == nil then
                vim.notify('No files to push', vim.log.levels.WARN, { title = "sf.nvim" })
            end
            sf.push_delta("--source-dir " .. file_paths)
        end, "push touched files [GIT]")
    end
}
