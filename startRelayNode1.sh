#!/bin/bash
DIRECTORY=/home/patrik/Desktop/cardano-relay
PORT=6000
HOSTADDR=0.0.0.0
TOPOLOGY=/home/patrik/Desktop/cardano-relay/configuration/testnet-topology.json
DB_PATH=/home/patrik/Desktop/cardano-relay/db
SOCKET_PATH=/home/patrik/Desktop/cardano-relay/db/socket
CONFIG=/home/patrik/Desktop/cardano-relay/configuration/testnet-config.json
/home/patrik/Desktop/cardano-relay/bin/cardano-node run +RTS -N -A16m -qg -qb -RTS --topology ${TOPOLOGY} --database-path ${DB_PATH} --socket-path ${SOCKET_PATH} --host-addr ${HOSTADDR} --port ${PORT} --config ${CONFIG}
