#!/bin/bash
#

if [[ $EUID -eq 0 ]]; then
   echo -e "This script SHOULD NOT be run with 'sudo' (as root). "
   exit 1
fi

source ./explain.sh

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


echo -e ""
echo -e ""
echo -e ""
echo -e ""
echo -e ""
echo -e "############################################################################"
echo -e "#"
echo -e "#   These scripts prepare the way for you to get started easily with"
echo -e "#   Meteor package development, testing, documenting, code style"
echo -e "#   linting and continuous integration"
echo -e "#"
echo -e "#   They are designed for a small (10GB) Xubuntu 14.04 virtual machine."
echo -e "#   They have not been tested in any other environment since the idea is"
echo -e "#   to provide clear proven instructions that can be adapted easily to"
echo -e "#   other circumstances."
echo -e "#"
echo -e "#   The scripts are 'idempotent' -- you can run them repeatedly without"
echo -e "#   adverse consequences."
echo -e "#"
echo -e "#   The first script 'Prep4MeteorCI_A.sh' sets up all necessary preconditions"
echo -e "#   for the second script.  The second one 'Prep4MeteorCI_B.sh' takes you "
echo -e "#   through the entir process of preparing a Meteor project and package with "
echo -e "#   all the previously mentioned application development support tools.."
echo -e "#"
echo -e "############################################################################"
read -p "Hit <enter> ::  " -n 1 -r USER_ANSWER

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



explain "#   Configure git for use with GitHub.
\n#
\n#  In this step we set up the local git tool kit to communicate correctly with GitHub.
\n#  "
if [ $? -eq 0 ]; then

  echo -e "#   -- Configuring git ... "

  git config --global user.email "${YOUR_NAME}"
  git config --global user.name "${YOUR_EMAIL}"
  git config --global push.default simple

fi

AUTORUN="";


explain "#   Create SSH keys directory if it does not exist.
\n#
\n#  This script requires you to have an SSH private key.
\n#  If the file '~/.ssh/id_rsa' exists, then this command group will do nothing.
\n#  Otherwise, it will set up the directory and create an empty '~/.ssh/id_rsa' into
\n#  which you can paste your private key."
if [ $? -eq 0 ]; then
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



explain "#   Install Meteor
\n#
\n#  In this step we simply run Meteor's installation
\n#  It takes a while, so you might want to do it in a separate terminal window.
\n#  The command to run is :
\n#  -    curl https://install.meteor.com/ | sh
\n#  "
if [ $? -eq 0 ]; then
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




PARENT_DIR="projects"
METEOR_PORT=3000


explain "#   Create a meteor project.
\n#
\n#   Here we create a container directory called '${PARENT_DIR}' and
\n#   inside it we start a Meteor project called '${PROJECT_NAME}'
\n#
\n#   When prompted, test meteor in a separate terminal window.
\n#
\n#  "
if [ $? -eq 0 ]; then
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



explain "#   Check the meteor project will work
\n#
\n#   If Meteor is not already running, it will start up ${PROJECT_NAME} now.
\n#   If Meteor IS already running, you will need to stop it.
\n#
\n#   When prompted, test meteor in a browser.
\n#
\n#  "
if [ $? -eq 0 ]; then

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




explain "#   Add Meteor application development support files
\n#
\n#   In this step we create some of the project meta data files :
\n#    -  LICENSE
\n#    -  README.md
\n#    -  .gitignore
\n#    -  .eslintrc
\n#  "
if [ $? -eq 0 ]; then

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

  echo -e ""
  echo -e ""
  echo -e "######################################################################"
  echo -e "#"
  echo -e "#  Configure Sublime Text to use the '.eslintrc' file for hinting about coding style contraventions :"
  echo -e "#  Go to Preferences >> Package Control"
  echo -e "#  In Package Control type : install package"
  echo -e "#  Install these two packages :"
  echo -e "#   - '\e[1;34mSublimeLinter\e[0m'"
  echo -e "#   - '\e[1;34mSublimeLinter-contrib-eslint\e[0m'"
  echo -e "#"
  echo -e "######################################################################"

fi



explain "#   Create our GitHub repository.
\n#
\n#   In this step we :
\n#    -  initialize a local .git repository
\n#    -  add all the files to the local repo and commit
\n#    -  establish our GitHub project as the remote repository
\n#    -  push our new files to GitHub
\n#
\n#   This step is NOT idempotent. If the project has already been pushed to
\n#   GitHub you will get errors.  If so, the easiest thing to do is
\n#   eliminate the project from GitHub and run this step again.
\n#  "
if [ $? -eq 0 ]; then

  echo -e "#########################################################################################"
  echo -e "#   "
  echo -e "#   The next steps are :"
  echo -e "#   "
  echo -e "#    1. Log in to GitHub and create a project with the exact name '${PROJECT_NAME}'"
  echo -e "#       Don't set any other values. We'll do that automatically."
  echo -e "#    2. Log in to CircleCI and set it to monitor project '${PROJECT_NAME}' for rebuilding."
  echo -e "#   "
  echo -e "#########################################################################################"
  read -p "To continue hit <enter> ::  " -n 1 -r USER_ANSWER

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




explain "#  Create a package and TinyTest it.
\n#
\n#  Meteor makes this very easy. Two commands and we have a unit tested package.
\n#  - meteor create --package yours:skeleton
\n#  - meteor test-packages
\n#
\n#  Notice the newly added files.  These will also have to be pushed to GitHub.
\n#  "
if [ $? -eq 0 ]; then

  existingMeteor

  pushd ~/${PARENT_DIR}
  pushd ${PROJECT_NAME}

  meteor create --package yours:skeleton
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



explain "#  Install 'selenium-webdriver'
\n#
\n#  Selenium Webdriver is required for the next step.
\n#  We must first ensure that root has not taken ownership of the local .npm directory.
\n#
\n#  You will need your password to enable the [ch]ange [own]er command.
\n#  sudo chown -R ${USER}:${USER} ~/.npm
\n#
\n#  "
if [ $? -eq 0 ]; then

  sudo chown -R ${USER}:${USER} ~/.npm
  npm install -y --prefix /home/yourself selenium-webdriver

fi



explain "#  Add a test runner for getting TinyTest output on the command line
\n#
\n#  TinyTest pretty prints its results in the browser.  This is useless for continuous integration.
\n#  We need to have test results on the command line
\n#
\n#  The GitHub repo . . .
\n#   https://github.com/warehouseman/meteor-tinytest-runner
\n#  . . . has a wrapper tool that drives a browser with Selenium and collects the results in
\n#   text format.  The installer deletes itself after preparing the files for immediate use.
\n#
\n#  "
if [ $? -eq 0 ]; then

  existingMeteor

  pushd ~/${PARENT_DIR}
  pushd ${PROJECT_NAME}

  wget -N https://raw.githubusercontent.com/warehouseman/meteor-tinytest-runner/master/meteor-tinytest-runner.run
  chmod ug+x meteor-tinytest-runner.run
  sudo chown -R ${USER}:${USER} ~/.npm
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



explain "#  Add a CircleCI configuration file and push to GitHub
\n#
\n#  On the previous commit, CircleCI recognized the project's existence but did not
\n#  know what to do with it.  Now, we have a test runner, and with the addition of a
\n#  'circle.yml' configuration file committing the project to GitHub will cause
\n#  an automatic rebuild.
\n#
\n#  "
if [ $? -eq 0 ]; then

  pushd ~/${PARENT_DIR}
  pushd ${PROJECT_NAME}

  mv example_circle.yml circle.yml

  git add packages
  git add circle.yml
  git add tests
  git commit -am 'Added package and package testing'
  git push -u origin master

  echo -e "#########################################################################################"
  echo -e "#   Open your CircleCI site and explore the most recent build.  In the build section you "
  echo -e "#   should find the same lines as before when we ran the test runner locally : "
  echo -e "#   [INFO] http://127.0.0.1:4096/packages/test-in-console.js?59dde1f. . . 07b3f499 75:17 S: tinytest - example "
  echo -e "#    "
  echo -e "#   Notice the execution time. Rebuild, and notice how the test is faster thanks to "
  echo -e "#   caching of dependencies"
  echo -e "#########################################################################################"
  echo -e "Hit <enter> after you have confirmed that CircleCI ran successful tests ::  "
  read -n 1 -r USER_ANSWER
  popd
  popd

fi



explain "#  Install 'bunyan'
\n#
\n#  Bunyan is a logging package with the special advantage of writing
\n#  run-time logs as JSON. This makes subsequent analysis and long-term
\n#  storage of production system logs much more efficient.
\n#
\n#  It is in two parts :
\n#   - a local node module to replace 'console.log'
\n#   - a global module that reads Bunyan JSON and reformats for different uses, including stdout.
\n#
\n#  We must first ensure that root has not taken ownership of the local .npm directory.
\n#
\n#  For ongoing server side logging during development or production we need a permanent home
\n#  for the logs.  The standard place for that in Ubuntu is /var/log.  So wee also need to
\n#  create a directory for Meteor with suitable permissions.
\n#
\n#  "
if [ $? -eq 0 ]; then

  sudo chown -R ${USER}:${USER} ~/.npm
  sudo npm install -y --global --prefix /usr bunyan

  LOG_DIR="/var/log/meteor"
  sudo mkdir -p ${LOG_DIR}
  sudo chown ${USER}:${USER} ${LOG_DIR}
  sudo chmod ug+rwx ${LOG_DIR}

fi




explain "#  Prepare for NightWatch testing.
\n#
\n#  Nightwatch tests applications end-to-end by directly controlling the
\n#  browser.  Meteor has full support for TinyTests running as part of
\n#  Meteor itself, but NightWatch has no such support and runs in its own
\n#  NodeJS process apart from Meteor's NodeJs process.  It can even run
\n#  on a different machine.
\n#
\n#  To install we pull this file stored in GitHub ...
\n#   wget -N https://github.com/warehouseman/meteor-nightwatch-runner/raw/master/meteor-nightwatch-runner.run
\n#  ... make it executable and then run it.
\n#
\n#  The installer prepares a Nightwatch test directory and then deletes
\n#  itself, leaving only what's necessary. It includes a sample 'circle.yml'
\n#  that expects the TinyTest runner to have been installed first; it will run
\n#  TinyTests and Nightwatch tests in CircleCI one after the other.
\n#
\n#  "
if [ $? -eq 0 ]; then

  pushd ~/${PARENT_DIR}
  pushd ${PROJECT_NAME}

  wget -N https://github.com/warehouseman/meteor-nightwatch-runner/raw/master/meteor-nightwatch-runner.run
  chmod ug+x meteor-nightwatch-runner.run

  ./meteor-nightwatch-runner.run

fi


explain "#  Run NightWatch testing.
\n#
\n#  Nightwatch and Meteor are separate.  This command group starts Meteor
\n#  in a background process, and then starts the Nightwatch Test Runner to
\n#  try the simple sanity check test -- 'Does the main page have a <body> tag?'.
\n#
\n#  "
if [ $? -eq 0 ]; then

  existingMeteor

  pushd ~/${PARENT_DIR}
  pushd ${PROJECT_NAME}

  meteor &  #  Running meteor in the background
  ./tests/nightwatch/runTests.js | bunyan
  kill -9 $(jobs -p)

  echo -e "#########################################################################################"
  echo -e "#   You ought to see lines similar to these : "
  echo -e "#  "
  echo -e "#   [2015-08-16T16:26:46.081Z]  INFO: demo/11123 on PkgTestDemo: Running:  Layout and Static Pages"
  echo -e "#   [2015-08-16T16:26:51.343Z]  INFO: demo/11123 on PkgTestDemo: ✔ Testing if element <body> is present."
  echo -e "#   [2015-08-16T16:26:51.934Z]  INFO: demo/11123 on PkgTestDemo: OK. 1 assertions passed. (5.851s)"
  echo -e "#   [2015-08-16T16:26:51.936Z]  INFO: demo/11123 on PkgTestDemo: "
  echo -e "#   [2015-08-16T16:26:51.936Z]  INFO: demo/11123 on PkgTestDemo: OK. 1 assertion passed. (6.554s)"
  echo -e "#   [2015-08-16T16:26:52.253Z]  INFO: demo/11123 on PkgTestDemo: Finished!  Nightwatch ran all the tests!"
  echo -e "#    "
  echo -e "#########################################################################################"
  echo -e "Hit <enter> after you have confirmed that you have these results ::  "
  read -n 1 -r USER_ANSWER
  popd
  popd

fi



explain "#  Push Nightwatch testing to GitHub (and CircleCI)
\n#
\n#  We are ready for the final stage: TinyTest & Nightwatch testing run in
\n#  a single pass of continuous integration in CircleCI.
\n#
\n#  The Nightwatch 'circle.yml' includes set up of TinyTest, so it can overwrite the
\n#  one created earlier.
\n#
\n#  "
if [ $? -eq 0 ]; then

  pushd ~/${PARENT_DIR}
  pushd ${PROJECT_NAME}

  cp tests/nightwatch/config/example_circle.yml circle.yml

  git add tests/nightwatch
  git commit -am 'Added Nightwatch testing'
  git push -u origin master

  popd
  popd

fi

echo -e "\nDone.";
exit 0;


# explain "#
# \n#
# \n#
# \n#  "
# if [ $? -eq 0 ]; then

#   pushd ~/${PARENT_DIR}
#   pushd ${PROJECT_NAME}


#   popd
#   popd

# fi


echo "Done.";
exit 0;
