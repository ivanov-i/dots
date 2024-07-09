return
{
	{
		'karoliskoncevicius/distilled-vim',
		name = 'distilled',
		config = function()
			vim.cmd('colorscheme distilled')
		end
	},
	{
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v1.x',
		dependencies = {
			-- LSP Support
			{'neovim/nvim-lspconfig'},
			{'williamboman/mason.nvim'},
			{'williamboman/mason-lspconfig.nvim'},

			-- Autocompletion
			{'hrsh7th/nvim-cmp'},
			{'hrsh7th/cmp-buffer'},
			{'hrsh7th/cmp-path'},
			{'saadparwaiz1/cmp_luasnip'},
			{'hrsh7th/cmp-nvim-lsp'},
			{'hrsh7th/cmp-nvim-lua'},

			-- Snippets
			{'L3MON4D3/LuaSnip'},
			{'rafamadriz/friendly-snippets'},

			-- Useful status updates for LSP
			{'j-hui/fidget.nvim'},
		}
	},
	{{
		'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
		config = function()
			require("lsp_lines").setup()
		end,
	}},

	'onsails/lspkind.nvim',
	{'jayp0521/mason-nvim-dap.nvim',
	dependencies = {
		{'williamboman/mason.nvim'},
		{'mfussenegger/nvim-dap'},
	}
},
{'theHamsta/nvim-dap-virtual-text', dependencies = {'nvim-treesitter/nvim-treesitter', 'mfussenegger/nvim-dap'} },
{'folke/neodev.nvim'},
{'airblade/vim-gitgutter'},
{'lewis6991/impatient.nvim'},
{'dhruvasagar/vim-prosession', dependencies= {'tpope/vim-obsession'}},
{'whiteinge/diffconflicts'},
{'tpope/vim-repeat'},
}



