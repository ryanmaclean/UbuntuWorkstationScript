#Ubuntu for Development and SRE Work

###[Upstart Fix](http://askubuntu.com/questions/614970/vivid-failed-to-connect-to-upstart-connection-refused)
Ubuntu has recently made the switch to SystemD. Not a bad thing, but many scripts (like the SSH one coming up next) still use Upstart. Lukcily we have a quick fix to tide us ove in the interim. 

`sudo apt-get install -y upstart-sysv`

###[Remove CDROM from Soures](http://askubuntu.com/questions/386265/media-change-please-insert-the-disc-labeled-when-trying-to-install-ruby-on-ra)
`sudo sed -i '/cdrom/d' /etc/apt/sources.list`

###[Quick and Dirty SSH Server](https://help.ubuntu.com/community/SSH/OpenSSH/Configuring)
I'd certainly recommend moving to keys over passwords, but for now, it'll do... 
```
sudo apt-get install -y openssh-server
sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.factory-defaults
sudo chmod a-w /etc/ssh/sshd_config.factory-defaults
sudo restart ssh
```

###Ubuntu Essentials
A (very) opinionated list of packages that are a must on every Ubuntu box you'll use for Rails or Mean stack development and Chef, Ansible, Puppet work. 

####Apt Fun
First, let's run an apt-get update:
`sudo apt-get update -qq`

Then we're on to the packages:
`sudo apt-get install indicator-multiload vim vagrant virtualbox chef puppet ansible tmux mussh multitail mc iptraf netcat links mutt zsh fish jmeter iperf iotop htop traceroute nmap docker ruby python python-pip git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev git build-essential openssl pkg-config nodejs npm -y`

###[AWS CLI](http://docs.aws.amazon.com/cli/latest/userguide/installing.html)
`sudo pip install awscli`

###[Fiddly Rails Things](https://gorails.com/setup/ubuntu/15.04)
```
cd ~
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
```

###And the MEAN Things
```
sudo npm cache clean -f
sudo npm install -g n
sudo n stable
sudo npm install -g bower grunt-cli
git clone https://github.com/meanjs/mean.git /opt/mean
cd /opt/mean
sudo npm install
cd ~
sudo npm install -g yo 
```

###Docker, Vagrant Stuff
Install Packer

```
mkdir packer
cd packer
wget https://dl.bintray.com/mitchellh/packer/packer_0.8.6_linux_amd64.zip
unzip packer_0.8.6_linux_amd64.zip
```

Install Flocker

```
sudo apt-get update
sudo apt-get -y install apt-transport-https software-properties-common
sudo add-apt-repository -y "deb https://clusterhq-archive.s3.amazonaws.com/ubuntu/$(lsb_release --release --short)/\$(ARCH) /"
sudo apt-get update
sudo apt-get -y --force-yes install clusterhq-flocker-cli
```


#Databases
You'll probably want some database clients and servers installed (but not running) when doing dev work. 

###PostgreSQL
```
sudo sh -c "echo 'deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main' > /etc/apt/sources.list.d/pgdg.list"
wget --quiet -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | sudo apt-key add -
sudo apt-get update
sudo apt-get install -y postgresql-common postgresql-9.3 libpq-dev
```

###MySQL
`sudo apt-get install -y  mysql-server mysql-client libmysqlclient-dev mysql-workbench`

###SQLite
`sudo apt-get install -y libsqlite3-dev sqlite3`

###MongoDB

```
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | sudo tee /etc/apt/sources.list.d/mongodb.list
sudo apt-get install -y mongodb-org 
```

#The Fun Stuff

These aren't needed, at all, and are more for personal use than anything else (though I have a feeling some might be of use to others).

###Steam
```
sudo apt-get install steam
cd ~/.local/share/Steam/skins/
git clone https://github.com/DirtDiglett/Pressure-for-Steam.git
cd ~
```

###[Spotify](http://howtoubuntu.org/how-to-install-spotify-in-ubuntu)
```
sudo apt-add-repository -y "deb http://repository.spotify.com stable non-free"
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys D2C19886
sudo apt-get update -qq
sudo apt-get install spotify-client
```

###Kodi
```
sudo apt-get install software-properties-common
sudo add-apt-repository ppa:team-xbmc/ppa
sudo apt-get update
sudo apt-get install kodi
```

###[Sublime Text 3 Installation](http://askubuntu.com/questions/172698/how-do-i-install-sublime-text-2-3)
```
sudo add-apt-repository ppa:webupd8team/sublime-text-3
sudo apt-get update -qq
sudo apt-get install -y sublime-text-installer
```

Then press "ctrl+`" and paste the following:
```
import urllib.request,os,hashlib; h = 'eb2297e1a458f27d836c04bb0cbaf282' + 'd0e7a3098092775ccb37ca9d6b2e4b7d'; pf = 'Package Control.sublime-package'; ipp = sublime.installed_packages_path(); urllib.request.install_opener( urllib.request.build_opener( urllib.request.ProxyHandler()) ); by = urllib.request.urlopen( 'http://packagecontrol.io/' + pf.replace(' ', '%20')).read(); dh = hashlib.sha256(by).hexdigest(); print('Error validating download (got %s instead of %s), please try manual install' % (dh, h)) if dh != h else open(os.path.join( ipp, pf), 'wb' ).write(by)
```

And hit enter

###[Chrome](http://www.howtogeek.com/203768/beginner-how-to-install-google-chrome-in-ubuntu-14.04/)
```
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg –I google-chrome-stable_current_amd64.deb
```

###[Slack Using ScudCloud](https://github.com/raelgc/scudcloud)
```
sudo apt-add-repository -y ppa:rael-gc/scudcloud
sudo apt-get update -qq
sudo apt-get install -y scudcloud
```

###Oh My ZSH!
`curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh`

###Oh my Fish!
`curl -L git.io/omf | sh`

###PhantomJS
`sudo npm install phantomjs`

###Cyberduck
```
echo -e "deb https://s3.amazonaws.com/repo.deb.cyberduck.io stable main" | sudo tee -a /etc/apt/sources.list > /dev/null
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys FE7097963FEFBE72
sudo apt-get update
sudo apt-get install -y duck
```

###[HipChat](https://www.hipchat.com/downloads#linux-install)
sudo su
echo "deb http://downloads.hipchat.com/linux/apt stable main" > \
  /etc/apt/sources.list.d/atlassian-hipchat.list
wget -O - https://www.hipchat.com/keys/hipchat-linux.key | apt-key add -
apt-get update
apt-get install -y hipchat

###Vundle VIM Plugin Manager
```
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
cat << EOF > ~/.vimrc
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
Plugin 'L9'
" Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
Plugin 'user/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
EOF
vim +PluginInstall +qall
```


#HiDPI Fixes
You'll need to do a few things in order to make sure the display is scaled properly. 

First, in Ubuntu:
```
apt-get install gnome-tweak-tool
gnome-tweak-tool
```

Navigate to the "Windows" section, and set the HiDPI Window Scaling to something larger than one. I've used "2" for monitors with 1800 vertical pixels. 

For Chrome:
This is actually now fixed, though previously the "--force-device-scale-factor=2" launch option was required. 

For Firefox: 
Navigate to "about:config"
Set layout.css.devPixelsPerPx to "2"
