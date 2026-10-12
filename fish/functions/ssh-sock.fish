function ssh-sock --description 'Switch between macOS and PIV SSH agent sockets'
    set -l piv /Users/pmooney/.ssh/pivy-agent.sock
    set -l is_darwin (test (uname) = Darwin; and echo true; or echo false)
    set -l action status
    if set -q argv[1]
        set action $argv[1]
    end
    if test (count $argv) -gt 1
        set action invalid
    end
    if not $is_darwin; and contains -- $action mac toggle
        printf 'ssh-sock: mac and toggle are only available on macOS\n' >&2
        return 1
    end
    if test "$action" = toggle
        set action piv
        if test "$SSH_AUTH_SOCK" = "$piv"
            set action mac
        end
    end

    switch $action
        case status
            set -l current "$SSH_AUTH_SOCK"
            if test -z "$current"
                set current unset
            end
            printf 'Current: %s\n' "$current"
            if $is_darwin
                set -l saved "$__ssh_sock_macos"
                if test -z "$saved"
                    set saved none
                end
                printf 'Saved macOS: %s\n' "$saved"
            end
        case piv
            if not test -S "$piv"
                printf 'ssh-sock: PIV socket is unavailable: %s\n' "$piv" >&2
                return 1
            end
            if $is_darwin; and test "$SSH_AUTH_SOCK" != "$piv"; and test -S "$SSH_AUTH_SOCK"
                set -U __ssh_sock_macos "$SSH_AUTH_SOCK"
            end
            set -gx SSH_AUTH_SOCK "$piv"
            printf 'Using PIV socket: %s\n' "$SSH_AUTH_SOCK"
        case mac
            for candidate in $__ssh_sock_macos (command launchctl getenv SSH_AUTH_SOCK 2>/dev/null) $SSH_AUTH_SOCK
                if test "$candidate" != "$piv"; and test -S "$candidate"
                    set -U __ssh_sock_macos "$candidate"
                    set -gx SSH_AUTH_SOCK "$candidate"
                    printf 'Using macOS socket: %s\n' "$SSH_AUTH_SOCK"
                    return 0
                end
            end
            printf 'ssh-sock: no valid macOS socket is available\n' >&2
            return 1
        case -h --help help '*'
            printf 'Usage: ssh-sock [status|piv|mac|toggle]\n'
            if not contains -- $action -h --help help
                return 2
            end
    end
end
