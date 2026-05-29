#!/usr/bin/env bash
# Example handlers — replace with your real install / configure logic.
#
# When you change state (defaults write, ~/.zshrc, launchd, …), use the
# journal-aware helpers from macrift's common.sh so `macrift undo` can revert
# whatever you do:
#
#   audit_default <domain> <key> <type> <value>     # queue defaults write
#   apply_audited_defaults                          # apply + journal
#   copy_config <src> <dst>                         # copy with backup
#   _journal_append_dotfile <path>                  # record dotfile change
#   _journal_append_launchd <label>                 # record launchd bootstrap
#   _journal_append_marker <file> <id>              # record rc-file marker
#
# Do NOT do raw `defaults write` or `launchctl bootstrap` outside these —
# `macrift plugin lint` will flag it and the journal can't undo it.
#
# See macrift's PLUGINS.md for the full public API and the do-not-do rules.

example_action() {
    printf '\n'
    log_info "This is where your action happens."
    log_hint "edit handlers/example.sh and replace this stub with your real logic"

    # Examples — uncomment as you wire things in:

    # # Queue a defaults write (will be journaled + applied below)
    # audit_default com.your.app SomeKey -bool true
    # apply_audited_defaults

    # # Copy a config file with automatic .bak of any existing version
    # copy_config "$_PLUGIN_DIR/config/example.conf" "$HOME/.example.conf"

    # # Brew install with built-in error handling
    # check_homebrew && brew_install some-package

    if ! confirm "Apply the example?" "y"; then
        log_skip "skipped"
        wait_enter
        return 0
    fi

    log_ok "example_action ran (replace me)"
    wait_enter
}

another_action() {
    printf '\n'
    log_info "Another action stub — replace me."
    wait_enter
}
