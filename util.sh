#!/bin/bash
#


function existingMeteor() {

  EXISTING_METEOR_PID=$(ps aux | grep meteor | grep -v grep | grep -c ~/.meteor/packages)
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
export PARENT_DIR="${PARENT_DIR}"
export PROJECT_NAME="${PROJECT_NAME}"
export PKG_NAME="${PKG_NAME}"
export GITHUB_ORGANIZATION_NAME="${GITHUB_ORGANIZATION_NAME}"
export PACKAGE_DEVELOPER="${PACKAGE_DEVELOPER}"
export YOUR_EMAIL="${YOUR_EMAIL}"
export YOUR_NAME="${YOUR_NAME}"
UDATA
}

function getUserData()
{

  if [ -f ./udata.sh ]; then
    source ./udata.sh
  else
    export PARENT_DIR=""
    export PROJECT_NAME=""
    export PKG_NAME=""
    export GITHUB_ORGANIZATION_NAME=""
    export PACKAGE_DEVELOPER=""
    export YOUR_EMAIL=""
    export YOUR_NAME=""
  fi


  CHOICE="n"
  while [[ ! "X${CHOICE}X" == "XyX" ]]
  do

    echo -e "\n\n# ${FRAME// /\~}"
    echo "Project path in ${HOME} directory : ${PARENT_DIR}"
    echo "Project name : ${PROJECT_NAME}"
    echo "Package name : ${PKG_NAME}"
    echo "GitHub organization name : ${GITHUB_ORGANIZATION_NAME}"
    echo "Project owner full name : ${PACKAGE_DEVELOPER}"
    echo "Project owner name : ${YOUR_NAME}"
    echo "Project owner email : ${YOUR_EMAIL}"

    read -ep "Is this correct? (y/n/q) ::  " -n 1 -r USER_ANSWER
    CHOICE=$(echo ${USER_ANSWER:0:1} | tr '[:upper:]' '[:lower:]')
    if [[ "X${CHOICE}X" == "XqX" ]]; then
      echo skip out
      return 1;
    elif [[ ! "X${CHOICE}X" == "XyX" ]]; then

      echo -e "\n Please supply the following details :\n";
      read -p "The project path within the ${HOME} directory :  :: " -e -i "${PARENT_DIR}" INPUT
      if [ ! "X${INPUT}X" == "XX" ]; then PARENT_DIR=${INPUT}; fi;

      read -p "The exact project name for use in GitHub :: " -e -i "${PROJECT_NAME}" INPUT
      if [ ! "X${INPUT}X" == "XX" ]; then PROJECT_NAME=${INPUT}; fi;

      read -p "The exact package name for use in GitHub :: " -e -i "${PKG_NAME}" INPUT
      if [ ! "X${INPUT}X" == "XX" ]; then PKG_NAME=${INPUT}; fi;

      read -p "The exact name for the GitHub organization :: " -e -i "${GITHUB_ORGANIZATION_NAME}" INPUT
      if [ ! "X${INPUT}X" == "XX" ]; then GITHUB_ORGANIZATION_NAME=${INPUT}; fi;

      read -p "The project owner full name to use to publish it in GitHub :: " -e -i "${PACKAGE_DEVELOPER}" INPUT
      if [ ! "X${INPUT}X" == "XX" ]; then PACKAGE_DEVELOPER=${INPUT}; fi;

      read -p "The email address for the project owner in GitHub :: " -e -i "${YOUR_EMAIL}" INPUT
      if [ ! "X${INPUT}X" == "XX" ]; then YOUR_EMAIL=${INPUT}; fi;

      read -p "The project owner name to use within the project :: " -e -i "${YOUR_NAME}" INPUT
      if [ ! "X${INPUT}X" == "XX" ]; then YOUR_NAME=${INPUT}; fi;

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

