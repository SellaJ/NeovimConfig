-- ============================================================================
--  Editor options
-- ============================================================================

-- Line numbers
vim.opt.nu = true
vim.opt.relativenumber = true

-- Indentation
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Search
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = true   -- case-insensitive search...
vim.opt.smartcase = true    -- ...unless you type a capital letter

-- Visual
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
vim.opt.cursorline = true

-- Persistent undo (works with undotree across sessions)
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true

-- Splits open where you'd expect
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Performance
vim.opt.updatetime = 50

-- ----------------------------------------------------------------------------
--  Silence provider warnings in :checkhealth.
--  You write no Perl/Ruby/Node/Python plugins, so these providers are noise.
-- ----------------------------------------------------------------------------
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_python3_provider = 0
