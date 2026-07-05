vim.g.mapleader = " "
vim.filetype.add({
    filename = {
        ['CMakeLists.txt'] = 'cmake',
    },
    pattern = {
        ['.*%.cmake'] = 'cmake',
        ['.*/[Cc][Mm]ake/.*%.txt'] = 'cmake',
    },
})
require("Sella.lazy")
require("Sella.remap")
require("Sella.set")
require("Sella.cmake-tools")
pcall(require, "Sella.telescope")
pcall(require, "Sella.treesitter")
pcall(require, "Sella.lsp")
print("Hello from Neovim!")
