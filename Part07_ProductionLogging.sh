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


explain ${DOCS}/Introduction.md


echo ""
echo ""
explain ${DOCS}/Observe_ordinary_console_logging.md

echo ""
echo ""
explain ${DOCS}/Add_an_NPM_module_to_your_package.md

echo ""
echo ""
explain ${DOCS}/Specify_Npm_modules.md

echo ""
echo ""
explain ${DOCS}/Bunyan_Server_Side_OnlyLogging.md

echo ""
echo ""
explain ${DOCS}/Add_Bunyan_Logging.md

echo ""
echo ""
explain ${DOCS}/Goodbye_console.md

echo ""
echo ""
explain ${DOCS}/Refactor_Bunyan_InstantiationA.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then

  pushd ~/${PARENT_DIR}/${PROJECT_NAME}/packages/${PKG_NAME} >/dev/null;

  wget -O logger.js https://raw.githubusercontent.com/martinhbramwell/Meteor-CI-Tutorial/master/fragments/logger.js
  sed -i -e "s/\${PKG_NAME}/${PKG_NAME}/" logger.js

  popd >/dev/null;

fi


echo ""
echo ""
explain ${DOCS}/Refactor_Bunyan_InstantiationB.md


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

