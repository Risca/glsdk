#!/bin/sh

cwd=`dirname $0`
. $cwd/common.sh

fetch_repo() {
    echo
    echo "----------------------------------------------------------------------------------------------"
    echo "The repo tool will be installed in $cwd folder"
    echo "----------------------------------------------------------------------------------------------"
    repoBinaryURL="http://commondatastorage.googleapis.com/git-repo-downloads/repo"
    check_status
    wget $repoBinaryURL -O $cwd/repo-temp
    check_status
    #This is to avoid skipping if repo did not download due to proxy issue
    mv $cwd/repo-temp $cwd/repo
    chmod a+x $cwd/repo
    check_status
    export PATH=$cwd:$PATH
    check_status
    echo "Successfully extracted the repo tool to $cwd"
    echo "Proceeding with repo init -u git://git.ti.com/glsdk/release-manifest.git"
    echo " "
    repo init -u git://git.ti.com/glsdk/release-manifest.git -m dra7xx-psdkla_evm_06_00_00_00.xml --no-repo-verify
    check_status
    echo
}


if [ -f "$cwd/repo" ]; then
    echo "--------------------------------------------------------------------------------"
    echo "WARNING!! $cwd/repo already exists"
    echo "--------------------------------------------------------------------------------"
else
    fetch_repo $cwd
fi

