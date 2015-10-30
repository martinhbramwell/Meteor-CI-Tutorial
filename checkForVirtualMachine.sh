#!/bin/bash
#

echo -e "Attempting to confirm we're running in a virtual machine . . .\n";
VIRTUAL=false;

MSG="Found a '%s' virtual machine.\n"

if [[ -d /proc/vz ]]; then
  if [[ -f /proc/vz/veinfo ]]; then
    printf "${MSG}" "Virtuozzo"; return 0;
  fi;
fi;

DMESG_CHK=$(dmesg | grep -i virtual);
if [[ 0 < $(echo "${DMESG_CHK}" | grep -c drive) ]]; then  printf "${MSG}" "Microsoft VirtualPC"; return 0; fi;
if [[ 0 < $(dmesg | grep -i xen) ]]; then  printf "${MSG}" "Xen"; return 0; fi;
if [[ 0 < $(echo "${DMESG_CHK}" | grep -c QEMU) ]]; then  printf "${MSG}" "QEMU"; return 0; fi;
if [[ 0 < $(echo "${DMESG_CHK}" | grep -c KVM) ]]; then  printf "${MSG}" "KVM"; return 0; fi;


echo " **PLEASE PLEASE PLEASE**";
echo " Only run these scripts on a Virtual Machine running Ubuntu 12.04LTS or newer";
echo " ";
echo " I have made no attempt to validate the script in other environments,";
echo " so failure and damage are the likely result if you do not respect this warning.";
echo " ";
echo " ";

exit 1;


