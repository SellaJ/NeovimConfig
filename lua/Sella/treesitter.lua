-- ============================================================================
--  Treesitter (syntax-aware highlighting & indentation)
-- ============================================================================
-- nvim-treesitter `main` branch: no configs.setup{}, no module system.
-- Install parsers with :TSInstall, enable highlighting per-buffer yourself.
 
require("nvim-treesitter").setup({})
 
-- Install the parsers you use (run once; safe to leave here):
--   :TSInstall c cpp zig lua vim vimdoc query cmake
 
-- Enable treesitter highlighting per filetype.
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "c", "cpp", "zig", "lua", "vim", "vimdoc", "query", "cmake" },
    callback = function()
        pcall(vim.treesitter.start)
    end,
})
 
-- Treesitter-based indentation (opt-in on main):
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "c", "cpp", "zig", "lua", "query", "cmake" },
    callback = function()
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
})
 