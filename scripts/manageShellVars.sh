#!/bin/bash

USER_VARS_FILE_NAME="${HOME}/.userVars.sh";

source ./scripts/shellVars.sh;

function loadShellVars() {

  if [ -f ${USER_VARS_FILE_NAME} ]; then
    source ${USER_VARS_FILE_NAME}
  else

    for varkey in "${!SHELLVARNAMES[@]}"; do
      X=${SHELLVARNAMES[$varkey]};
      SHELLVARS["${X},VAL"]=${!X};
      eval "export ${SHELLVARNAMES[$varkey]}='${SHELLVARS[${SHELLVARNAMES[$varkey]},VAL]}'";
    done

  fi

  # echo "From source ... ";
  # echo "PROJECT_NAME = ${PROJECT_NAME}";
  # echo "PKG_NAME = ${PKG_NAME}";
  # echo -e "GITHUB_ORGANIZATION_NAME = ${GITHUB_ORGANIZATION_NAME}\n";

}

function saveShellVars()
{

  echo -e "Saving shell variables to $1";
  echo -e "#/bin/bash\n#  You can edit this, but it may be altered progrmmatically." > $1;
  for varkey in "${!SHELLVARNAMES[@]}"; do
    X=${SHELLVARNAMES[$varkey]};
    eval "echo \"export ${X}='${!X}';\"  >> $1;";
  done

  chown ${SUDOUSER}:${SUDOUSER} ${USER_VARS_FILE_NAME};

}


function askUserForParameters()
{

  declare -a VARS_TO_UPDATE=("${!1}");

  CHOICE="n";
  while [[ ! "X${CHOICE}X" == "XyX" ]]
  do
    ii=1;
    for varkey in "${VARS_TO_UPDATE[@]}"; do
      eval  "printf \"\n%+5s  %s\" $ii \"${SHELLVARS[${varkey},SHORT]}\"";
#      eval   "echo $ii/. -- ${SHELLVARS[${varkey},SHORT]}";
      ((ii++));
    done;

    echo -e "\n\n";

    read -ep "Is this correct? (y/n/q) ::  " -n 1 -r USER_ANSWER
    CHOICE=$(echo ${USER_ANSWER:0:1} | tr '[:upper:]' '[:lower:]')
    if [[ "X${CHOICE}X" == "XqX" ]]; then
      echo "Skipping this operation."; return 1;
    elif [[ ! "X${CHOICE}X" == "XyX" ]]; then

      for varkey in "${VARS_TO_UPDATE[@]}"; do
        read -p "${SHELLVARS[${varkey},LONG]}" -e -i "${!varkey}" INPUT
        if [ ! "X${INPUT}X" == "XX" ]; then eval "${varkey}=\"${INPUT}\""; fi;
      done;

    fi;
    echo "  "
  done;

  saveShellVars ${USER_VARS_FILE_NAME};
  return;

};


# loadShellVars;

# PARM_NAMES=("PKG_NAME" "GITHUB_ORGANIZATION_NAME");
# askUserForParameters PARM_NAMES[@];
# exit;
# echo -e "
# From SHELLVARS ...";
# echo "PARENT_DIR = ${PARENT_DIR}";
# echo "METEOR_PWD = ${METEOR_PWD}";
# echo "YOUR_FULLNAME = ${YOUR_FULLNAME}";
# echo "FLOOZIE = ${FLOOZIE}";
# # for varkey in "${!SHELLVARS[@]}"; do
# #   echo ${SHELLVARS[$varkey]};
# # done

# # eval "export VVV='hhh';";
# # echo $VVV;
# echo -e "------


# ";
# exit;

