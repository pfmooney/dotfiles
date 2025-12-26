if test "$hostname" != "patricks-mac.local"
	return
end

function _claudekey
	security find-generic-password -s 'Claude Code' -w
end
function avante-setup
	argparse 'u/unset' -- $argv
	if set -ql _flag_unset
		set -gu AVANTE_ANTHROPIC_API_KEY
		set -gu ANTHROPIC_API_KEY
		echo "Keys cleared"
		return 0
	end
	set -gx AVANTE_ANTHROPIC_API_KEY $(_claudekey)
	set -gx ANTHROPIC_API_KEY $(_claudekey)
end
