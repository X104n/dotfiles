# Neovim Keybindings & Reference

Leader key: `Space`

---

## Terminal (ToggleTerm)

| Key | Action |
|-----|--------|
| `Ctrl+T` | Toggle terminal |

Use `Ctrl+\ Ctrl+N` to exit terminal mode and return to normal mode.

---

## File Explorer (Neo-tree)

| Key | Action |
|-----|--------|
| `Ctrl+N` | Toggle file explorer |
| `a` | New file (inside tree) |
| `d` | Delete file (inside tree) |
| `r` | Rename file (inside tree) |
| `Enter` | Open file (inside tree) |

The explorer opens automatically when you start nvim with no file arguments.

---

## Buffers / Tabs (Bufferline)

| Key | Action |
|-----|--------|
| `Shift+L` | Next buffer/tab |
| `Shift+H` | Previous buffer/tab |
| `:bd` | Close current buffer |

---

## File Search (Telescope)

| Key | Action |
|-----|--------|
| `Ctrl+P` | Find files by name |

Inside the Telescope picker:
| Key | Action |
|-----|--------|
| `Ctrl+J` / `↓` | Move down |
| `Ctrl+K` / `↑` | Move up |
| `Enter` | Open selected file |
| `Ctrl+X` | Open in horizontal split |
| `Ctrl+V` | Open in vertical split |
| `Escape` | Close picker |

---

## LSP (Language Server)

These are available when a language server is attached to the file.

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gr` | Find all references |
| `K` | Hover documentation |
| `Space + rn` | Rename symbol |
| `Space + ca` | Code actions (fixes, imports, etc.) |
| `Space + e` | Show diagnostic (error/warning) details |
| `[d` | Jump to previous diagnostic |
| `]d` | Jump to next diagnostic |

---

## Autocompletion (nvim-cmp)

| Key | Action |
|-----|--------|
| `Ctrl+Space` | Manually trigger completion |
| `Tab` | Next suggestion / expand snippet |
| `Shift+Tab` | Previous suggestion |
| `Enter` | Confirm selected suggestion |
| `Escape` | Close completion menu |

Completions appear automatically from:
- LSP (language server)
- Current buffer words
- File paths
- Snippets (LuaSnip)

---

## General Vim Basics

### Modes
| Key | Action |
|-----|--------|
| `i` | Enter insert mode (before cursor) |
| `a` | Enter insert mode (after cursor) |
| `o` | New line below and enter insert mode |
| `O` | New line above and enter insert mode |
| `v` | Enter visual mode (select characters) |
| `V` | Enter visual line mode (select lines) |
| `Escape` | Return to normal mode |

### Navigation
| Key | Action |
|-----|--------|
| `h / j / k / l` | Left / Down / Up / Right |
| `w` | Jump to start of next word |
| `b` | Jump to start of previous word |
| `0` | Start of line |
| `$` | End of line |
| `gg` | Top of file |
| `G` | Bottom of file |
| `Ctrl+D` | Scroll down half page |
| `Ctrl+U` | Scroll up half page |
| `%` | Jump to matching bracket |

### Editing
| Key | Action |
|-----|--------|
| `dd` | Delete (cut) line |
| `yy` | Copy (yank) line |
| `p` | Paste below |
| `P` | Paste above |
| `u` | Undo |
| `Ctrl+R` | Redo |
| `ciw` | Change (replace) entire word |
| `ci"` | Change text inside quotes |
| `>>`/ `<<` | Indent / un-indent line |

### Search
| Key | Action |
|-----|--------|
| `/text` | Search forward for "text" |
| `?text` | Search backward for "text" |
| `n` | Next match |
| `N` | Previous match |
| `:noh` | Clear search highlight |

### Splits
| Key | Action |
|-----|--------|
| `:vsp` | Vertical split |
| `:sp` | Horizontal split |
| `Ctrl+W` then `h/j/k/l` | Move between splits |
| `Ctrl+W` then `q` | Close split |

### Saving & Quitting
| Key | Action |
|-----|--------|
| `:w` | Save |
| `:q` | Quit |
| `:wq` | Save and quit |
| `:q!` | Quit without saving |

---

## Plugin Management (Lazy)

| Command | Action |
|---------|--------|
| `:Lazy` | Open plugin manager UI |
| `:Lazy sync` | Install / update / clean plugins |
| `:Lazy update` | Update all plugins |

---

## LSP Server Management (Mason)

| Command | Action |
|---------|--------|
| `:Mason` | Open Mason UI to install language servers |

Useful servers to install:
- `lua-language-server` — Lua
- `typescript-language-server` — JavaScript / TypeScript
- `pyright` — Python
- `rust-analyzer` — Rust
- `clangd` — C / C++
- `bash-language-server` — Bash
