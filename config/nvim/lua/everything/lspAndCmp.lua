local lsp = require('lsp-zero')
lsp.preset('recommended')

-- IMPORTANT: make sure to setup neodev BEFORE lspconfig
require("neodev").setup({
  -- add any options here, or leave empty to use the default settings
})
local ensure_installed = {
	'lua_ls',
	'rust_analyzer',
	'pyright',
	'jsonls',
	'jdtls'
}

require('mason').setup()
require ('mason-nvim-dap').setup({
	automatic_setup = true,
	handlers = {},
	ensure_installed = ensure_installed,
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
  vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
  vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)

  vim.keymap.set("n", "<leader>fr", function() require('telescope.builtin').lsp_references() end, opts)
  vim.keymap.set("n", "<leader>fs", function() require('telescope.builtin').lsp_document_symbols() end, opts)
  vim.keymap.set("n", "<leader>fc", function() require('telescope.builtin').lsp_incoming_calls() end, opts)
  vim.keymap.set("n", "<leader>fo", function() require('telescope.builtin').lsp_outgoing_calls() end, opts)
  vim.keymap.set("n", "<leader>fi", function() require('telescope.builtin').lsp_implementations() end, opts)
  vim.keymap.set("n", "<leader>fx", function() require('telescope.builtin').lsp_document_diagnostics() end, opts)

end)

local lspconfig = require('lspconfig')

for _, server in ipairs(ensure_installed) do
    if server ~= 'lua_ls' then
        lspconfig[server].setup({ })
    end
end

-- Fix Undefined global 'vim'
lspconfig.lua_ls.setup({
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

local cmp = require('cmp')
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

cmp.setup({
	completion = {
		autocomplete = false
	},
	sources = {
		{name = 'path'},
		{name = 'nvim_lsp'},
		{name = 'buffer'},
        {name = 'vim_dadbod_completion'},
		{name = 'luasnip'},
	},
	window = {
		documentation = cmp.config.window.bordered()
	},
	view = {
	    entries = {
	        follow_cursor = true,
	    },
	},

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

vim.api.nvim_create_autocmd("FileType", {
    pattern = {"sql", "mysql", "plsql", "sqlite"},
    callback = function()
        cmp.setup.buffer {
            sources = {
                { name = 'vim-dadbod-completion' },
                {name = 'buffer'},
            }
        }
    end,
})

lsp.set_preferences({
    suggest_lsp_servers = true,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

lsp.setup()

-- diagnostics

vim.keymap.set(
	"",
	"<Leader>l",
	require("lsp_lines").toggle,
	{ desc = "Toggle lsp_lines" }
)

--debug

vim.keymap.set("n", "<F9>", require("dap").toggle_breakpoint)
vim.keymap.set("n", "<leader>kb", require("dap").toggle_breakpoint)
vim.keymap.set("n", "<F5>", require("dap").continue)
vim.keymap.set("n", "<leader>kc", require("dap").continue)
vim.keymap.set("n", "<F10>", require("dap").step_over)
vim.keymap.set("n", "<leader>ks", require("dap").step_over)
vim.keymap.set("n", "<F11>", require("dap").step_into)
vim.keymap.set("n", "<leader>ki", require("dap").step_into)
vim.keymap.set("n", "<F12>", require("dap").step_out)
vim.keymap.set("n", "<leader>ko", require("dap").step_out)
vim.keymap.set("n", "<leader>de", function() require("dap").terminate() end)


-- require 'mason-nvim-dap'.setup_handlers {
--     function(source_name)
--       -- all sources with no handler get passed here
--
--
--       -- Keep original functionality of `automatic_setup = true`
--       require('mason-nvim-dap.automatic_setup')(source_name)
--     end,
--     python = function(source_name)
--         dap.adapters.python = {
-- 	        type = "executable",
-- 	        command = "python",
-- 	        args = {
-- 		        "-m",
-- 		        "debugpy.adapter",
-- 	        },
--         }
--
--         dap.configurations.python = {
-- 	        {
-- 		        type = "python",
-- 		        request = "launch",
-- 		        name = "Launch file",
-- 		        program = "${file}", -- This configuration will launch the current file if used.
-- 	        },
--         }
--     end,
-- }

require("nvim-dap-virtual-text").setup()

