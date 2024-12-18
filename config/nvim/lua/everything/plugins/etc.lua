return
{
	{
		'karoliskoncevicius/distilled-vim',
		name = 'distilled',
		config = function()
			vim.cmd('colorscheme distilled')
		end
	},
	{{
		'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
		config = function()
			require("lsp_lines").setup()
		end,
	}},
	{'nvim-java/nvim-java'},

	-- 'onsails/lspkind.nvim',
	-- {'jayp0521/mason-nvim-dap.nvim',
	-- dependencies = {
	-- 	{'williamboman/mason.nvim'},
	-- 	{'mfussenegger/nvim-dap'},
	-- }
    -- },
{'theHamsta/nvim-dap-virtual-text', dependencies = {'nvim-treesitter/nvim-treesitter', 'mfussenegger/nvim-dap'} },
{'folke/neodev.nvim'},
{'airblade/vim-gitgutter'},
{'lewis6991/impatient.nvim'},
{'whiteinge/diffconflicts'},
{'tpope/vim-repeat'},
}



