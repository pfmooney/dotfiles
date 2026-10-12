complete -c ssh-sock -f
complete -c ssh-sock -n 'not __fish_seen_subcommand_from status piv mac toggle' -a status -d 'Show current and saved sockets'
complete -c ssh-sock -n 'not __fish_seen_subcommand_from status piv mac toggle' -a piv -d 'Use the PIV socket'
complete -c ssh-sock -n 'not __fish_seen_subcommand_from status piv mac toggle' -a mac -d 'Use the macOS socket'
complete -c ssh-sock -n 'not __fish_seen_subcommand_from status piv mac toggle' -a toggle -d 'Switch between sockets'
