#!/bin/bash

VERSION=v2.0.0
FILE_RELEASE=Scored
URL_RELEASE=https://github.com/MinseokOh/score_qtbuild/releases/download/${VERSION}/${FILE_RELEASE}

function score_dependency() {
	sudo apt-get update
	sudo apt-get -y install unzip
	sudo apt-get -y install libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-program-options-dev libboost-test-dev libboost-thread-dev libboost-all-dev unzip libminiupnpc-dev python-virtualenv
	sudo apt-get -y install build-essential libtool autotools-dev automake pkg-config libssl-dev libevent-dev bsdmainutils
	sudo apt-get -y install software-properties-common && add-apt-repository ppa:bitcoin/bitcoin
	sudo apt-get update
	sudo apt-get -y install libdb4.8-dev libdb4.8++-dev
	sudo apt-get -y install libzmq3-dev
}

function score_install() {
	score_dependency
	echo "$(tput setaf 1)[INSTALL] score MN $(tput sgr0)"		
	pushd ~/
		mkdir scored
			pushd scored
			wget ${URL_RELEASE}
			chmod +x ${FILE_RELEASE}
		popd
	popd
	score_run
	echo "$(tput setaf 1)[INSTALL] score MN Complete! $(tput sgr0)"
}

function score_run() {
	echo "$(tput setaf 1)[RUN] score $(tput sgr0)"		
    pushd ~/scored/
    	./Scored
    popd
}

function score_stop() {
	echo "$(tput setaf 1)[STOP] score Wallet$(tput sgr0)"	
	pkill Scored
}

function score_update() {
	score_stop
	git pull
	score_install
	score_run
}

function score_conf() {
	echo "~/.Score/Score.conf"
}

COMMAND=$1


if [ "${COMMAND}" = "install" ]; then 
	score_install
fi

if [ "${COMMAND}" = "run" ]; then 
	score_run
fi

if [ "${COMMAND}" = "stop" ]; then 
	score_stop
fi

if [ "${COMMAND}" = "update" ]; then 
	score_update
fi