return {
  'tris203/hawtkeys.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  config = {
    keyboardLayout = 'colemak',
    customMaps = {
      ['wk.register'] = {
        method = 'which_key',
      },
      ['lazy'] = {
        method = 'lazy',
      },
    },
  },
}
