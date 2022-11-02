local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

-- Map <leader> to ,
vim.cmd [[let mapleader=',']]
-- ========================================== Function key ==========================================
-- <F2> for Enable LPS
-- <F3> for Enable Telescope
-- <F4> for Minimap
-- <F5> for Explorer
-- <F6> for Outline
-- <F7> for Trouble
-- <F8> for Floaterm
-- <F9> for Git blamer
-- <F10> for Git messenger
-- <F11>
-- <F12> Toggle relative line numbers and regular line numbers.
keymap('', '<F12>', ':set norelativenumber!<CR>', { noremap = false, silent = true })

-- ========================================== Coding key ==========================================
-- Clear highlight when press <Esc>
keymap('n', '<esc>', ':noh<CR><esc>', opts)

-- Open register
keymap('n', '<C-r>', ':Registers<CR>', opts)

-- Switch to next tab
keymap('n', '<A-.>', ':tabn<CR>', opts)
-- Switch to previous tab
keymap('n', '<A-,>', ':tabp<CR>', opts)
-- Close tab
keymap('n', '<A-c>', ':bd<CR>', opts)

-- Switch to specific tab
keymap('n', '<A-1>', '1gt<CR>', opts)
keymap('n', '<A-2>', '2gt<CR>', opts)
keymap('n', '<A-3>', '3gt<CR>', opts)
keymap('n', '<A-4>', '4gt<CR>', opts)
keymap('n', '<A-5>', '5gt<CR>', opts)
keymap('n', '<A-6>', '6gt<CR>', opts)
keymap('n', '<A-7>', '7gt<CR>', opts)
keymap('n', '<A-8>', '8gt<CR>', opts)
keymap('n', '<A-9>', '9gt<CR>', opts)

-- New tab
keymap('n', 'te', ':tabedit', opts)
keymap('n', 'sh', ':split<CR><C-w>w', opts)
keymap('n', 'sv', ':vsplit<CR><C-w>w', opts)

-- Resize with arrows
keymap("n", "<A-Up>", ":resize -2<CR>", opts)
keymap("n", "<A-Down>", ":resize +2<CR>", opts)
keymap("n", "<A-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<A-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<A-.>", ":bnext<CR>", opts)
keymap("n", "<A-,>", ":bprevious<CR>", opts)

-- Move text up and down

-- Insert --
-- Move cursor in insert mode
keymap("i", "<A-h>", "<Left>", opts)
keymap("i", "<A-j>", "<Down>", opts)
keymap("i", "<A-k>", "<Up>", opts)
keymap("i", "<A-l>", "<Right>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Terminal --
-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- ========================================== Stuff key ==========================================
-- Select all
keymap("n", "<C-a>", "gg<S-v>G", opts)

-- Disable copy when in paste in visual mode
keymap("x", "p", 'p:let @+=@0<CR>:let @"=@0<CR>', opts)

-- Save and source
keymap("n", "<C-s>", ':w<CR>:lua require("notify")("Save successfull 勒", "info",{title = "Save file "})<CR>:noh<CR>', opts)

-- ========================================== Plugins key ==========================================
-- Config plugin's keymap here for plugins lazyload
-- NvimTree
keymap ("", "<F5>", ":NvimTreeFindFileToggle<CR>", opts)

-- Floaterm
keymap ("", "<F8>", ":FloatermToggle<CR>", opts)

-- EasyAlign
-- Start interactive EasyAlign in visual mode (e.g. vipga)
keymap("x", "ga", '<Plug>(EasyAlign)', term_opts)

-- Start interactive EasyAlign for a motion/text object (e.g. gaip)
keymap("n", "ga", '<Plug>(EasyAlign)', term_opts)

-- NERDCommenter
keymap("n", "<A-/>", '<plug>NERDCommenterToggle', term_opts)
keymap("v", "<A-/>", '<plug>NERDCommenterToggle', term_opts)
keymap("n", "<A-?>", '<plug>NERDCommenterSexy', term_opts)
keymap("v", "<A-?>", '<plug>NERDCommenterSexy', term_opts)
