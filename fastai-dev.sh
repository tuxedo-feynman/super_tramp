#!/usr/bin/bash


###################################
# FASTAI-DEV SCRIPT		  #
# Setup a development environment #
# for fastai projects on iPad	  #	
###################################

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

### SETUP NEW SYSTEM ###
adduser $USERNAME
adduser $USERNAME sudo

### SETUP SPEECH DEPENDENCIES
apt-get update

apt-get -y install graphviz \
   libwebp-dev \
   curl \
   htop \
   ffmpeg \
   docker.io \
   neovim \
   python3-pip


sudo systemctl enable --now docker

apt-get -y install libsndfile1

cd /home/$USERNAME

sudo -u $USERNAME git clone https://github.com/tuxedo-feynman/smellslikesingularity

pip install fastai
