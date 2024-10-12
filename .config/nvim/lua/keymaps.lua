local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- MNEI Colemak-DH mod
vim.keymap.set({ 'n', 'v' }, 'm', 'h', opts)
vim.keymap.set({ 'n', 'v' }, 'n', 'j', opts)
vim.keymap.set({ 'n', 'v' }, 'e', 'k', opts)
vim.keymap.set({ 'n', 'v' }, 'i', 'l', opts)

-- inSert bind
vim.keymap.set('n', 's', 'i', opts)
vim.keymap.set('n', 'S', 'I', opts)

-- nekt (next)
vim.keymap.set('n', 'k', 'n', opts)
vim.keymap.set('n', 'K', 'N', opts)

--Remap space as leader key
vim.keymap.set('', '<Space>', '<Nop>', opts)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --

-- Better half page jumps. Snaps cursor to the middle.
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Jumps half a page down' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Jumps half a page up' })

-- Move visual mode selection up and down
vim.keymap.set('v', 'N', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'E', ":m '<-2<CR>gv=gv")

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`
-- TODO: Change the vim.keymap.set lines with keymap function

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-m>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-n>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-e>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-i>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
