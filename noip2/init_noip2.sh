#!/bin/bash

if dpkg --print-architecture | grep -iq 'arm'
then
	export NOIP2_BIN=noip2-arm_32
        echo "ARM architecture"
else
        export NOIP2_BIN=noip2-x86_64
        echo "x86_64 architecture"
fi


echo "1) Generating noip systemd exec script to $NODE_HOME/gen/startNoip2.sh"
cat > ${NODE_HOME}/gen/startNoip2.sh << EOF
#!/bin/bash
${NODE_HOME}/bin/${NOIP2_BIN} -c ${NODE_HOME}/noip2/noip2.conf
EOF

chmod +x ${NODE_HOME}/gen/startNoip2.sh

echo "2) Generating noip2 systemd service file"
cat > ${NODE_HOME}/gen/noip2-hostname.service << EOF
# The noip service to resolve hostname (part of systemd)
# file: /etc/systemd/system/noip2-hostname.service

[Unit]
Description     = No-ip.com dynamic IP address updater
After           = syslog.target
After           = network.target

[Service]
User            = ${USER}
Type            = forking
WorkingDirectory= ${NODE_HOME}
ExecStart       = /bin/bash -c '${NODE_HOME}/gen/startNoip2.sh'
#KillSignal=SIGINT
#RestartKillSignal=SIGINT
#TimeoutStopSec=2
#LimitNOFILE=32768
Restart=always
#RestartSec=5
#SyslogIdentifier=noip2

[Install]
WantedBy        = multi-user.target
Alias		= noip2.service
EOF

sudo cp $NODE_HOME/gen/noip2-hostname.service /etc/systemd/system/noip2-hostname.service
sudo chmod 644 /etc/systemd/system/noip2-hostname.service

sudo systemctl daemon-reload
#sudo systemctl enable noip-hostname.service
