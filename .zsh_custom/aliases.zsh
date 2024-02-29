alias cdp="cd ~/develop/php"

function tuts {
    php ./tuts.phar "$@"
}

function move {
    php ./tuts.phar move "$@" && php ./tuts.phar show
}

# makes commands like "git log" and "grep" not clear the screen after exit
PAGER='less -X'

#alias workspace="docker-compose run --rm workspace bash"
#alias dcs="docker-compose start php-fpm nginx database"
alias cdp="cd ~/develop/php"
#alias php-fixer="docker-compose run --rm php-cli tools/php-cs-fixer/vendor/bin/php-cs-fixer fix"
