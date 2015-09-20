#!/bin/bash

set -e
#
if [[ $EUID -eq 0 ]]; then
   echo -e "This script SHOULD NOT be run with 'sudo' (as root). "
   exit 1
fi

DOCS="./AutomaticDocumentationInTheCloud/doc"
source ./explain.sh
source ./util.sh

explain ${DOCS}/Introduction.md



export PACKAGES=~/${PARENT_DIR}/packages
export PACKAGE_DIRS=${PACKAGES}/somebodyelse:${PACKAGES}/${YOUR_NAME}



echo ""
echo ""
explain ${DOCS}/Try_jsDoc_from_the_Command_Line_A.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then

  pushd ~/${PARENT_DIR}/${PROJECT_NAME}/

  echo -e "\n\nBefore generating documentation . . . "
  tree -L 2 ./packages/${PKG_NAME}
  jsdoc -d ./packages/${PKG_NAME}/docs ./packages/${PKG_NAME}
  echo -e "\n\n . . . after generating documentation . . . "
  tree -L 2 ./packages/${PKG_NAME}

  popd

fi


echo ""
echo ""
explain ${DOCS}/Try_jsDoc_from_the_Command_Line_B.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then

  echo "Paste this URI into your browser :"
  echo -e "\n   ${HOME}/${PARENT_DIR}/${PROJECT_NAME}/packages/${PKG_NAME}/docs/index.html\n\n"

fi


echo ""
echo ""
explain ${DOCS}/Configure_Sublime_Text_to_use_jsDoc.md



echo ""
echo ""
explain ${DOCS}/Use_Sublime_Text_jsDoc_plugin_A.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then

  pushd ~/${PARENT_DIR}/${PROJECT_NAME}/packages/${PKG_NAME}

  wget -O ${PKG_NAME}-tests.js https://raw.githubusercontent.com/martinhbramwell/Meteor-CI-Tutorial/master/fragments/yourpackage-tests.js

  popd

fi


echo ""
echo ""
explain ${DOCS}/Use_Sublime_Text_jsDoc_plugin_B.md




echo ""
echo ""
explain ${DOCS}/Use_Sublime_Text_jsDoc_plugin_C.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then

  pushd ~/${PARENT_DIR}/${PROJECT_NAME}/

  jsdoc -d ./packages/${PKG_NAME}/docs ./packages/${PKG_NAME}
  echo -e "\n Look at : ${HOME}/${PARENT_DIR}/${PROJECT_NAME}/packages/${PKG_NAME}/docs/index.html\n\n"

  popd

fi


echo ""
echo ""
explain ${DOCS}/Publish_jsDocs_toGitHub_A.md



TEMP_ZIP="/tmp/${PKG_NAME}_docs.zip"
echo ""
echo ""
explain ${DOCS}/Publish_jsDocs_toGitHub_B.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then

  pushd ~/${PARENT_DIR}/${PROJECT_NAME}/packages/${PKG_NAME}

    pushd docs

    echo -e "Zipping up the documentation directory.\n"

    rm -f ${TEMP_ZIP}
    zip -qr ${TEMP_ZIP} *

    popd

  echo -e "Committing master branch changes of the package.\n"

  set +e
  git add docs/*
  echo "additions $?"
  git commit -am "Preliminary package documentation."
  echo "committed $?"
  git push
  echo "pushed $?"
  set -e

  popd

  echo -e "Pushing to remote repo and publishing docs as a GitHub Pages website.\n"
  ./PushDocsToGitHubPagesBranch.sh ${PKG_NAME} ~/${PARENT_DIR}/${PROJECT_NAME}/packages/${PKG_NAME} ${TEMP_ZIP}


  echo -e "Removing temp file.\n"
  rm -f ${TEMP_ZIP}

fi





## FLAG FOR INCLUSION IN SLIDES - ${DOCS}/Fin.md explain

echo ""
echo -e "\nDone.  Now start up ./Part06_CloudContinuousIntegration.sh";

exit 0;

