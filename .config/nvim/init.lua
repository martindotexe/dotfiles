vim.pack.add({
    { src = "https://github.com/folke/which-key.nvim" },
    { src = "https://github.com/folke/tokyonight.nvim" },
    { src = "https://github.com/stevearc/oil.nvim" },
    { src = "https://github.com/nvim-mini/mini.statusline" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/mason-org/mason.nvim" },
    { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
    { src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },
    {
        src = "https://github.com/Saghen/blink.cmp",
        version = vim.version.range("*"),
    },
})
-- Options
local o = vim.o
local opt = vim.opt

vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true

o.clipboard = "unnamedplus"
o.guicursor = "i:ver100-iCursor" -- Use block cursor in insert mode
o.colorcolumn = "80" -- Highlight column 80
o.signcolumn = "yes:1" -- Always show sign column
o.termguicolors = true -- Enable true colors
o.swapfile = false -- Disable swap files
o.expandtab = true -- Use spaces instead of tabs
o.tabstop = 4 -- Number of spaces for a tab
o.softtabstop = 4 -- Number of spaces for a tab when editing
o.shiftwidth = 4 -- Number of spaces for autoindent
o.shiftround = true -- Round indent to multiple of shiftwidth
o.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" } -- Sets how neovim will display certain whitespace characters in the editor.
o.number = true -- Show line numbers
o.relativenumber = true -- Show relative line numbers
o.numberwidth = 2 -- Width of the line number column
o.wrap = false -- Disable line wrapping
o.cursorline = true -- Highlight the current line
o.scrolloff = 10 -- Keep 10 lines above and below the cursor
o.undofile = true -- Enable persistent undo
opt.completeopt = { "menuone", "popup", "noinsert" } -- Options for completion menu
o.winborder = "rounded" -- Use rounded borders for windows
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

-- Keymaps

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
map("n", "<leader>v", "<cmd>vsplit<CR>", { desc = "[V]ertical split" })
map("n", "<leader>h", "<cmd>split<CR>", { desc = "[H]orizontal split" })
map("n", "<leader>ps", "<cmd>lua vim.pack.update()<CR>", { desc = "[P]lugin [S]ync" })
map("n", "\\", "<CMD>Oil<CR>", { desc = "Open parent directory" })
map("n", "<leader>f", function()
    vim.lsp.buf.format()
end, { desc = "[F]ormat file" })

-- Autocommands

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Highlight yanked text
local highlight_group = augroup("YankHighlight", { clear = true })
autocmd("TextYankPost", {
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({ timeout = 170 })
    end,
    group = highlight_group,
})

autocmd("LspAttach", {
    group = augroup("lsp", { clear = true }),
    callback = function(args)
        autocmd("BufWritePre", {
            buffer = args.buf,
            callback = function()
                vim.lsp.buf.format({ async = false, id = args.data.client_id })
            end,
        })
    end,
})

-- Theme
vim.cmd([[colorscheme tokyonight-night]])

-- Oil
require("oil").setup({
    view_options = {
        show_hidden = true,
    },
})

-- Blink
require("blink.cmp").setup({
    completion = { documentation = { auto_show = true } },
    sources = {
        default = { "lsp" },
    },
    fuzzy = { implementation = "prefer_rust_with_warning" },
})

-- Mini staatusline
local statusline = require("mini.statusline")
statusline.setup()
statusline.section_location = function()
    return "%2l:%-2v"
end

-- Treesitter
require("nvim-treesitter").setup({})

local parsers = { "bash", "lua", "luadoc", "markdown", "gleam" }
require("nvim-treesitter").install(parsers)
vim.api.nvim_create_autocmd("FileType", {
    pattern = parsers,
    callback = function()
        vim.treesitter.start()
    end,
})

-- LSP
local servers = {
    pyright = {},
    ts_ls = {},
    tailwindcss = {},
    gopls = {},
    lua_ls = {
        settings = {
            Lua = {
                runtime = { version = "LuaJIT" },
                diagnostics = { globals = { "vim", "require" } },
                workspace = { library = vim.api.nvim_get_runtime_file("", true) },
                telemetry = { enable = false },
            },
        },
    },
}

local ensure_installed = vim.tbl_keys(servers or {})
vim.list_extend(ensure_installed, {
    "stylua", -- Used to format Lua code
})
require("mason").setup({})
require("mason-lspconfig").setup({})
require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

-- Enable servers that can't be installed via mason
servers = vim.tbl_extend("keep", servers, {
    gleam = {},
})

for server, settings in pairs(servers) do
    vim.lsp.config(server, settings)
    vim.lsp.enable(server)
end
