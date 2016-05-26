#!/bin/bash
#
export MODULES=~/${PARENT_DIR}/modules;
export MODULE_DIRS=${MODULES}/thirdparty:${MODULES}/${YOUR_UID}

function Create_a_module_A() {

  mkdir -p ${MODULES}/${YOUR_UID};
  mkdir -p ${MODULES}/thirdparty;
  echo "export PARENT_DIR=\"${PARENT_DIR}\"";
  echo "export MODULES=\"${MODULES}\"";
  echo "export MODULE_DIRS=\"${MODULE_DIRS}\"";

  while [[ $(grep -c MODULE_DIRS ~/.profile) -gt 0 ]]; do
    sed -i '/MODULE_DIRS/d' ~/.profile;
  done;

#  HAS_MODULE_DIRS=$(grep MODULE_DIRS ~/.profile | grep -c ${MODULES} ~/.profile) || echo -e "\nConfiguring MODULE_DIRS as '${MODULE_DIRS}'.";
  echo -e "\n#\nexport MODULE_DIRS=${MODULE_DIRS};" >> ~/.profile;

  source ~/.profile;

}


declare EXPORT_NAME="${MODULE_NAME}Log";
function Create_a_module_B() {

  pushd ${MODULES}/${YOUR_UID} >/dev/null;

  CREATE_MODULE=true;
  if [[ -d ${MODULE_NAME}
     && -f ${MODULE_NAME}/package.json
     &&    $(grep -c "name.*${MODULE_NAME}" ${MODULE_NAME}/package.json ) -gt 0 ]]; then

    if [[  "XX${REPLACE_EXISTING_MODULE}XX" == "XXXX"  ]]; then

      echo "";
      echo "";
      echo "The module, '${MODULE_NAME}', was created earlier.
              You can delete it and [r]ecreate it OR [s]kip this step."
      read -p "  'r' or 's' ::  " -n 1 -r USER_ANSWER
      CHOICE=$(echo ${USER_ANSWER:0:1} | tr '[:upper:]' '[:lower:]')
      if [[ "X${CHOICE}X" == "XsX" ]]; then
        CREATE_MODULE=false;
      else
        echo "";
        echo "Deleting old ${MODULE_NAME}. . . ";
        rm -fr ${MODULE_NAME}
      fi;
      echo ""

    elif [[  "${REPLACE_EXISTING_MODULE=}" == "yes"  ]]; then
      echo "";
      echo "Deleting old ${MODULE_NAME}. . . ";
      rm -fr ${MODULE_NAME}
    else
      CREATE_MODULE=false;
    fi;

  fi;

  if [[ ${CREATE_MODULE} ]]; then
    echo "Making package.json";
    mkdir ${MODULE_NAME};
    pushd ${MODULE_NAME};
    cat << PKGJSN > package.json
{
  "name": "${MODULE_NAME}",
  "version": "0.0.1",
  "description": "describe your module here",
  "main": "index.js",
  "scripts": {
    "test": "test"
  },
  "repository": {
    "type": "git",
    "url": "git@github.com:${GITHUB_ORGANIZATION_NAME}/${MODULE_NAME}.git"
  },
  "author": "${YOUR_FULLNAME}",
  "license": "MIT",
  "bugs": {
    "url": "https://github.com/${GITHUB_ORGANIZATION_NAME}/${MODULE_NAME}/issues"
  },
  "homepage": "http://${GITHUB_ORGANIZATION_NAME}.github.io/${MODULE_NAME}"
}
PKGJSN

    cat << IDXJS > index.js
// ${MODULE_NAME}/index.js
exports.${EXPORT_NAME} = function() {
  console.log("logged from module '${MODULE_NAME}'" );
};
IDXJS

    cat << MDRDMD > README.md
# This is an example Meteor 1.3 module.  You should describe it here . . . 
MDRDMD

    cat << MDGITIG > .gitignore
example_circle.yml
node_modules
MDGITIG

# echo "SCRIPT_DIR  -- ${SCRIPT_DIR}";
    cp ${SCRIPT_DIR}/../LICENSE .;

    popd >/dev/null;
  fi

  popd >/dev/null;

}


function Create_a_module_C() {

  echo -e "Building new module directory \n\n";
  pushd ~/${PARENT_DIR}/${PROJECT_NAME} >/dev/null;

    mkdir -p ./node_modules;
    echo -e "Linking to new module \n\n";

    meteor npm link ${MODULES}/${YOUR_UID}/${MODULE_NAME};

    MAIN_FILE="./client/main.js";
    declare CNT=$(grep -c 'mdlirbl02' ${MAIN_FILE});
    if [[ ${CNT} -lt 1 ]]; then
      declare MTCH="import './main.html';";
      declare  ADD="import { ${EXPORT_NAME} } from '${MODULE_NAME}';";
      sed -i -e "s|${MTCH}|${MTCH}\n${ADD}|g" ${MAIN_FILE};
      declare MTCH="    // increment the counter when button is clicked";
      declare  ADD="    ${EXPORT_NAME}(); // > logged from module '${MODULE_NAME}'";
      sed -i -e "s|${MTCH}|${MTCH}\n${ADD}|g" ${MAIN_FILE};
    fi;

  popd >/dev/null;

}

function Create_GitHub_Repo_Deploy_Keys_for_Module() {
  Create_GitHub_Repo_Deploy_Keys ${MODULE_NAME} ${REPLACE_EXISTING_PROJECT};
}

function Create_GitHub_Repo_For_Module() {
  Create_GitHub_Repo ${MODULE_NAME} ${REPLACE_EXISTING_PROJECT};
}


function Add_GitHub_Repo_Deploy_Key_For_Module() {
  Add_GitHub_Repo_Deploy_Key ${MODULE_NAME} ${REPLACE_EXISTING_PROJECT};
}



function Control_a_modules_versions_A() {

  export RMT_REPO="https://github.com/${GITHUB_ORGANIZATION_NAME}/${MODULE_NAME}";
  set +e;   wget -q --spider ${RMT_REPO}; EXISTS=$?;    set -e;

  until [[ ${EXISTS} -eq 0 ]]
  do
    echo "Can find no GitHub repo at '${RMT_REPO}'"
    read -p "  Hit enter when one has been created : " -n 1 -r YRMDLRDY
    echo ""
    set +e;   wget -q --spider ${RMT_REPO}; EXISTS=$?;    set -e;

  done

  Make_GitHub_Repo_Deploy_Key_Title ${GITHUB_ORGANIZATION_NAME} ${MODULE_NAME};

  echo -e "Go to the 'Deploy Key' configuration page for the GitHub repo at : ";
  echo -e "\n    https://github.com/${GITHUB_ORGANIZATION_NAME}/${MODULE_NAME}/settings/keys";
  echo -e "\nThen click the [Add deploy key] button and fill in the fields as follows : \n";
  echo -e " - Title -- fill with :      ${REPO_DEPLOY_KEY_TITLE} \n";
  echo -e " - Key -- fill with :      $(cat ~/.ssh/${REPO_DEPLOY_KEY_TITLE}.pub) \n";
  echo -e " - Allow write access -- checked";

}


function Control_a_modules_versions_B_nonstop() {
  Control_a_modules_versions_B "${NONSTOP}";
}


function Control_a_modules_versions_B() {

  declare DATA_TO_FETCH=false;
  if [[  "${1}" == "${NONSTOP}"  ]]; then DATA_TO_FETCH=true; fi;

  prepareKnownHost "github.com";

  pushd ${MODULES}/${YOUR_UID}/${MODULE_NAME} >/dev/null;

    cat << GITIG > .gitignore
.npm
backup
docs
GITIG

  # mkdir -p ~/.ssh;
  # chmod 700 ~/.ssh;
  # if test -f ~/.ssh/id_rsa; then chmod 600 ~/.ssh/id_rsa; fi;

  # set +e;   ssh-add;   set -e;

  ${DATA_TO_FETCH} && pushPseudoStash  && echo -e "\nStashed";

  echo -e "Initializing 'git'";
  git init;

  if [[ $(git remote) = ${MODULE_NAME}_origin ]];
  then
    echo -e "Remote, named ${MODULE_NAME}_origin has already been defined for repo ${GITHUB_ORGANIZATION_NAME}/${MODULE_NAME}.git";
  else
    echo -e "Defining remote, named ${MODULE_NAME}_origin for repo ${GITHUB_ORGANIZATION_NAME}/${MODULE_NAME}.git";
    git remote add ${MODULE_NAME}_origin git@github-${GITHUB_ORGANIZATION_NAME}-${MODULE_NAME}:${GITHUB_ORGANIZATION_NAME}/${MODULE_NAME}.git;
  fi;

  ${DATA_TO_FETCH} && {
    git fetch ${MODULE_NAME}_origin && echo -e "\nFetched";
#    BRNCH=$(git branch); BRNCH="${BRNCH#* }";  # When hand built, master does not yet exist, so we can't specify it in the pull
    git pull ${MODULE_NAME}_origin master && echo -e "\nPulled";
    popPseudoStash && echo -e "\nDestashed";
  }

  set +e;
  git add .;
  git commit -am 'First commit' && echo -e "\nCommitted";
  set -e;

  eval "$(ssh-agent -s)";

  git push -u ${MODULE_NAME}_origin master && echo -e "\nPushed";

  popd >/dev/null;

}


function TinyTest_a_module() {

  pushd ~/${PARENT_DIR}/${PROJECT_NAME} >/dev/null;

  killMeteorProcess
  meteor test-modules &

  tree

  echo -e "#########################################################################################"
  echo -e "#   Meteor Module Testing is now starting up as a background process."
  echo -e "#   In a browser, please open the URL -- http://localhost:${METEOR_PORT}/ --"
  echo -e "#    to confirm that it is working."
  echo -e "#    "
  echo -e "#   Above, you can see the files that were created."
  echo -e "#    "
  echo -e "#########################################################################################"
  echo -e "Hit <enter> after you have confirmed that Meteor ran successful tests ::  "
  read -n 1 -r USER_ANSWER

  kill -9 $(jobs -p)
  killMeteorProcess

  popd >/dev/null;
}


function Add_a_test_runner_for_getting_TinyTest_output_on_the_command_line_nonstop() {
  Add_a_test_runner_for_getting_TinyTest_output_on_the_command_line ${NONSTOP};
}


function Add_a_test_runner_for_getting_TinyTest_output_on_the_command_line() {

  pushd ~/${PARENT_DIR} >/dev/null;
  pushd ${PROJECT_NAME} >/dev/null;

  killMeteorProcess

#  wget https://raw.githubusercontent.com/warehouseman/meteor-tinytest-runner/7a2bd1916eea40406d3959d55ed465f891c33dcf/meteor-tinytest-runner.bin
  wget https://raw.githubusercontent.com/warehouseman/meteor-tinytest-runner/master/meteor-tinytest-runner.bin
  chmod ug+x meteor-tinytest-runner.bin
  ./meteor-tinytest-runner.bin

  # cat ./tests/tinyTests/ci/installSeleniumWebDriver.sh;

  chmod a+rx ./tests/tinyTests/*.sh
  ./tests/tinyTests/test-all.sh

  if [[  "${1}" != "${NONSTOP}"  ]]; then

    echo -e "#########################################################################################"
    echo -e "#   Above you should see lines like :"
    echo -e "#   [INFO] http://127.0.0.1:4096/modules/test-in-console.js?59dde1f. . . 07b3f499 75:17 S: tinytest - example "
    echo -e "#    "
    echo -e "#   and below, after you hit <enter>, you should see the new list of project files. "
    echo -e "#    "
    echo -e "#########################################################################################"
    echo -e "Hit <enter> after you have confirmed that Meteor ran successful tests ::  "
    read -n 1 -r USER_ANSWER
    tree

  fi;

  killMeteorProcess

  popd >/dev/null;
  popd >/dev/null;

}
