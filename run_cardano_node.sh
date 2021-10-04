#!/bin/bash
mkdir -p /home/patrik/Desktop/cardano-relay/db/

cardano-node run \
     --topology $NODE_HOME/configuration/testnet/testnet-topology.json \
     --database-path $NODE_HOME/db \
     --socket-path $NODE_HOME/db/node.socket \
     --host-addr 127.0.0.1 \
     --port 8081 \
     --config $NODE_HOME/configuration/testnet/testnet-config.json
