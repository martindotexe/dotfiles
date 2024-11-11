-- [[ Basic Keymaps ]]

local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Basic movement keys
map('n', 'n', 'j')
map('n', 'e', 'k')
map('n', 'i', 'l')
--p('n', 'h', 'h')

-- Visual mode mappings
map('v', 'n', 'j')
map('v', 'e', 'k')
map('v', 'i', 'l')

-- Remap insert mode to use 'm'
map('n', 'm', 'i')
map('n', 'M', 'I')

-- Extended movement mappings
map('n', 'I', '$') -- In to end of line
map('n', 'H', '0') -- Home of line

-- Window navigation
map('n', '<C-n>', '<C-w>j')
map('n', '<C-e>', '<C-w>k')
map('n', '<C-i>', '<C-w>l')
map('n', '<C-h>', '<C-w>h')

-- Move original 'e' functionality to 'l'
map('n', 'l', 'e') -- Look at end of word
map('n', 'L', 'E') -- Look at end of WORD

-- Search movement
map('n', 'k', 'n') -- Keep searching forward
map('n', 'K', 'N') -- Keep searching backward

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
map('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Better half page jumps. Snaps cursor to the middle.
map('n', '<C-d>', '<C-d>zz', { desc = 'Jumps half a page down' })
map('n', '<C-u>', '<C-u>zz', { desc = 'Jumps half a page up' })

-- Move visual mode selection up and down
map('v', 'N', ":m '>+1<CR>gv=gv")
map('v', 'E', ":m '<-2<CR>gv=gv")

-- Tmux navigation
map('n', '<Left>', [[<cmd>lua require('tmux').move_left()<cr>]])
map('n', '<Down>', [[<cmd>lua require('tmux').move_down()<cr>]])
map('n', '<Up>', [[<cmd>lua require('tmux').move_up()<cr>]])
map('n', '<Right>', [[<cmd>lua require('tmux').move_right()<cr>]])

-- vim: ts=2 sts=2 sw=2 et
