#!/bin/bash
#


function existingMeteor() {

  EXISTING_METEOR_PID=$(ps aux | grep meteor | grep tools/main.js | awk '{print $2}')
  if [[  ${EXISTING_METEOR_PID} -gt 0  ]]; then
    echo ""
    echo ""
    echo "A Meteor process was started earlier.  Find it and stop it."
    echo "If you cannot find it, in a separate terminal window, stop it now with :"
    echo "   kill -9 ${EXISTING_METEOR_PID}"
    echo ""
    echo -e "After you have stopped the old Meteor process hit <enter> to start the new one.  "
    read -n 1 -r USER_ANSWER
  fi

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
  else
    export PROJECT_NAME=""
    export GITHUB_ORGANIZATION_NAME=""
    export YOUR_NAME=""
    export YOUR_EMAIL=""
  fi


  CHOICE="n"
  while [[ ! "X${CHOICE}X" == "XyX" ]]
  do

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
    elif [[ ! "X${CHOICE}X" == "XyX" ]]; then

      echo -e "\n Please supply the following details :\n";
      read -p "The exact project name for use in GitHub :: " -e -i "${PROJECT_NAME}" INPUT
      if [ ! "X${INPUT}X" == "XX" ]; then PROJECT_NAME=${INPUT}; fi;

      read -p "The exact name for the GitHub organization :: " -e -i "${GITHUB_ORGANIZATION_NAME}" INPUT
      if [ ! "X${INPUT}X" == "XX" ]; then GITHUB_ORGANIZATION_NAME=${INPUT}; fi;

      read -p "The project owner name to use to publish it in GitHub :: " -e -i "${YOUR_NAME}" INPUT
      if [ ! "X${INPUT}X" == "XX" ]; then YOUR_NAME=${INPUT}; fi;

      read -p "The email address for the project owner in GitHub :: " -e -i "${YOUR_EMAIL}" INPUT
      if [ ! "X${INPUT}X" == "XX" ]; then YOUR_EMAIL=${INPUT}; fi;

    fi;
    echo "  "
  done
  saveUserData
  return
}

if [ -f ./udata.sh ]; then
  source ./udata.sh
  echo "Project name : ${PROJECT_NAME}"
fi

#############################

