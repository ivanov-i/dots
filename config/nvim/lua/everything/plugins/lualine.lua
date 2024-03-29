return
{
	'nvim-lualine/lualine.nvim',
	opts =
	{
		options =
		{
			icons_enabled = false,
			component_separators = { left = '', right = ''},
			section_separators = { left = '', right = ''},
			globalstatus = true,
		},
		sections =
		{
			lualine_a = {},
			lualine_b = {'diagnostics'},
			lualine_c = {{'filename', path=3, newfile_status=true}},
			lualine_x =
			{
				'encoding',
				'fileformat',
				'filetype',
				'progress',
				'location',
			},

				lualine_y = {},
				lualine_z = {},
		},
	}
}
-- require('lualine').setup {
--   options = {
--     icons_enabled = true,
--     theme = 'auto',
--     component_separators = { left = '', right = ''},
--     section_separators = { left = '', right = ''},
--     disabled_filetypes = {
--       statusline = {},
--       winbar = {},
--     },
--     ignore_focus = {},
--     always_divide_middle = true,
--     globalstatus = false,
--     refresh = {
--       statusline = 1000,
--       tabline = 1000,
--       winbar = 1000,
--     }
--   },
--   sections = {
--     lualine_a = {'mode'},
--     lualine_b = {'', 'diff', 'diagnostics'},
--     lualine_c = {'filename'},
--     lualine_x = {'encoding', 'fileformat', 'filetype'},
--     lualine_y = {'progress'},
--     lualine_z = {'location'}
--   },
--   inactive_sections = {
--     lualine_a = {},
--     lualine_b = {},
--     lualine_c = {'filename'},
--     lualine_x = {'location'},
--     lualine_y = {},
--     lualine_z = {}
--   },
--   tabline = {},
--   winbar = {},
--   inactive_winbar = {},
--   extensions = {}
-- }
