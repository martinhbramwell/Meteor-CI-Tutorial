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


export PACKAGES=~/${PARENT_DIR}/packages
export PACKAGE_DIRS=${PACKAGES}/somebodyelse:${PACKAGES}/${YOUR_NAME}


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


## FLAG FOR INCLUSION IN SLIDES - ${DOCS}/Fin.md explain

echo ""
echo -e "\nDone.  Now start up ./Part03_CloudContinuousIntegration.sh";

exit 0;

