#!/usr/bin/env bash

set -e

# Include arguments script
source "${0%/*}/install-args.sh"

FILES=('.gitconfig' '.gitignore_global' '.zshrc' '.zsh_custom')
declare -r FILES # Make "FILES" readonly

declare -A TEXT # Make "TEXT" an associative array
TEXT[regular]="\e[0m"
TEXT[black]="\e[30m"
TEXT[red]="\e[31m"
TEXT[green]="\e[32m"
TEXT[yellow]="\e[33m"
TEXT[blue]="\e[34m"
TEXT[purple]="\e[35m"
TEXT[cyan]="\e[36m"
TEXT[white]="\e[37m"
TEXT[bold]="\e[1m"
declare -r TEXT # Make "TEXT" readonly

## $1 COLOR $2 TEXT to echo
function COLOR {
    echo "${TEXT[$1]}$2${TEXT[regular]}"
}

## $1 Source Path
function createBackup {
    if [[ "$_arg_backup" == "on" ]]; then
        echo "Already exists - creating backup: $(COLOR green $1.bak)"

        cp -Lr $1 $1.bak
    else
        echo "Already exists - $(COLOR red "Skipping Backup")"
    fi
}

function createSymlink {
    if [[ -e $HOME/$1 ]]; then
        (
            cd $HOME
            rm -rf $1
        )
    fi

    ln -sf $PWD/$1 $HOME/$1
}

# Remove any backup files that exist and nothing else
if [[ "$_arg_remove_backups" == "on" ]]; then
    echo -e "${TEXT[bold]}$(COLOR green "Remove all backup files if they exist...")\n"

    for i in "${FILES[@]}"; do
        if [[ ! -e $HOME/$i.bak ]]; then
            continue
        fi

        echo -e "$(COLOR red "Removing: $HOME/$i")"
        (
            cd $HOME
            rm -rf "$i.bak"
        )
    done

    echo -e "${TEXT[bold]}$(COLOR green "Success!")\n"
    exit
fi

# Create symlinks in the $HOME dir to files in dot-home ($PWD)
echo -e "${TEXT[bold]}$(COLOR green "Installing items to home directory!")\n"

for i in "${FILES[@]}"; do
    if [[ -e $HOME/$i && "$_arg_overwrite" != "on" ]]; then
        echo "File already exists - Skipping: $i"

        continue
    fi

    echo -e "Creating symlink: $(COLOR cyan $i)"

    if [[ -f $HOME/$i || -d $HOME/$i ]]; then
        echo -e $(createBackup $HOME/$i)
    fi

    createSymlink $i

    echo ""
done
