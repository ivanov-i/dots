-- Reserve a space in the gutter
-- This will avoid an annoying layout shift in the screen
-- vim.opt.signcolumn = 'yes'

-- Add cmp_nvim_lsp capabilities settings to lspconfig
-- This should be executed before you configure any language server
local lspconfig_defaults = require('lspconfig').util.default_config
lspconfig_defaults.capabilities = vim.tbl_deep_extend(
  'force',
  lspconfig_defaults.capabilities,
  require('cmp_nvim_lsp').default_capabilities()
)

-- This is where you enable features that only work
-- if there is a language server active in the file
vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local opts = {buffer = event.buf}

    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
    vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
    vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
    vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
    vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
    vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
    vim.keymap.set('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)

    -- vim.keymap.set('i', '<Tab>', function()
    --     if not vim.lsp.inline_completion.get() then
    --         return '<Tab>'
    --     end
    -- end, { expr = true, desc = 'Accept the current inline completion' })
  end,
})

vim.lsp.enable('pyright')
vim.lsp.enable('jdtls')
vim.lsp.enable('vtsls')
vim.lsp.enable('bashls')
vim.lsp.config('lua_ls', {
-- Fix Undefined global 'vim'
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' },
      },
	  workspace = {
		  checkThirdParty = false,
	  },
	  telemetry = {
		  enable = false,
	  },
    },
  },
})
vim.lsp.enable('lua_ls')

local cmp = require('cmp')
vim.g.gitgutter_sign_allow_clobber = 0
cmp.setup({
  sources = {
    {name = 'nvim_lsp'},
    {name = 'luasnip'},
    {name = 'buffer'},
    {name = 'path'},
  },
  snippet = {
    expand = function(args)
      -- You need Neovim v0.10 to use vim.snippet
      vim.snippet.expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({}),
  telemetry = false,
  completion = {
    autocomplete = false,
  }
})

vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = '✘',
            [vim.diagnostic.severity.WARN] = '⚠',
            [vim.diagnostic.severity.HINT] = '⚑',
            [vim.diagnostic.severity.INFO] = '»'
        }
    }
})

vim.lsp.enable('copilot')
vim.lsp.inline_completion.enable()
