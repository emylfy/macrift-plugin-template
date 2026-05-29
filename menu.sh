#!/usr/bin/env bash
# your-plugin-name — macrift plugin entry point.
#
# Sourced by macrift's _plugin_load_all at startup. Defines the function
# named in plugin.json's menu.function field, which the main menu invokes
# when the user picks this plugin's entry.

# Self-locate so the plugin can find its own files regardless of install path.
_PLUGIN_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export _PLUGIN_DIR

# OPTIONAL: source any handlers / helpers split into handlers/*.sh.
# shellcheck source=handlers/example.sh
source "$_PLUGIN_DIR/handlers/example.sh"

# Public entry — matches plugin.json's menu.function.
# This is what _plugin_load_all registers and main_menu calls.
your_plugin_menu() {
    crumb_push "Your plugin"
    while true; do
        clear
        local choice
        choice=$(show_menu "Your plugin" \
            "Do something" \
            "Do something else" \
            "Back")

        case "$choice" in
            1) example_action       || true ;;
            2) another_action       || true ;;
            0) break ;;
            *) ;;
        esac
    done
    crumb_pop
}
