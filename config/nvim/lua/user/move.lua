local opts = { noremap = true, silent = true }
-- Normal-mode commands
vim.api.nvim_set_keymap ('n', '<A-j>', ':MoveLine(1)<CR>', opts)
vim.api.nvim_set_keymap ('n', '<A-k>', ':MoveLine(-1)<CR>', opts)
vim.api.nvim_set_keymap ('n', '<A-h>', ':MoveHChar(-1)<CR>', opts)
vim.api.nvim_set_keymap ('n', '<A-l>', ':MoveHChar(1)<CR>', opts)

-- Visual-mode commands
vim.api.nvim_set_keymap ('v', '<A-j>', ':MoveBlock(1)<CR>', opts)
vim.api.nvim_set_keymap ('v', '<A-k>', ':MoveBlock(-1)<CR>', opts)
vim.api.nvim_set_keymap ('v', '<A-h>', ':MoveHBlock(-1)<CR>', opts)
vim.api.nvim_set_keymap ('v', '<A-l>', ':MoveHBlock(1)<CR>', opts)
