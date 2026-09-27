#!/usr/bin/env bash
# ============================================================
# Named tmux-resurrect snapshots — ~/.config/tmux/scripts/sessions.sh
#   sessions.sh save <name>   save everything as <name>
#   sessions.sh menu          pick a named save (or latest autosave) to load
#   sessions.sh load <name>   load a named save
#   sessions.sh latest        load the newest autosave (continuum)
#   sessions.sh delmenu       pick a named save to delete
# Named saves live in <resurrect-dir>/named/ and are never touched by
# continuum's 15-min autosave or resurrect's old-backup cleanup.
# ============================================================
set -uo pipefail

SELF="$(readlink -f "$0")"
RES="$HOME/.config/tmux/plugins/tmux-resurrect/scripts"
DIR="$(tmux show -gqv @resurrect-dir)"
DIR="${DIR:-${XDG_DATA_HOME:-$HOME/.local/share}/tmux/resurrect}"
DIR="${DIR/#\~/$HOME}"
NAMED="$DIR/named"
mkdir -p "$NAMED"

restore() { # $1 = path relative to $DIR
    ln -sfn "$1" "$DIR/last"
    "$RES/restore.sh"
}

named_files() { ls -t "$NAMED"/*.txt 2>/dev/null; }

case "${1:-}" in
save)
    name="$(printf '%s' "${2:-}" | tr -c 'A-Za-z0-9_-' '_')"
    [ -n "$name" ] || { tmux display "No name given, nothing saved"; exit 1; }
    "$RES/save.sh" quiet
    cp -L "$DIR/last" "$NAMED/$name.txt"
    tmux display "Saved session as '$name'"
    ;;
load)
    [ -f "$NAMED/$2.txt" ] || { tmux display "No save named '$2'"; exit 1; }
    restore "named/$2.txt"
    tmux display "Loaded '$2'"
    ;;
latest)
    f="$(ls -t "$DIR"/tmux_resurrect_*.txt 2>/dev/null | head -1)"
    [ -n "$f" ] || { tmux display "No autosave yet"; exit 1; }
    restore "$(basename "$f")"
    tmux display "Loaded autosave $(basename "$f")"
    ;;
menu | delmenu)
    items=()
    i=1
    while IFS= read -r f; do
        n="$(basename "$f" .txt)"
        when="$(date -r "$f" '+%b %d %H:%M')"
        key=""; [ $i -le 9 ] && key="$i"
        if [ "$1" = menu ]; then
            items+=("$n  ($when)" "$key" "run-shell '$SELF load $n'")
        else
            items+=("$n  ($when)" "$key" "confirm-before -p \"Delete save '$n'? (y/n)\" \"run-shell 'rm -f $NAMED/$n.txt'\"")
        fi
        i=$((i + 1))
    done < <(named_files)

    if [ "$1" = menu ]; then
        [ ${#items[@]} -gt 0 ] && items+=("")
        items+=("latest autosave" "a" "run-shell '$SELF latest'")
        tmux display-menu -T "#[align=centre] Load session " "${items[@]}"
    else
        [ ${#items[@]} -gt 0 ] || { tmux display "No named saves"; exit 0; }
        tmux display-menu -T "#[align=centre] Delete save " "${items[@]}"
    fi
    ;;
*)
    echo "usage: $0 save <name> | load <name> | latest | menu | delmenu" >&2
    exit 1
    ;;
esac
