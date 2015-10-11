#!/bin/bash
set -e
#
if [[ $EUID -eq 0 ]]; then
   echo -e "This script SHOULD NOT be run with 'sudo' (as root). "
   exit 1
fi


DOCS="./CloudContinuousIntegration/doc"
source ./explain.sh
source ./util.sh


explain ${DOCS}/Introduction.md

explain ${DOCS}/Connect_CircleCI_to_GitHub.md

explain ${DOCS}/Add_a_CircleCI_configuration_file_and_push_to_GitHub.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then


  pushd ~/${PARENT_DIR}/${PROJECT_NAME} >/dev/null;

  # Get a circle.yml file
  cp example_circle.yml circle.yml;

  git add circle.yml;
  git add tests;
  set +e;    git commit -am 'Added circle.yml and unit testing';   set -e;
  git push -u ${PROJECT_NAME}_origin master;

  echo -e "\n\n#########################################################################################"
  echo -e "#   Open your CircleCI site and explore the most recent build.  In the build section at the"
  echo -e "#   line 'tests/tinyTests/test-all.sh' you will find that tests failed for lack of a package"
  echo -e "#   to test.  We need to clone our package and depend a symbolic link to it. "
  echo -e "#########################################################################################"
  echo -e "Hit <enter> when ready to continue ::  "
  read -n 1 -r USER_ANSWER

  popd >/dev/null;

fi


explain ${DOCS}/Amend_the_configuration_and_push_again.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then

  pushd ~/${PARENT_DIR} >/dev/null;
  pushd ${PROJECT_NAME} >/dev/null;

  # ci_help.sh is called by the circle.yml script.
  # It loops through a list of packages, clones them and links them into the project
#  cp ./fragments/ci_help.sh ~/${PARENT_DIR}/${PROJECT_NAME}/packages
  wget -O ./packages/ci_help.sh https://raw.githubusercontent.com/martinhbramwell/Meteor-CI-Tutorial/master/fragments/ci_help.sh

  # Fix project specific flag variables
  sed -i -e "s/\${GITHUB_ORGANIZATION_NAME}/${GITHUB_ORGANIZATION_NAME}/" ./packages/ci_help.sh
  sed -i -e "s/\${PKG_NAME}/${PKG_NAME}/" ./packages/ci_help.sh
  sed -i -e "s/\${YOUR_UID}/${YOUR_UID}/" ./packages/ci_help.sh

  chmod a+x ./packages/ci_help.sh

  # Add execution of ci_help.sh to circle.yml
  sed -i '/ADD_MORE_DEPENDENCY_PREPARATIONS_ABOVE_THIS_LINE/c\
    # Pull each of our packages and link them into our project\
    - ./packages/ci_help.sh\
    # ADD_MORE_DEPENDENCY_PREPARATIONS_ABOVE_THIS_LINE' circle.yml

  git add packages;
  set +e;    git commit -am 'Add script to clone packages and symlink to them';   set -e;
  git push -u ${PROJECT_NAME}_origin master;

  echo -e "\n\n#########################################################################################"
  echo -e "#   Open your CircleCI site and explore the most recent build.  In the build section you "
  echo -e "#   should find the same lines as before when we ran the test runner locally : "
  echo -e "#   [INFO] http://127.0.0.1:4096/packages/test-in-console.js?59dde1f. . . 07b3f499 75:17 S: tinytest - example "
  echo -e "#########################################################################################"
  echo -e "Hit <enter> after you have confirmed that CircleCI ran successful tests ::  "
  read -n 1 -r USER_ANSWER
  popd >/dev/null;
  popd >/dev/null;

fi





explain ${DOCS}/Prepare_for_NightWatch_testing.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then

  pushd ~/${PARENT_DIR} >/dev/null;
  pushd ${PROJECT_NAME} >/dev/null;

  wget -N https://github.com/warehouseman/meteor-nightwatch-runner/raw/master/meteor-nightwatch-runner.run
  chmod ug+x meteor-nightwatch-runner.run

  ./meteor-nightwatch-runner.run
  popd >/dev/null;
  popd >/dev/null;

fi


explain ${DOCS}/Run_NightWatch_testing.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then

  pushd ~/${PARENT_DIR} >/dev/null;
  pushd ${PROJECT_NAME} >/dev/null;

  killMeteorProcess

  METEOR_URL="http://localhost:3000/";
  STARTED=false;

  until wget -q --spider ${METEOR_URL};
  do
    echo "Waiting for ${METEOR_URL}";
    if ! ${STARTED}; then
      meteor &
      STARTED=true;
    fi;
    sleep 2;
  done

  echo "Meteor is running on ${METEOR_URL}";

  ./tests/nightwatch/runTests.js | bunyan

  killMeteorProcess
  echo "Done.";


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


  EXISTING_METEOR_PIDS=$(ps aux | grep meteor  | grep -v grep | grep ~/.meteor/packages | awk '{print $2}')
  for pid in ${EXISTING_METEOR_PIDS}; do
    echo "Kill Meteor process : ${pid}";
    kill -9 ${pid};
  done;

  popd >/dev/null;
  popd >/dev/null;

fi



explain ${DOCS}/Configure_CircleCI_for_Nightwatch_Testing.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then

  pushd ~/${PARENT_DIR}/${PROJECT_NAME} >/dev/null;

  cp tests/nightwatch/config/example_circle.yml circle.yml;
  # Add execution of ci_help.sh to circle.yml
  sed -i '/ADD_MORE_DEPENDENCY_PREPARATIONS_ABOVE_THIS_LINE/c\
    # Pull each of our packages and link them into our project\
    - ./packages/ci_help.sh\
    # ADD_MORE_DEPENDENCY_PREPARATIONS_ABOVE_THIS_LINE' circle.yml

  git add tests/nightwatch;

  set +e;    git commit -am 'Added Nightwatch testing';   set -e;
  git push

  popd >/dev/null;

fi



## FLAG FOR INCLUSION IN SLIDES - ${DOCS}/Fin.md explain

echo -e "\n\n\nDone! You have finished with 'Part06_CloudContinuousIntegration.sh'."
echo -e "\n\n   Are you ready to begin './Part07_ProductionLogging.sh'?"
echo -e "         If so, hit [y]es, or <Enter>.  If NOT then hit [n]o or <ctrl-c>."


read -p "  'y' or 'n' ::  " -n 1 -r USER_ANSWER
CHOICE=$(echo ${USER_ANSWER:0:1} | tr '[:upper:]' '[:lower:]')
if [[ "X${CHOICE}X" == "XyX"  || "X${CHOICE}X" == "XX" ]]; then
  echo -e "\n\nStarting Part #4.";
  ./Part07_ProductionLogging.sh
fi;


echo -e "\n\n";

exit 0;

