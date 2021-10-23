#!/bin/bash

if dpkg --print-architecture | grep -iq 'arm'
then
	export NOIP2_BIN=noip2-arm_32
        echo "ARM architecture"
else
        export NOIP2_BIN=noip2-x86_64
        echo "x86_64 architecture"
fi

echo "1) Generating noip2 systemd service file"
cat > ${NODE_HOME}/gen/noip2.service << EOF
# The noip service to resolve hostname (part of systemd)
# file: /etc/systemd/system/noip2.service

[Unit]
Description     = No-ip.com dynamic IP address updater
After           = network-online.target
Wants		= network-online.target

[Service]
User            = ${USER}
Type            = forking
WorkingDirectory= ${NODE_HOME}
ExecStart	= ${NODE_HOME}/bin/${NOIP2_BIN}
SyslogIdentifier=noip2

[Install]
WantedBy        = multi-user.target
EOF

sudo cp $NODE_HOME/gen/noip2.service /etc/systemd/system/noip2.service
sudo chmod 644 /etc/systemd/system/noip2.service

sudo cp $NODE_HOME/noip2/no-ip2.conf /usr/local/etc/no-ip2.conf
sudo chmod 666 /usr/local/etc/no-ip2.conf

echo "2) Loading, enabling, starting noip2.service"
sudo systemctl daemon-reload
sudo systemctl enable noip2.service
sudo systemctl start noip2.service
