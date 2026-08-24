#!/bin/zsh
set -euo pipefail

DAYS=30
DRY_RUN=0

CODEX_HOME="${CODEX_HOME:-$HOME/.codex}"
DB="$CODEX_HOME/state_5.sqlite"

usage() {
    echo "Usage: $0 [-n|--dry-run] [-d|--days N]"
    exit 1
}

while (( $# )); do
    case "$1" in
        -n|--dry-run)
            DRY_RUN=1
            shift
            ;;
        -d|--days)
            [[ $# -ge 2 ]] || usage
            DAYS="$2"
            shift 2
            ;;
        -h|--help)
            usage
            ;;
        *)
            usage
            ;;
    esac
done

[[ "$DAYS" == <-> ]] || {
    echo "Invalid number of days: $DAYS" >&2
    exit 1
}

[[ -f "$DB" ]] || {
    echo "Codex database not found: $DB" >&2
    exit 1
}

command -v sqlite3 >/dev/null || {
    echo "sqlite3 not found" >&2
    exit 1
}

command -v codex >/dev/null || {
    echo "codex not found" >&2
    exit 1
}

CUTOFF_MS=$(( $(date -v-"${DAYS}"d +%s) * 1000 ))

if (( DRY_RUN )); then
    echo "Dry run — sessions untouched for more than $DAYS days:"
else
    echo "Archiving sessions untouched for more than $DAYS days:"
fi

echo

sqlite3 -readonly -separator $'\t' "$DB" "
    SELECT
        id,
        strftime(
            '%Y-%m-%d %H:%M',
            updated_at_ms / 1000,
            'unixepoch',
            'localtime'
        ),
        replace(
            replace(
                CASE
                    WHEN name IS NOT NULL AND name <> '' THEN name
                    WHEN title IS NOT NULL AND title <> '' THEN title
                    ELSE '(unnamed)'
                END,
                char(10), ' '
            ),
            char(9), ' '
        )
    FROM threads
    WHERE archived = 0
      AND source IN ('cli', 'vscode')
      AND updated_at_ms < $CUTOFF_MS
    ORDER BY updated_at_ms;
" |
while IFS=$'\t' read -r id updated label; do
    printf '%s  %s\n' "$updated" "$label"

    if (( ! DRY_RUN )); then
        codex archive "$id"
    fi
done
