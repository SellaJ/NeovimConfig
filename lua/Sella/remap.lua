local keymap = vim.keymap

-- Project explorer (we'll set this up with netrw first, then telescope)
keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Move visual selection up/down
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Keep cursor centered during navigation
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")

-- Paste without losing register
keymap.set("x", "<leader>p", [["_dP]])

-- Copy to system clipboard
keymap.set({"n", "v"}, "<leader>y", [["+y]])
keymap.set("n", "<leader>Y", [["+Y]])

-- Delete without yanking
keymap.set({"n", "v"}, "<leader>d", [["_d]])

-- Escape from insert mode
keymap.set("i", "<C-c>", "<Esc>")

-- Disable Q
keymap.set("n", "Q", "<nop>")

-- Quick fix navigation
keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- Replace word under cursor
keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
