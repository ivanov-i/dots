require("everything.leader")
require("everything.remap")
require("everything.options")

if not vim.g.vscode then
    require("everything.lazy-bootstrap")
    require("everything.lazy")
    require("everything.colors")
    require("everything.lspAndCmp")
end
