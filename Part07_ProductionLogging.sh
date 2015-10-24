#!/bin/bash
set -e
#
if [[ $EUID -eq 0 ]]; then
   echo -e "This script SHOULD NOT be run with 'sudo' (as root). "
   exit 1
fi


DOCS="./ProductionLogging/doc"
source ./explain.sh
source ./util.sh


RUN_RULE="";
explain ${DOCS}/Introduction.md

echo ""
echo ""
RUN_RULE="";
explain ${DOCS}/Observe_ordinary_console_logging.md # MANUAL_INPUT_REQUIRED

echo ""
echo ""
RUN_RULE="";
explain ${DOCS}/Add_an_NPM_module_to_your_package.md # MANUAL_INPUT_REQUIRED

echo ""
echo ""
RUN_RULE="";
explain ${DOCS}/Specify_Npm_modules.md # MANUAL_INPUT_REQUIRED

echo ""
echo ""
RUN_RULE="";
explain ${DOCS}/Bunyan_Server_Side_OnlyLogging.md # MANUAL_INPUT_REQUIRED

echo ""
echo ""
RUN_RULE="";
explain ${DOCS}/Add_Bunyan_Logging.md # MANUAL_INPUT_REQUIRED

echo ""
echo ""
RUN_RULE="";
explain ${DOCS}/Goodbye_console.md # MANUAL_INPUT_REQUIRED

echo ""
echo ""
RUN_RULE="";
explain ${DOCS}/Refactor_Bunyan_InstantiationA.md MORE_ACTION # CODE_BLOCK MANUAL_INPUT_REQUIRED
if [ "${RUN_RULE}" != "n" ]; then

  pushd ~/${PARENT_DIR}/${PROJECT_NAME}/packages/${PKG_NAME} >/dev/null;

  wget -O logger.js https://raw.githubusercontent.com/martinhbramwell/Meteor-CI-Tutorial/master/fragments/logger.js
  sed -i -e "s/\${PKG_NAME}/${PKG_NAME}/" logger.js

  popd >/dev/null;

fi

echo ""
echo ""
RUN_RULE="";
explain ${DOCS}/Refactor_Bunyan_InstantiationB.md # MANUAL_INPUT_REQUIRED


echo ""
echo ""
explain ${DOCS}/Package_Upgrade_and_Project_Rebuild_A.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then

  pushd ~/${PARENT_DIR}/${PROJECT_NAME} >/dev/null;
  
  killMeteorProcess
  launchMeteorProcess "http://localhost:3000/"  "test-packages"
  sleep 10
  echo "The 'tail' command shows . . . "
  tail -n 9 /var/log/meteor/ci4meteor.log  | bunyan -o short
  echo ". . . the tail end of log file.\n"

  popd >/dev/null;

  killMeteorProcess
  read -p "To continue hit <enter> ::  " -n 1 -r USER_ANSWER

fi



echo ""
echo ""
explain ${DOCS}/Package_Upgrade_and_Project_Rebuild_B.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then

  killMeteorProcess

  pushd ~/${PARENT_DIR}/${PROJECT_NAME} >/dev/null;
  pushd ./packages/${PKG_NAME} >/dev/null;


  touch .gitignore;
  [[ $(grep -c ".npm" .gitignore) -lt 1 ]] && echo ".npm" >> .gitignore;
  git add .gitignore;
  git add logger.js;
  sed -i -r 's/(.*)(version: .)([0-9]+\.[0-9]+\.)([0-9]+)(.*)/echo "\1\2\3$((\4+1))\5"/ge' package.js;
  git commit -am 'add logging';
  git push;

  popd >/dev/null;

  meteor list;
  git commit -am 'added logging to ${PKG_NAME}';
  git push;

  popd >/dev/null;

fi


## FLAG FOR INCLUSION IN SLIDES - ${DOCS}/Fin.md explain

echo -e "\n\n\nDone! You have finished with 'Part07_ProductionLogging.sh'."
echo -e "\n\n   Are you ready to begin './Part08_RealWorldPackage.sh'?"
echo -e "         If so, hit [y]es, or <Enter>.  If NOT then hit [n]o or <ctrl-c>."


read -p "  'y' or 'n' ::  " -n 1 -r USER_ANSWER
CHOICE=$(echo ${USER_ANSWER:0:1} | tr '[:upper:]' '[:lower:]')
if [[ "X${CHOICE}X" == "XyX"  || "X${CHOICE}X" == "XX" ]]; then
  echo -e "\n\nStarting Part #4.";
  ./Part08_RealWorldPackage.sh
fi;


echo -e "\n\n";

exit 0;

