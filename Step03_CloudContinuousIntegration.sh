#!/bin/bash
#
if [[ $EUID -eq 0 ]]; then
   echo -e "This script SHOULD NOT be run with 'sudo' (as root). "
   exit 1
fi

DOCS="./CloudContinuousIntegration/doc" 
source ./explain.sh
source ./util.sh

highlight ${DOCS}/Introduction.md
read -p "Hit <enter> ::  " -n 1 -r USER_ANSWER


explain ${DOCS}/Add_a_CircleCI_configuration_file_and_push_to_GitHub.md # CODE_BLOCK
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





explain ${DOCS}/Prepare_for_NightWatch_testing.md # CODE_BLOCK
if [ $? -eq 0 ]; then

  pushd ~/${PARENT_DIR}
  pushd ${PROJECT_NAME}

  wget -N https://github.com/warehouseman/meteor-nightwatch-runner/raw/master/meteor-nightwatch-runner.run
  chmod ug+x meteor-nightwatch-runner.run

  ./meteor-nightwatch-runner.run
  popd
  popd

fi


explain ${DOCS}/Run_NightWatch_testing.md # CODE_BLOCK
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



explain ${DOCS}/Push_Nightwatch_testing_to_GitHub_and_CircleCI.md # CODE_BLOCK
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


echo ""
echo ""
highlight ${DOCS}/Observe_ordinary_console_logging.md
read -p "To continue hit <enter> ::  " -n 1 -r USER_ANSWER

echo ""
echo ""
highlight ${DOCS}/Add_an_NPM_module_to_your_package.md
read -p "To continue hit <enter> ::  " -n 1 -r USER_ANSWER

echo ""
echo ""
highlight ${DOCS}/Specify_Npm_modules.md
read -p "To continue hit <enter> ::  " -n 1 -r USER_ANSWER

echo ""
echo ""
highlight ${DOCS}/dummy.md
read -p "To continue hit <enter> ::  " -n 1 -r USER_ANSWER

echo ""
echo ""
highlight ${DOCS}/dummy.md
read -p "To continue hit <enter> ::  " -n 1 -r USER_ANSWER


# echo ""
# echo ""
# highlight ${DOCS}/dummy.md
# read -p "To continue hit <enter> ::  " -n 1 -r USER_ANSWER




echo -e "\nDone.";
exit 0;

# explain "#  FIXME
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
