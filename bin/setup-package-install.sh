#!/bin/sh

. `dirname $0`/common.sh

cmd="sudo apt-get install ssh corkscrew gawk texinfo chrpath git-email g++ libc6:i386 libc6-i386 libstdc++6:i386 libncurses5:i386 libz1:i386 libc6:i386 libc6-dev-i386 device-tree-compiler nfs-kernel-server"
echo "--------------------------------------------------------------------------------"
echo "This step will make sure you have the proper host support packages installed"
echo "using the following command: $cmd"
echo
echo "Note! This command requires you to have administrator priviliges (sudo access) "
echo "on your host."
read -p "Press return to continue" REPLY

echo
$cmd
check_status
svn help > /dev/null
echo
echo "Package verification and installation successfully completed"
echo "--------------------------------------------------------------------------------"
echo
