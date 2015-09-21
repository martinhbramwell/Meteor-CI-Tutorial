#!/bin/bash

set -e
#
if [[ $EUID -eq 0 ]]; then
   echo -e "This script SHOULD NOT be run with 'sudo' (as root). "
   exit 1
fi

DOCS="./VersionControlInTheCloud/doc"


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

  if ${INSTALLMETEOR}; then
    curl https://install.meteor.com/ | sh;
    touch /usr/local/bin/meteor
    chmod a+x /usr/local/bin/meteor
  fi;

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




echo ""
echo ""
explain ${DOCS}/Create_remote_GitHub_repository_A.md




echo ""
echo ""
explain ${DOCS}/Create_remote_GitHub_repository_B.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then

  echo -e "Go to the 'Deploy Key' configuration page for the GitHub repo at : ";
  echo -e "\n    https://github.com/${GITHUB_ORGANIZATION_NAME}/${PROJECT_NAME}/settings/keys";
  echo -e "\nThen click the [Add deploy key] button and fill in the fields as follows : \n";
  echo -e " - Title -- fill with :      ${PACKAGE_DEVELOPER} \n";
  echo -e " - Key -- fill with :      $(cat ~/.ssh/id_rsa.pub) \n";
  echo -e " - Allow write access -- checked";

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




## FLAG FOR INCLUSION IN SLIDES - ${DOCS}/Fin.md explain

echo ""
echo -e "\nDone.  Now start up ./Part03_UnitTestAPackage.sh";

exit 0;
