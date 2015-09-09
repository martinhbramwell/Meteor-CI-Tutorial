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
    echo -e "#    - project owner name"
    echo -e "#    - project owner email."
    echo -e "#   Please ensure you have entered these values correctly."
    echo -e "#####################################################################"
    exit 1;
fi;



explain ${DOCS}/Configure_git_for_GitHub.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then

  echo -e "#   -- Configuring git ... "

  git config --global user.email "${YOUR_NAME}"
  git config --global user.name "${YOUR_EMAIL}"
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

  git init
  git add .
  git commit -am 'First commit'
  git remote add origin git@github.com:${GITHUB_ORGANIZATION_NAME}/${PROJECT_NAME}.git
  # git remote set-url origin git@github.com:FleetingClouds/${PROJECT_NAME}.git
  git push -u origin master

  popd
  popd

fi




explain ${DOCS}/Create_a_package_A.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then

  export PACKAGES=~/projects/packages
  export PACKAGE_DIRS=${PACKAGES}/somebodyelse:${PACKAGES}/yourself
  mkdir -p ${PACKAGES}/yourself
  mkdir -p ${PACKAGES}/somebodyelse
  export HAS_PACKAGE_DIRS=$(grep PACKAGE_DIRS ~/.profile | grep -c ${PACKAGES} ~/.profile)
  [[ ${HAS_PACKAGE_DIRS} -lt 1 ]] && echo -e "\n#\nexport PACKAGE_DIRS=${PACKAGE_DIRS}" >> ~/.profile
  source ~/.profile

fi



explain ${DOCS}/Create_a_package_B.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then

  PACKAGE_DEVELOPER="yourself";
  PACKAGE_NAME="yourpackage";
  pushd ${PACKAGES}/${PACKAGE_DEVELOPER};

  CREATE_PACKAGE=true;
  if [[ -d ${PACKAGE_NAME}
     && -f ${PACKAGE_NAME}/package.js
     &&    $(grep -c "name.*${PACKAGE_DEVELOPER}:${PACKAGE_NAME}" ${PACKAGE_NAME}/package.js ) -gt 0 ]]; then

    echo "The package, '${PACKAGE_DEVELOPER}:${PACKAGE_NAME}', was created earlier.
            You can delete it and [r]ecreate it OR [s]kip this step."
    read -p "  'r' or 's' ::  " -n 1 -r USER_ANSWER
    CHOICE=$(echo ${USER_ANSWER:0:1} | tr '[:upper:]' '[:lower:]')
    if [[ "X${CHOICE}X" == "XsX" ]]; then
      CREATE_PACKAGE=false;
    else
      echo "";
      echo "Deleting old ${PACKAGE_NAME}. . . ";
      rm -fr ${PACKAGE_NAME}
    fi;
    echo ""

  fi;

  ${CREATE_PACKAGE} && meteor create --package "${PACKAGE_DEVELOPER}:${PACKAGE_NAME}";

  popd

  pushd ~/projects/${PROJECT_NAME}
  INSTALL_PACKAGE=true;
  meteor list > pkgs.txt;
  echo -e "Currently installed packages :"
  cat pkgs.txt
  if [[ $(cat pkgs.txt | grep -c "${PACKAGE_DEVELOPER}:${PACKAGE_NAME}") -gt 0 ]]; then

    echo "The package, '${PACKAGE_DEVELOPER}:${PACKAGE_NAME}', was installed earlier.
            You can remove it and [r]einstall it OR [s]kip this step."
    read -p "  'r' or 's' ::  " -n 1 -r USER_ANSWER
    CHOICE=$(echo ${USER_ANSWER:0:1} | tr '[:upper:]' '[:lower:]')
    if [[ "X${CHOICE}X" == "XsX" ]]; then
      INSTALL_PACKAGE=false;
    else
      echo "";
      echo "Removing old ${PACKAGE_DEVELOPER}:${PACKAGE_NAME}. . . ";
      meteor remove ${PACKAGE_DEVELOPER}:${PACKAGE_NAME};
    fi;
    echo ""

  fi;
  rm -f pkgs.txt;

  ${INSTALL_PACKAGE} && meteor add "${PACKAGE_DEVELOPER}:${PACKAGE_NAME}";
  ${INSTALL_PACKAGE} && meteor list;

  popd

fi




explain ${DOCS}/Create_a_package_C.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then

  cd ~/projects/${PROJECT_NAME}
  ln -s ${PACKAGE_DIRS}/yourself/yourpackage ./packages/yourpackage

fi




explain ${DOCS}/TinyTest_a_package.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then

  existingMeteor

  pushd ~/${PARENT_DIR}
  pushd ${PROJECT_NAME}

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
explain ${DOCS}/Try_ESLint_from_the_Command_Line.md

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
explain ${DOCS}/Try_ESLint_Command_Line_Again.md

echo ""
echo ""
explain ${DOCS}/Try_jsDoc_from_the_Command_Line_A.md

echo ""
echo ""
explain ${DOCS}/Try_jsDoc_from_the_Command_Line_B.md

echo ""
echo ""
explain ${DOCS}/Configure_Sublime_Text_to_use_jsDoc.md


## FLAG FOR INCLUSION IN SLIDES - ${DOCS}/Fin.md explain 

echo ""
echo -e "\nDone.  Now start up ./Step03_CloudContinuousIntegration.sh";

exit 0;

