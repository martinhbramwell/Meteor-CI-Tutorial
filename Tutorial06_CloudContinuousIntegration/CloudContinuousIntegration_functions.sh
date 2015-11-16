function Add_a_CircleCI_configuration_file_and_push_to_GitHub() {


  pushd ~/${PARENT_DIR}/${PROJECT_NAME} >/dev/null;

  # Get a circle.yml file
  cp example_circle.yml circle.yml;

  git add circle.yml;
  git add tests;
  set +e;    git commit -am 'Added circle.yml and unit testing';   set -e;

#  echo -e "\n#####  eval \"\$(ssh-agent -s)\" ##### ";
  eval "$(ssh-agent -s)";

#  echo -e "\n#####  git push -u ${PROJECT_NAME}_origin master ##### ";
  git push -u ${PROJECT_NAME}_origin master;

  echo -e "

    ############################################################################################
    #   Open your CircleCI site and explore the most recent build.  In the build section at the
    #   line 'tests/tinyTests/test-all.sh' you will find that tests failed for lack of a package
    #   to test.  We need to clone our package and depend a symbolic link to it.
    ############################################################################################
    ";
  if [[ "${1}" != "${NONSTOP}" ]]; then
    echo -e "Hit <enter> when ready to continue ::  ";
    read -n 1 -r USER_ANSWER;
  fi;

  popd >/dev/null;

}

function Amend_the_configuration_and_push_again() {

  pushd ~/${PARENT_DIR} >/dev/null;
  pushd ${PROJECT_NAME} >/dev/null;

  # 'obtain_managed_packages.sh' is called by the circle.yml script.
  # It depends on the array of package descriptions in 'managed_packages.sh'
  # It loops through the listed packages, clones them and links them into the project

  wget -N -O ./packages/managed_packages.sh https://raw.githubusercontent.com/martinhbramwell/Meteor-CI-Tutorial/master/fragments/managed_packages.sh
  wget -N -O ./packages/obtain_managed_packages.sh https://raw.githubusercontent.com/martinhbramwell/Meteor-CI-Tutorial/master/fragments/obtain_managed_packages.sh

  # Fix project specific flag variables
  sed -i -e "s/\${GITHUB_ORGANIZATION_NAME}/${GITHUB_ORGANIZATION_NAME}/" ./packages/managed_packages.sh
  sed -i -e "s/\${PKG_NAME}/${PKG_NAME}/" ./packages/managed_packages.sh
  sed -i -e "s/\${YOUR_UID}/${YOUR_UID}/" ./packages/managed_packages.sh

  chmod a+x ./packages/obtain_managed_packages.sh

  # Add execution of obtain_managed_packages.sh to circle.yml
  sed -i '/ADD_MORE_DEPENDENCY_PREPARATIONS_ABOVE_THIS_LINE/c\
    # Pull each of our packages and link them into our project\
    - ./packages/obtain_managed_packages.sh\
    # ADD_MORE_DEPENDENCY_PREPARATIONS_ABOVE_THIS_LINE' circle.yml

  git add packages;
  set +e;    git commit -am 'Add script to clone packages and symlink to them';   set -e;
#  git push -u ${PROJECT_NAME}_origin master;
  git push;

  echo -e "


  #########################################################################################
  #   Open your CircleCI site and explore the most recent build.  In the build section you
  #   should find the same lines as before when we ran the test runner locally :
  #   [INFO] http://127.0.0.1:4096/packages/test-in-console.js?59dde1f. . . 07b3f499 75:17 S: tinytest - example
  #########################################################################################";

  if [[ "${1}" != "${NONSTOP}" ]]; then
    echo -e "Hit <enter> after you have confirmed that CircleCI ran successful tests ::  ";
    read -n 1 -r USER_ANSWER;
  fi;

  popd >/dev/null;
  popd >/dev/null;

}

function Prepare_for_NightWatch_testing() {

  pushd ~/${PARENT_DIR}/${PROJECT_NAME} >/dev/null;

    wget -N -N https://github.com/warehouseman/meteor-nightwatch-runner/raw/master/meteor-nightwatch-runner.run;
    chmod ug+x meteor-nightwatch-runner.run;

    ./meteor-nightwatch-runner.run;

  popd >/dev/null;

}

function Run_NightWatch_testing() {

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


  echo -e "

    #########################################################################################
    #   You ought to see lines similar to these :
    #
    #   [2015-08-16T16:26:46.081Z]  INFO: demo/11123 on PkgTestDemo: Running:  Layout and Static Pages
    #   [2015-08-16T16:26:51.343Z]  INFO: demo/11123 on PkgTestDemo: ✔ Testing if element <body> is present.
    #   [2015-08-16T16:26:51.934Z]  INFO: demo/11123 on PkgTestDemo: OK. 1 assertions passed. (5.851s)
    #   [2015-08-16T16:26:51.936Z]  INFO: demo/11123 on PkgTestDemo:
    #   [2015-08-16T16:26:51.936Z]  INFO: demo/11123 on PkgTestDemo: OK. 1 assertion passed. (6.554s)
    #   [2015-08-16T16:26:52.253Z]  INFO: demo/11123 on PkgTestDemo: Finished!  Nightwatch ran all the tests!
    #
    #########################################################################################
    ";

  if [[ "${1}" != "${NONSTOP}" ]]; then
    echo -e "Hit <enter> after you have confirmed that you have these results ::  ";
    read -n 1 -r USER_ANSWER;
  fi;


  EXISTING_METEOR_PIDS=$(ps aux | grep meteor  | grep -v grep | grep ~/.meteor/packages | awk '{print $2}')
  for pid in ${EXISTING_METEOR_PIDS}; do
    echo "Kill Meteor process : ${pid}";
    kill -9 ${pid};
  done;

  popd >/dev/null;
  popd >/dev/null;


}

function Configure_CircleCI_for_Nightwatch_Testing() {

  pushd ~/${PARENT_DIR}/${PROJECT_NAME} >/dev/null;

  cp tests/nightwatch/config/example_circle.yml circle.yml;
  # Add execution of obtain_managed_packages.sh to circle.yml
  sed -i '/ADD_MORE_DEPENDENCY_PREPARATIONS_ABOVE_THIS_LINE/c\
    # Pull each of our packages and link them into our project\
    - ./packages/obtain_managed_packages.sh\
    # ADD_MORE_DEPENDENCY_PREPARATIONS_ABOVE_THIS_LINE' circle.yml

  git add tests/nightwatch;

  set +e;    git commit -am 'Added Nightwatch testing';   set -e;
  git push

  popd >/dev/null;

}

