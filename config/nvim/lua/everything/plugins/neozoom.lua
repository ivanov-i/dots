return
{
	'nyngwang/NeoZoom.lua',
	setup = true,
	init = function()
		vim.keymap.set('n', '<leader>z', function () vim.cmd('NeoZoomToggle') end, { silent = true, nowait = true })
	end,
}

