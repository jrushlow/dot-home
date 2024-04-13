#!/bin/bash

# To generate install-args.sh: argbash install-args-parsing.m4 -o install-args.sh --strip all -c

# m4_ignore(
echo "This is just a parsing library template, not the library - pass this file to 'argbash' to fix this." >&2
exit 11  #)Created by argbash-init v2.10.0
# ARG_OPTIONAL_BOOLEAN([backup], [b], [Create a .bak backup of any existing file.], [on])
# ARG_OPTIONAL_BOOLEAN([overwrite], [o], [Overwrite an existing files.])
# ARG_OPTIONAL_BOOLEAN([remove-backups], [r], [Only remove generated backups and nothing else.])
# ARG_HELP([<The general help message of my script>])
# ARGBASH_GO
