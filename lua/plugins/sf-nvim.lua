return {
    'xixiaofinland/sf.nvim',

    dependencies = {
        'nvim-treesitter/nvim-treesitter',
        'ibhagwan/fzf-lua', -- no need if you don't use listing metadata feature
    },

    config = function()
        local sf = require('sf')
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

            -- Define what metadata to be listed in `list_md_to_retrieve()` (<leader>ml)
            -- Salesforce has numerous metadata types. We narrow down the scope of `list_md_to_retrieve()`.
            types_to_retrieve = {
                -- Apex
                "ApexClass",
                "ApexTrigger",
                "ApexPage",
                "ApexComponent",

                -- Lightning / UI
                "LightningComponentBundle",
                "AuraDefinitionBundle",
                "FlexiPage",
                "CustomTab",
                "CompactLayout",
                "GlobalValueSet",
                "GlobalValueSetTranslation",

                -- Static & content
                "StaticResource",
                "ContentAsset",

                -- Objects & fields
                "CustomObject",
                "CustomField",
                "FieldSet",
                "Index",
                "ValidationRule",
                "RecordType",
                "BusinessProcess",

                -- Security
                "Profile",
                "PermissionSet",
                "PermissionSetGroup",
                "Role",
                "SharingRules",
                "SharingSet",

                -- Automation
                "Flow",
                "FlowDefinition",
                "Workflow",
                "WorkflowAlert",
                "WorkflowFieldUpdate",
                "WorkflowRule",
                "WorkflowTask",
                "AssignmentRules",
                "AutoResponseRules",
                "EscalationRules",

                -- Email & templates
                "EmailTemplate",
                "Letterhead",

                -- Reports & dashboards
                "Report",
                "ReportType",
                "Dashboard",

                -- Data & integrations
                "NamedCredential",
                "AuthProvider",
                "RemoteSiteSetting",
                "ExternalDataSource",
                "CustomMetadata",
                "CustomPermission",

                -- Labels & translations
                "CustomLabel",
                "Translations",

                -- Experience Cloud
                "Network",
                "NavigationMenu",
                "ExperienceBundle",

                -- Packaging / org config
                "Settings",
                "InstalledPackage",

                -- Misc
                "Queue",
                "Group",
                "Site",
                "BrandingSet",
            },

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
        nmap("<leader>ml", sf.list_md_to_retrieve, "metadata listing")
        nmap("<leader>mtl", sf.list_md_type_to_retrieve, "metadata-type listing")
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
    end
}
