#!/bin/bash
echo export CARDANO_NODE_SOCKET_PATH="/home/patrik/Desktop/cardano-relay/db/node.socket">> $HOME/.bashrc
echo PATH="$HOME/.local/bin:$PATH" >> $HOME/.bashrc
#echo export LD_LIBRARY_PATH="/usr/local/lib:$LD_LIBRARY_PATH" >> $HOME/.bashrc
echo export NODE_HOME=$HOME/Desktop/cardano-relay >> $HOME/.bashrc
#echo export NODE_CONFIG=mainnet>> $HOME/.bashrc
echo export NODE_CONFIG=testnet>> $HOME/.bashrc
source $HOME/.bashrc
echo "Cardano variables in $HOME/.bashrc set, congratulations! :-)"
