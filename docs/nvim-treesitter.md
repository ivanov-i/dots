---
summary: 'Neovim Tree-sitter setup for Neovim 0.12+.'
read_when:
  - Editing config/nvim Tree-sitter config.
  - Debugging Neovim Tree-sitter highlight or parser errors.
---
## Tree-sitter
- This repo targets Neovim 0.12+ with `nvim-treesitter` on the `main` branch.
- Keep `nvim-treesitter` non-lazy. The upstream plugin does not support lazy-loading.
- The plugin manages parsers and queries in `stdpath('data')/site`; keep that directory on `runtimepath`.
- Highlighting is enabled with `vim.treesitter.start()` from a `FileType` autocommand.
- Startup must not depend on `tree-sitter` CLI. The CLI is only needed when explicitly installing or updating non-bundled parsers with `:TSInstall` or `:TSUpdate`.
- Neovim 0.12 ships Tree-sitter node selection built in: `an`, `in`, `[n`, `]n`. This config does not add custom remaps for that feature.
