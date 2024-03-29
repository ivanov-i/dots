return
{
	'nvim-treesitter/nvim-treesitter',
	dependencies = {
		-- 'nvim-treesitter/nvim-treesitter-refactor',
		-- 'RRethy/nvim-treesitter-textsubjects',
		-- 'RRethy/nvim-treesitter-endwise',
	},
	build = ':TSUpdate',
	event = 'VeryLazy',
	opts =
	{
		-- A list of parser names, or "all"
		ensure_installed = { "c", "lua", "rust", "javascript", "typescript", "java", "python" },

		-- Install parsers synchronously (only applied to `ensure_installed`)
		sync_install = false,

		-- Automatically install missing parsers when entering buffer
		-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
		auto_install = true,

		---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
		-- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

		highlight = {
			-- `false` will disable the whole extension
			-- disable highlight to avoid requiring w!
			-- enable = true,
			additional_vim_regex_highlighting = false,
		},

        config = {
            require("nvim-treesitter.configs").setup {
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        node_incremental = "v",
                        node_decremental = "V",
                    },
                }
            },
        }
    },
}
