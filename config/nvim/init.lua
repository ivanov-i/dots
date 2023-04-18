pcall(require, "impatient")
require("everything")

vim.api.nvim_create_autocmd("FileType", { callback = function() vim.opt.formatoptions = vim.opt.formatoptions - { "c","r","o" } end, })
