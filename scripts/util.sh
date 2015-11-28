#!/bin/bash
#

export SUDOUSER=$(who am i | awk '{print $1}');
export GITHUB_SHTTP="https://api.github.com";

export green='\e[0;32m'
export flashingRed='\e[5;31m'
export endColor='\e[0m';

function verifyFreeSpace() {
  MINFREESPACE=1500000
  FREESPACE=$(df / | grep dev | awk '{print $4}')
  if [[  ${FREESPACE} -lt ${MINFREESPACE} ]]; then
    echo You have only ${FREESPACE} bytes free.  You should have ${MINFREESPACE};
    exit 1;
  fi;
}


function aptNotYetInstalled() {

  set +e;
#  echo -e "\n  $1";
  return $(dpkg-query -W --showformat='${Status}\n' $1 2>/dev/null | grep -c "install ok installed");
  set -e;

}

function aptNotYetInSources() {

#  echo -e "\n  $1";
  return $(grep -r --exclude='*.save' --exclude='*.gpg' "$1" /etc/apt  | grep -v "#" | grep -c $1;);

}

function npmNotYetInstalled() {

#  echo -e "\n  $1  $2";
  return $(npm list $2 $1 | grep -c "empty";);

}


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

# P1 : the url to verify
# P2 : additional commands to meteor. Eg; test-packages
function launchMeteorProcess()
{
  METEOR_URL=$1;
  STARTED=false;

  until wget -q --spider ${METEOR_URL};
  do
    echo "Waiting for ${METEOR_URL}";
    if ! ${STARTED}; then
      meteor $2 &
      STARTED=true;
    fi;
    sleep 2;
  done

  echo "Meteor is running on ${METEOR_URL}";
}

function killMeteorProcess()
{
  EXISTING_METEOR_PIDS=$(ps aux | grep meteor  | grep -v grep | grep ~/.meteor/packages | awk '{print $2}')
  for pid in ${EXISTING_METEOR_PIDS}; do
    echo "Kill Meteor process : ${pid}";
    kill -9 ${pid};
  done;
}


function saveUserData()
{
cat << UDATA > ~/.udata.sh;
export PARENT_DIR="${PARENT_DIR}";
export PROJECT_NAME="${PROJECT_NAME}";
export PKG_NAME="${PKG_NAME}";
export GITHUB_ORGANIZATION_NAME="${GITHUB_ORGANIZATION_NAME}";
export PACKAGE_DEVELOPER="${PACKAGE_DEVELOPER}";
export YOUR_EMAIL="${YOUR_EMAIL}";
export YOUR_UID="${YOUR_UID}";
export YOUR_FULLNAME="${YOUR_FULLNAME}";
export METEOR_UID="${METEOR_UID}";
export METEOR_PWD="${METEOR_PWD}";
UDATA

chown ${SUDOUSER}:${SUDOUSER} ~/.udata.sh;

}

function saveNonStopData()
{
cat << NSDATA > ~/.nsdata.sh
export GITHUB_PERSONAL_TOKEN="${GITHUB_PERSONAL_TOKEN}";
export REPLACE_EXISTING_PROJECT="${REPLACE_EXISTING_PROJECT}";
export REPLACE_EXISTING_PACKAGE="${REPLACE_EXISTING_PACKAGE}";
NSDATA

chown ${SUDOUSER}:${SUDOUSER} ~/.nsdata.sh;

}

function didNotGetUserData()
{

    echo -e "#####################################################################"
    echo -e "#   The rest of this script will fail without correct values for : "
    echo -e "#    - projects directory"
    echo -e "#    - project name"
    echo -e "#    - package name"
    echo -e "#    - github organization name"
    echo -e "#    - developer id"
    echo -e "#    - developer email."
    echo -e "#    - developer name"
    echo -e "#    - developer full name"
    echo -e "#   Please ensure you have entered these values correctly."
    echo -e "#####################################################################"
    exit 1;

}

function didNotGetNSData()
{

    echo -e "#####################################################################"
    echo -e "#   The rest of this script will fail without correct values for : "
    echo -e "#    - developer personal token"
    echo -e "#    - approve to delete and replace project '${PROJECT_NAME}'"
    echo -e "#    - approve to delete and replace package '${PKG_NAME}'"
    echo -e "#   Please ensure you have entered these values correctly."
    echo -e "#####################################################################"
    exit 1;

}

function getUserData()
{
  if [ -f ~/.udata.sh ]; then
    source ~/.udata.sh
  else
    export PARENT_DIR="";
    export PROJECT_NAME="";
    export PKG_NAME="";
    export GITHUB_ORGANIZATION_NAME="";
    export PACKAGE_DEVELOPER="";
    export YOUR_UID="";
    export YOUR_FULLNAME="";
    export YOUR_EMAIL="";
    export METEOR_UID="";
    export METEOR_PWD="";
  fi

  CHOICE="n"
  while [[ ! "X${CHOICE}X" == "XyX" ]]
  do

    echo -e "${FRAME// /\~}"
    echo "Projects folder in ${HOME} directory : ${PARENT_DIR}"
    echo "Project name : ${PROJECT_NAME}"
    echo "Package name : ${PKG_NAME}"
    echo "GitHub organization name : ${GITHUB_ORGANIZATION_NAME}"
    echo "GutHub user id: ${PACKAGE_DEVELOPER}"
    echo "GutHub user full name : ${YOUR_FULLNAME}"
    echo "Project owner local user id : ${YOUR_UID}"
    echo "Project owner email : ${YOUR_EMAIL}"
    echo "Meteor server user ID : ${METEOR_UID}"
    echo "Meteor server password : ${METEOR_PWD}"

    read -ep "Is this correct? (y/n/q) ::  " -n 1 -r USER_ANSWER
    CHOICE=$(echo ${USER_ANSWER:0:1} | tr '[:upper:]' '[:lower:]')
    if [[ "X${CHOICE}X" == "XqX" ]]; then
      echo skip out
      return 1;
    elif [[ ! "X${CHOICE}X" == "XyX" ]]; then

      echo -e "\n Please supply the following details :\n";
      read -p "Your directory for projects in the ${HOME} directory :  :: " -e -i "${PARENT_DIR}" INPUT
      if [ ! "X${INPUT}X" == "XX" ]; then PARENT_DIR=${INPUT}; fi;

      read -p "The exact project name for use in GitHub :: " -e -i "${PROJECT_NAME}" INPUT
      if [ ! "X${INPUT}X" == "XX" ]; then PROJECT_NAME=${INPUT}; fi;

      read -p "The exact package name for use in GitHub :: " -e -i "${PKG_NAME}" INPUT
      if [ ! "X${INPUT}X" == "XX" ]; then PKG_NAME=${INPUT}; fi;

      read -p "The exact name for the GitHub organization :: " -e -i "${GITHUB_ORGANIZATION_NAME}" INPUT
      if [ ! "X${INPUT}X" == "XX" ]; then GITHUB_ORGANIZATION_NAME=${INPUT}; fi;

      read -p "The project owner user id in GitHub :: " -e -i "${PACKAGE_DEVELOPER}" INPUT
      if [ ! "X${INPUT}X" == "XX" ]; then PACKAGE_DEVELOPER=${INPUT}; fi;

      read -p "The project owner name to use within the project :: " -e -i "${YOUR_UID}" INPUT
      if [ ! "X${INPUT}X" == "XX" ]; then YOUR_UID=${INPUT}; fi;

      read -p "The project owner full name to use to publish it in GitHub :: " -e -i "${YOUR_FULLNAME}" INPUT
      if [ ! "X${INPUT}X" == "XX" ]; then YOUR_FULLNAME=${INPUT}; fi;

      read -p "The email address for the project owner in GitHub :: " -e -i "${YOUR_EMAIL}" INPUT
      if [ ! "X${INPUT}X" == "XX" ]; then YOUR_EMAIL=${INPUT}; fi;

      read -p "Meteor account user name for Meteor deployment server :: " -e -i "${METEOR_UID}" INPUT
      if [ ! "X${INPUT}X" == "XX" ]; then METEOR_UID=${INPUT}; fi;

      read -p "Meteor account password for Meteor deployment server :: " -e -i "${METEOR_PWD}" INPUT
      if [ ! "X${INPUT}X" == "XX" ]; then METEOR_PWD=${INPUT}; fi;

    fi;
    echo "  "
  done;
  saveUserData;
  return;
}


function getNonStopData()
{
  if [ -f ~/.nsdata.sh ]; then
    source ~/.nsdata.sh
  else
    export GITHUB_PERSONAL_TOKEN="";
    export REPLACE_EXISTING_PROJECT="";
    export REPLACE_EXISTING_PACKAGE="";
  fi


  CHOICE="n"
  while [[ ! "X${CHOICE}X" == "XyX" ]]
  do

    echo -e "${FRAME// /\~}"
    echo "GitHub personal token : ${GITHUB_PERSONAL_TOKEN}";
    echo "You approve deleting and replacing project '${PROJECT_NAME}' : ${REPLACE_EXISTING_PROJECT}"
    echo "You approve deleting and replacing package '${PKG_NAME}' : ${REPLACE_EXISTING_PACKAGE}"

    read -ep "Is this correct? (y/n/q) ::  " -n 1 -r USER_ANSWER
    CHOICE=$(echo ${USER_ANSWER:0:1} | tr '[:upper:]' '[:lower:]')
    if [[ "X${CHOICE}X" == "XqX" ]]; then
      echo skip out
      return 1;
    elif [[ ! "X${CHOICE}X" == "XyX" ]]; then

      echo -e "\n Please supply the following details :\n";
      read -p "Your GitHub personal token :: " -e -i "${GITHUB_PERSONAL_TOKEN}" INPUT
      if [ ! "X${INPUT}X" == "XX" ]; then GITHUB_PERSONAL_TOKEN=${INPUT}; fi;

      read -p "Should the project '${PROJECT_NAME}' be COMPLETELY ERASED? (yes/no) :: " -e -i "${REPLACE_EXISTING_PROJECT}" INPUT
      if [ "X${INPUT}X" == "XyesX" ]; then REPLACE_EXISTING_PROJECT="yes"; else REPLACE_EXISTING_PROJECT="no"; fi;

      read -p "Should the package '${PKG_NAME}' be COMPLETELY ERASED? (yes/no) :: " -e -i "${REPLACE_EXISTING_PACKAGE}" INPUT
      if [ "X${INPUT}X" == "XyesX" ]; then REPLACE_EXISTING_PACKAGE="yes"; else REPLACE_EXISTING_PACKAGE="no"; fi;

    fi;
    echo "  "
  done;
  saveNonStopData;
  return;
}

function getRepo() {
  EXISTING_REPO=$(curl -sH "${AUTH}" ${GITHUB_SHTTP}/repos/${GITHUB_ORGANIZATION_NAME}/${REPO} | jq '.name';);
};

function dropRepo() {
  curl -sH "${AUTH}" -X DELETE ${GITHUB_SHTTP}/repos/${GITHUB_ORGANIZATION_NAME}/${REPO};
}

function makeRepo() {
  NEW_REPO=$(curl -sH "${AUTH}" \
       -X POST -d "{ \"name\": \"${REPO}\", \"auto_init\": true, \"private\": false, \"gitignore_template\": \"Meteor\" }" \
    ${GITHUB_SHTTP}/orgs/${GITHUB_ORGANIZATION_NAME}/repos);
}


function Create_GitHub_Repo_For_Org() {
  # echo "Token = ${GITHUB_PERSONAL_TOKEN}";
  # echo "Org = ${GITHUB_ORGANIZATION_NAME}";
  # echo " P1 = ${1}";
  # echo " P2 = ${2}";
  export AUTH="Authorization: token ${GITHUB_PERSONAL_TOKEN}";
  export REPO=${1};
  export EXISTING_REPO=;
  export NEW_REPO=;

  SWITCH=0;

  getRepo;
  echo "EXISTING_REPO = ${EXISTING_REPO}";

  if [ "${EXISTING_REPO}" == "\"${1}\"" ]; then
    SWITCH=$(($SWITCH+1));
  fi;
  if [ "${2}" == "yes" ]; then
    SWITCH=$(($SWITCH+2));
  fi;

#  echo "SWITCH=${SWITCH}";
  case ${SWITCH} in
  0)  echo "Repo '${1}' forbids overwrite but doesn't exist.";
      echo "Creating repo '${1}' now.";
      makeRepo;
    ;;
  1)  echo "Repo '${1}' forbids overwrite and does exist";
    ;;
  2)  echo "Repo '${1}' allows overwrite and doesn't exist";
      echo "Creating repo '${1}' now.";
      makeRepo;
    ;;
  3)  echo "Repo '${1}' allows overwrite and does exist";
      echo "Dropping and recreating repo '${1}' now.";
      dropRepo;
      makeRepo;
    ;;
  *) echo "impossible"
    ;;  esac

  getRepo;
  echo "Repo name is '${EXISTING_REPO}'";
  
}


function Make_GitHub_Repo_Deploy_Key_Title() {
  export REPO_DEPLOY_KEY_TITLE="github-${1}-${2}";
}


function Create_GitHub_Repo_Deploy_Keys() {

  export REPO_NAME=${1};
  export OVERWRITE=${2};
  SET_UP_SSH=true;

  mkdir -p ~/.ssh;
  chmod 700 ~/.ssh
  pushd  ~/.ssh  >/dev/null;

    eval `ssh-agent -s`;
    touch config;

    Make_GitHub_Repo_Deploy_Key_Title ${GITHUB_ORGANIZATION_NAME} ${REPO_NAME};
    echo "REPO_DEPLOY_KEY_TITLE - ${REPO_DEPLOY_KEY_TITLE}";

    if [[ "${OVERWRITE}" != "yes" ]]; then
      if [ -f ${REPO_DEPLOY_KEY_TITLE} ]; then SET_UP_SSH=false;  fi;
      if [ -f ${REPO_DEPLOY_KEY_TITLE}.pub ]; then SET_UP_SSH=false;  fi;
      if cat config | grep -c "Host ${REPO_DEPLOY_KEY_TITLE}"; then
        SET_UP_SSH=false;
      fi
    else
      rm -f ${REPO_DEPLOY_KEY_TITLE};
      rm -f ${REPO_DEPLOY_KEY_TITLE}.pub;
    fi;

    if [ ${SET_UP_SSH} == true ]; then
      echo "Creating deploy key for ${REPO_DEPLOY_KEY_TITLE}";
      ssh-keygen -t rsa -b 4096 -C "${REPO_DEPLOY_KEY_TITLE}" -N "" -f "${REPO_DEPLOY_KEY_TITLE}"

      if cat config | grep -c "Host ${REPO_DEPLOY_KEY_TITLE}"; then
        echo "git host alias '${REPO_DEPLOY_KEY_TITLE}' already present in $(pwd)/config";
      else
        echo "Appending git host alias '${REPO_DEPLOY_KEY_TITLE}' to $(pwd)/config";
        printf 'Host github-%s-%s\nHostName github.com\nUser git\nIdentityFile ~/.ssh/github-%s-%s\n\n' "${GITHUB_ORGANIZATION_NAME}" "${REPO_NAME}"  "${GITHUB_ORGANIZATION_NAME}" "${REPO_NAME}" >> config
      fi;
      # ls -la

      echo "Adding '${REPO_DEPLOY_KEY_TITLE}' to ssh agent";
      ssh-add ${REPO_DEPLOY_KEY_TITLE}
      ssh-add -l

    else
      echo -e "#########################################################################################"
      echo -e "#   Found deploy keys for ${REPO_DEPLOY_KEY_TITLE} already present.  Will NOT overwrite."
      echo -e "#   Please ensure you have a correctly configured SSH directory for use with GitHub."
      echo -e "#########################################################################################"
    fi

  popd >/dev/null;

}


function getRepoDeployKey() {

  # echo curl -sH "${AUTH}" ${GITHUB_SHTTP}/repos/${GITHUB_ORGANIZATION_NAME}/${REPO}/keys;
  KEYS_ARRAY=$(curl -sH "${AUTH}" \
    ${GITHUB_SHTTP}/repos/${GITHUB_ORGANIZATION_NAME}/${REPO}/keys);

  # echo "AUTH = ${AUTH}";
  # echo ${KEYS_ARRAY};
  if echo ${KEYS_ARRAY} | grep -c "Bad credentials"; then
    echo -e "GitHub responds :: \n ${KEYS_ARRAY}";
    exit;
  fi;

  if echo ${KEYS_ARRAY} | grep -c "Not Found"; then
    LIM=0;
  else
    LIM=$(echo ${KEYS_ARRAY} | jq ". | length";);
  fi;

  IDX=0;
  while [  ${IDX} -lt ${LIM}  ]; do
    EXISTING_REPO_DEPLOY_KEY_TITLE=$(echo ${KEYS_ARRAY} | jq ".[${IDX}].title");
    # echo "${EXISTING_REPO_DEPLOY_KEY_TITLE}   vs   ${REPO_DEPLOY_KEY_TITLE}";
    if [[ ${EXISTING_REPO_DEPLOY_KEY_TITLE} == "\"${REPO_DEPLOY_KEY_TITLE}\"" ]]; then
      EXISTING_REPO_DEPLOY_KEY_ID=$(echo ${KEYS_ARRAY} | jq ".[${IDX}].id";);
      let IDX=${LIM};
    fi;

    # echo "Key #$IDX is :: " ${EXISTING_REPO_DEPLOY_KEY_TITLE};
    let IDX=IDX+1;
  done
#  echo "Key #$IDX id is :: " ${EXISTING_REPO_DEPLOY_KEY_ID};

};

function dropRepoDeployKey() {
  curl -sH "${AUTH}" -X DELETE \
     ${GITHUB_SHTTP}/repos/${GITHUB_ORGANIZATION_NAME}/${REPO}/keys/${EXISTING_REPO_DEPLOY_KEY_ID};
}

function addRepoDeployKey() {
  
  REPOKEY=$(cat /home/${SUDOUSER}/.ssh/${REPO_DEPLOY_KEY_TITLE}.pub);
  RESP=$(curl -sH "${AUTH}" \
       -X POST -d "{ \"title\": \"${REPO_DEPLOY_KEY_TITLE}\", \"read_only\": false, \"key\": \"${REPOKEY}\" }" \
    ${GITHUB_SHTTP}/repos/${GITHUB_ORGANIZATION_NAME}/${REPO}/keys);
  EXISTING_REPO_DEPLOY_KEY_TITLE=$(echo -e "${RESP}" | jq ".title");
#y  echo -e "\nº\n${EXISTING_REPO_DEPLOY_KEY_TITLE}\nº\n";
}


function Add_GitHub_Repo_Deploy_Key() {
  # echo "Token = ${GITHUB_PERSONAL_TOKEN}";
  # # echo "Org = ${GITHUB_ORGANIZATION_NAME}";
  # echo " P1 = ${1}";
  # echo " P2 = ${2}";
  export AUTH="Authorization: token ${GITHUB_PERSONAL_TOKEN}";
  export REPO=${1};
  export EXISTING_REPO_DEPLOY_KEY_ID=;
  export EXISTING_REPO_DEPLOY_KEY_TITLE=;
  Make_GitHub_Repo_Deploy_Key_Title ${GITHUB_ORGANIZATION_NAME} ${REPO};

  SWITCH=0;

  getRepoDeployKey;
  echo "REPO_DEPLOY_KEY_TITLE = ${REPO_DEPLOY_KEY_TITLE}";
  echo "EXISTING_REPO_DEPLOY_KEY_TITLE = ${EXISTING_REPO_DEPLOY_KEY_TITLE}";
  echo "EXISTING_REPO_DEPLOY_KEY_ID = ${EXISTING_REPO_DEPLOY_KEY_ID}";


  if [ "${EXISTING_REPO_DEPLOY_KEY_TITLE}" == "\"${REPO_DEPLOY_KEY_TITLE}\"" ]; then
    SWITCH=$(($SWITCH+1));
  fi;
  if [ "${2}" == "yes" ]; then
    SWITCH=$(($SWITCH+2));
  fi;

  echo "SWITCH=${SWITCH}";
  case ${SWITCH} in
  0)  echo "Repo '${1}' forbids overwrite but deploy key doesn't exist.";
      echo "Creating deploy key for repo '${1}' now.";
      addRepoDeployKey;
    ;;
  1)  echo "Repo '${1}' forbids overwrite and deploy key does exist";
    ;;
  2)  echo "Repo '${1}' allows overwrite and deploy key doesn't exist";
      echo "Creating deploy key for repo '${1}' now.";
      addRepoDeployKey;
    ;;
  3)  echo "Repo '${1}' allows overwrite and deploy key does exist";
      echo "Dropping and recreating deploy key for repo '${1}' now.";
      dropRepoDeployKey;
      addRepoDeployKey;
    ;;
  *) echo "impossible"
    ;;  esac

  getRepo;
  echo "Repo deploy key name is '${EXISTING_REPO_DEPLOY_KEY_TITLE}'";
  
}

function pushPseudoStash() {

  export PSTSH="../pseudo_stash";
  mkdir -p "${PSTSH}";
  
  mv README.md "${PSTSH}";
  mv .gitignore "${PSTSH}";

}

function popPseudoStash() {
  
  mv "${PSTSH}"/README.md .;
  mv "${PSTSH}"/.gitignore .;

}

function prepareKnownHost() {

  declare HOST=${1};

  echo -e "Collecting GitHub public keys for 'known-hosts'";
  mkdir -p ~/.ssh;
  touch ~/.ssh/known_hosts;

  ssh-keygen -R ${HOST};
  ssh-keyscan -H -t rsa ${HOST} >> ~/.ssh/known_hosts;

  IPADDR=$(host ${HOST}  | awk '/has address/ { print $4 }')

  ssh-keygen -R ${IPADDR};
  ssh-keyscan -H -t rsa ${IPADDR} >> ~/.ssh/known_hosts;

  printf "\nDeploy key is : %s\n" "$(ssh-keygen -lf ~/.ssh/github-${GITHUB_ORGANIZATION_NAME}-${PROJECT_NAME}.pub)";

}


function checkNotRoot() {
  if [[ $EUID -eq 0 ]]; then
    echo -e "This script SHOULD NOT be run with 'sudo' (as root). ";
    exit 1;
  fi;
}

export CPU_WIDTH=;
function checkForVirtualMachine() {
  echo -e "Analyzing environment . . .";

  CPU_WIDTH=$(lshw -class cpu 2>/dev/null | grep width | sed 's/  //g' | cut -d' ' -f3);

  VIRTUAL=false;

  MSG="Found a '%s' virtual machine.\n";

  if [[ -d /proc/vz ]]; then
    if [[ -f /proc/vz/veinfo ]]; then
      printf "${MSG}" "Virtuozzo"; VIRTUAL=true;
    fi;
  fi;

  DMESG_CHK=$(dmesg | grep -i virtual);
  if [[ 0 < $(echo "${DMESG_CHK}" | grep -c drive) ]]; then  printf "${MSG}" "Microsoft VirtualPC"; VIRTUAL=true; fi;
  if [[ 0 < $(dmesg | grep -i xen) ]]; then  printf "${MSG}" "Xen"; VIRTUAL=true; fi;
  if [[ 0 < $(echo "${DMESG_CHK}" | grep -c QEMU) ]]; then  printf "${MSG}" "QEMU"; VIRTUAL=true; fi;
  if [[ 0 < $(echo "${DMESG_CHK}" | grep -c KVM) ]]; then  printf "${MSG}" "KVM"; VIRTUAL=true; fi;

  # if [[ 0 < $(echo "${DMESG_CHK}" | grep -c drive) ]]; then  printf "${MSG}" "Microsoft VirtualPC"; return 0; fi;
  # if [[ 0 < $(dmesg | grep -i xen) ]]; then  printf "${MSG}" "Xen"; return 0; fi;
  # if [[ 0 < $(echo "${DMESG_CHK}" | grep -c QEMU) ]]; then  printf "${MSG}" "QEMU"; return 0; fi;
  # if [[ 0 < $(echo "${DMESG_CHK}" | grep -c KVM) ]]; then  printf "${MSG}" "KVM"; return 0; fi;

  if [[ ${VIRTUAL} -eq true ]]; then
    echo "CPU type : ${CPU_WIDTH}-bit";
  else
    echo " **PLEASE PLEASE PLEASE**";
    echo " Only run these scripts on a Virtual Machine running Ubuntu 12.04LTS or newer";
    echo " ";
    echo " I have made no attempt to validate the script in other environments,";
    echo " so failure and damage are the likely result if you do not respect this warning.";
    echo " ";
    echo " ";

    exit 1;

  fi;

}


declare -a TUTORIAL_SECTIONS=();
function collectSectionNames() {
  
  IDX=0;
  for filename in ./Tutorial*.sh; do

    TUTORIAL_SECTION=$(echo ${filename} | sed 's/.\/Tutorial//g' | sed 's/_/|/g' | sed 's/.sh/|/g');
    arrIN=(${TUTORIAL_SECTION//|/ });
    TUTORIAL_SECTIONS+=(${arrIN[1]});
    # echo "${IDX} : ${arrIN[1]}";
    IDX=$((${IDX}+1));
    
  done

}


function setSection() {
  IDX=$((${1}-1));
  export SECTION_NUM="${1}";
  export SECTION=${TUTORIAL_SECTIONS[${IDX}]};
  export NEXT_SECTION_NUM=$((${1}+1));
  export NEXT_SECTION=${TUTORIAL_SECTIONS[${1}]};
  printf -v BINDIR "./Tutorial%02d_%s" ${SECTION_NUM} "${SECTION}";
#  echo ${NEXT_SECTION_NUM} ${NEXT_SECTION};
  printf -v NEXTBINDIR "./Tutorial%02d_%s" ${NEXT_SECTION_NUM} "${NEXT_SECTION}";
}

export INTRO="/*
 * DO NOT EDIT - This file is generated by 
 * execution of concatenateTheSlides.sh
 */
var sections = {
";
export NAME_TUTORIAL_SECTIONS_FILE="./scripts/tutorial_sections.js";
function makeJavaScriptSectionList() {
  printf "${INTRO}" > ${NAME_TUTORIAL_SECTIONS_FILE};
  
  AA=65; IDX=0; ASC=$(($IDX+${AA})); SEP=" ";
  while [ ${IDX} -lt ${#TUTORIAL_SECTIONS[@]} ]
  do
    printf "  %s \\$(printf '%03o' "$ASC"): \"Tutorial%02d_%s\"\n" "${SEP}" "$(($IDX+1))" "${TUTORIAL_SECTIONS[${IDX}]}" >> ${NAME_TUTORIAL_SECTIONS_FILE};
    IDX=$(($IDX+1));
    ASC=$(($IDX+${AA}));
    SEP=",";
  done;

  printf "};\n" >> ${NAME_TUTORIAL_SECTIONS_FILE};
}

function endOfSectionScript() {

  printf "\n\n\n  Done! You have finished part #%d, '%s', of the tutorial.\n
             Are you ready to begin part #%d, '%s'.?
               If so, hit [y]es, or <Enter>.
               If NOT then hit [n]o or <ctrl-c>.\n\n" \
          ${1} ${2} $(($1+1)) ${3}
  printf -v NEWSCRIPT "Tutorial%02d_%s.sh" $(($1+1)) ${3}
  read -p "  'y' or 'n' ::  " -n 1 -r USER_ANSWER
  CHOICE=$(echo ${USER_ANSWER:0:1} | tr '[:upper:]' '[:lower:]')
  if [[ "X${CHOICE}X" == "XyX"  || "X${CHOICE}X" == "XX" ]]; then
    echo -e "\n\nStarting Part #${SECTNUM}.";
    bash ./${NEWSCRIPT};
  fi;

}


PROJECT_NAME="  ** NOT DEFINED ** ";
if [ -f ~/.udata.sh ]; then
  source ~/.udata.sh
  echo "Project name : '${PROJECT_NAME}'"
fi

if [ -f ~/.nsdata.sh ]; then
  source ~/.nsdata.sh;
fi

#############################

