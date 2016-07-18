#!/bin/sh

cwd=`dirname $0`
. $cwd/common.sh

defaultdir="${HOME}/bin"

repoPath=$(pwd)/bin;
repodst="$repoPath/repo"

if [ -f "$repodst" ]; then
    export PATH=$repoPath:$PATH;
    repo sync -j $(nproc)
    repo forall -c "git checkout -b psdkla_dev" 2> /dev/null
    repo forall -c "git checkout psdkla_dev" 

else
    echo "--------------------------------------------------------------------------------"
    echo "ERROR. Please run this script from the Processor SDK Linux Automotive root folder "
    echo "--------------------------------------------------------------------------------"
fi

