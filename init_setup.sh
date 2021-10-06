#!/bin/bash
echo "1) Adding variables to $HOME/.bashrc"
echo export NODE_HOME=$HOME/git/cardano-relay >> $HOME/.bashrc
echo export CARDANO_NODE_SOCKET_PATH="${NODE_HOME}/db/node.socket">> $HOME/.bashrc
echo PATH="${NODE_HOME}/bin:$PATH" >> $HOME/.bashrc
#echo export NODE_CONFIG=mainnet>> $HOME/.bashrc
echo export NODE_CONFIG=testnet>> $HOME/.bashrc
source $HOME/.bashrc

echo "2) Generating systemd exec script to $NODE_HOME/gen/startRelayNode1.sh"
cat > ${NODE_HOME}/gen/startRelayNode1.sh << EOF
#!/bin/bash
DIRECTORY=$NODE_HOME
PORT=1337
#HOSTADDR=94.112.10.17
HOSTADDR=127.0.0.1
TOPOLOGY=$NODE_HOME/configuration/${NODE_CONFIG}-topology.json
DB_PATH=$NODE_HOME/db
SOCKET_PATH=$NODE_HOME/db/node.socket
CONFIG=$NODE_HOME/configuration/${NODE_CONFIG}-config.json
#$NODE_HOME/bin/cardano-node run +RTS -N -A16m -qg -qb -RTS --topology \${TOPOLOGY} --database-path \${DB_PATH}
#$NODE_HOME/bin/cardano-node run +RTS -N -A16m -qg -qb -RTS --topology \${TOPOLOGY} --database-path \${DB_PATH} --socket-path \${SOCKET_PATH} --host-addr \${HOSTADDR} --port \${PORT} --config \${CONFIG}
$NODE_HOME/bin/cardano-node run --topology \${TOPOLOGY} --database-path \${DB_PATH} --socket-path \${SOCKET_PATH} --host-addr \${HOSTADDR} --port \${PORT} --config \${CONFIG}
EOF

chmod +x ${NODE_HOME}/gen/startRelayNode1.sh

echo "3) Generating systemd service to $NODE_HOME/gen/cardano-node.service"
cat > $NODE_HOME/gen/cardano-node.service << EOF
# The Cardano node service (part of systemd)
# file: /etc/systemd/system/cardano-node.service

[Unit]
Description     = Cardano node service
Wants           = network-online.target
After           = network-online.target

[Service]
User            = ${USER}
Type            = simple
WorkingDirectory= ${NODE_HOME}
ExecStart       = /bin/bash -c '${NODE_HOME}/gen/startRelayNode1.sh'
KillSignal=SIGINT
RestartKillSignal=SIGINT
TimeoutStopSec=2
LimitNOFILE=32768
Restart=always
RestartSec=5
SyslogIdentifier=cardano-node

[Install]
WantedBy        = multi-user.target
EOF

echo "4) Installing cardano systemd service to /etc/systemd/system/cardano-node.service"
sudo cp $NODE_HOME/gen/cardano-node.service /etc/systemd/system/cardano-node.service
sudo chmod 644 /etc/systemd/system/cardano-node.service

#Run the following to enable auto-starting of your stake pool at boot time.
sudo systemctl daemon-reload
sudo systemctl enable cardano-node

echo "Cardano variables in $HOME/.bashrc set, congratulations! :-)"

echo "Starting cardano-node service with parameters"
sudo systemctl start cardano-node.service
