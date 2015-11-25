#!/bin/bash

set -e;
#
source ./scripts/util.sh;
declare NONSTOP="nonstop";

checkForVirtualMachine;
checkNotRoot;

export SUDOUSER=$(who am i | awk '{print $1}');

collectSectionNames;

setSection 8;
source "${BINDIR}/${SECTION}_functions.sh";

source ./scripts/explain.sh

RUN_RULE="";
explain ${BINDIR}/Introduction.md

echo ""
echo ""
RUN_RULE="";
explain ${BINDIR}/Another_NodeJS_moduleA.md # MANUAL_INPUT_REQUIRED

echo ""
echo ""
explain ${BINDIR}/Another_NodeJS_moduleB.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then Another_NodeJS_moduleB; fi;

echo ""
echo ""
explain ${BINDIR}/Another_NodeJS_moduleC.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then Another_NodeJS_moduleC; fi;

echo ""
echo ""
explain ${BINDIR}/Async_Problem_Buried_Methods.md

echo ""
echo ""
RUN_RULE="";
explain ${BINDIR}/Async_Problem_Wrapped_Proxy_A.md # MANUAL_INPUT_REQUIRED

echo ""
echo ""
RUN_RULE="";
explain ${BINDIR}/Async_Problem_Wrapped_Proxy_B.md  # MANUAL_INPUT_REQUIRED


echo ""
echo ""
RUN_RULE="";
explain ${BINDIR}/Async_Problem_Sync_Namespace.md # MANUAL_INPUT_REQUIRED

echo ""
echo ""
RUN_RULE="";
explain ${BINDIR}/Async_Problem_TinyTest_A.md # MANUAL_INPUT_REQUIRED

echo ""
echo ""
RUN_RULE="";
explain ${BINDIR}/Call_Into_Package_Methods.md MORE_ACTION # CODE_BLOCK MANUAL_INPUT_REQUIRED
if [ "${RUN_RULE}" != "n" ]; then Call_Into_Package_Methods; fi;

echo ""
echo ""
RUN_RULE="";
explain ${BINDIR}/Package_Dependencies.md # MANUAL_INPUT_REQUIRED

echo ""
echo ""
RUN_RULE="";
explain ${BINDIR}/Declare_Callable_Method.md # MANUAL_INPUT_REQUIRED

echo ""
echo ""
explain ${BINDIR}/View_and_Hide_The_Example.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then View_and_Hide_The_Example; fi;



## FLAG FOR INCLUSION IN SLIDES - ${BINDIR}/Fin.md explain

endOfSectionScript ${SECTION_NUM} ${SECTION} ${NEXT_SECTION};


exit 0;

