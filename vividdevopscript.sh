#!/bin/bash
sudo sed -i '/cdrom/d' /etc/apt/sources.list

#Add Repositories
sudo add-apt-repository -y "deb https://clusterhq-archive.s3.amazonaws.com/ubuntu/$(lsb_release --release --short)/\$(ARCH) /"
sudo sh -c "echo 'deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main' > /etc/apt/sources.list.d/pgdg.list"
wget --quiet -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | sudo apt-key add -
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | sudo tee /etc/apt/sources.list.d/mongodb.list
sudo apt-add-repository -y "deb http://repository.spotify.com stable non-free"
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys D2C19886
echo "deb https://s3.amazonaws.com/repo.deb.cyberduck.io stable main" | sudo tee -a /etc/apt/sources.list > /dev/null
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys FE7097963FEFBE72
echo "deb http://downloads.hipchat.com/linux/apt stable main" | sudo tee -a /etc/apt/sources.list.d/atlassian-hipchat.list > /dev/null
wget -O - https://www.hipchat.com/keys/hipchat-linux.key | sudo apt-key add -
xargs -I % sudo add-apt-repository % <<EOF
ppa:team-xbmc/ppa 
ppa:webupd8team/sublime-text-3 
ppa:rael-gc/scudcloud
EOF

##Update Apt
sudo apt-get update

##MS Fonts Stuff
echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | sudo debconf-set-selections
echo ttf-mscorefonts-installer msttcorefonts/present-mscorefonts-eula note | sudo debconf-set-selections

##Install Opinionated Stuff Here
sudo apt-get -y --force-yes install mtr clusterhq-flocker-cli dtrx keepass2 indicator-multiload apt-transport-https \
software-properties-common vim vagrant virtualbox chef puppet ansible tmux mussh multitail mc iptraf netcat links \
mutt zsh fish jmeter iperf iotop htop traceroute nmap docker.io ruby python python-pip git-core curl zlib1g-dev \
build-essential libssl-dev libreadline-dev libyaml-dev libxml2-dev libxslt1-dev libcurl4-openssl-dev \
python-software-properties libffi-dev git build-essential openssl pkg-config nodejs npm postgresql-common postgresql-9.3 \
libpq-dev mysql-client libmysqlclient-dev mysql-workbench libsqlite3-dev sqlite3 mongodb-org steam \
spotify-client software-properties-common sublime-text-installer rbenv scudcloud duck hipchat gitk 

#mysql-server gnome-tweak-tool

##Config SSH
sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.factory-defaults
sudo chmod a-w /etc/ssh/sshd_config.factory-defaults
sudo restart ssh

##Install Pip Resources
sudo pip install awscli

##Get Your Ruby On
#git clone git://github.com/sstephenson/rbenv.git .rbenv
#echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
#echo 'eval "$(rbenv init -)"' >> ~/.bashrc
#exec $SHELL
#git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
#echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
#exec $SHELL
#git clone https://github.com/sstephenson/rbenv-gem-rehash.git ~/.rbenv/plugins/rbenv-gem-rehash
#rbenv install 2.2.2
#rbenv global 2.2.2
#echo "gem: --no-ri --no-rdoc" > ~/.gemrc
#sudo gem install bundler rails:4.2.1
#rbenv rehash

##Make it MEAN
sudo npm cache clean -f
sudo npm install -g n
sudo n stable
sudo npm install -g bower grunt-cli
sudo git clone https://github.com/meanjs/mean.git /opt/mean
cd /opt/mean
sudo npm install
cd ~

##Install Yeoman and PhantomJS
sudo npm install -g yo phantomjs

##Install Packer 
mkdir packer
cd packer
wget https://dl.bintray.com/mitchellh/packer/packer_0.8.6_linux_amd64.zip
unzip packer_0.8.6_linux_amd64.zip
cd~

##Spice Up Steam - FIX, NEEDS A STEAM START FIRST
#cd ~/.local/share/Steam/skins/
#git clone https://github.com/DirtDiglett/Pressure-for-Steam.git
#cd ~

##Install Chrome... I tried to avoid it but still could not
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb &&\
sudo dpkg -i google-chrome-stable_current_amd64.deb &&\
sudo apt-get install -f -y 

##Oh-My-ZSH!
curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
##Oh-My-Fish
curl -L github.com/oh-my-fish/oh-my-fish/raw/master/bin/install | sh
##Bash-It!
git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it
sh ~/.bash_it/install.sh

##Install Vundle, the Vim Package Manager
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

##Install Lastpass
sudo apt-get install -y openssl libcurl4-openssl-dev libxml2 libssl-dev libxml2-dev pinentry-curses xclip
git clone https://github.com/lastpass/lastpass-cli.git
cd lastpass-cli
make && make install
cd ~ &&\
wget https://lastpass.com/download/cdn/lp_no_bin.xpi &&\
sudo mv lp_no_bin.xpi  ~/.mozilla/extensions/ 

##Install Synergy
wget http://synergy-project.org/files/packages/synergy-v1.7.4-stable-c734bab-Linux-x86_64.deb -O synergy.deb
sudo dpkg -i synergy.deb
sudo apt-get install -f -y
rm -rf synergy.deb

##Install Telegram
wget https://updates.tdesktop.com/tlinux/tsetup.0.8.57.tar.xz -O ~/telegram.xz
tar xvf tsetup.0.8.57.tar.xz
sudo mv Telegram/ /opt/
rm -rf ~/telegram.xz
export PATH=$PATH:/opt/Telegram
sudo ln -s /opt/Telegram/Telegram /opt/Telegram/telegram

##Start the Tweak Tool - Set This Puppy to "2"
#gnome-tweak-tool &
