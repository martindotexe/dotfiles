return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons', 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
  },
  {
    'Kicamon/markdown-table-mode.nvim',
    config = function()
      require('markdown-table-mode').setup()
    end,
  },
}
