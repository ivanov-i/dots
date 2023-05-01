local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

require('packer').startup(function(use)
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.0',
		-- or                            , branch = '0.1.x',
		requires = { {'nvim-lua/plenary.nvim'} }
	}
	use {
		'nvim-telescope/telescope-fzf-native.nvim',
		run = 'make',
		cond = vim.fn.executable 'make' == 1
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
		branch = 'v1.x',
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

			-- Useful status updates for LSP
			{'j-hui/fidget.nvim'},
		}
	}
	use({
		'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
		config = function()
			require("lsp_lines").setup()
		end,
	})

	use('907th/vim-auto-save')
	use('onsails/lspkind.nvim')
	use('terrortylor/nvim-comment')
	use{'jayp0521/mason-nvim-dap.nvim',
	requires = {
		{'williamboman/mason.nvim'},
		{'mfussenegger/nvim-dap'},
	}
	}
	use {'theHamsta/nvim-dap-virtual-text', requires = {'nvim-treesitter/nvim-treesitter', 'mfussenegger/nvim-dap'} }
    use('lukas-reineke/indent-blankline.nvim')
	use {"jcdickinson/wpm.nvim", requires = {'nvim-lualine/lualine.nvim'}}
	use {'folke/neodev.nvim'}
	use {'nyngwang/NeoZoom.lua'}
	use {'airblade/vim-gitgutter'}
	use {'nvim-treesitter/nvim-treesitter-context', requires = {'nvim-treesitter/nvim-treesitter'}}
	use {'github/copilot.vim'}
	use {'lewis6991/impatient.nvim'}
	use {'danilamihailov/beacon.nvim'}
	use {'dhruvasagar/vim-prosession', requires= {'tpope/vim-obsession'}}
	use {'whiteinge/diffconflicts'}
	use {'vim-test/vim-test'}
	use {'axkirillov/hbac.nvim'}

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		require('packer').sync()
	end
end)

if pcall(require, 'impatient') then
	require('impatient')
end
