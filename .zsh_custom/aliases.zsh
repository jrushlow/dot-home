alias cdp="cd ~/develop/php"

function tuts {
    php ./tuts.phar "$@"
}

function move {
    php ./tuts.phar move "$@" && php ./tuts.phar show
}

# makes commands like "git log" and "grep" not clear the screen after exit
PAGER='less -X'
