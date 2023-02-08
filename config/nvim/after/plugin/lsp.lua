local lsp = require('lsp-zero')
lsp.preset('recommended')
lsp.ensure_installed({
	'sumneko_lua',
	'rust_analyzer',
	'pyright',
	'jsonls',
})
--
-- Fix Undefined global 'vim'
lsp.configure('sumneko_lua', {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
})

local cmp = require('cmp')
cmp.setup({
	completion = {
		autocomplete = false
	},
	sources = {
		{name = 'path'},
		{name = 'nvim_lsp', keyword_length = 3},
		{name = 'buffer', keyword_length = 3},
		-- {name = 'luasnip', keyword_length = 2},
	},
	window = {
		documentation = cmp.config.window.bordered()
	},
})

local select_opts = {behavior = cmp.SelectBehavior.Select}
-- local cmp_enable = {cmp.setup.enabled = true }
local cmp_mappings = lsp.defaults.cmp_mappings({
	['<up>'] = cmp.mapping.select_prev_item(select_opts),
	['<down>'] = cmp.mapping.select_next_item(select_opts),
	['<C-u>'] = cmp.mapping.scroll_docs(-4),
	['<C-f>'] = cmp.mapping.scroll_docs(4),
	['<C-e>'] = cmp.mapping.abort(),
	['<C-y>'] = cmp.mapping.confirm({select = true}),
	['<cr>'] = cmp.mapping.confirm({select = false}),

	['<C-p>'] = cmp.mapping.select_prev_item(select_opts),
	['<C-n>'] = cmp.mapping(function(fallback)
		local col = vim.fn.col('.') - 1

		if cmp.visible() then
			cmp.select_next_item(select_opts)
		-- elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
			-- fallback()
		else
			cmp.complete()
		end
	end, {'i', 's'}),
})

local lspkind = require('lspkind')

lsp.setup_nvim_cmp({
	mapping = cmp_mappings,
	formatting = {
		format = function(entry, vim_item)
			if vim.tbl_contains({ 'path' }, entry.source.name) then
				local icon, hl_group = require('nvim-web-devicons').get_icon(entry:get_completion_item().label)
				if icon then
					vim_item.kind = icon
					vim_item.kind_hl_group = hl_group
					return vim_item
				end
			end

			return lspkind.cmp_format({
				with_text = false,
				mode = 'symbol', -- show only symbol annotations
				maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
				ellipsis_char = '…', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)

			})(entry, vim_item)
		end
	}
})

lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

lsp.on_attach(function(client, bufnr)
  local opts = {buffer = bufnr, remap = false}

  if client.name == "eslint" then
      vim.cmd.LspStop('eslint')
      return
  end

  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
  vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
  vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
  vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
  vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
  vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
end)

lsp.setup()

-- diagnostics

vim.diagnostic.config({
	virtual_text = false,
	severity_sort = true,
	float = {
		border = 'rounded',
		source = 'always',
		header = '',
		prefix = '',
	},
})

vim.keymap.set(
	"",
	"<Leader>l",
	require("lsp_lines").toggle,
	{ desc = "Toggle lsp_lines" }
)

--debug

vim.keymap.set("n", "<F9>", require("dap").toggle_breakpoint)
vim.keymap.set("n", "<F5>", require("dap").continue)
vim.keymap.set("n", "<F10>", require("dap").step_over)
vim.keymap.set("n", "<F11>", require("dap").step_into)
vim.keymap.set("n", "<F12>", require("dap").step_out)
vim.keymap.set("n", "<leader>de", function() require("dap").terminate() end)

local dap = require("dap")

require('mason').setup()
require ('mason-nvim-dap').setup({
    ensure_installed = {'stylua', 'jq', 'python'}
})

require 'mason-nvim-dap'.setup_handlers {
    function(source_name)
      -- all sources with no handler get passed here


      -- Keep original functionality of `automatic_setup = true`
      require('mason-nvim-dap.automatic_setup')(source_name)
    end,
    python = function(source_name)
        dap.adapters.python = {
	        type = "executable",
	        command = "python",
	        args = {
		        "-m",
		        "debugpy.adapter",
	        },
        }

        dap.configurations.python = {
	        {
		        type = "python",
		        request = "launch",
		        name = "Launch file",
		        program = "${file}", -- This configuration will launch the current file if used.
	        },
        }
    end,
}
require("dapui").setup()
require("nvim-dap-virtual-text").setup()

vim.keymap.set("n", "<leader>dr", require('dapui').toggle)

