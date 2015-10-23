#!/bin/bash
set -e
#
if [[ $EUID -eq 0 ]]; then
   echo -e "This script SHOULD NOT be run with 'sudo' (as root). "
   exit 1
fi


DOCS="./RealWorldPackage/doc"
source ./explain.sh
source ./util.sh


RUN_RULE="";
explain ${DOCS}/Introduction.md

echo ""
echo ""
RUN_RULE="";
explain ${DOCS}/Another_NodeJS_moduleA.md # MANUAL_INPUT_REQUIRED

echo ""
echo ""
explain ${DOCS}/Another_NodeJS_moduleB.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then

  pushd ~/${PARENT_DIR}/${PROJECT_NAME}/packages/${PKG_NAME} >/dev/null;

  mkdir -p tools/testing
  pushd ./tools/testing >/dev/null;

  wget https://raw.githubusercontent.com/martinhbramwell/Meteor-CI-Tutorial/master/fragments/reloadSwaggerPetStore.sh
  chmod a+x reloadSwaggerPetStore.sh

  popd >/dev/null;
  popd >/dev/null;

fi

echo ""
echo ""
explain ${DOCS}/Another_NodeJS_moduleC.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then

  pushd ~/${PARENT_DIR}/${PROJECT_NAME} >/dev/null;
  pushd ./packages/${PKG_NAME} >/dev/null;

  source ./tools/testing/reloadSwaggerPetStore.sh
  reloadSwaggerPetStore
  wget -O ${PKG_NAME}.js https://raw.githubusercontent.com/martinhbramwell/Meteor-CI-Tutorial/master/fragments/yourpackage.js

  popd >/dev/null;
  
  killMeteorProcess
  launchMeteorProcess "http://localhost:3000/"
  echo "Contacting Swagger Pet Store . . . "
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
explain ${DOCS}/Async_Problem_Buried_Methods.md

echo ""
echo ""
RUN_RULE="";
explain ${DOCS}/Async_Problem_Wrapped_Proxy_A.md # MANUAL_INPUT_REQUIRED

echo ""
echo ""
RUN_RULE="";
explain ${DOCS}/Async_Problem_Wrapped_Proxy_B.md  # MANUAL_INPUT_REQUIRED


echo ""
echo ""
RUN_RULE="";
explain ${DOCS}/Async_Problem_Sync_Namespace.md # MANUAL_INPUT_REQUIRED

echo ""
echo ""
RUN_RULE="";
explain ${DOCS}/Async_Problem_TinyTest_A.md # MANUAL_INPUT_REQUIRED

echo ""
echo ""
RUN_RULE="";
explain ${DOCS}/Call_Into_Package_Methods.md MORE_ACTION # CODE_BLOCK MANUAL_INPUT_REQUIRED
if [ "${RUN_RULE}" != "n" ]; then

  pushd ~/${PARENT_DIR}/${PROJECT_NAME}/packages/${PKG_NAME} >/dev/null;

  wget -N https://raw.githubusercontent.com/martinhbramwell/Meteor-CI-Tutorial/master/fragments/usage_example.js
  wget -N https://raw.githubusercontent.com/martinhbramwell/Meteor-CI-Tutorial/master/fragments/usage_example.html
  sed -i -e "s/\${PKG_NAME}/${PKG_NAME}/" usage_example.html
  sed -i -e "s/\${GITHUB_ORGANIZATION_NAME}/${GITHUB_ORGANIZATION_NAME}/" usage_example.html
  popd >/dev/null;

fi

echo ""
echo ""
RUN_RULE="";
explain ${DOCS}/Package_Dependencies.md # MANUAL_INPUT_REQUIRED

echo ""
echo ""
RUN_RULE="";
explain ${DOCS}/Declare_Callable_Method.md # MANUAL_INPUT_REQUIRED

echo ""
echo ""
explain ${DOCS}/View_and_Hide_The_Example.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then

  pushd ~/${PARENT_DIR}/${PROJECT_NAME} >/dev/null;

  killMeteorProcess
  launchMeteorProcess "http://localhost:3000/"
  echo -e "\n\n     Open the URL http://localhost:3000/\n"

  read -p "To continue hit <enter> ::  " -n 1 -r USER_ANSWER
  killMeteorProcess

  popd >/dev/null;

fi




## FLAG FOR INCLUSION IN SLIDES - ${DOCS}/Fin.md explain

echo -e "\n\n\nDone! You have finished with 'Part08_RealWorldPackage.sh'."
echo -e "\n\n   Are you ready to begin './Part09_PackageSelfTest.sh'?"
echo -e "         If so, hit [y]es, or <Enter>.  If NOT then hit [n]o or <ctrl-c>."


read -p "  'y' or 'n' ::  " -n 1 -r USER_ANSWER
CHOICE=$(echo ${USER_ANSWER:0:1} | tr '[:upper:]' '[:lower:]')
if [[ "X${CHOICE}X" == "XyX"  || "X${CHOICE}X" == "XX" ]]; then
  echo -e "\n\nStarting Part #4.";
  ./Part09_PackageSelfTest.sh
fi;


echo -e "\n\n";

exit 0;

