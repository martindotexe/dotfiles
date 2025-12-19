local o = vim.o
local opt = vim.opt

vim.cmd([[colorscheme tokyonight-night]])

vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.netrw_liststyle = 1 -- Use the long listing view
vim.g.netrw_sort_by = "size" -- Sort files by size
vim.g.have_nerd_font = true

vim.schedule(function()
	vim.o.clipboard = "unnamedplus"
end)

o.termguicolors = true
o.laststatus = 2
o.guicursor = "i:ver100-iCursor" -- Use block cursor in insert mode
o.colorcolumn = "80" -- Highlight column 80
o.signcolumn = "yes:1" -- Always show sign column
o.termguicolors = true -- Enable true colors
o.ignorecase = true -- Ignore case in search
o.swapfile = false -- Disable swap files
o.autoindent = true -- Enable auto indentation
o.expandtab = true -- Use spaces instead of tabs
o.tabstop = 4 -- Number of spaces for a tab
o.softtabstop = 4 -- Number of spaces for a tab when editing
o.shiftwidth = 4 -- Number of spaces for autoindent
o.shiftround = true -- Round indent to multiple of shiftwidth
o.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" } -- Sets how neovim will display certain whitespace characters in the editor.
o.list = true -- Show whitespace characters
o.number = true -- Show line numbers
o.relativenumber = true -- Show relative line numbers
o.numberwidth = 2 -- Width of the line number column
o.wrap = false -- Disable line wrapping
o.cursorline = true -- Highlight the current line
o.scrolloff = 10 -- Keep 10 lines above and below the cursor
o.inccommand = "nosplit" -- Shows the effects of a command incrementally in the buffer
o.undofile = true -- Enable persistent undo
opt.completeopt = { "menuone", "popup", "noinsert" } -- Options for completion menu
o.winborder = "rounded" -- Use rounded borders for windows
o.mouse = "a" -- Enable mouse mode
o.showmode = false -- Don't show the mode, since it's already in the status line
o.ignorecase = true -- Ignore case in search
o.smartcase = true -- Use case in search if case
o.updatetime = 250 -- Decrease update time
o.timeoutlen = 300 -- Decrease mapped sequence wait time
o.splitright = true -- Configure how new vertical splits should be opened
o.splitbelow = true -- Configure how new horizontal splits should be opened
o.inccommand = "split" -- Preview substitutions live, as you type!
o.confirm = true -- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),

vim.cmd.filetype("plugin indent on") -- Enable filetype detection, plugins, and indentation
