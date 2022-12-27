-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.0',
		-- or                            , branch = '0.1.x',
		requires = { {'nvim-lua/plenary.nvim'} }
	}
	use({
		'karoliskoncevicius/distilled-vim',
		as = 'distilled',
		config = function()
			vim.cmd('colorscheme distilled')
		end
	})

	use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
	use('tpope/vim-fugitive')
	use {
		'VonHeikemen/lsp-zero.nvim',
		requires = {
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
		}
	}

	use('907th/vim-auto-save')
	use('nvim-tree/nvim-web-devicons')
	use('onsails/lspkind.nvim')
	use('terrortylor/nvim-comment')
	use{'jayp0521/mason-nvim-dap.nvim',
		requires = {
			{'williamboman/mason.nvim'},
			{'mfussenegger/nvim-dap'},
		}
	}
	use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }
	use {'theHamsta/nvim-dap-virtual-text', requires = {'nvim-treesitter/nvim-treesitter', 'mfussenegger/nvim-dap'} }
    use('lukas-reineke/indent-blankline.nvim')

end)
