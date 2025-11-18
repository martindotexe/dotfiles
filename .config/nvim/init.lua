vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Colors
vim.o.termguicolors = true

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- Swapfile
vim.opt.swapfile = false

-- [[ Setting options ]]
require("options")

-- [[ Basic Keymaps ]]
require("keymaps")

-- [[ Install `lazy.nvim` plugin manager ]]
require("lazy-bootstrap")

-- [[ Configure and install plugins ]]
require("lazy-plugins")

-- [[ Espanso tsv converter ]]
vim.keymap.set("n", "<leader>e", function()
	-- Delete lines that don't match the pattern
	vim.cmd([[%g!/\v^.+\t.+$/d]])
	-- Convert remaining lines
	vim.cmd([[%s/\v(.+)\t(.+)/  - trigger: ".\1 "\r    replace: "\2"/g]])
	-- Add "matches:" to the top
	vim.cmd([[norm! ggOmatches:]])
end, { noremap = true, desc = "Convert TSV to Espanso YAML" })

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
