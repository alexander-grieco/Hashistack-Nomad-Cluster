#!/bin/bash

set -e

exec > >(sudo tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
sudo chmod +x /ops/scripts/server.sh
sudo bash -c "NOMAD_BINARY=${nomad_binary}  /ops/scripts/start-server.sh \"${server_count}\""
rm -rf /ops/