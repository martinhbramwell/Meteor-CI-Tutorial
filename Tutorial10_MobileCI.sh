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




## FLAG FOR INCLUSION IN SLIDES - ${BINDIR}/Fin.md explain

endOfSectionScript ${SECTION_NUM} ${SECTION} ${NEXT_SECTION};


exit 0;

