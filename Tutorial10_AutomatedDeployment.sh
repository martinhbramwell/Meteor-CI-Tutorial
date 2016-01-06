#!/bin/bash

set -e;
#
source ./scripts/manageShellVars.sh;
source ./scripts/util.sh;

checkForVirtualMachine;
checkNotRoot;

export SUDOUSER=$(who am i | awk '{print $1}');

collectSectionNames;

setSection 10;
source "${BINDIR}/${SECTION}_functions.sh";


source ./scripts/explain.sh

RUN_RULE="";
explain ${BINDIR}/Introduction.md


explain ${BINDIR}/PrepareAndroidSDK_A.md;

explain ${BINDIR}/PrepareAndroidSDK_B.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then PrepareAndroidSDK_B; fi;

explain ${BINDIR}/BuildAndroidAPK_A.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then BuildAndroidAPK_A; fi;

explain ${BINDIR}/BuildAndroidAPK_B.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then BuildAndroidAPK_B; fi;

explain ${BINDIR}/DeployToMeteorServers.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then DeployToMeteorServers; fi;

explain ${BINDIR}/PrepareCIwithAndroidSDK.md MORE_ACTION # CODE_BLOCK MANUAL_INPUT_REQUIRED
if [ "${RUN_RULE}" != "n" ]; then PrepareCIwithAndroidSDK; fi;

explain ${BINDIR}/PrepareCIwithAndroidBuilder.md MORE_ACTION # CODE_BLOCK MANUAL_INPUT_REQUIRED
if [ "${RUN_RULE}" != "n" ]; then PrepareCIwithAndroidBuilder; fi;

explain ${BINDIR}/PrepareCIwithMeteorDeployment.md MORE_ACTION # CODE_BLOCK MANUAL_INPUT_REQUIRED
if [ "${RUN_RULE}" != "n" ]; then PrepareCIwithMeteorDeployment; fi;

explain ${BINDIR}/PushFinalChanges.md MORE_ACTION # CODE_BLOCK MANUAL_INPUT_REQUIRED
if [ "${RUN_RULE}" != "n" ]; then PushFinalChanges; fi;


## FLAG FOR INCLUSION IN SLIDES - ${BINDIR}/Fin.md explain

### endOfSectionScript ${SECTION_NUM} ${SECTION} ${NEXT_SECTION};


exit 0;

