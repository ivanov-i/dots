return
{
    "simrat39/symbols-outline.nvim",
    config = function()
        require("symbols-outline").setup(
        {
        })
        vim.api.nvim_create_autocmd({ "BufEnter" }, {
            group = vim.api.nvim_create_augroup("SharedLspSymbolsSidebar", { clear = true }),
            pattern = "*",
            callback = function()
                require("symbols-outline").open_outline()
            end
        })
    end,
}
