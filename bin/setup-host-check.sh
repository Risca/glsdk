#!/bin/sh

echo
echo "--------------------------------------------------------------------------------"
echo "Verifying Linux host distribution"
host=`lsb_release -a 2>/dev/null | grep Codename: | awk {'print $2'}`
if [ "$host" = "trusty" ]; then
    echo "Ubuntu 14.04 found successfully, continuing.."
    echo "--------------------------------------------------------------------------------"
    echo
else
    echo "Unsupported host machine, only Ubuntu 14.04 supported"
    exit 1
fi
