-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- Fuzzy finder
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.4',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    -- Color scheme (Visual Studio Dark-like theme)
--    use({
--        'lunarvim/darkplus.nvim',
--        config = function()
--            require('darkplus').setup({
--                -- Enable transparent background
--                transparent = false,
--                -- Enable italic comment
--                italic_comments = true,
--                -- Disable nvim-tree background color
--                disable_nvimtree_bg = true,
--            })
--            vim.cmd('colorscheme darkplus')
--        end
--    })
    -- color scheme tokyo night
    use({
        'folke/tokyonight.nvim',
        config = function()
            require('tokyonight').setup({
               style = "storm" 
            })
            vim.cmd('colorscheme tokyonight-storm')
        end
    })
    -- Treesitter for better syntax highlighting
    use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})

    -- Harpoon for quick file navigation (Primeagen's tool!)
    use('theprimeagen/harpoon')

    -- Undo tree
    use('mbbill/undotree')

    -- Git
    use('tpope/vim-fugitive')

    -- LSP Support
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        requires = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-buffer'},
            {'hrsh7th/cmp-path'},
            {'hrsh7th/cmp-cmdline'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'hrsh7th/cmp-nvim-lua'},

            -- Snippets
            {'L3MON4D3/LuaSnip'},
            {'saadparwaiz1/cmp_luasnip'},
            {'rafamadriz/friendly-snippets'},
        }
    }
end)
