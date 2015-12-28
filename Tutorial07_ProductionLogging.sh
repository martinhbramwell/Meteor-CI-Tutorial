#!/bin/bash

set -e;
#
source ./scripts/manageShellVars.sh;
source ./scripts/util.sh

checkForVirtualMachine;
checkNotRoot;

export SUDOUSER=$(who am i | awk '{print $1}');

collectSectionNames;

setSection 7;
source "${BINDIR}/${SECTION}_functions.sh";


source ./scripts/explain.sh

RUN_RULE="";
explain ${BINDIR}/Introduction.md


RUN_RULE="";
explain ${BINDIR}/Observe_ordinary_console_logging.md # MANUAL_INPUT_REQUIRED

RUN_RULE="";
explain ${BINDIR}/Add_an_NPM_module_to_your_package.md # MANUAL_INPUT_REQUIRED

RUN_RULE="";
explain ${BINDIR}/Specify_Npm_modules.md # MANUAL_INPUT_REQUIRED

RUN_RULE="";
explain ${BINDIR}/Bunyan_Server_Side_OnlyLogging.md # MANUAL_INPUT_REQUIRED

RUN_RULE="";
explain ${BINDIR}/Add_Bunyan_Logging.md # MANUAL_INPUT_REQUIRED

RUN_RULE="";
explain ${BINDIR}/Goodbye_console.md # MANUAL_INPUT_REQUIRED

RUN_RULE="";
explain ${BINDIR}/Refactor_Bunyan_InstantiationA.md MORE_ACTION # CODE_BLOCK MANUAL_INPUT_REQUIRED
if [ "${RUN_RULE}" != "n" ]; then Refactor_Bunyan_InstantiationA; fi;

RUN_RULE="";
explain ${BINDIR}/Refactor_Bunyan_InstantiationB.md # MANUAL_INPUT_REQUIRED

explain ${BINDIR}/Package_Upgrade_and_Project_Rebuild_A.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then Package_Upgrade_and_Project_Rebuild_A; fi;

explain ${BINDIR}/Package_Upgrade_and_Project_Rebuild_B.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then Package_Upgrade_and_Project_Rebuild_B; fi;


## FLAG FOR INCLUSION IN SLIDES - ${BINDIR}/Fin.md explain

endOfSectionScript ${SECTION_NUM} ${SECTION} ${NEXT_SECTION};


exit 0;

