export PACKAGES=~/${PARENT_DIR}/packages;
export PACKAGE_DIRS=${PACKAGES}/thirdparty:${PACKAGES}/${YOUR_UID}

function Create_a_package_A() {

  mkdir -p ${PACKAGES}/${YOUR_UID};
  mkdir -p ${PACKAGES}/thirdparty;
  echo "export PARENT_DIR=\"${PARENT_DIR}\"";
  echo "export PACKAGES=\"${PACKAGES}\"";
  echo "export PACKAGE_DIRS=\"${PACKAGE_DIRS}\"";

  while [[ $(grep -c PACKAGE_DIRS ~/.profile) -gt 0 ]]; do
    sed -i '/PACKAGE_DIRS/d' ~/.profile;
  done;

#  HAS_PACKAGE_DIRS=$(grep PACKAGE_DIRS ~/.profile | grep -c ${PACKAGES} ~/.profile) || echo -e "\nConfiguring PACKAGE_DIRS as '${PACKAGE_DIRS}'.";
  echo -e "\n#\nexport PACKAGE_DIRS=${PACKAGE_DIRS};" >> ~/.profile;

  source ~/.profile;

}


function Create_a_package_B() {

  pushd ${PACKAGES}/${YOUR_UID} >/dev/null;

  CREATE_PACKAGE=true;
  if [[ -d ${PKG_NAME}
     && -f ${PKG_NAME}/package.js
     &&    $(grep -c "name.*${GITHUB_ORGANIZATION_NAME}:${PKG_NAME}" ${PKG_NAME}/package.js ) -gt 0 ]]; then

    if [[  "XX${REPLACE_EXISTING_PACKAGE}XX" == "XXXX"  ]]; then

      echo "";
      echo "";
      echo "The package, '${GITHUB_ORGANIZATION_NAME}:${PKG_NAME}', was created earlier.
              You can delete it and [r]ecreate it OR [s]kip this step."
      read -p "  'r' or 's' ::  " -n 1 -r USER_ANSWER
      CHOICE=$(echo ${USER_ANSWER:0:1} | tr '[:upper:]' '[:lower:]')
      if [[ "X${CHOICE}X" == "XsX" ]]; then
        CREATE_PACKAGE=false;
      else
        echo "";
        echo "Deleting old ${PKG_NAME}. . . ";
        rm -fr ${PKG_NAME}
      fi;
      echo ""

    elif [[  "${REPLACE_EXISTING_PACKAGE=}" == "yes"  ]]; then
      echo "";
      echo "Deleting old ${PKG_NAME}. . . ";
      rm -fr ${PKG_NAME}
    else
      CREATE_PACKAGE=false;
    fi;

  fi;

  ${CREATE_PACKAGE} && meteor create --package "${GITHUB_ORGANIZATION_NAME}:${PKG_NAME}";

  sed -i "/api\.use('.*${PKG_NAME}/d" ${PKG_NAME}/package.js

  popd >/dev/null;

  pushd ~/${PARENT_DIR}/${PROJECT_NAME} >/dev/null;

  echo -e "Reviewing installed packages . . . ( slow! give us a minute ) \n\n"

  INSTALL_PACKAGE=true;
  meteor list > pkgs.txt;
  echo -e "Currently installed packages :"
  cat pkgs.txt
  if [[ $(cat pkgs.txt | grep -c "${GITHUB_ORGANIZATION_NAME}:${PKG_NAME}") -gt 0 ]]; then

    if [[  "XX${REPLACE_EXISTING_PACKAGE}XX" == "XXXX"  ]]; then

      echo "";
      echo "";
      echo "The package, '${GITHUB_ORGANIZATION_NAME}:${PKG_NAME}', was installed earlier.
              You can remove it and [r]einstall it OR [s]kip this step."
      read -p "  'r' or 's' ::  " -n 1 -r USER_ANSWER
      CHOICE=$(echo ${USER_ANSWER:0:1} | tr '[:upper:]' '[:lower:]')
      if [[ "X${CHOICE}X" == "XsX" ]]; then
        INSTALL_PACKAGE=false;
      else
        echo "";
        echo "Removing old ${GITHUB_ORGANIZATION_NAME}:${PKG_NAME}. . . ";
        meteor remove ${GITHUB_ORGANIZATION_NAME}:${PKG_NAME};
      fi;
      echo ""

    elif [[  "${REPLACE_EXISTING_PACKAGE=}" == "yes"  ]]; then
      echo "";
      echo "Removing old ${GITHUB_ORGANIZATION_NAME}:${PKG_NAME}. . . ";
      meteor remove ${GITHUB_ORGANIZATION_NAME}:${PKG_NAME};
    else
      INSTALL_PACKAGE=false;
    fi;

  fi;
  rm -f pkgs.txt;

  ${INSTALL_PACKAGE} && meteor add "${GITHUB_ORGANIZATION_NAME}:${PKG_NAME}";
  ${INSTALL_PACKAGE} && meteor list;

  popd >/dev/null;


}


function Create_a_package_C() {

  mkdir -p ~/${PARENT_DIR}/${PROJECT_NAME}/packages;
  pushd ~/${PARENT_DIR}/${PROJECT_NAME}/packages >/dev/null;
  rm -f ${PKG_NAME};
  ln -s ${PACKAGES}/${YOUR_UID}/${PKG_NAME};
  popd >/dev/null;

}


function Control_a_packages_versions_A() {

  export RMT_REPO="https://github.com/${GITHUB_ORGANIZATION_NAME}/${PKG_NAME}";
  set +e;   wget -q --spider ${RMT_REPO}; EXISTS=$?;    set -e;

  until [[ ${EXISTS} -eq 0 ]]
  do
    echo "Can find no GitHub repo at '${RMT_REPO}'"
    read -p "  Hit enter when one has been created : " -n 1 -r YRPKGRDY
    echo ""
    set +e;   wget -q --spider ${RMT_REPO}; EXISTS=$?;    set -e;

  done

  Make_GitHub_Repo_Deploy_Key_Title ${GITHUB_ORGANIZATION_NAME} ${PKG_NAME};

  echo -e "Go to the 'Deploy Key' configuration page for the GitHub repo at : ";
  echo -e "\n    https://github.com/${GITHUB_ORGANIZATION_NAME}/${PKG_NAME}/settings/keys";
  echo -e "\nThen click the [Add deploy key] button and fill in the fields as follows : \n";
  echo -e " - Title -- fill with :      ${REPO_DEPLOY_KEY_TITLE} \n";
  echo -e " - Key -- fill with :      $(cat ~/.ssh/${REPO_DEPLOY_KEY_TITLE}.pub) \n";
  echo -e " - Allow write access -- checked";

}


function Control_a_packages_versions_B() {

  declare DATA_TO_FETCH=false;
  if [[  "${1}" == "${NONSTOP}"  ]]; then DATA_TO_FETCH=true; fi;

  prepareKnownHost "github.com";

  pushd ${PACKAGES}/${YOUR_UID}/${PKG_NAME} >/dev/null;

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

  if [[ $(git remote) = ${PKG_NAME}_origin ]];
  then
    echo -e "Remote, named ${PKG_NAME}_origin has already been defined for repo ${GITHUB_ORGANIZATION_NAME}/${PKG_NAME}.git";
  else
    echo -e "Defining remote, named ${PKG_NAME}_origin for repo ${GITHUB_ORGANIZATION_NAME}/${PKG_NAME}.git";
    git remote add ${PKG_NAME}_origin git@github-${GITHUB_ORGANIZATION_NAME}-${PKG_NAME}:${GITHUB_ORGANIZATION_NAME}/${PKG_NAME}.git;
  fi;

  ${DATA_TO_FETCH} && {
    git fetch ${PKG_NAME}_origin && echo -e "\nFetched";
    git pull ${PROJECT_NAME}_origin master && echo -e "\nPulled";  # When hand built, master does not yet exist
    # git pull ${PKG_NAME}_origin && echo -e "\nPulled";
    popPseudoStash && echo -e "\nDestashed";
  }

  set +e;
  git add .;
  git commit -am 'First commit' && echo -e "\nCommitted";
  set -e;

  eval "$(ssh-agent -s)";

  git push -u ${PKG_NAME}_origin master && echo -e "\nPushed";

  popd >/dev/null;

}


function TinyTest_a_package() {

  pushd ~/${PARENT_DIR}/${PROJECT_NAME} >/dev/null;

  killMeteorProcess
  meteor test-packages &

  tree

  echo -e "#########################################################################################"
  echo -e "#   Meteor Package Testing is now starting up as a background process."
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


function Add_a_test_runner_for_getting_TinyTest_output_on_the_command_line() {

  pushd ~/${PARENT_DIR} >/dev/null;
  pushd ${PROJECT_NAME} >/dev/null;

  killMeteorProcess

  wget -N -N https://raw.githubusercontent.com/warehouseman/meteor-tinytest-runner/master/meteor-tinytest-runner.run
  chmod ug+x meteor-tinytest-runner.run
  ./meteor-tinytest-runner.run
  chmod a+rx ./tests/tinyTests/*.sh
  ./tests/tinyTests/test-all.sh

  if [[  "${1}" != "${NONSTOP}"  ]]; then

    echo -e "#########################################################################################"
    echo -e "#   Above you should see lines like :"
    echo -e "#   [INFO] http://127.0.0.1:4096/packages/test-in-console.js?59dde1f. . . 07b3f499 75:17 S: tinytest - example "
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
