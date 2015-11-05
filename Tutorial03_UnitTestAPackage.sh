#!/bin/bash

set -e;
#
source ./scripts/util.sh

checkForVirtualMachine;
checkNotRoot;

export SUDOUSER=$(who am i | awk '{print $1}');

collectSectionNames;

setSection 3;
source "${BINDIR}/${SECTION}_functions.sh";

source ./scripts/explain.sh

RUN_RULE="";
explain ${BINDIR}/Introduction.md

explain ${BINDIR}/Create_a_package_A.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then Create_a_package_A; fi;

explain ${BINDIR}/Create_a_package_B.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then Create_a_package_B; fi;

explain ${BINDIR}/Create_a_package_C.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then Create_a_package_C; fi;

explain ${BINDIR}/Create_GitHub_Repo_Deploy_Keys.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then Create_GitHub_Repo_Deploy_Keys; fi;

RUN_RULE="";
explain ${BINDIR}/Control_a_packages_versions_A.md MORE_ACTION # CODE_BLOCK MANUAL_INPUT_REQUIRED
if [ "${RUN_RULE}" != "n" ]; then Control_a_packages_versions_A; fi;

explain ${BINDIR}/Control_a_packages_versions_B.md  MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then Control_a_packages_versions_B; fi;

explain ${BINDIR}/TinyTest_a_package.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then TinyTest_a_package; fi;

explain ${BINDIR}/Add_a_test_runner_for_getting_TinyTest_output_on_the_command_line.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then Add_a_test_runner_for_getting_TinyTest_output_on_the_command_line; fi;

## FLAG FOR INCLUSION IN SLIDES - ${BINDIR}/Fin.md explain

endOfSectionScript ${SECTION_NUM} ${SECTION} ${NEXT_SECTION};

exit 0;

