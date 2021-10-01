#!/bin/bash
mkdir -p /home/patrik/Desktop/cardano-relay/db/

cardano-node run \
     --topology /home/patrik/Desktop/cardano-relay/cardano-node-1.30.0-linux/configuration/cardano/testnet/testnet-topology.json \
     --database-path /home/patrik/Desktop/cardano-relay/db \
     --socket-path /home/patrik/Desktop/cardano-relay/db/node.socket \
     --host-addr 127.0.0.1 \
     --port 8081 \
     --config /home/patrik/Desktop/cardano-relay/cardano-node-1.30.0-linux/configuration/cardano/testnet/testnet-config.json
