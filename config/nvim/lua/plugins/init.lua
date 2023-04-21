return {
	{
		'nvim-telescope/telescope.nvim', tag = '0.1.0',
		-- or                            , branch = '0.1.x',
		dependencies = { {'nvim-lua/plenary.nvim'} }
	},
	{
		'nvim-telescope/telescope-fzf-native.nvim',
		build = 'make',
		cond = vim.fn.executable 'make' == 1
	},
	{
		'karoliskoncevicius/distilled-vim',
		name = 'distilled',
		config = function()
			vim.cmd('colorscheme distilled')
		end
	},

	{'nvim-treesitter/nvim-treesitter', build = function()
		require("nvim-treesitter.install").update({ with_sync = true })
	end},

	{'tpope/vim-fugitive'},
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

	'907th/vim-auto-save',
	'onsails/lspkind.nvim',
	'terrortylor/nvim-comment',
	{'jayp0521/mason-nvim-dap.nvim',
	dependencies = {
		{'williamboman/mason.nvim'},
		{'mfussenegger/nvim-dap'},
	}
},
{'theHamsta/nvim-dap-virtual-text', dependencies = {'nvim-treesitter/nvim-treesitter', 'mfussenegger/nvim-dap'} },
'lukas-reineke/indent-blankline.nvim',
{'roobert/node-type.nvim', dependencies = {'nvim-lualine/lualine.nvim'}},
{"jcdickinson/wpm.nvim", dependencies = {'nvim-lualine/lualine.nvim'}},
{'folke/neodev.nvim'},
{'nyngwang/NeoZoom.lua'},
{'airblade/vim-gitgutter'},
{'nvim-treesitter/nvim-treesitter-context', dependencies = {'nvim-treesitter/nvim-treesitter'}},
{'github/copilot.vim'},
{'lewis6991/impatient.nvim'},
{'danilamihailov/beacon.nvim'},
{'dhruvasagar/vim-prosession', dependencies= {'tpope/vim-obsession'}},
{'whiteinge/diffconflicts'},
{'vim-test/vim-test'},
}
