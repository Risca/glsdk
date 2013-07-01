#!/bin/sh

cwd=`dirname $0`
. $cwd/common.sh

defaultdir="${HOME}/bin"

repoPath=$(pwd)/bin;
repodst="$repoPath/repo"

if [ -f "$repodst" ]; then
    export PATH=$repoPath:$PATH;
    repo sync
    repo forall -c "git checkout -b glsdk_dev" 2> /dev/null
    repo forall -c "git checkout glsdk_dev" 

else
    echo "--------------------------------------------------------------------------------"
    echo "ERROR. Please run this script from the GLSDK root folder "
    echo "--------------------------------------------------------------------------------"
fi

