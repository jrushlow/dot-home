#!/usr/bin/env bash

# set -eu

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

# $1 source path
# $2 target path
function createSymlink {
    if [[ -e $2 ]]; then
        (rm -rf $2)
    fi

    ln -sf $1 $2
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
    sourcePath=$PWD/$i
    targetPath=$HOME/$i
    diffResult="$(diff $targetPath $sourcePath --color='always' -N)"
    isDiff=$?

    echo -e "Checking $(COLOR cyan $targetPath)"   

    # If target exists, get a diff from the source
    if [[ -e $targetPath ]]; then
        echo " - Found file"

        if [[ "$isDiff" == 1 ]]; then
            echo " - Existing file has changes (Red: Existing file. Green: New File.)"
            echo "$diffResult"
        fi
    else
        echo " - File doesn't exist"
    fi

    # If the files exists but -o not passed, skip
    if [[ "$_arg_overwrite" != "on" && -e $targetPath ]]; then
        echo " - Skipping - overwrite not enabled"
        echo ""

        continue
    fi

    # If the file does not exist, create it then continue to next file
    if [[ ! -e $targetPath ]]; then
        echo -e " - Creating symlink for $(COLOR cyan $i)"
        createSymlink $sourcePath $targetPath
        echo -e " - Created: $(COLOR green $targetPath)"
        echo ""

        continue
    fi

    # Create a backup of the file/directory if backups are "on"
    if [[ -f $targetPath || -d $targetPath ]] && [[ "$_arg_backup" == "on" ]]; then
        echo " - Creating Backup..."

        cp -Lr $targetPath $targetPath.bak

        echo -e " - Backup Created: $(COLOR green $targetPath.bak)"
    fi

    echo -e " - Creating symlink for $(COLOR cyan $i)"
    createSymlink $sourcePath $targetPath
    echo -e " - Created: $(COLOR green $targetPath)"
    echo ""
done
