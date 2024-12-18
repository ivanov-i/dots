vim.opt.sessionoptions = {
  -- Windovigation required options.
  "buffers",
  "help",
  "blank",
  "terminal",
  "winsize",
  "tabpages",
  -- Other options.
  "curdir",
  "globals",
  "folds",
}

return {
    'rmagatti/auto-session',
    lazy = false,

    opts = {
        pre_save_cmds = {
            function()
                require("windovigation.actions").persist_state()
            end,
        }
    },
}
