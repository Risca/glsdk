#!/bin/sh

cwd=`dirname $0`
. $cwd/common.sh

defaultdir="${HOME}/bin"

repodst="$cwd/repo"

fetch_repo() {
    echo
    echo "----------------------------------------------------------------------------------------------"
    echo "The repo tool will be installed in $(pwd)/bin folder"
    echo "----------------------------------------------------------------------------------------------"
    repoBinaryURL="https://dl-ssl.google.com/dl/googlesource/git-repo/repo"
    check_status
    wget $repoBinaryURL -O $repodst
    check_status
    export PATH=$cwd:$PATH
    check_status
    chmod a+x $repodst
    check_status
    echo "Successfully extracted the repo tool to $cwd"
    sleep 2
    echo "Proceeding with repo init -u git://git.ti.com/glsdk/release-manifest.git"
    echo " "
    repo init -u git://git.ti.com/glsdk/release-manifest.git -m dra7xx-evm.xml
    check_status
    echo
}


if [ -f "$repodst" ]; then
    echo "--------------------------------------------------------------------------------"
    echo "WARNING!! $repodst already exists"
    echo "--------------------------------------------------------------------------------"
else
    fetch_repo $cwd
fi

