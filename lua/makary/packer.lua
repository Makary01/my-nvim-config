-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use 'nvim-lua/plenary.nvim'

    use 'nvim-tree/nvim-web-devicons'

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.6',
        requires = {
            {'nvim-lua/plenary.nvim'},
            {'nvim-tree/nvim-web-devicons'},
        }
    }

    use {"smartpde/telescope-recent-files"}

    use { "catppuccin/nvim", as = "catppuccin" }

    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }


    use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})

    use('mbbill/undotree')

    use('tpope/vim-fugitive')

    use {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
    }

    use {
        'hrsh7th/nvim-cmp',
        requires = {
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-omni",
        },
    }

    use { "rafamadriz/friendly-snippets" }

    use {
        'L3MON4D3/LuaSnip',
         dependencies = { "rafamadriz/friendly-snippets" },
         run = "make install_jsregexp",
    }

    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        requires = {
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},
            {'neovim/nvim-lspconfig'},
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'L3MON4D3/LuaSnip'},
        }
    }

    use 'm4xshen/autoclose.nvim'

    use 'ggandor/lightspeed.nvim'

    use {
        'xixiaofinland/sf.nvim',
        requires = {
            'nvim-treesitter/nvim-treesitter',
            'ibhagwan/fzf-lua',
        }
    }

    use "folke/which-key.nvim"

    use 'svban/YankAssassin.vim'
end)
