# Neovim config

## Plugins

### Fomratting
[Conform](https://github.com/stevearc/conform.nvim) - formatting

#### Commands
- FormatEnable[!] - enable formating, ! - only for current buffer
- FormatDisable[!] - disable formating, ! - only for current buffer

### Debugging
[nvim-dap](https://github.com/mfussenegger/nvim-dap) - Debug Adapter Protocol client
[nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui) - UI for nvim dap

#### Keybindings nvim-dap
| Mode | Key | Description |
| ---- | --- | ----------- |
| n | F5 | start/continue |
| n | F1 | step into |
| n | F2 | step over |
| n | F3 | step out |
| n | <leader>b  | toggle breakpoint |
| n | <leader>B | condition breakpoint |

#### Keybindings nvim-dap-ui
| Mode | Key | Description |
| ---- | --- | ----------- |
| n | F7 | toggle dap ui |
| n | M-k | evaluate expression under cursor |
| v | M-k | evaluate selected expression |

### VCS
[tpope/vim-fugitive](https://github.com/tpope/vim-fugitive) - Git extension
[tpope/vim-rhubarb](https://github.com/tpope/vim-rhubarb?tab=readme-ov-file) - GitHub extension
[lewis6991/gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) Git integration for buffers

#### Keybindings gitsigns.nvim
| Mode | Key | Description |
| ---- | --- | ----------- |
| n, v | ]c | next hunk |
| n, v | [c | previous hunk |
| n, v | <leader>hs | stage hunk |
| n, v | <leader>hr | reset hunk |
| n | <leader>hS | stage buffer |
| n | <leader>hR | restart buffer |
| n | <leader>hu | undo stage hunk |
| n | <leader>hp | preview hunk |
| n | <leader>hb | git blame line |
| n | <leader>hd | git diff against index |
| n | <leader>hD | git diff against last commit |
| n | <leader>tb | toggle git blame line |
| n | <leader>td | toggle git show deleted |
| o, x | <leader>ih | select git hunk |

### LSP
[neovim/nvim-lspconfig]() - 
[folke/neodev.nvim]() - 
[folke/neoconf.nvim]() - 
