vim.loader.enable()

require("everything")

if not vim.g.vscode then
    vim.api.nvim_create_autocmd("FileType", { callback = function() vim.opt.formatoptions = vim.opt.formatoptions - { "c","r","o" } end, })
end
