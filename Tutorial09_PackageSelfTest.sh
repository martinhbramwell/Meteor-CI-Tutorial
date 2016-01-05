#!/bin/bash

set -e;
#
source ./scripts/manageShellVars.sh;
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


explain ${BINDIR}/PushDocsToGitHubPagesFromCIBuild_A.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then PushDocsToGitHubPagesFromCIBuild_A; fi;

explain ${BINDIR}/PushDocsToGitHubPagesFromCIBuild_B.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then PushDocsToGitHubPagesFromCIBuild_B; fi;

explain ${BINDIR}/InspectBuildResults.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then InspectBuildResults; fi;

explain ${BINDIR}/ReportAnIssue.md # CODE_BLOCK MANUAL_INPUT_REQUIRED
if [ "${RUN_RULE}" != "n" ]; then ReportAnIssue; fi;



## FLAG FOR INCLUSION IN SLIDES - ${BINDIR}/Fin.md explain

endOfSectionScript ${SECTION_NUM} ${SECTION} ${NEXT_SECTION};


exit 0;



