#!/bin/bash
#

PURPLE='\033[0;35m'
ORANGE='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color



function highlight()
{
  echo -en ${PURPLE};
  cat $1 | awk '{while(match($0,"[$]{[^}]*}")) {var=substr($0,RSTART+2,RLENGTH -3);gsub("[$]{"var"}",ENVIRON[var])}}1' | sed '1,/o 0 o/d;/<!-- -->]/,$d' | fold -w 60 -s;
  echo -en ${NC};
}

FRAME=$(printf "%-80s" "~");
function explain()
{
  echo -e "\n\n\n\n${FRAME// /\~}"

  if [ -r "$1" ]; then
#    fold -w 80 -s $1;
    highlight $1;

  else
    echo -e "FIXME";
    echo -e $1;
  fi;

	if [ "X${AUTORUN}X" == "XaX" ]; then return 0; fi;
	echo -e "Type : '${RED}a${NC}ll' if you want to execute the rest of the script without pausing."
	echo -e "Type : '${RED}n${NC}o' to skip the group of related commands."
	echo -e "Hit : '${RED}y${NC}es'  or '${RED}<enter>${NC}' to execute the group, '${RED}q${NC}uit' OR '${RED}<ctrl-c>${NC}' to quit"
	read -p "  'a', 'n', 'q' or <enter> ::  " -n 1 -r USER_ANSWER

	CHOICE=$(echo ${USER_ANSWER:0:1} | tr '[:upper:]' '[:lower:]')
#	echo X${CHOICE}X
	if [ "X${CHOICE}X" == "XnX" ]; then return 1; fi;
  if [ "X${CHOICE}X" == "XqX" ]; then echo ""; exit 0; fi;
	AUTORUN=${CHOICE};
	return 0;
}


function saveUserData()
{
cat << UDATA > udata.sh
export PROJECT_NAME="${PROJECT_NAME}"
export GITHUB_ORGANIZATION_NAME="${GITHUB_ORGANIZATION_NAME}"
export YOUR_NAME="${YOUR_NAME}"
export YOUR_EMAIL="${YOUR_EMAIL}"
UDATA
}

function getUserData()
{

  if [ -f ./udata.sh ]; then
    source ./udata.sh
    echo "Project name : ${PROJECT_NAME}"
  else
    export PROJECT_NAME=""
    export GITHUB_ORGANIZATION_NAME=""
    export YOUR_NAME=""
    export YOUR_EMAIL=""
  fi


  CHOICE="n"
  while [[ ! "X${CHOICE}X" == "XyX" ]]
  do
    echo -e "\n Please supply the following details :\n";
    read -p "The exact project name for use in GitHub :: " -e -i "${PROJECT_NAME}" INPUT
    if [ ! "X${INPUT}X" == "XX" ]; then PROJECT_NAME=${INPUT}; fi;

    read -p "The exact name for the GitHub organization :: " -e -i "${GITHUB_ORGANIZATION_NAME}" INPUT
    if [ ! "X${INPUT}X" == "XX" ]; then GITHUB_ORGANIZATION_NAME=${INPUT}; fi;

    read -p "The project owner name to use to publish it in GitHub :: " -e -i "${YOUR_NAME}" INPUT
    if [ ! "X${INPUT}X" == "XX" ]; then YOUR_NAME=${INPUT}; fi;

    read -p "The email address for the project owner in GitHub :: " -e -i "${YOUR_EMAIL}" INPUT
    if [ ! "X${INPUT}X" == "XX" ]; then YOUR_EMAIL=${INPUT}; fi;

    echo -e "\n\n# ${FRAME// /\~}"
    echo "Project name : ${PROJECT_NAME}"
    echo "GitHub organization name : ${GITHUB_ORGANIZATION_NAME}"
    echo "Project owner name : ${YOUR_NAME}"
    echo "Project owner email : ${YOUR_EMAIL}"

    read -ep "Is this correct? (y/n/q) ::  " -n 1 -r USER_ANSWER
    CHOICE=$(echo ${USER_ANSWER:0:1} | tr '[:upper:]' '[:lower:]')
    if [[ "X${CHOICE}X" == "XqX" ]]; then
      echo skip out
      return 1;
    fi;
    echo "  "
  done
  saveUserData
  return
}

source udata.sh

#############################

