local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- telescope
    { "nvim-telescope/telescope.nvim",   tag = "0.1.4",      dependencies = { "nvim-lua/plenary.nvim" } },

    -- colorscheme
    {
        "folke/tokyonight.nvim",
        priority = 1000,
        config = function()
            vim.cmd("colorscheme tokyonight-night")
        end
    },
    -- treesitter
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

    -- harpoon
    { "theprimeagen/harpoon" },

    -- undotree
    { "mbbill/undotree" },

    -- fugitive
    { "tpope/vim-fugitive" },

    -- lsp
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v3.x",
        dependencies = {
            "neovim/nvim-lspconfig",
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lua",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets",
        },
    },
})
