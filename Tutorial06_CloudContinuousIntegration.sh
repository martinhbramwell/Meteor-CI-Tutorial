#!/bin/bash

set -e;
#
source ./scripts/util.sh

checkForVirtualMachine;
checkNotRoot;

export SUDOUSER=$(who am i | awk '{print $1}');

collectSectionNames;

setSection 6;
source "${BINDIR}/${SECTION}_functions.sh";

source ./scripts/explain.sh

RUN_RULE="";
explain ${BINDIR}/Introduction.md

RUN_RULE="";
explain ${BINDIR}/Connect_CircleCI_to_GitHub_A.md # MANUAL_INPUT_REQUIRED

RUN_RULE="";
explain ${BINDIR}/Connect_CircleCI_to_GitHub_B.md MORE_ACTION # CODE_BLOCK MANUAL_INPUT_REQUIRED
if [ "${RUN_RULE}" != "n" ]; then Connect_CircleCI_to_GitHub_B; fi;

explain ${BINDIR}/Add_a_CircleCI_configuration_file_and_push_to_GitHub.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then Add_a_CircleCI_configuration_file_and_push_to_GitHub; fi;

explain ${BINDIR}/Amend_the_configuration_and_push_again.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then Amend_the_configuration_and_push_again; fi;

explain ${BINDIR}/Prepare_for_NightWatch_testing.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then Prepare_for_NightWatch_testing; fi;

explain ${BINDIR}/Run_NightWatch_testing.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then Run_NightWatch_testing; fi;

explain ${BINDIR}/Configure_CircleCI_for_Nightwatch_Testing.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then Configure_CircleCI_for_Nightwatch_Testing; fi;

# FIXME : Push_Nightwatch_testing_to_GitHub_and_CircleCI.md  ???????????

## FLAG FOR INCLUSION IN SLIDES - ${BINDIR}/Fin.md explain

endOfSectionScript ${SECTION_NUM} ${SECTION} ${NEXT_SECTION};


exit 0;


