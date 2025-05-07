return
{
    {
        'axieax/urlview.nvim',
        config = function()
            require('urlview').setup()
        end
    },
	{
		'karoliskoncevicius/distilled-vim',
		name = 'distilled',
		config = function()
			vim.cmd('colorscheme distilled')
		end
	},
    -- 		-- LSP Support
    {'mfussenegger/nvim-jdtls'},
	{'nvim-java/nvim-java'},
    {
        "mason-org/mason.nvim",
        config = function()
            require("mason").setup()
        end
    },
    {"mason-org/mason-lspconfig.nvim"},
    {"neovim/nvim-lspconfig"},
	-- Autocompletion
	{'hrsh7th/nvim-cmp'},
	{'hrsh7th/cmp-buffer'},
	{'hrsh7th/cmp-path'},
	{'saadparwaiz1/cmp_luasnip'},
	{'hrsh7th/cmp-nvim-lsp'},
	{'hrsh7th/cmp-nvim-lua'},

	-- Snippets
	{'L3MON4D3/LuaSnip', build = "make install_jsregexp"},
	{'rafamadriz/friendly-snippets'},

	-- Useful status updates for LSP
	{'j-hui/fidget.nvim'},

	-- 'onsails/lspkind.nvim',
	-- {'jayp0521/mason-nvim-dap.nvim',
	-- dependencies = {
	-- 	{'williamboman/mason.nvim'},
	-- 	{'mfussenegger/nvim-dap'},
	-- }
    -- },
{'theHamsta/nvim-dap-virtual-text', dependencies = {'nvim-treesitter/nvim-treesitter', 'mfussenegger/nvim-dap'} },
{'folke/neodev.nvim'},
{'lewis6991/impatient.nvim'},
{'lewis6991/gitsigns.nvim'},
{'whiteinge/diffconflicts'},
{'tpope/vim-repeat'},
}



