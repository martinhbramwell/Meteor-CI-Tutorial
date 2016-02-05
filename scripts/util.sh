#!/bin/bash
#

declare NONSTOP="nonstop";

export TMP_DIRECTORY="${HOME}/tmp";
mkdir -p ${TMP_DIRECTORY};

export SUDOUSER=$(who am i | awk '{print $1}');
export GITHUB_SHTTP="https://api.github.com";

export ANDROID_PLACE="${HOME}/.android";
export ANDROID_SDK="android-sdk-linux";
export ANDROID_HOME="${ANDROID_PLACE}/${ANDROID_SDK}";
export ENV_FILE="${HOME}/.profile";

export KEYSTORE_PATH="${HOME}/.meteorci-tutorial-keystore";
export ZIPALIGN_PATH="${ANDROID_HOME}/build-tools/23.0.1";
export ALIGNMENT=4

export green='\e[0;32m'
export flashingRed='\e[5;31m'
export endColor='\e[0m';

export TUTORIAL_REPO="https://raw.githubusercontent.com/martinhbramwell/Meteor-CI-Tutorial";
export TUTORIAL_FRAGMENTS="${TUTORIAL_REPO}/master/fragments";

function verifyFreeSpace() {
  MINFREESPACE=7000000;
  # FREESPACE=$(df / | grep dev | awk '{print $4}');

  pushd ${HOME} >/dev/null;
    FREESPACE=$(df -k .  | grep -v Available  | awk '{print $4}');
  popd >/dev/null;


  CHOICE="n";
  while [[ ! "X${CHOICE}X" == "XyX" ]]
  do

    if [[  ${FREESPACE} -lt ${MINFREESPACE} ]]; then
      echo -e "
      You have only ${FREESPACE} bytes free.  You should have ${MINFREESPACE}.
      Hit 'y' to continue, 'r' to retry or 'q' to quit.
      ";
      read -ep "Have you cleared enough space? (y/r/q) ::  " -n 1 -r USER_ANSWER
      CHOICE=$(echo ${USER_ANSWER:0:1} | tr '[:upper:]' '[:lower:]')
      if [[ "X${CHOICE}X" == "XqX" ]]; then
        echo "Continuing . . . "
        return 1;
      elif [[ ! "X${CHOICE}X" == "XrX" ]]; then
        FREESPACE=$(df / | grep dev | awk '{print $4}');
      fi;
    else
      CHOICE="y";
    fi;

  done;
}


function installToolsForTheseScripts() {

  INST=();

  pushd ${HOME} >/dev/null;
    sudo apt-get -y update;
  popd >/dev/null;

  X="gawk"; if aptNotYetInstalled "${X}"; then INST=("${INST[@]}" "${X}"); else echo "${X} is installed"; fi;
  X="git"; if aptNotYetInstalled "${X}"; then INST=("${INST[@]}" "${X}"); else echo "${X} is installed"; fi;
  X="python-pygments"; if aptNotYetInstalled "${X}"; then INST=("${INST[@]}" "${X}"); else echo "${X} is installed"; fi;
  X="gettext"; if aptNotYetInstalled "${X}"; then INST=("${INST[@]}" "${X}"); else echo "${X} is installed"; fi;
  X="jq"; if aptNotYetInstalled "${X}"; then INST=("${INST[@]}" "${X}"); else echo "${X} is installed"; fi;
  X="virt-what"; if aptNotYetInstalled "${X}"; then INST=("${INST[@]}" "${X}"); else echo "${X} is installed"; fi;

  echo "${#INST[@]} packages not installed.";
  if [[ ${#INST[@]} -lt 1 ]]; then return 0; fi;

  printf  "
          The first step requires installing some missing tools that
        make these explanations more readable.  These are :  ";
  echo "";
  for var in "${INST[@]}";
  do
    echo "          - ${var}";
  done;
  echo "";

  read -p "  'q' or <enter> ::  " -n 1 -r USER_ANSWER;

  CHOICE=$(echo ${USER_ANSWER:0:1} | tr '[:upper:]' '[:lower:]');
  RUN_RULE=${CHOICE};
  if [ "X${CHOICE}X" == "XqX" ]; then echo ""; exit 0; fi;

  # Make sure we atart off with the right version of awk.
  X="git"; if aptNotYetInstalled "${X}"; then
    sudo apt-get -y install "${X}";
  fi;

  if aptNotYetInstalled gawk; then
    sudo apt-get -y install gawk;
    sudo update-alternatives --set awk /usr/bin/gawk;
  fi;

  # These scripts also need "Pygmentize" to colorize text
  # and "jq" to parse JSON
  X="python-pygments"; if aptNotYetInstalled "${X}"; then
    sudo apt-get -y install "${X}";
  fi;

  X="jq"; if aptNotYetInstalled "${X}"; then
    sudo apt-get -y install "${X}";
  fi;

}

function Install_other_tools() {

  X="build-essential";             # for selenium webdriver
  if aptNotYetInstalled "${X}"; then
    sudo apt-get -y install "${X}";
  fi;

  X="libssl-dev";                  # for selenium webdriver
  if aptNotYetInstalled "${X}"; then
    sudo apt-get -y install "${X}";
  fi;

  X="libappindicator1";            # for chrome
  if aptNotYetInstalled "${X}"; then
    sudo apt-get -y install "${X}";
  fi;

  X="curl";                        # for Meteor
  if aptNotYetInstalled "${X}"; then
    sudo apt-get -y install "${X}";
  fi;

  X="ssh";                         # for version control
  if aptNotYetInstalled "${X}"; then
    sudo apt-get -y install "${X}";
  fi;

  X="tree";                        # for demo convenience
  if aptNotYetInstalled "${X}"; then
    sudo apt-get -y install "${X}";
  fi;

  X="expect";                        # for demo convenience
  if aptNotYetInstalled "${X}"; then
    sudo apt-get -y install "${X}";
  fi;

  X="python-pip";                  # for demo convenience
  if aptNotYetInstalled "${X}"; then
    sudo apt-get -y install "${X}";
  fi;


}

function Configure_git_for_GitHub() {

  # echo -e "#    -- Configuring git -- "

  git config --global user.email "${YOUR_EMAIL}"
  git config --global user.name "${YOUR_FULLNAME}"
  git config --global push.default simple

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

  # echo -e "\n  $1  $2";
  # npm list $2 $1;
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
  EXISTING_METEOR_PIDS=$(ps aux | grep meteor  | grep -v grep | grep ~/.meteor/packages | awk '{print $2}');
#  echo ">${IFS}<  ${EXISTING_METEOR_PIDS} ";
  for pid in ${EXISTING_METEOR_PIDS}; do
    echo "Kill Meteor process : >> ${pid} <<";
    kill -9 ${pid};
  done;
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


function Create_GitHub_Repo() {
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
  if [[ "${EXISTING_REPO}" == "null" ]]; then
    echo -e "

       Failed to create repo. ('${EXISTING_REPO}'), for project '${1}'!
       GitHub personal token is '${GITHUB_PERSONAL_TOKEN:0:4} ....... ${GITHUB_PERSONAL_TOKEN:36:39}'.
       ";
    exit 1;
  fi;
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

  CPU_WIDTH=$(lshw -class cpu 2>/dev/null | grep width | sed 's/^[ \t]*//' | cut -d' ' -f2);
  CPU_MSG="CPU type : ${CPU_WIDTH}-bit";

  if [[ 0 < $(grep -c docker /proc/1/cgroup) ]]; then
    echo "Running in a Docker container. ${CPU_MSG}";
   else
    VMTST=$(sudo virt-what);
    if [[ "X${VMTST}X" == "XX" ]]; then

      echo " **PLEASE PLEASE PLEASE**";
      echo " Only run these scripts on a Virtual Machine running Ubuntu 12.04LTS or newer";
      echo " ";
      echo " I have made no attempt to validate the script in other environments,";
      echo " so failure and damage are the likely result if you do not respect this warning.";
      echo " ";
      echo " ";

      exit 1;

    else

      echo "Running in a ${VMTST} virtual machine. ${CPU_MSG}";

    fi;
  fi;

}


declare -a TUTORIAL_SECTIONS=();
function collectSectionNames() {

  IDX=0;
  for filename in ./Tutorial*.sh; do

    TUTORIAL_SECTION=$(echo ${filename} | sed 's/.\/Tutorial//g' | sed 's/_/|/g' | sed 's/.sh/|/g');
    arrIN=(${TUTORIAL_SECTION//|/ });
    TUTORIAL_SECTIONS+=(${arrIN[1]});
#    echo "${IDX} : ${arrIN[1]}";
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


loadShellVars;   # Try to load shell variables

# PROJECT_NAME="  ** NOT DEFINED ** ";
# if [ -f ~/.userVars.sh ]; then
#   source ~/.userVars.sh;
#   echo "Project name : '${PROJECT_NAME}'";
# else
#   echo "Don't have '~/.userVars.sh'";
#   exit;
# fi

export BUILD_DIRECTORY="${HOME}/${PARENT_DIR}/${PROJECT_NAME}";
export PROJECT_URI="${PROJECT_NAME}-${GITHUB_ORGANIZATION_NAME}.meteor.com";
export TARGET_SERVER_URL="https://${PROJECT_URI}/";


#############################

