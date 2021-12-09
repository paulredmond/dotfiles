# Uncomment to profile zsh startup
# See the bottom of the file
# @see https://blog.askesis.pl/post/2017/04/how-to-debug-zsh-startup-time.html
# zmodload zsh/zprof

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

export VISUAL="subl -n"
export EDITOR="$VISUAL"
export TERM="xterm-256color"

# export RBENV_VERSION=1.9.3

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="af-magic"
ZSH_THEME="miloshadzic"
#ZSH_THEME="bureau"
# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

bindkey "[C" forward-word
bindkey "[D" backward-word

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git docker docker-compose zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# Stop spelling checks of command arguments. Only consider commands.
unsetopt correctall && setopt correct

# Customize to your needs...
# export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/sbin:./bin:./vendor/bin:$HOME/bin:$HOME/.dotfiles/bin:$PATH

# zsh completion for docker-compose
fpath=(~/.dotfiles/.zsh/completion $fpath)
autoload -Uz compinit && compinit -i

# Default Aliases
alias ack='nocorrect ack'
# alias vagrant='nocorrect vagrant'
#alias subl='nocorrect subl'
alias mongod='nocorrect mongod'
alias rake='noglob rake'
alias mate='nocorrect mate'
alias p='nocorrect pstorm'
#alias npm='nocorrect npm'
alias rspec='nocorrect rspec '
alias ....='cd ../../..'
alias lah='ls -lah'
alias console='nocorrect console'
alias zshrc="${VISUAL:-${EDITOR:-vim}} ~/.zshrc"

# PHP
alias c='composer'
alias iphp='psysh'
alias art='php artisan'
alias sail='bash vendor/bin/sail'
alias tinker='php artisan tinker'
alias mfs='php artisan migrate:fresh --seed'
alias t='phpunit'
alias clearlog='truncate -s 0 $(git rev-parse --show-toplevel)/storage/logs/laravel.log'
alias clearlogs='truncate -s 0 $(git rev-parse --show-toplevel)/storage/logs/*.log'

# NPM
alias npm-exec='PATH=$(npm bin):$PATH'
alias yi='yarn install'
alias yw='yarn install && yarn run watch'

# Git aliases
alias g='git'
alias gs='git status'
alias gdc='git diff --cached'
alias gst='git status'
alias wip='git commit -am "WIP"'

# Docker aliases
alias d='docker'
alias dc='docker-compose'
alias dm='docker-machine'
alias dmnative='echo "Switching to native docker" && eval $(docker-machine env -u)'
alias docker-cleanup='docker network prune && docker system prune'
# http://unix.stackexchange.com/questions/22615/how-can-i-get-my-external-ip-address-in-bash/81699#81699
alias ip='dig +short myip.opendns.com @resolver1.opendns.com'

# Local config
if [[ -e $HOME/.zshrc.local ]]
then
    source $HOME/.zshrc.local
fi

#
# Link a local composer repository
#
# After, you can require the project normally:
# `composer require [vendor]/composer-package`
#
# If `composer require` doesn't work the first time, you may need to add @dev:
# `composer require [vendor]/composer-package @dev`
#
# See: https://calebporzio.com/bash-alias-composer-link-use-local-folders-as-composer-dependancies/
#
composer-link() {
    composer config repositories.local '{"type": "path", "url": "'$1'"}' --file composer.json
}

# Start a simple web server from any directory
function serve()
{
  python -m SimpleHTTPServer 8000
}

function findprocess()
{
    ps aux | grep $1
}

function myprocess()
{
    ps -ef | grep $USER
}

function corscheck()
{
    curl -I \
      -H "Origin: http://example.com" \
      -H "Access-Control-Request-Method: POST" \
      -H "Access-Control-Request-Headers: X-Requested-With" \
      -X OPTIONS \
      $1
}

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

#if hash docker-machine 2>/dev/null; then
#    eval "$(docker-machine env default)"
#fi

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# added by travis gem
[ -f /Users/paul/.travis/travis.sh ] && source /Users/paul/.travis/travis.sh

# Hyper Terminal
export LANG="en_US.UTF-8"
export LC_COLLATE="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LC_MESSAGES="en_US.UTF-8"
export LC_MONETARY="en_US.UTF-8"
export LC_NUMERIC="en_US.UTF-8"
export LC_TIME="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

export PATH="$HOME/.yarn/bin:$PATH"

# Uncomment to profile zsh startup
# See the top of the file
# @see https://blog.askesis.pl/post/2017/04/how-to-debug-zsh-startup-time.html
# zprof

# fnm
export PATH=/Users/predmond/.fnm:$PATH
eval "`fnm env`"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/$USER/.sdkman"
[[ -s "/Users/$USER/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/$USER/.sdkman/bin/sdkman-init.sh"
