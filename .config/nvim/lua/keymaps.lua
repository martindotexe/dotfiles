local function map(mode, lhs, rhs, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.keymap.set(mode, lhs, rhs, opts)
end

-- Clear highlights on search when pressing <Esc> in normal mode
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Better half page jumps. Snaps cursor to the middle.
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("v", "J", ":m '>+1<CR>gv=gv") -- Move visual mode selection down
map("v", "K", ":m '<-2<CR>gv=gv") -- Move visual mode selection up
map("n", "<space>", "<Nop>")
map("n", "<Leader>v", "<cmd>vsplit<CR>", { desc = "[V]ertical split" })
map("n", "<Leader>h", "<cmd>split<CR>", { desc = "[H]orizontal split" })
map("n", "<leader>ps", "<cmd>lua vim.pack.update()<CR>", { desc = "[P]lugin [S]ync" })
map("n", "\\", ":Neotree reveal<CR>", { desc = "NeoTree reveal" })
