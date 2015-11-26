#!/bin/bash

set -e;
#
source ./scripts/util.sh

checkForVirtualMachine;
checkNotRoot;

export SUDOUSER=$(who am i | awk '{print $1}');

collectSectionNames;

setSection 9;
source "${BINDIR}/${SECTION}_functions.sh";


source ./scripts/explain.sh

RUN_RULE="";
explain ${BINDIR}/Introduction.md


explain ${BINDIR}/UsageExampleEndToEnd.md MORE_ACTION # CODE_BLOCK MANUAL_INPUT_REQUIRED
if [ "${RUN_RULE}" != "n" ]; then UsageExampleEndToEnd; fi;


explain ${BINDIR}/FinishDocumentation.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then FinishDocumentation; fi;

explain ${BINDIR}/IntegratingEverything.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then IntegratingEverything; fi;

explain ${BINDIR}/CodeMaintenanceHelperFile_A.md;

explain ${BINDIR}/CodeMaintenanceHelperFile_B.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then CodeMaintenanceHelperFile_B; fi;

explain ${BINDIR}/CodeMaintenanceHelperFile_C.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then CodeMaintenanceHelperFile_C; fi;

explain ${BINDIR}/ScriptAuthorization.md MORE_ACTION # CODE_BLOCK MANUAL_INPUT_REQUIRED
if [ "${RUN_RULE}" != "n" ]; then ScriptAuthorization; fi;

explain ${BINDIR}/PushDocsToGitHubPagesFromCIBuild.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then PushDocsToGitHubPagesFromCIBuild; fi;




echo -e " * * Curtailed * * "
exit;


explain ${BINDIR}/LastPage.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then

  TEMP_ZIP="/tmp/${PKG_NAME}_docs.zip"
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




RUN_RULE="";
explain ${BINDIR}/FirstPage.md



## FLAG FOR INCLUSION IN SLIDES - ${BINDIR}/Fin.md explain

explain \
${BINDIR}/dummy.md

explain  \
${BINDIR}/dummy.md


# echo ""
# echo ""
# explain  \
# ${BINDIR}/dummy.md




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
