vim.pack.add({
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	{ src = "https://github.com/nvim-mini/mini.statusline" },
	{ src = "https://github.com/nvim-mini/mini.ai" },
	{ src = "https://github.com/nvim-mini/mini.surround" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim" },
	{ src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },
	{ src = "https://github.com/saghen/blink.cmp" },
	{ src = "https://github.com/stevearc/conform.nvim" },
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/folke/which-key.nvim" },
	{ src = "https://github.com/folke/tokyonight.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/MunifTanjim/nui.nvim" },
	{
		src = "https://github.com/nvim-neo-tree/neo-tree.nvim",
		version = vim.version.range("3"),
	},
})

require("neo-tree").setup({
	close_if_last_window = true,
	sort_case_insensitive = true,
	source_selector = {
		winbar = true,
		sources = {
			{ source = "filesystem", display_name = " 󰉓 File " },
			{ source = "git_status", display_name = " 󰊢 Git " },
		},
	},
	window = {
		mappings = {
			["h"] = "open_split",
			["v"] = "open_vsplit",
			["a"] = { "add", config = { show_path = "relative" } },
			["A"] = "add_directory",
			["P"] = { "toggle_preview", config = { use_float = true, use_image_nvim = true } },
			["b"] = "toggle_node",
		},
	},
	filesystem = {
		window = {
			mappings = {
				["o"] = "system_open",
				["\\"] = "close_window",
			},
		},
	},
	commands = {
		system_open = function(state)
			local node = state.tree:get_node()
			local path = node:get_id()
			local OS = require("utils").getOs()
			if OS == "OSX" or OS == "Darwin" then
				vim.fn.jobstart({ "open", path }, { detach = true })
			elseif OS == "Linux" then
				vim.fn.jobstart({ "xdg-open", path }, { detach = true })
			end
		end,
	},
	event_handlers = {
		{
			event = "file_open_requested",
			handler = function()
				vim.cmd("Neotree close")
			end,
		},
	},
})

-- Mini
require("mini.surround").setup()
require("mini.ai").setup({ n_lines = 500 })
local statusline = require("mini.statusline")
statusline.setup()
statusline.section_location = function()
	return "%2l:%-2v"
end

-- Blink.cmp
require("blink.cmp").setup({
	keymap = {
		preset = "default",
	},
	appearance = {
		nerd_font_variant = "mono",
	},
	completion = {
		documentation = { auto_show = true, auto_show_delay_ms = 500 },
	},
	sources = {
		default = { "lsp" },
	},
	fuzzy = { implementation = "prefer_rust_with_warning" },
	signature = { enabled = true },
})

-- Conform
require("conform").setup({
	notify_on_error = false,
	format_on_save = function(bufnr)
		local disable_filetypes = { c = true, cpp = true }
		if disable_filetypes[vim.bo[bufnr].filetype] then
			return nil
		else
			return {
				timeout_ms = 500,
				lsp_format = "fallback",
			}
		end
	end,
	formatters_by_ft = {
		lua = { "stylua" },
		gleam = { "gleam" },
		javascript = { "prettierd" },
		typescript = { "prettierd" },
		svelte = { "prettierd" },
		html = { "prettierd" },
		css = { "prettierd" },
	},
})

require("nvim-treesitter").setup({
	ensure_installed = {
		"bash",
		"c",
		"diff",
		"html",
		"lua",
		"luadoc",
		"markdown",
		"markdown_inline",
		"query",
		"vim",
		"vimdoc",
		"gleam",
	},

	auto_install = true,
	highlight = {
		enable = true,
	},
})
