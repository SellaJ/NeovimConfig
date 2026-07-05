-- ============================================================================
--  Plugin manager (lazy.nvim) + plugin list
-- ============================================================================

-- Bootstrap: clone lazy.nvim itself on first launch if it isn't present.
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
    -- telescope (fuzzy finder)
    -- Dropped the pinned `tag = "0.1.4"` so you track current releases.
    -- plenary is its required dependency.
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
    },

    -- colorscheme
    {
        "folke/tokyonight.nvim",
        priority = 1000,
        opts = {
            style = "moon",
            on_colors = function(c)
                c.bg = "#1a1b26"
                c.bg_dark = "#16161e"
                c.bg_float = "#1a1b26"
                c.bg_sidebar = "#16161e"
                c.bg_statusline = "#16161e"
            end,
        },
        config = function(_, opts)
            require("tokyonight").setup(opts)
            vim.cmd.colorscheme("tokyonight-moon")
        end,
    },

    -- file management
    {
        "stevearc/oil.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        -- load on these so `nvim .` opens oil on a directory
        lazy = false,
        opts = {
            delete_to_trash = false, -- no `trash` cmd on Windows by default
            view_options = {
                show_hidden = true,
            },
            keymaps = {
                ["<C-h>"] = false, -- free up if it clashes with window nav
            },
        },
        config = function(_, opts)
            require("oil").setup(opts)
            vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
        end,
    },

    -- treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        build = ":TSUpdate",
    },

    --cmkae-tools
    {
        "Civitasv/cmake-tools.nvim"
    },

    -- undotree
    { "mbbill/undotree" },

    -- fugitive (git)
    { "tpope/vim-fugitive" },

    -- lsp: nvim-lspconfig provides server config DATA; mason installs the
    -- server binaries; mason-lspconfig bridges the two and auto-enables them.
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "mason-org/mason.nvim",
            "mason-org/mason-lspconfig.nvim",
        },
    },
})
