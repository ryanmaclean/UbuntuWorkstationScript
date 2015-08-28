#!/bin/bash
##Remove CDROM From Sources List
sudo sed -i '/cdrom/d' /etc/apt/sources.list

##Add Repositories
sudo sh -c "echo 'deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main' > /etc/apt/sources.list.d/pgdg.list"
echo -e "deb http://downloads.hipchat.com/linux/apt stable main" | sudo tee -a /etc/apt/sources.list.d/atlassian-hipchat.list > /dev/null
echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | sudo tee /etc/apt/sources.list.d/mongodb.list
echo -e "deb https://s3.amazonaws.com/repo.deb.cyberduck.io stable main" | sudo tee -a /etc/apt/sources.list > /dev/null

###Combo-adding a few repos at once that follow the same format
xargs -I % sudo add-apt-repository -y % <<EOF
ppa:team-xbmc/ppa 
ppa:webupd8team/sublime-text-3 
ppa:rael-gc/scudcloud
"deb http://repository.spotify.com stable non-free"
"deb https://clusterhq-archive.s3.amazonaws.com/ubuntu/$(lsb_release --release --short)/\$(ARCH) /"
EOF

##Add Repo Keys
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys D2C19886
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys FE7097963FEFBE72
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
wget -O - https://www.hipchat.com/keys/hipchat-linux.key | sudo apt-key add -
wget --quiet -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | sudo apt-key add -

##Update Apt
sudo apt-get update -qq

##Install Opinionated Stuff Here
sudo apt-get -y --force-yes install openssh-server clusterhq-flocker-cli indicator-multiload apt-transport-https software-properties-common vim vagrant virtualbox chef puppet ansible tmux mussh multitail mc iptraf netcat links mutt zsh fish jmeter iperf iotop htop traceroute nmap docker.io ruby python python-pip git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev git build-essential openssl pkg-config nodejs npm postgresql-common postgresql-9.3 libpq-dev mysql-client libmysqlclient-dev mysql-workbench libsqlite3-dev sqlite3 mongodb-org steam spotify-client software-properties-common sublime-text-installer scudcloud duck hipchat gnome-tweak-tool

###Un-comment if you need MySQLd
#sudo apt-get install -y mysql-server

##Config SSH
sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.factory-defaults
sudo chmod a-w /etc/ssh/sshd_config.factory-defaults
sudo restart ssh

##Install Pip Resources
sudo pip install awscli

##Get Your Ruby On - This doesn't work if you've already got Fish or ZSH set to default shell
git clone git://github.com/sstephenson/rbenv.git .rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
exec $SHELL
git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
exec $SHELL
git clone https://github.com/sstephenson/rbenv-gem-rehash.git ~/.rbenv/plugins/rbenv-gem-rehash
rbenv install 2.2.2
rbenv global 2.2.2
echo "gem: --no-ri --no-rdoc" > ~/.gemrc
gem install bundler rails:4.2.1
rbenv rehash

##Make it MEAN
sudo npm cache clean -f
sudo npm install -g n
sudo n stable
sudo npm install -g bower grunt-cli yo
git clone https://github.com/meanjs/mean.git /opt/mean
cd /opt/mean
sudo npm install
cd ~

##Install Packer 
mkdir packer
cd packer
wget https://dl.bintray.com/mitchellh/packer/packer_0.8.6_linux_amd64.zip
unzip packer_0.8.6_linux_amd64.zip

##Spice Up Steam
cd ~/.local/share/Steam/skins/
git clone https://github.com/DirtDiglett/Pressure-for-Steam.git
cd ~

##Install Chrome... I tried to avoid it but still could not
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg –I google-chrome-stable_current_amd64.deb

###Pick a shell - ZSH or Fish
###This is for ZSH
##curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh

###This is for Fish
curl -L git.io/omf | sh

##Install Our Web Testing Driver PhantomJS
sudo npm install phantomjs

##Install Vundle, the Vim Package Manager
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

##For HiDPI Users - Un-Comment and we'll start the Tweak Tool - set the "window scaling" to "2"
#gnome-tweak-tool &
