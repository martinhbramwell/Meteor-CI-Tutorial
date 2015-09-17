#!/bin/bash

set -e
#
if [[ $EUID -eq 0 ]]; then
   echo -e "This script SHOULD NOT be run with 'sudo' (as root). "
   exit 1
fi

DOCS="./UnitTestThePackage/doc"
source ./explain.sh
source ./util.sh

explain ${DOCS}/Introduction.md

RUN_RULE=a
explain ${DOCS}/Set_Up_Project_Names.md MORE_ACTION
RUN_RULE=
if ! getUserData; then
    echo -e "#####################################################################"
    echo -e "#   The rest of this script will fail without correct values for : "
    echo -e "#    - project name"
    echo -e "#    - package name"
    echo -e "#    - project owner name"
    echo -e "#    - project owner full name"
    echo -e "#    - project owner email."
    echo -e "#   Please ensure you have entered these values correctly."
    echo -e "#####################################################################"
    exit 1;
fi;



explain ${DOCS}/Configure_git_for_GitHub.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then

  echo -e "#   -- Configuring git ... "

  git config --global user.email "${YOUR_EMAIL}"
  git config --global user.name "${PACKAGE_DEVELOPER}"
  git config --global push.default simple

fi

explain ${DOCS}/Install_Meteor.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then
  INSTALLMETEOR=true
  if [[ $(meteor --version) =~ .*Meteor.* ]]
  then
    echo "Meteor has been installed already.  Do you want to reinstall?"
    read -p "  'y' or 'n' ::  " -n 1 -r USER_ANSWER
    CHOICE=$(echo ${USER_ANSWER:0:1} | tr '[:upper:]' '[:lower:]')
    if [[ "X${CHOICE}X" == "XnX" ]];
    then
      INSTALLMETEOR=false;
    fi;
  fi

  if ${INSTALLMETEOR}; then curl https://install.meteor.com/ | sh; fi;

fi




export PARENT_DIR=projects
METEOR_PORT=3000


explain ${DOCS}/Create_Meteor_project.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then
  # Make a projects directory
  mkdir -p ~/${PARENT_DIR}

  pushd ~/${PARENT_DIR}


  BUILD_IT=true
  if [[ -d ~/${PARENT_DIR}/${PROJECT_NAME} ]]; then
    echo "";
    echo "";
    echo "The project, '${PROJECT_NAME}', was created earlier.
            You can delete it and [r]ecreate it OR [s]kip this step."
    read -p "  'r' or 's' ::  " -n 1 -r USER_ANSWER
    CHOICE=$(echo ${USER_ANSWER:0:1} | tr '[:upper:]' '[:lower:]')
    if [[ "X${CHOICE}X" == "XsX" ]]; then
      BUILD_IT=false
    else
      echo "";
      echo "Deleting old ${PROJECT_NAME}. . . ";
      rm -fr ${PROJECT_NAME}
    fi;
    echo ""
  fi

  if ${BUILD_IT}; then

    echo "creating project ${PROJECT_NAME} . . . ";
    # Start a Meteor project
    meteor create ${PROJECT_NAME}

  else
    echo "Skipped";
  fi

  ls -la ${PROJECT_NAME}
  popd


fi



explain ${DOCS}/Check_the_meteor_project_will_work.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then

  existingMeteor

  pushd ~/${PARENT_DIR}/${PROJECT_NAME}

  meteor &

  echo -e "#########################################################################################"
  echo -e "#   Meteor is now starting up as a background process."
  echo -e "#   In a browser, please open the URL -- http://localhost:${METEOR_PORT}/ --"
  echo -e "#    to confirm that it is working."
  echo -e "#########################################################################################"
  echo -e "After you have confirmed that Meteor is working on port ${METEOR_PORT} hit <enter> to STOP IT and go on to next step.  "
  read -n 1 -r USER_ANSWER

  echo -e "Stopping Meteor process . . . "

  kill -9 $(jobs -p)

  popd

fi


export GITHUB_RAW="https://raw.githubusercontent.com/warehouseman/meteor-swagger-client/master/.eslintrc"
explain ${DOCS}/Add_Meteor_application_development_support_files.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then

  pushd ~/${PARENT_DIR}
  pushd ${PROJECT_NAME}

  cat << LICMIT > LICENSE
The MIT License (MIT)

Copyright (c) 2015 Warehouseman

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
LICMIT

  cat << GITIG > .gitignore
.meteor/local
.meteor/meteorite
GITIG

  cat << RDME > README.md
# ${PROJECT_NAME}

A bare minimum app and package for running TinyTest and NightWatch in CircleCI
RDME

  wget -N https://raw.githubusercontent.com/warehouseman/meteor-swagger-client/master/.eslintrc
  # wget -N https://raw.githubusercontent.com/airbnb/javascript/master/packages/eslint-config-airbnb/.eslintrc
  # wget -N https://raw.githubusercontent.com/meteor/meteor/devel/scripts/admin/eslint/.eslintrc

  ls -la

  popd
  popd

fi



echo ""
echo ""
explain ${DOCS}/Create_remote_GitHub_repository.md


RUN_RULE="";


explain ${DOCS}/Create_SSH_keys_directory_if_not_exist.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then
  SET_UP_SSH=true;
  if [ -f ~/.ssh/id_rsa ]; then SET_UP_SSH=false;  fi
  if [ -f ~/.ssh/id_rsa.pub ]; then SET_UP_SSH=false;  fi
  if [ -f ~/.ssh/authorized_keys ]; then SET_UP_SSH=false;  fi

  if [ ${SET_UP_SSH} == true ]; then
    echo "Setting up SSH directory";
    mkdir -p ~/.ssh
    chmod 700 ~/.ssh
    touch ~/.ssh/authorized_keys                               #  Edit to add allowed connections
    touch ~/.ssh/id_rsa                                        #  Edit to add private key
    touch ~/.ssh/id_rsa.pub                                    #  Edit to add public key
    chmod 600 ~/.ssh/authorized_keys
    chmod 600 ~/.ssh/id_rsa
    chmod 644 ~/.ssh/id_rsa.pub
    ls -la ~/.ssh

    echo -e "#########################################################################################"
    echo -e "#   The necessary files have been created and permissions set correctly."
    echo -e "#   Please provide the correct content for the three files listed above"
    echo -e "#########################################################################################"
    read -p "Hit <enter> ::  " -n 1 -r USER_ANSWER

  else
    echo -e "#########################################################################################"
    echo -e "#   Found SSH artifacts already present.  Will NOT set up SSH."
    echo -e "#   Please ensure you have a correctly configured SSH directory for use with GitHub."
    echo -e "#   Visit :  https://help.github.com/articles/generating-ssh-keys/"
    echo -e "#########################################################################################"
  fi
fi



explain ${DOCS}/Create_local_GitHub_repository.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then

  pushd ~/${PARENT_DIR}
  pushd ${PROJECT_NAME}

  ssh-add
  git init
  git add .
  git commit -am 'First commit'
  git remote add origin git@github.com:${GITHUB_ORGANIZATION_NAME}/${PROJECT_NAME}.git
# git remote set-url origin git@github.com:${GITHUB_ORGANIZATION_NAME}/${PROJECT_NAME}.git
  git push -u origin master

  popd
  popd

fi




export PACKAGES=~/${PARENT_DIR}/packages
export PACKAGE_DIRS=${PACKAGES}/somebodyelse:${PACKAGES}/${YOUR_NAME}

explain ${DOCS}/Create_a_package_A.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then

  mkdir -p ${PACKAGES}/${YOUR_NAME}
  mkdir -p ${PACKAGES}/somebodyelse
  HAS_PACKAGE_DIRS=$(grep PACKAGE_DIRS ~/.profile | grep -c ${PACKAGES} ~/.profile)
  [[ ${HAS_PACKAGE_DIRS} -lt 1 ]] && echo -e "\n#\nexport PACKAGE_DIRS=${PACKAGE_DIRS}" >> ~/.profile
  source ~/.profile

fi

explain ${DOCS}/Create_a_package_B.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then

  pushd ${PACKAGES}/${YOUR_NAME};

  CREATE_PACKAGE=true;
  if [[ -d ${PKG_NAME}
     && -f ${PKG_NAME}/package.js
     &&    $(grep -c "name.*${GITHUB_ORGANIZATION_NAME}:${PKG_NAME}" ${PKG_NAME}/package.js ) -gt 0 ]]; then

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

  fi;

  ${CREATE_PACKAGE} && meteor create --package "${GITHUB_ORGANIZATION_NAME}:${PKG_NAME}";

  popd

  pushd ~/${PARENT_DIR}/${PROJECT_NAME}

  echo -e "Reviewing installed packages . . . ( slow! give us a minute) \n\n"

  INSTALL_PACKAGE=true;
  meteor list > pkgs.txt;
  echo -e "Currently installed packages :"
  cat pkgs.txt
  if [[ $(cat pkgs.txt | grep -c "${GITHUB_ORGANIZATION_NAME}:${PKG_NAME}") -gt 0 ]]; then

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

  fi;
  rm -f pkgs.txt;

  ${INSTALL_PACKAGE} && meteor add "${GITHUB_ORGANIZATION_NAME}:${PKG_NAME}";
  ${INSTALL_PACKAGE} && meteor list;

  popd

fi




explain ${DOCS}/Create_a_package_C.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then

  mkdir -p ~/${PARENT_DIR}/${PROJECT_NAME}/packages
  pushd ~/${PARENT_DIR}/${PROJECT_NAME}/packages
  ln -s ${PACKAGES}/${YOUR_NAME}/${PKG_NAME} ${PKG_NAME}
  popd

fi



explain ${DOCS}/Control_a_packages_versions_A.md # CODE_BLOCK
YRPKGRDY="";
until [[ "${YRPKGRDY}" == "y" || "${YRPKGRDY}" == "Y" ]]
do
  read -p "Have you prepared a GitHub repo called '${PKG_NAME}'? (y/Y) : " -n 1 -r YRPKGRDY
  echo ""
done


explain ${DOCS}/Control_a_packages_versions_B.md  MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then

  pushd ${PACKAGES}/${YOUR_NAME}/${PKG_NAME}

  ssh-add
  git init
  git add .
  git commit -am 'First commit'
  git remote add origin git@github.com:${GITHUB_ORGANIZATION_NAME}/${PKG_NAME}.git
# git remote set-url origin git@github.com:${GITHUB_ORGANIZATION_NAME}/${PKG_NAME}.git
  git push -u origin master

  popd


fi



explain ${DOCS}/TinyTest_a_package.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then

  existingMeteor

  pushd ~/${PARENT_DIR}/${PROJECT_NAME}

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

  popd

fi


explain ${DOCS}/Add_a_test_runner_for_getting_TinyTest_output_on_the_command_line.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then

  existingMeteor

  pushd ~/${PARENT_DIR}
  pushd ${PROJECT_NAME}

  wget -N https://raw.githubusercontent.com/warehouseman/meteor-tinytest-runner/master/meteor-tinytest-runner.run
  chmod ug+x meteor-tinytest-runner.run
  ./meteor-tinytest-runner.run
  ./tests/tinyTests/test-all.sh
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

  popd
  popd

fi


echo ""
echo ""
explain ${DOCS}/Try_ESLint_from_the_Command_Line.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then

  pushd ~/${PARENT_DIR}/${PROJECT_NAME}/
  set +e
  eslint ./packages/${PKG_NAME}/${PKG_NAME}-tests.js
  set -e
  popd

fi


echo ""
echo ""
explain ${DOCS}/Configure_Sublime_Text_to_use_ESLint.md

echo ""
echo ""
explain ${DOCS}/Customize_ESLint_in_Sublime_Text.md

echo ""
echo ""
explain ${DOCS}/Try_ESLint_in_Sublime_Text.md

echo ""
echo ""
explain ${DOCS}/Try_ESLint_Command_Line_Again.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then

  pushd ~/${PARENT_DIR}/${PROJECT_NAME}/
  set +e
  eslint ./packages/${PKG_NAME}/${PKG_NAME}-tests.js
  set -e
  popd

fi


echo ""
echo ""
explain ${DOCS}/Try_jsDoc_from_the_Command_Line_A.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then

  pushd ~/${PARENT_DIR}/${PROJECT_NAME}/

  echo -e "\n\nBefore generating documentation . . . "
  tree -L 2 ./packages/${PKG_NAME}
  jsdoc -d ./packages/${PKG_NAME}/docs ./packages/${PKG_NAME}
  echo -e "\n\n . . . after generating documentation . . . "
  tree -L 2 ./packages/${PKG_NAME}

  popd

fi


echo ""
echo ""
explain ${DOCS}/Try_jsDoc_from_the_Command_Line_B.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then

  echo "Paste this URI into your browser :"
  echo -e "\n   ${HOME}/${PARENT_DIR}/${PROJECT_NAME}/packages/${PKG_NAME}/docs/index.html\n\n"

fi


echo ""
echo ""
explain ${DOCS}/Configure_Sublime_Text_to_use_jsDoc.md



echo ""
echo ""
explain ${DOCS}/Use_Sublime_Text_jsDoc_plugin_A.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then

  pushd ~/${PARENT_DIR}/${PROJECT_NAME}/packages/${PKG_NAME}

  wget -O ${PKG_NAME}-tests.js https://raw.githubusercontent.com/martinhbramwell/Meteor-CI-Tutorial/master/fragments/yourpackage-tests.js

  popd

fi


echo ""
echo ""
explain ${DOCS}/Use_Sublime_Text_jsDoc_plugin_B.md




echo ""
echo ""
explain ${DOCS}/Use_Sublime_Text_jsDoc_plugin_C.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then

  pushd ~/${PARENT_DIR}/${PROJECT_NAME}/

  jsdoc -d ./packages/${PKG_NAME}/docs ./packages/${PKG_NAME}
  echo -e "\n Look at : ${HOME}/${PARENT_DIR}/${PROJECT_NAME}/packages/${PKG_NAME}/docs/index.html\n\n"

  popd

fi


echo ""
echo ""
explain ${DOCS}/Publish_jsDocs_toGitHub_A.md



echo ""
echo ""
explain ${DOCS}/Publish_jsDocs_toGitHub_B.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then

  pushd ~/${PARENT_DIR}/${PROJECT_NAME}/packages/${PKG_NAME}
  pushd docs

  echo -e "Zipping up the documentation directory.\n"

  rm -f ../.tmp_docs.zip
  zip -qr ../.tmp_docs.zip *

  popd

  echo -e "Committing changes to package, pushing to remote repo and publishing docs as a GitHub Pages website.\n"

  git add docs/*
  git commit -am "Preliminary package documentation."
  git push

  popd

  ./PushDocsToGitHubPagesBranch.sh ${PKG_NAME} ~/${PARENT_DIR}/${PROJECT_NAME}/packages/${PKG_NAME} .tmp_docs.zip

fi





## FLAG FOR INCLUSION IN SLIDES - ${DOCS}/Fin.md explain

echo ""
echo -e "\nDone.  Now start up ./Part03_CloudContinuousIntegration.sh";

exit 0;

