#!/bin/bash

set -e;
#
source ./scripts/manageShellVars.sh;
source ./scripts/util.sh;

checkForVirtualMachine;
checkNotRoot;

export SUDOUSER=$(who am i | awk '{print $1}');

collectSectionNames;

setSection 4;
source "${BINDIR}/${SECTION}_functions.sh";

source ./scripts/explain.sh

RUN_RULE="";
explain ${BINDIR}/Introduction.md

explain ${BINDIR}/Try_ESLint_from_the_Command_Line.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then Try_ESLint_from_the_Command_Line; fi;

RUN_RULE="";
explain ${BINDIR}/Configure_Sublime_Text_to_use_ESLint.md # MANUAL_INPUT_REQUIRED

RUN_RULE="";
explain ${BINDIR}/Customize_ESLint_in_Sublime_Text.md # MANUAL_INPUT_REQUIRED

RUN_RULE="";
explain ${BINDIR}/Correct_the_indicated_code_quality_defects.md # MANUAL_INPUT_REQUIRED

explain ${BINDIR}/Ignore_Some_Files.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then Ignore_Some_Files; fi;

explain ${BINDIR}/Try_ESLint_Command_Line_Again.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then Try_ESLint_Command_Line_Again; fi;

## FLAG FOR INCLUSION IN SLIDES - ${BINDIR}/Fin.md explain

endOfSectionScript ${SECTION_NUM} ${SECTION} ${NEXT_SECTION};

exit 0;

