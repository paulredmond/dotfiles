# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# export RBENV_VERSION=1.9.3

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="af-magic"
# ZSH_THEME="robbyrussell"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

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
plugins=(git brew cap composer jira phing rails rails3 rails4 rake ruby svn vagrant gem cake ant symfony2 github bundler heroku gitfast)

source $ZSH/oh-my-zsh.sh

# Stop spelling checks of command arguments. Only consider commands.
unsetopt correctall && setopt correct

# Customize to your needs...
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:~/bin:~/Dropbox/bin:/usr/local/share/npm/bin:/usr/local/sbin:/opt/boxen/nvm/v0.8.8/bin:$PATH
export NODE_PATH="/usr/local/lib/node:/opt/boxen/nvm/v0.8.8/lib/node_modules"

alias redis.start="redis-server /usr/local/etc/redis.conf"
alias memcached.start="launchctl load ~/Library/LaunchAgents/homebrew.mxcl.memcached.plist"
alias memcached.launcher='ln -sfv /usr/local/opt/memcached/*.plist ~/Library/LaunchAgents'
alias mongo.start='mongod'
alias mongo.launcher='ln -sfv /usr/local/opt/mongodb/*.plist ~/Library/LaunchAgents'
alias redis.launcher='ln -sfv /usr/local/opt/redis/*.plist ~/Library/LaunchAgents'
alias redis.launch='launchctl load ~/Library/LaunchAgents/homebrew.mxcl.redis.plist'
alias redis.start='redis-server /usr/local/etc/redis.conf'
alias beanstalkd.launcher='ln -sfv /usr/local/opt/beanstalk/*.plist ~/Library/LaunchAgents'
alias beanstalkd.launch='launchctl load ~/Library/LaunchAgents/homebrew.mxcl.beanstalk.plist'
alias ack='nocorrect ack'
alias vagrant='nocorrect vagrant'
alias subl='nocorrect subl'
alias composer='composer.phar'
alias mongod='nocorrect mongod'
alias rake='noglob rake'
alias mate='nocorrect mate'
alias p='nocorrect pstorm'
alias npm='nocorrect npm'
alias rspec='nocorrect rspec '

# Git aliases
alias gs='git status'


cdpath=( ~ ~/www/sheknows ~/www/sheknows/dev.sheknows.com ~/www )

source /opt/boxen/env.sh
# source /opt/boxen/nvm/nvm.sh


#
# Provides a review workflow for pull requests. Best used with `prmerge` when ready to merge.
#
# Example - checks out the Pull Request 1 and rebases branch against master:
#     `prfetch master 1`
#     ... Check it out, test, etc.
#     `prmerge master 1`
#     Merges the Pull request, creates a reference to it, then pushes to the remote.
#
# @link http://derickrethans.nl/managing-prs-for-php-mongo.html
#
function prfetch()
{
    git checkout $1
    git fetch origin pull/$2/head:pr/$2
    git checkout pr/$2
    git rebase $1
}

#
# Merge a Pull Request that has been reviewed using `prfetch` and push.
# Example - Merge PR #1 into master and reference the PR in the merge:
#     `prmerge master 1`
#
function prmerge()
{
    git checkout $1
    git merge --no-ff -m "Merged pull request #$2" pr/$2
    git branch -D pr/$2
    git push
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
