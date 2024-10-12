local plugins = {
  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    ft = { 'markdown' },
    build = function()
      vim.fn['mkdp#util#install']()
    end,
  },
  { 'MeanderingProgrammer/render-markdown.nvim' },
  {
    'tadmccorkle/markdown.nvim',
    ft = 'markdown',
    opts = {},
  },
  {
    'williamboman/mason.nvim',
    opts = {
      ensure_installed = {
        'gopls',
      },
    },
  },
  {
    'pedro757/emmet',
    config = function()
      local lspconfig = require 'lspconfig'
      local configs = require 'lspconfig.configs'

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true

      if not configs.ls_emmet then
        configs.ls_emmet = {
          default_config = {
            cmd = { 'emmet-ls', '--stdio' },
            filetypes = {
              'html',
              'css',
              'scss',
              'javascriptreact',
              'typescriptreact',
              'haml',
              'xml',
              'xsl',
              'pug',
              'slim',
              'sass',
              'stylus',
              'less',
              'sss',
              'hbs',
              'handlebars',
              'tmpl',
            },
            html = {
              options = {
                -- Disable Emmet snippets if another source is used
                ['bem.enabled'] = true,
              },
            },
            root_dir = function(fname)
              return vim.loop.cwd()
            end,
            settings = {},
          },
        }
      end

      lspconfig.ls_emmet.setup { capabilities = capabilities }
    end,
  },
  {
    'epwalsh/obsidian.nvim',
    lazy = true,
    ft = 'markdown',
    dependencies = {
      -- Required.
      'nvim-lua/plenary.nvim',
    },
    opts = {
      workspaces = {
        {
          name = 'Coding',
          path = '~/vaults/coding',
        },
      },
    },
  },
  { 'ThePrimeagen/vim-be-good' },
}
return plugins
