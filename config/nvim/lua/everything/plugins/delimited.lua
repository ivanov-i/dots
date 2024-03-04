    return {
        "mizlan/delimited.nvim",
        opts = {
            pre = function()
                -- do something here
            end,
            post = function()
                -- do something here
            end,
        },
        config = function ()
            vim.keymap.set("n", "[d", require("delimited").goto_prev)
            vim.keymap.set("n", "]d", require("delimited").goto_next)
            vim.keymap.set("n", "[D", function()
                require("delimited").goto_prev({ severity = vim.diagnostic.severity.ERROR })
            end)
            vim.keymap.set("n", "]D", function()
                require("delimited").goto_next({ severity = vim.diagnostic.severity.ERROR })
            end)
        end
    }
