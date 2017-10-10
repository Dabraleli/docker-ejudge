#!/bin/bash

CONTEST_HOME="/home/ejudge"
EJUDGE_INSTALL="/opt/scripts/install.sh"

chown -R ejudge:ejudge "${CONTEST_HOME}"
cp -r /opt/scripts/html/* /var/www/ejudge/cgi-bin/
if [ "$(ls -A $CONTEST_HOME)" ]; then
    echo "Contest directory is not empty. Leaving."
else
    echo "Installing ejudge..."
    /bin/bash "${EJUDGE_INSTALL}"
fi
