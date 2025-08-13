-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }
    use {
        "ellisonleao/gruvbox.nvim",
        as = 'gruvbox',
        config = function()
            -- Default options:
            require("gruvbox").setup({
                terminal_colors = true, -- add neovim terminal colors
                undercurl = true,
                underline = true,
                bold = true,
                italic = {
                    strings = true,
                    emphasis = true,
                    comments = true,
                    operators = false,
                    folds = true,
                },
                strikethrough = true,
                invert_selection = false,
                invert_signs = false,
                invert_tabline = false,
                invert_intend_guides = false,
                inverse = true, -- invert background for search, diffs, statuslines and errors
                contrast = "",  -- can be "hard", "soft" or empty string
                palette_overrides = {},
                overrides = {},
                dim_inactive = false,
                transparent_mode = false,
            })
            vim.cmd('colorscheme gruvbox')
        end
    }

    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
    use('theprimeagen/harpoon')
    use('mbbill/undotree')
    use('tpope/vim-fugitive')

    -- LSP Support
    use('neovim/nvim-lspconfig')
    -- Autocompletion
    use('hrsh7th/nvim-cmp')
    use('hrsh7th/cmp-buffer')
    use('hrsh7th/cmp-path')
    use('saadparwaiz1/cmp_luasnip')
    use('hrsh7th/cmp-nvim-lsp')
    use('hrsh7th/cmp-nvim-lua')
    -- Snippets
    use('L3MON4D3/LuaSnip')
    use('rafamadriz/friendly-snippets')

    -- use {
    --     'VonHeikemen/lsp-zero.nvim',
    --     requires = {
    --         -- LSP Support
    --         { 'neovim/nvim-lspconfig' },
    --         { 'williamboman/mason.nvim' },
    --         { 'williamboman/mason-lspconfig.nvim' },
    --
    --     }
    -- }

    use {
        'ivanesmantovich/xkbswitch.nvim',
        config = function()
            require("xkbswitch").setup()
        end
    }

    use {
        'folke/zen-mode.nvim'
    }

    -- use { "nvim-treesitter/nvim-treesitter-context", }

    use { 'eandrju/cellular-automaton.nvim' }

    use {
        "folke/trouble.nvim",
        config = function()
            require("trouble").setup {
                -- icons = {},
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end
    }

    use {
        'untitled-ai/jupyter_ascending.vim'
    }

end)
