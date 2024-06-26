
# needed because of Argbash --> m4_ignore([
### START OF CODE GENERATED BY Argbash v2.10.0 one line above ###
# Argbash is a bash code generator used to get arguments parsing right.
# Argbash is FREE SOFTWARE, see https://argbash.io for more info


# # When called, the process ends.
# Args:
# 	$1: The exit message (print to stderr)
# 	$2: The exit code (default is 1)
# if env var _PRINT_HELP is set to 'yes', the usage is print to stderr (prior to $1)
# Example:
# 	test -f "$_arg_infile" || _PRINT_HELP=yes die "Can't continue, have to supply file as an argument, got '$_arg_infile'" 4
die()
{
	local _ret="${2:-1}"
	test "${_PRINT_HELP:-no}" = yes && print_help >&2
	echo "$1" >&2
	exit "${_ret}"
}


# Function that evaluates whether a value passed to it begins by a character
# that is a short option of an argument the script knows about.
# This is required in order to support getopts-like short options grouping.
begins_with_short_option()
{
	local first_option all_short_options='borh'
	first_option="${1:0:1}"
	test "$all_short_options" = "${all_short_options/$first_option/}" && return 1 || return 0
}

# THE DEFAULTS INITIALIZATION - OPTIONALS
_arg_backup="on"
_arg_overwrite="off"
_arg_remove_backups="off"


# Function that prints general usage of the script.
# This is useful if users asks for it, or if there is an argument parsing error (unexpected / spurious arguments)
# and it makes sense to remind the user how the script is supposed to be called.
print_help()
{
	printf '%s\n' "<The general help message of my script>"
	printf 'Usage: %s [-b|--(no-)backup] [-o|--(no-)overwrite] [-r|--(no-)remove-backups] [-h|--help]\n' "$0"
	printf '\t%s\n' "-b, --backup, --no-backup: Create a .bak backup of any existing file. (on by default)"
	printf '\t%s\n' "-o, --overwrite, --no-overwrite: Overwrite an existing files. (off by default)"
	printf '\t%s\n' "-r, --remove-backups, --no-remove-backups: Only remove generated backups and nothing else. (off by default)"
	printf '\t%s\n' "-h, --help: Prints help"
}


# The parsing of the command-line
parse_commandline()
{
	while test $# -gt 0
	do
		_key="$1"
		case "$_key" in
			# The backup argurment doesn't accept a value,
			# we expect the --backup or -b, so we watch for them.
			-b|--no-backup|--backup)
				_arg_backup="on"
				test "${1:0:5}" = "--no-" && _arg_backup="off"
				;;
			# We support getopts-style short arguments clustering,
			# so as -b doesn't accept value, other short options may be appended to it, so we watch for -b*.
			# After stripping the leading -b from the argument, we have to make sure
			# that the first character that follows coresponds to a short option.
			-b*)
				_arg_backup="on"
				_next="${_key##-b}"
				if test -n "$_next" -a "$_next" != "$_key"
				then
					{ begins_with_short_option "$_next" && shift && set -- "-b" "-${_next}" "$@"; } || die "The short option '$_key' can't be decomposed to ${_key:0:2} and -${_key:2}, because ${_key:0:2} doesn't accept value and '-${_key:2:1}' doesn't correspond to a short option."
				fi
				;;
			# See the comment of option '--backup' to see what's going on here - principle is the same.
			-o|--no-overwrite|--overwrite)
				_arg_overwrite="on"
				test "${1:0:5}" = "--no-" && _arg_overwrite="off"
				;;
			# See the comment of option '-b' to see what's going on here - principle is the same.
			-o*)
				_arg_overwrite="on"
				_next="${_key##-o}"
				if test -n "$_next" -a "$_next" != "$_key"
				then
					{ begins_with_short_option "$_next" && shift && set -- "-o" "-${_next}" "$@"; } || die "The short option '$_key' can't be decomposed to ${_key:0:2} and -${_key:2}, because ${_key:0:2} doesn't accept value and '-${_key:2:1}' doesn't correspond to a short option."
				fi
				;;
			# See the comment of option '--backup' to see what's going on here - principle is the same.
			-r|--no-remove-backups|--remove-backups)
				_arg_remove_backups="on"
				test "${1:0:5}" = "--no-" && _arg_remove_backups="off"
				;;
			# See the comment of option '-b' to see what's going on here - principle is the same.
			-r*)
				_arg_remove_backups="on"
				_next="${_key##-r}"
				if test -n "$_next" -a "$_next" != "$_key"
				then
					{ begins_with_short_option "$_next" && shift && set -- "-r" "-${_next}" "$@"; } || die "The short option '$_key' can't be decomposed to ${_key:0:2} and -${_key:2}, because ${_key:0:2} doesn't accept value and '-${_key:2:1}' doesn't correspond to a short option."
				fi
				;;
			# See the comment of option '--backup' to see what's going on here - principle is the same.
			-h|--help)
				print_help
				exit 0
				;;
			# See the comment of option '-b' to see what's going on here - principle is the same.
			-h*)
				print_help
				exit 0
				;;
			*)
				_PRINT_HELP=yes die "FATAL ERROR: Got an unexpected argument '$1'" 1
				;;
		esac
		shift
	done
}

# Now call all the functions defined above that are needed to get the job done
parse_commandline "$@"

# OTHER STUFF GENERATED BY Argbash

### END OF CODE GENERATED BY Argbash (sortof) ### ])
