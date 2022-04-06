#!/usr/bin/bash


#########################################################
# FASTAI-DEV SCRIPT		  			#
# Setup a development environment 			#
# for fastai projects on iPad	  			#
#########################################################
# First you need to clone this repo on the new server.	#
# generate a new ssh key pair     			#
# ssh-keygen -t rsa -b 4096 -C "your_email@domain.com"	#
# copy the public key, and add it to github.		#
# then git clone the repo on the new server 		#
#########################################################

SUPPORTED_OS_NAME="Ubuntu"
SUPPORTED_OS_VERSION="impish"
IS_SUPPORTED_OS=false


# check OS is supported version
if [[ -f /etc/os-release ]]; then
	. /etc/os-release
	if [[ $SUPPORTED_OS_NAME == $NAME && $SUPPORTED_OS_VERSION == $VERSION_CODENAME ]]; then
		IS_SUPPORTED_OS=true
	fi
fi
if [[ $IS_SUPPORTED_OS == false ]]; then
	echo "ERROR: fastai-dev script only supports Ubuntu Impish"
	exit 1
fi
if [ -z $USERNAME ]; then
	echo $USERNAME
	echo "ERROR: must set a USERNAME variable"
	exit 1
fi

### SETUP NEW SYSTEM ###
#adduser $USERNAME
#adduser $USERNAME sudo
#ufw enable
#ufw allow ssh
#ufw allow 60000:61000/udp

### SETUP SPEECH DEPENDENCIES
apt-get update

apt-get -y install graphviz \
   libwebp-dev \
   curl \
   htop \
   ffmpeg \
   neovim \
   python3-pip \
   sofware-properties-common \
   tmux \
   silversearcher-ag

apt-get repository ppa:keithw/mosh
apt-get update
apt-get install mosh


# VIM
VIM_PLUG_FILE_PATH=".local/share/nvim/site/autoload"
echo "${VIM_PLUG_FILE_PATH}/plug.vim"
mkdir -p "/home/${USERNAME}/${VIM_PLUG_FILE_PATH}" && cp "${VIM_PLUG_FILE_PATH}/plug.vim" "/home/${USERNAME}/${VIM_PLUG_FILE_PATH}" && chown -R $USERNAME "/home/${USERNAME}/.local"
mkdir -p ~/$VIM_PLUG_FILE_PATH && cp $VIM_PLUG_FILE_PATH/plug.vim ~/$VIM_PLUG_FILE_PATH/

VIM_CONFIG_DIR=".config/nvim"
mkdir -p "/home/${USERNAME}/${VIM_CONFIG_DIR}" && cp "${VIM_CONFIG_DIR}/init.vim" "/home/${USERNAME}/${VIM_CONFIG_DIR}" && chown -R $USERNAME "/home/${USERNAME}/.config"
mkdir -p ~/$VIM_CONFIG_DIR && cp $VIM_CONFIG_DIR/init.vim ~/$VIM_CONFIG_DIR

nvim 'PlugInstall --sync' +qa
sudo su $USERNAME nvim 'PlugInstall --sync' +qa

#make this a link instead
cp tmux/.tmux.conf /home/$USERNAME && chown $USERNAME /home/$USERNAME/.tmux.conf
cp tmux/.tmux.conf ~/

# my app stuff
#apt-get -y install libsndfile1
#pip install fastai
#sudo -u $USERNAME cd ~/ && git clone https://github.com/tuxedo-feynman/smellslikesingularity

apt autoremove
