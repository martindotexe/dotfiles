-- Neovim configuration for nvim nightly 0.12+
-- Using built-in package manager (vim.pack.add)

-- ============================================================================
-- Plugins
-- ============================================================================

vim.pack.add({
    -- UI and theme
    { src = "https://github.com/folke/which-key.nvim" },
    { src = "https://github.com/folke/tokyonight.nvim" },

    -- File management
    { src = "https://github.com/stevearc/oil.nvim" },

    -- Mini ecosystem
    { src = "https://github.com/nvim-mini/mini.statusline" },
    { src = "https://github.com/nvim-mini/mini.pairs" },
    { src = "https://github.com/nvim-mini/mini.pick" },

    -- Git integration
    { src = "https://github.com/lewis6991/gitsigns.nvim" },

    -- Syntax highlighting
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" },

    -- LSP support
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/mason-org/mason.nvim" },
    { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
    { src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },

    -- Completion
    {
        src = "https://github.com/Saghen/blink.cmp",
        version = vim.version.range("*"),
    },
})

-- ============================================================================
-- Options
-- ============================================================================
local o = vim.o
local opt = vim.opt

-- Leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- UI appearance
vim.g.have_nerd_font = true      -- Nerdfonts enabled
o.guicursor = "i:ver100-iCursor" -- Vertical bar cursor in insert mode
o.colorcolumn = "80"             -- Highlight column 80
o.signcolumn = "yes:1"           -- Always show sign column
o.termguicolors = true           -- Enable true colors
o.cursorline = true              -- Highlight current line
o.showmode = false               -- Hide mode since it's in statusline
o.winborder = "rounded"          -- Rounded borders for floating windows
o.list = true                    -- Show whitespace characters
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Line numbers
o.number = true         -- Show line numbers
o.relativenumber = true -- Show relative line numbers
o.numberwidth = 2       -- Width of line number column

-- Indentation
o.expandtab = true  -- Use spaces instead of tabs
o.tabstop = 4       -- Number of spaces per tab
o.softtabstop = 4   -- Number of spaces per tab when editing
o.shiftwidth = 4    -- Number of spaces for autoindent
o.shiftround = true -- Round indent to multiple of shiftwidth

-- Text display
o.wrap = false   -- Disable line wrapping
o.scrolloff = 10 -- Keep 10 lines above/below cursor

-- Search behavior
o.ignorecase = true    -- Ignore case in search
o.smartcase = true     -- Case-sensitive if uppercase present
o.inccommand = "split" -- Live preview of substitutions

-- Completion
opt.completeopt = { "menuone", "popup", "noinsert" }

-- Splits
o.splitright = true -- Vertical splits open to the right
o.splitbelow = true -- Horizontal splits open below

-- File handling
o.swapfile = false -- Disable swap files
o.undofile = true  -- Enable persistent undo
o.confirm = true   -- Prompt to save before quitting

-- Performance
o.updatetime = 250 -- Faster completion and git signs
o.timeoutlen = 300 -- Faster key sequence completion

-- Clipboard
o.clipboard = "unnamedplus" -- Use system clipboard

vim.cmd.filetype("plugin indent on")

-- ============================================================================
-- Diagnostics
-- ============================================================================

vim.diagnostic.config({
    virtual_text = true,
})

-- ============================================================================
-- Keymaps
-- ============================================================================

-- Helper function to set keymaps with default options (noremap, silent).
-- Accepts an optional opts table to extend or override defaults.
local function map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.keymap.set(mode, lhs, rhs, opts)
end

-- General editor
map("n", "<Esc>", "<cmd>nohlsearch<CR>") -- Clear search highlights
map("n", "<space>", "<Nop>")             -- Disable space in normal mode
map("n", "<C-d>", "<C-d>zz")             -- Half page down, center cursor
map("n", "<C-u>", "<C-u>zz")             -- Half page up, center cursor
map("v", "J", ":m '>+1<CR>gv=gv")        -- Move selection down
map("v", "K", ":m '<-2<CR>gv=gv")        -- Move selection up

-- Diagnostics
map("n", "<leader>dt", function()
    local config = vim.diagnostic.config()
    vim.diagnostic.config({ virtual_text = not config.virtual_text })
end, { desc = "[D]iagnostic [T]oggle virtual text" })

-- Window management
map("n", "<leader>v", "<cmd>vsplit<CR>", { desc = "[V]ertical split" })
map("n", "<leader>h", "<cmd>split<CR>", { desc = "[H]orizontal split" })

-- File browser
map("n", "\\", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- Fuzzy finder
map("n", "<leader>ff", "<cmd>Pick files<CR>", { desc = "[F]ind [F]iles" })
map("n", "<leader>fg", "<cmd>Pick grep_live<CR>", { desc = "[F]ind by [G]rep" })
map("n", "<leader>fb", "<cmd>Pick buffers<CR>", { desc = "[F]ind [B]uffers" })

-- Git operations
map("n", "<leader>gp", "<cmd>Gitsigns preview_hunk<CR>", { desc = "[G]it [P]review hunk" })
map("n", "<leader>gb", "<cmd>Gitsigns blame_line<CR>", { desc = "[G]it [B]lame line" })

-- Plugin management
map("n", "<leader>ps", "<cmd>lua vim.pack.update()<CR>", { desc = "[P]lugin [S]ync" })

-- ============================================================================
-- Autocommands
-- ============================================================================

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Briefly highlight yanked text
local highlight_group = augroup("YankHighlight", { clear = true })
autocmd("TextYankPost", {
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({ timeout = 170 })
    end,
    group = highlight_group,
})

-- Auto-format on save when LSP is attached.
-- Uses async=false to ensure formatting completes before save.
-- The client_id ensures only the attached LSP server formats the buffer.
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

-- ============================================================================
-- Theme
-- ============================================================================
vim.cmd([[colorscheme tokyonight-night]])

-- ============================================================================
-- Plugin Configuration
-- ============================================================================

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
        default = { "lsp", "path", "buffer" },
    },
    fuzzy = { implementation = "prefer_rust_with_warning" },
})

-- Mini statusline
local statusline = require("mini.statusline")
statusline.setup()
statusline.section_location = function()
    return "%2l:%-2v"
end

-- Mini pairs
require("mini.pairs").setup()

-- Mini pick
require("mini.pick").setup()

-- Gitsigns
require("gitsigns").setup({
    signs = {
        add = { text = "┃" },
        change = { text = "┃" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
    },
    signs_staged = {
        add = { text = "┃" },
        change = { text = "┃" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
    },
    signs_staged_enable = true,
})

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

-- ============================================================================
-- LSP Configuration
-- ============================================================================

-- Define LSP servers and their settings.
-- Servers listed here will be auto-installed via Mason.
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

-- Extract server names for Mason to install.
-- Also add additional tools like formatters.
local ensure_installed = vim.tbl_keys(servers or {})
vim.list_extend(ensure_installed, {
    "stylua", -- Lua formatter
})

-- Setup Mason and auto-install tools
require("mason").setup({})
require("mason-lspconfig").setup({})
require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

-- Add servers that aren't available via Mason (e.g., system-installed).
-- tbl_extend with "keep" preserves existing server configs and adds new ones.
servers = vim.tbl_extend("keep", servers, {
    gleam = {},
})

-- Configure and enable all LSP servers
for server, settings in pairs(servers) do
    vim.lsp.config(server, settings)
    vim.lsp.enable(server)
end
