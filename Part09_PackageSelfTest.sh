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
  sed -i -e "s/\${PACKAGE_DEVELOPER}/${PACKAGE_DEVELOPER}/" ${NGHTWTCH_FILE}
  sed -i -e "s/\${YOUR_EMAIL}/${YOUR_EMAIL}/" ${NGHTWTCH_FILE}

  popd >/dev/null;


  pushd ~/${PARENT_DIR}/${PROJECT_NAME} >/dev/null;

  ./tests/nightwatch/runTests.js | bunyan

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
