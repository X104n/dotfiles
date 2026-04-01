#!/usr/bin/env bash
# Dotfiles installer — interactive picker with symlink + backup support
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%Y%m%d_%H%M%S)"

# ── Color helpers ─────────────────────────────────────────────────────────────
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[0;33m'
CYAN='\033[0;36m'; BOLD='\033[1m'; RESET='\033[0m'

info()    { echo -e "${CYAN}  →${RESET} $*"; }
success() { echo -e "${GREEN}  ✓${RESET} $*"; }
warn()    { echo -e "${YELLOW}  !${RESET} $*"; }
error()   { echo -e "${RED}  ✗${RESET} $*"; }
header()  { echo -e "\n${BOLD}$*${RESET}"; }

# ── Dotfile registry ──────────────────────────────────────────────────────────
# Add new dotfiles here: ("display name" "source subdir" "target path")
ENTRIES=(
    "nvim       │ Neovim config            │ nvim                │ $HOME/.config/nvim"
    "cheapino   │ Cheapino keyboard layout  │ cheapino            │ $HOME/.config/cheapino"
)
# To add a new entry, append a line like:
#   "key        │ Description               │ source/subdir       │ /target/path"

# ── Parse entries ─────────────────────────────────────────────────────────────
parse_entry() {
    local entry="$1" field="$2"
    echo "${entry}" | awk -F'│' "{gsub(/^[[:space:]]+|[[:space:]]+$/, \"\", \$$((field+1))); print \$$((field+1))}"
}

# ── Interactive checklist (no external deps) ──────────────────────────────────
run_checklist() {
    local -n _selected="$1"   # nameref to output array
    local count=${#ENTRIES[@]}
    local -a checked=()

    for ((i=0; i<count; i++)); do checked+=("false"); done

    local cursor=0

    # Disable echo and enable raw input
    tput civis 2>/dev/null || true
    trap 'tput cnorm 2>/dev/null; tput rmcup 2>/dev/null; exit' INT TERM EXIT

    tput smcup 2>/dev/null || true

    while true; do
        tput cup 0 0 2>/dev/null || clear
        echo -e "${BOLD}Select dotfiles to install${RESET}  (↑/↓ move, space toggle, a all, n none, enter confirm, q quit)\n"

        for ((i=0; i<count; i++)); do
            local name desc
            name=$(parse_entry "${ENTRIES[$i]}" 0)
            desc=$(parse_entry "${ENTRIES[$i]}" 1)
            local box="[ ]"; [[ "${checked[$i]}" == "true" ]] && box="[${GREEN}x${RESET}]"
            if (( i == cursor )); then
                echo -e "  ${BOLD}▶ $box  %-12s${RESET}  %s" "$name" "$desc"
            else
                printf "    $box  %-12s  %s\n" "$name" "$desc"
            fi
        done

        # Read a single keypress
        IFS= read -rsn1 key
        if [[ $key == $'\x1b' ]]; then
            read -rsn2 -t 0.1 key2 || key2=""
            key+="$key2"
        fi

        case "$key" in
            $'\x1b[A'|k)
                if (( cursor > 0 )); then (( cursor-- )) || true; fi ;;
            $'\x1b[B'|j)
                if (( cursor < count-1 )); then (( cursor++ )) || true; fi ;;
            ' ')
                if [[ "${checked[$cursor]}" == "true" ]]; then
                    checked[$cursor]="false"
                else
                    checked[$cursor]="true"
                fi ;;
            a|A)  for ((i=0; i<count; i++)); do checked[$i]="true"; done ;;
            n|N)  for ((i=0; i<count; i++)); do checked[$i]="false"; done ;;
            ''|$'\n')  break ;;
            q|Q|$'\x1b')
                tput rmcup 2>/dev/null || true
                tput cnorm 2>/dev/null || true
                trap - INT TERM EXIT
                echo "Aborted."
                exit 0 ;;
        esac
    done

    tput rmcup 2>/dev/null || true
    tput cnorm 2>/dev/null || true
    trap - INT TERM EXIT

    for ((i=0; i<count; i++)); do
        if [[ "${checked[$i]}" == "true" ]]; then _selected+=("$i"); fi
    done
}

# ── Install a single dotfile ───────────────────────────────────────────────────
install_dotfile() {
    local src="$DOTFILES_DIR/$1"
    local dst="$2"
    local name="$3"

    if [[ ! -e "$src" ]]; then
        error "$name: source '$src' not found, skipping"
        return
    fi

    # Backup existing target if it's not already our symlink
    if [[ -e "$dst" || -L "$dst" ]]; then
        if [[ -L "$dst" && "$(readlink "$dst")" == "$src" ]]; then
            success "$name: already linked, skipping"
            return
        fi
        mkdir -p "$BACKUP_DIR"
        mv "$dst" "$BACKUP_DIR/$(basename "$dst")"
        warn "$name: backed up existing config to $BACKUP_DIR/"
    fi

    mkdir -p "$(dirname "$dst")"
    ln -s "$src" "$dst"
    success "$name: linked $dst → $src"
}

# ── Main ───────────────────────────────────────────────────────────────────────
main() {
    header "Dotfiles Installer"
    echo -e "  Repo: ${CYAN}${DOTFILES_DIR}${RESET}"

    local -a selection=()
    run_checklist selection

    if (( ${#selection[@]} == 0 )); then
        echo -e "\n  Nothing selected. Exiting."
        exit 0
    fi

    header "Installing..."
    for idx in "${selection[@]}"; do
        local entry="${ENTRIES[$idx]}"
        local name src dst
        name=$(parse_entry "$entry" 0)
        src=$(parse_entry "$entry" 2)
        dst=$(parse_entry "$entry" 3)
        install_dotfile "$src" "$dst" "$name"
    done

    header "Done."
    if [[ -d "$BACKUP_DIR" ]]; then
        info "Backups saved to: $BACKUP_DIR"
    fi
}

main "$@"
