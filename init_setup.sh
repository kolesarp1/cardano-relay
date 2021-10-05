#!/bin/bash
echo export CARDANO_NODE_SOCKET_PATH="/home/patrik/Desktop/cardano-relay/db/node.socket">> $HOME/.bashrc
#echo export LD_LIBRARY_PATH="/usr/local/lib:$LD_LIBRARY_PATH" >> $HOME/.bashrc
echo export NODE_HOME=$HOME/Desktop/cardano-relay >> $HOME/.bashrc
echo PATH="$NODE_HOME/bin:$PATH" >> $HOME/.bashrc
#echo export NODE_CONFIG=mainnet>> $HOME/.bashrc
echo export NODE_CONFIG=testnet>> $HOME/.bashrc
source $HOME/.bashrc

./create_starting_scripts.sh
sudo mv $NODE_HOME/cardano-node.service /etc/systemd/system/cardano-node.service
sudo chmod 644 /etc/systemd/system/cardano-node.service

#Run the following to enable auto-starting of your stake pool at boot time.
sudo systemctl daemon-reload
sudo systemctl enable cardano-node

echo "Cardano variables in $HOME/.bashrc set, congratulations! :-)"

echo "Starting cardano-node with paramenetrs"
sudo systemctl start cardano-node.service
