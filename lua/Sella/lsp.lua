-- ============================================================================
--  LSP + native completion  (Neovim 0.12, no lsp-zero, no nvim-cmp)
-- ============================================================================
--
--  IMPORTANT for your C++/Vulkan project:
--  clangd cannot find your #define macros, include paths, or compiler flags
--  unless it can read a `compile_commands.json` (a "compilation database").
--  Your config points clangd at `build/compile_commands.json` (see below).
--  Generate it once from your project root with:
--
--      cmake -S . -B build -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
--
--  Or make it permanent by adding this line to your CMakeLists.txt:
--
--      set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
--
--  Re-run CMake whenever you add files or change flags so clangd stays in sync.
-- ----------------------------------------------------------------------------

-- ---------------------------------------------------------------------------
--  1. Native insert-mode completion options  (NEW: required on 0.12)
-- ---------------------------------------------------------------------------
-- On 0.12 the built-in autocomplete is gated behind this option. Without it
-- vim.lsp.completion.enable() registers the source but the popup never shows
-- automatically as you type. This is the fix for "no autocomplete".
vim.o.autocomplete = true

-- completeopt controls how the popup behaves:
--   fuzzy    - fuzzy matching (so "vkdev" matches "vkCreateDevice"); without
--              this, matching is strict from the start of the word.
--   menuone  - show the menu even when there's only one match.
--   noselect - don't auto-insert/select the first item (you pick with <C-y>).
--   popup    - show extra info (docs/signature) for the selected item.
vim.opt.completeopt = { "fuzzy", "menuone", "noselect", "popup" }

-- Don't spam "match 1 of 5" messages in the command line.
vim.opt.shortmess:append("c")

-- ---------------------------------------------------------------------------
--  2. Per-buffer keymaps + completion, set when any LSP attaches
-- ---------------------------------------------------------------------------
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("sella.lsp", { clear = true }),
    callback = function(ev)
        local opts = { buffer = ev.buf, remap = false }

        -- Navigation / info
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gri", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)

        -- Diagnostics (note: open_float lives under vim.diagnostic, not buf)
        vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)

        -- Refactoring / actions
        vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>fm", function() vim.lsp.buf.format() end, opts)

        -- Signature help while typing args (insert mode)
        vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)

        -- Manually trigger the completion menu (handy when autotrigger hasn't fired)
        vim.keymap.set("i", "<C-l>", function() vim.lsp.completion.get() end, opts)

        -- Enable native LSP completion for this buffer
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client and client:supports_method("textDocument/completion") then
            vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
        end
    end,
})

-- ---------------------------------------------------------------------------
--  3. Mason: installs the language server *binaries*
-- ---------------------------------------------------------------------------
require("mason").setup({})

-- mason-lspconfig 2.x auto-enables (vim.lsp.enable) every server it installs,
-- so you do NOT call vim.lsp.enable yourself. It only enables servers actually
-- installed via Mason.
require("mason-lspconfig").setup({
    ensure_installed = { "zls", "clangd", "cmake", "ols", "omnisharp", "lua_ls", "slangd" },
})

-- ---------------------------------------------------------------------------
--  4. Per-server overrides via native vim.lsp.config
-- ---------------------------------------------------------------------------
-- vim.lsp.config() MERGES your overrides on top of nvim-lspconfig's defaults
-- (found in its lsp/ directory). Servers you don't list here (zls, cmake, ols,
-- omnisharp) still work with their defaults.

vim.lsp.config("clangd", {
    cmd = { "clangd" },
})

vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            runtime = { version = "LuaJIT" },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
            },
            diagnostics = {
                globals = { "vim" },
            },
        },
    },
})
