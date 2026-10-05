#!/usr/bin/env bash
set -euo pipefail

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
UUID='next-event@bhavik.dev'

if [[ "${1:-}" == '--session' ]]; then
    gnome-shell --devkit --wayland &
    preview_pid=$!
    trap 'kill "$preview_pid" 2>/dev/null || true' EXIT
    trap 'exit 130' INT
    trap 'exit 143' TERM

    # Wait for the preview Shell to register the extension on its private bus.
    enabled=false
    for ((attempt = 0; attempt < 40; attempt++)); do
        if ! kill -0 "$preview_pid" 2>/dev/null; then
            wait "$preview_pid"
            exit 1
        fi
        if gnome-extensions enable "$UUID" 2>/dev/null; then
            enabled=true
            break
        fi
        sleep 0.5
    done
    if [[ "$enabled" != true ]]; then
        echo 'Could not enable the extension in the preview.' >&2
        exit 1
    fi
    wait "$preview_pid"
    exit
fi

if [[ $# -gt 1 || ( $# -eq 1 && "$1" != '--setup-only' ) ]]; then
    echo "Usage: $0 [--setup-only]" >&2
    exit 1
fi

glib-compile-schemas --strict "$PROJECT_DIR/schemas"

data_dir="${XDG_DATA_HOME:-$HOME/.local/share}"
extension_path="$data_dir/gnome-shell/extensions/$UUID"
mkdir -p "$(dirname "$extension_path")"

if [[ "$(readlink -f "$extension_path" 2>/dev/null || true)" != "$PROJECT_DIR" ]]; then
    if [[ -e "$extension_path" || -L "$extension_path" ]]; then
        backup_root="$data_dir/gnome-shell/extension-backups"
        mkdir -p "$backup_root"
        backup_dir="$(mktemp -d "$backup_root/next-event.XXXXXX")"
        mv "$extension_path" "$backup_dir/$UUID"
        echo "Previous installation backed up to $backup_dir/$UUID"
    fi
    ln -s "$PROJECT_DIR" "$extension_path"
fi

echo "Development extension linked to $PROJECT_DIR"
if [[ "${1:-}" == '--setup-only' ]]; then
    exit
fi

if [[ ! -x /usr/libexec/mutter-devkit ]]; then
    echo 'Install the preview devkit first: sudo apt install mutter-dev-bin' >&2
    exit 1
fi

echo 'Close the preview and rerun ./dev.sh after editing JavaScript.'
exec dbus-run-session -- "$PROJECT_DIR/dev.sh" --session
