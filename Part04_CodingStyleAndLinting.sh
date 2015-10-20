#!/bin/bash

set -e
#
if [[ $EUID -eq 0 ]]; then
   echo -e "This script SHOULD NOT be run with 'sudo' (as root). "
   exit 1
fi

DOCS="./CodingStyleAndLinting/doc"
source ./explain.sh
source ./util.sh

explain ${DOCS}/Introduction.md


export PACKAGES=~/${PARENT_DIR}/packages
export PACKAGE_DIRS=${PACKAGES}/thirdparty:${PACKAGES}/${YOUR_UID}


echo ""
echo ""
explain ${DOCS}/Try_ESLint_from_the_Command_Line.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then

  pushd ~/${PARENT_DIR}/${PROJECT_NAME}/ >/dev/null;
  set +e
  eslint ./${PROJECT_NAME}.js
  set -e
  popd >/dev/null;

fi

echo ""
echo ""
RUN_RULE="";
explain ${DOCS}/Configure_Sublime_Text_to_use_ESLint.md # MANUAL_INPUT_REQUIRED

echo ""
echo ""
RUN_RULE="";
explain ${DOCS}/Customize_ESLint_in_Sublime_Text.md # MANUAL_INPUT_REQUIRED

echo ""
echo ""
RUN_RULE="";
explain ${DOCS}/Try_ESLint_in_Sublime_Text.md # MANUAL_INPUT_REQUIRED

echo ""
echo ""
explain ${DOCS}/Try_ESLint_Command_Line_Again.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then

  pushd ~/${PARENT_DIR}/${PROJECT_NAME}/ >/dev/null;
  set +e
  eslint ./packages/${PKG_NAME}/${PKG_NAME}-tests.js
  set -e
  popd >/dev/null;

fi


## FLAG FOR INCLUSION IN SLIDES - ${DOCS}/Fin.md explain


echo -e "\n\n\nDone! You have finished with 'Part04_CodingStyleAndLinting.sh'."
echo -e "\n\n   Are you ready to begin './Part05_AutomaticDocumentationInTheCloud.sh'?"
echo -e "         If so, hit [y]es, or <Enter>.  If NOT then hit [n]o or <ctrl-c>."


read -p "  'y' or 'n' ::  " -n 1 -r USER_ANSWER
CHOICE=$(echo ${USER_ANSWER:0:1} | tr '[:upper:]' '[:lower:]')
if [[ "X${CHOICE}X" == "XyX"  || "X${CHOICE}X" == "XX" ]]; then
  echo -e "\n\nStarting Part #4.";
  ./Part05_AutomaticDocumentationInTheCloud.sh
fi;


echo -e "\n\n";

exit 0;

