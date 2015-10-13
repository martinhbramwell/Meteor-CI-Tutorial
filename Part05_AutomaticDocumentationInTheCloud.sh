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
export PACKAGE_DIRS=${PACKAGES}/thirdparty:${PACKAGES}/${YOUR_UID}



echo ""
echo ""
explain ${DOCS}/Try_jsDoc_from_the_Command_Line_A.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then

  pushd ~/${PARENT_DIR}/${PROJECT_NAME}/ >/dev/null;

  echo -e "\n\nBefore generating documentation . . . "
  tree -L 2 ./packages/${PKG_NAME}
  jsdoc -d ./packages/${PKG_NAME}/docs ./packages/${PKG_NAME}
  echo -e "\n\n . . . after generating documentation . . . "
  tree -L 2 ./packages/${PKG_NAME}

  popd >/dev/null;

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
RUN_RULE="";
explain ${DOCS}/Configure_Sublime_Text_to_use_jsDoc.md



echo ""
echo ""
explain ${DOCS}/Use_Sublime_Text_jsDoc_plugin_A.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then

  pushd ~/${PARENT_DIR}/${PROJECT_NAME}/packages/${PKG_NAME} >/dev/null;

  wget -O ${PKG_NAME}-tests.js https://raw.githubusercontent.com/martinhbramwell/Meteor-CI-Tutorial/master/fragments/yourpackage-tests.js

  popd >/dev/null;

fi


echo ""
echo ""
RUN_RULE="";
explain ${DOCS}/Use_Sublime_Text_jsDoc_plugin_B.md




echo ""
echo ""
explain ${DOCS}/Use_Sublime_Text_jsDoc_plugin_C.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then

  pushd ~/${PARENT_DIR}/${PROJECT_NAME}/ >/dev/null;

  jsdoc -d ./packages/${PKG_NAME}/docs ./packages/${PKG_NAME}
  echo -e "\n Look at : ${HOME}/${PARENT_DIR}/${PROJECT_NAME}/packages/${PKG_NAME}/docs/index.html\n\n"

  popd >/dev/null;

fi


echo ""
echo ""
RUN_RULE="";
explain ${DOCS}/Publish_jsDocs_toGitHub_A.md



TEMP_ZIP="/tmp/${PKG_NAME}_docs.zip"
echo ""
echo ""
explain ${DOCS}/Publish_jsDocs_toGitHub_B.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then

  pushd ~/${PARENT_DIR}/${PROJECT_NAME}/packages/${PKG_NAME} >/dev/null;

    pushd docs >/dev/null;

      echo -e "Zipping up the documentation directory.\n"

      rm -f ${TEMP_ZIP}
      zip -qr ${TEMP_ZIP} *

    popd >/dev/null;

    echo -e "Committing master branch changes of the package.\n"

    set +e
    git add docs/*
    echo "git add errors : $?"
    git commit -am "Preliminary package documentation."
    echo "git commit errors : $?"
    git push
    echo "git push errors : $?"
    set -e

  popd >/dev/null;

  echo -e "Pushing to remote repo and publishing docs as a GitHub Pages website.\n"
  ./PushDocsToGitHubPagesBranch.sh ${PKG_NAME} ~/${PARENT_DIR}/${PROJECT_NAME}/packages/${PKG_NAME} ${TEMP_ZIP} ${PKG_NAME}_origin

  echo -e "Removing temp file.\n"
  rm -f ${TEMP_ZIP}

  echo -e "To see your documentation on-line, open this link:\n\n          https://${GITHUB_ORGANIZATION_NAME}.github.io/${PKG_NAME}/"
  rm -f ${TEMP_ZIP}

fi


## FLAG FOR INCLUSION IN SLIDES - ${DOCS}/Fin.md explain

echo -e "\n\n\nDone! You have finished with 'Part05_AutomaticDocumentationInTheCloud.sh'."
echo -e "\n\n   Are you ready to begin './Part06_CloudContinuousIntegration.sh'?"
echo -e "         If so, hit [y]es, or <Enter>.  If NOT then hit [n]o or <ctrl-c>."


read -p "  'y' or 'n' ::  " -n 1 -r USER_ANSWER
CHOICE=$(echo ${USER_ANSWER:0:1} | tr '[:upper:]' '[:lower:]')
if [[ "X${CHOICE}X" == "XyX"  || "X${CHOICE}X" == "XX" ]]; then
  echo -e "\n\nStarting Part #4.";
  ./Part06_CloudContinuousIntegration.sh
fi;

echo -e "\n\n";

exit 0;

