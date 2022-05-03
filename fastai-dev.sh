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
ufw allow 5000/tcp
ufw allow 22/tcp

### SETUP SPEECH DEPENDENCIES
apt-get update

apt-get -y install graphviz \
   libwebp-dev \
   curl \
   htop \
   ffmpeg \
   python3-pip \
   tmux \
   silversearcher-ag \
   nodejs \
   npm \
   python3-flask

apt-get repository ppa:keithw/mosh
apt-get update
apt-get install mosh


# VIM

# install 0.6.1 
#wget https://github.com/neovim/neovim/releases/download/v0.6.1/nvim.appimage
#mv nvim.appimage /usr/local/bin/
#chmod +x /usr/local/bin/nvim.appimage
#
#CUSTOM_NVIM_PATH=/usr/local/bin/nvim.appimage
#sudo update-alternatives --install /usr/bin/ex v "${CUSTOM_NVIM_PATH}" 110
#sudo update-alternatives --install /usr/bin/vi vi "${CUSTOM_NVIM_PATH}" 110
#sudo update-alternatives --install /usr/bin/vim vim "${CUSTOM_NVIM_PATH}" 110
#
## configure
#VIM_PLUG_FILE_PATH=".local/share/nvim/site/autoload"
#echo "${VIM_PLUG_FILE_PATH}/plug.vim"
#mkdir -p "/home/${USERNAME}/${VIM_PLUG_FILE_PATH}" && cp "${VIM_PLUG_FILE_PATH}/plug.vim" "/home/${USERNAME}/${VIM_PLUG_FILE_PATH}" && chown -R $USERNAME "/home/${USERNAME}/.local"
#mkdir -p ~/$VIM_PLUG_FILE_PATH && cp $VIM_PLUG_FILE_PATH/plug.vim ~/$VIM_PLUG_FILE_PATH/
#
#VIM_CONFIG_DIR=".config/nvim"
#mkdir -p "/home/${USERNAME}/${VIM_CONFIG_DIR}" && cp "${VIM_CONFIG_DIR}/init.vim" "/home/${USERNAME}/${VIM_CONFIG_DIR}" && chown -R $USERNAME "/home/${USERNAME}/.config"
#mkdir -p ~/$VIM_CONFIG_DIR && cp $VIM_CONFIG_DIR/init.vim ~/$VIM_CONFIG_DIR
#
#vim 'PlugInstall --sync' +qa
#sudo su $USERNAME vim 'PlugInstall --sync' +qa
#
#echo "WE DIDN'T SeTUP COPILOT, RUN Copilot setup in VIM"
##make this a link instead
#cp tmux/.tmux.conf /home/$USERNAME && chown $USERNAME /home/$USERNAME/.tmux.conf
#cp tmux/.tmux.conf ~/
#
## my app stuff
#apt-get -y install libsndfile1
#pip install fastai

apt autoremove
