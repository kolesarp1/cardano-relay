cat > $NODE_HOME/cardano-node.service << EOF
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
ExecStart       = /bin/bash -c '${NODE_HOME}/startRelayNode1.sh'
KillSignal=SIGINT
RestartKillSignal=SIGINT
TimeoutStopSec=2
LimitNOFILE=32768
Restart=always
RestartSec=5
SyslogIdentifier=cardano-node

[Install]
WantedBy	= multi-user.target
EOF

cat > ${NODE_HOME}/startRelayNode1.sh << EOF
#!/bin/bash
DIRECTORY=$NODE_HOME
PORT=1337
#HOSTADDR=94.112.10.17
HOSTADDR=127.0.0.1
TOPOLOGY=$NODE_HOME/configuration/${NODE_CONFIG}-topology.json
DB_PATH=$NODE_HOME/db
SOCKET_PATH=$NODE_HOME/db/node.socket
CONFIG=$NODE_HOME/configuration/${NODE_CONFIG}-config.json
#$NODE_HOME/bin/cardano-node run +RTS -N -A16m -qg -qb -RTS --topology \${TOPOLOGY} --database-path \${DB_PATH} --socket-path \${SOCKET_PATH} --host-addr \${HOSTADDR} --port \${PORT} --config \${CONFIG}
$NODE_HOME/bin/cardano-node run --topology \${TOPOLOGY} --database-path \${DB_PATH} --socket-path \${SOCKET_PATH} --host-addr \${HOSTADDR} --port \${PORT} --config \${CONFIG}

EOF

chmod +x ${NODE_HOME}/startRelayNode1.sh
