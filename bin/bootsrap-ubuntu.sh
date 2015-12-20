#!/usr/bin/env bash

if [[ -e $HOME/.dotfiles/bin/.bootstrap ]]; then
	echo "Bootstrap has been executed already."
	echo "If you really want to run this again: rm \$HOME/.dotfiles/bin/.bootstrap"
	exit 0
fi

sudo apt-get update

sudo apt-get install -y \
	python-software-properties \
	libssl-dev \
	libreadline-dev

sudo add-apt-repository -y ppa:ondrej/php5-5.6
sudo apt-add-repository -y ppa:webupd8team/java

sudo apt-get update -y

# Tools
sudo apt-get install -y \
	xbacklight \
	silversearcher-ag \
	ack-grep \
	xclip \
	keychain

# Dev
sudo apt-get install -y \
	git \
	ruby \
	vim \
	zsh \
	php5 \
	php5-cli \
	php5-mysql \
	php5-mongo \
	php5-memcached \
	php5-xdebug \
	mysql-client \
	oracle-java8-installer

# Docker
sudo apt-key adv --keyserver hkp://pgp.mit.edu:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
sudo touch /etc/apt/sources.list.d/docker.list
echo "deb https://apt.dockerproject.org/repo ubuntu-trusty main" | sudo tee -a /etc/apt/sources.list.d/docker.list
sudo apt-get -y update
sudo apt-get purge lxc-docker*
apt-cache policy docker-engine
sudo apt-get -y install docker-engine
sudo usermod -aG docker $USER

# Cleanup
sudo apt-get autoremove -y

# rbenv
git clone https://github.com/sstephenson/rbenv.git $HOME/.rbenv
git clone https://github.com/sstephenson/ruby-build.git $HOME/.rbenv/plugins/ruby-build
PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
rbenv install 2.2.3
rbenv global 2.2.3

# NVM
git clone https://github.com/creationix/nvm.git ~/.nvm \
&& cd ~/.nvm \
&& git checkout `git describe --abbrev=0 --tags`
. ~/.nvm/nvm.sh
nvm install node
npm install -g \
 babel \
 bower \
 browser-sync \
 browserify \
 dependency-check \
 express-generator \
 grunt-cli \
 gulp \
 jscs \
 jshint \
 karma \
 karma-browserify \
 less \
 mocha \
 pioneer \
 pm2 \
 underscore-cli

# Paths
mkdir -p $HOME/Code/Sandbox $HOME/bin

# Fonts
mkdir -p $HOME/.fonts
(cd $HOME/.dotfiles \
	&& rake \
	&& cp -r Fonts/**/*.{otf,ttf} $HOME/.fonts \
	&& touch bin/.bootstrap)

# Install oh-my-zsh
chsh -s $(grep /zsh$ /etc/shells | tail -1)
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
