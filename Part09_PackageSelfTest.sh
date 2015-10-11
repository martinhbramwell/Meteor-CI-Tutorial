#!/bin/bash
set -e
#
if [[ $EUID -eq 0 ]]; then
   echo -e "This script SHOULD NOT be run with 'sudo' (as root). "
   exit 1
fi


DOCS="./PackageSelfTest/doc"
source ./explain.sh
source ./util.sh


explain ${DOCS}/Introduction.md


echo ""
echo ""
explain ${DOCS}/UsageExampleEndToEnd.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then

  NGHTWTCH=~/${PARENT_DIR}/${PROJECT_NAME}/packages/${PKG_NAME}/nightwatch;
  mkdir -p ${NGHTWTCH};

  pushd ${NGHTWTCH} >/dev/null;

  NGHTWTCH_FILE=test_usage_example.js;
  wget -O ${NGHTWTCH_FILE} https://raw.githubusercontent.com/martinhbramwell/Meteor-CI-Tutorial/master/fragments/${NGHTWTCH_FILE}
  sed -i -e "s/\${PKG_NAME}/${PKG_NAME}/" ${NGHTWTCH_FILE}
  sed -i -e "s/\${YOUR_FULLNAME}/${YOUR_FULLNAME}/" ${NGHTWTCH_FILE}
  sed -i -e "s/\${YOUR_EMAIL}/${YOUR_EMAIL}/" ${NGHTWTCH_FILE}

  popd >/dev/null;


  pushd ~/${PARENT_DIR}/${PROJECT_NAME} >/dev/null;

  killMeteorProcess
  launchMeteorProcess "http://localhost:3000/"

  ./tests/nightwatch/runTests.js | bunyan

  killMeteorProcess

  popd >/dev/null;

fi


echo ""
echo ""
explain ${DOCS}/FinishDocumentation.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then

  pushd ~/${PARENT_DIR}/${PROJECT_NAME}/packages/${PKG_NAME} >/dev/null;

  mkdir -p backup
  cp ${PKG_NAME}.js backup/${PKG_NAME}_$(date +%Y%m%d%H%M).js
  cp usage_example.js backup/usage_example_$(date +%Y%m%d%H%M).js

  wget -O ${PKG_NAME}.js https://raw.githubusercontent.com/martinhbramwell/Meteor-CI-Tutorial/master/fragments/yourpackage_documented.js
  sed -i -e "s/\${PKG_NAME}/${PKG_NAME}/" ${PKG_NAME}.js;
  sed -i -e "s/\${YOUR_FULLNAME}/${YOUR_FULLNAME}/" ${PKG_NAME}.js;
  sed -i -e "s/\${YOUR_EMAIL}/${YOUR_EMAIL}/" ${PKG_NAME}.js;

  wget -O usage_example.js https://raw.githubusercontent.com/martinhbramwell/Meteor-CI-Tutorial/master/fragments/usage_example_documented.js
  sed -i -e "s/\${PKG_NAME}/${PKG_NAME}/" usage_example.js;
  sed -i -e "s/\${YOUR_FULLNAME}/${YOUR_FULLNAME}/" usage_example.js;
  sed -i -e "s/\${YOUR_EMAIL}/${YOUR_EMAIL}/" usage_example.js;

  jsdoc -d ./docs . ./nightwatch;
  echo -e "\n Documentation hs been generated ..."
  echo -e "\n Look at : ${HOME}/${PARENT_DIR}/${PROJECT_NAME}/packages/${PKG_NAME}/docs/index.html\n\n"

  popd >/dev/null;

fi


echo ""
echo ""
explain ${DOCS}/FirstPage.md


echo ""
echo ""
explain ${DOCS}/LastPage.md



## FLAG FOR INCLUSION IN SLIDES - ${DOCS}/Fin.md explain

echo ""
echo ""
explain \
${DOCS}/dummy.md

echo ""
echo ""
explain  \
${DOCS}/dummy.md


# echo ""
# echo ""
# explain  \
# ${DOCS}/dummy.md




echo -e "\nDone.";
exit 0;

# explain "#  FIXME
# \n#
# \n#
# \n#  "
# if [ $? -eq 0 ]; then

#   pushd ~/${PARENT_DIR} >/dev/null;
#   pushd ${PROJECT_NAME} >/dev/null;


#   popd >/dev/null;
#   popd >/dev/null;

# fi


echo "Done.";
exit 0;
