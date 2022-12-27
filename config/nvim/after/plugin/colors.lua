function ColorMyPencils(color)
	color = color or "distilled"
	vim.cmd("colorscheme " .. color)

	vim.api.nvim_set_hl(0, "Normal", {bg = "None"})
	vim.api.nvim_set_hl(0, "NormalFloat", {bg = "None"})
	vim.opt.termguicolors = true
end

 ColorMyPencils()
