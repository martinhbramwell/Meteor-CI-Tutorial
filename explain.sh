#!/bin/bash
#


FRAME=$(printf "%-80s" "~"); 
function explain()
{
  echo -e "\n\n\n\n# ${FRAME// /\~}"
  echo -e $1
  echo -e "# ${FRAME// /\~}"
	if [ "X${AUTORUN}X" == "XaX" ]; then return 0; fi;
	echo -e "Type '\e[1;34ma\e[0mll\e[1;34m<enter>\e[0m' if you want to execute the rest of the script without pausing."
	echo -e "Type '\e[1;34mn\e[0mo\e[1;34m<enter>\e[0m' to skip the group of related commands."
	echo -e "Hit '\e[1;34m<enter>\e[0m' to execute the group, '\e[1;34mq\e[0m' OR '\e[1;34m<ctrl-c>\e[0m' to quit"
	read -p "  'a', 'n' or <enter> ::  " -n 1 -r USER_ANSWER

	CHOICE=$(echo ${USER_ANSWER:0:1} | tr '[:upper:]' '[:lower:]')
#	echo X${CHOICE}X
	if [ "X${CHOICE}X" == "XnX" ]; then return 1; fi;
  if [[ "X${CHOICE}X" == "XqX" ]]; then echo ""; exit 0; fi;
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
    echo -e "\n\n";
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

