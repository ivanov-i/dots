local M = {}

local function start_buffer(buf)
    if vim.bo[buf].buftype ~= "" or vim.bo[buf].filetype == "" then
        return
    end

    pcall(vim.treesitter.start, buf)
end

function M.setup()
    require("nvim-treesitter").setup {
        install_dir = vim.fn.stdpath("data") .. "/site",
    }

    local group = vim.api.nvim_create_augroup("EverythingTreesitter", { clear = true })

    vim.api.nvim_create_autocmd("FileType", {
        group = group,
        callback = function(event)
            start_buffer(event.buf)
        end,
    })

    start_buffer(vim.api.nvim_get_current_buf())
end

return M
