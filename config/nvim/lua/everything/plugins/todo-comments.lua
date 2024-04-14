-- Highlight todo, notes, etc in comments
-- here are the examples:
-- TODO: This is a todo
-- FIXME: This is a fixme
-- NOTE: This is a note
-- HACK: This is a hack
-- XXX: This is a warning
-- BUG: This is a bug
-- IDEA: This is an idea
-- UNDONE: This is an undone
-- REVIEW: This is a review
-- DEBUG: This is a debug
-- OPTIMIZE: This is an optimize
-- IMPORTANT: This is an important
-- INFO: This is an info
-- QUESTION: This is a question
-- EXAMPLE: This is an example
-- WARN: This is a warning
-- ERROR: This is an error
-- DONE: This is a done
-- TASK: This is a task
-- DONT: This is a dont
-- DONTSHOW: This is a dontshow

return
{
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = true } ,
}

