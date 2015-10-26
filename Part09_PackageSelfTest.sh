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


RUN_RULE="";
explain ${DOCS}/Introduction.md


echo ""
echo ""
explain ${DOCS}/UsageExampleEndToEnd.md MORE_ACTION # CODE_BLOCK MANUAL_INPUT_REQUIRED
if [ "${RUN_RULE}" != "n" ]; then

  pushd ~/${PARENT_DIR}/${PROJECT_NAME} >/dev/null;
    pushd ./packages/${PKG_NAME}/tools/testing >/dev/null;

    NGHTWTCH_FILE=test_usage_example.js;
    wget -O ${NGHTWTCH_FILE} https://raw.githubusercontent.com/martinhbramwell/Meteor-CI-Tutorial/master/fragments/${NGHTWTCH_FILE}
    sed -i -e "s/\${PKG_NAME}/${PKG_NAME}/" ${NGHTWTCH_FILE}
    sed -i -e "s/\${YOUR_FULLNAME}/${YOUR_FULLNAME}/" ${NGHTWTCH_FILE}
    sed -i -e "s/\${YOUR_EMAIL}/${YOUR_EMAIL}/" ${NGHTWTCH_FILE}

    popd >/dev/null;

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

  rm -fr ./docs
  jsdoc -d ./docs . ./tools/testing;
  echo -e "\n Documentation has been generated locally ..."
  echo -e "\n Look at : file://${HOME}/${PARENT_DIR}/${PROJECT_NAME}/packages/${PKG_NAME}/docs/index.html\n\n"

  popd >/dev/null;

fi

echo ""
echo ""
explain ${DOCS}/IntegratingEverything.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then

  pushd ~/${PARENT_DIR}/${PROJECT_NAME} >/dev/null;
    pushd packages/${PKG_NAME} >/dev/null;

      echo -e "Committing master branch changes of the package.\n"

      set +e
      echo -e "Adding all remaining files.\n";
      git add tools;
      git add .eslintrc;
      git add usage_example.html;
      git add usage_example.js;
      echo "Increment package version number"
      sed -i -r 's/(.*)(version: .)([0-9]+\.[0-9]+\.)([0-9]+)(.*)/echo "\1\2\3$((\4+1))\5"/ge' package.js;
      echo "git add errors : $?"
      git commit -am "save all we have done so far";
      echo "git commit errors : $?"
      git push
      echo "git push errors : $?"
      set -e

    popd >/dev/null;

    meteor list;
    git commit -am "catch update to '${PKG_NAME}'";
    echo "git commit errors : $?"
    git push
    echo "git push errors : $?"

  popd >/dev/null;
fi




echo ""
echo ""
TEMP_ZIP="/tmp/${PKG_NAME}_docs.zip"
explain ${DOCS}/CodeLintingHelperFile.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then

  pushd ~/${PARENT_DIR}/${PROJECT_NAME}/packages/${PKG_NAME} >/dev/null;

    pushd docs >/dev/null;

      echo -e "Zipping up the documentation directory.\n"

      rm -f ${TEMP_ZIP}
      zip -qr ${TEMP_ZIP} *

    popd >/dev/null;

    echo -e "Committing master branch changes of the package.\n"

    set +e
    echo -e "Adding all remaining files.\n"
    git add docs/*
    git add usage_example*;
    git add nightwatch;
    git add backup;
    echo "Increment package version number"
    sed -i -r 's/(.*)(version: .)([0-9]+\.[0-9]+\.)([0-9]+)(.*)/echo "\1\2\3$((\4+1))\5"/ge' package.js;
    echo "git add errors : $?"
    git commit -am "now it is self-documenting and self-testing";
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

  pushd ~/${PARENT_DIR}/${PROJECT_NAME} >/dev/null;

    meteor list;
    git commit -am "new tests in nightwatch";
    echo "git commit errors : $?"
    git push
    echo "git push errors : $?"

  popd >/dev/null;
fi




echo ""
echo ""
RUN_RULE="";
explain ${DOCS}/FirstPage.md


echo ""
echo ""
RUN_RULE="";
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
