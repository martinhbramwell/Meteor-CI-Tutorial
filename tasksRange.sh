#!/bin/bash
#
TasksList="tasksList_A.sh";
SectionPrefix="Tutorial";
FileSuffix="_functions.sh";

RANGE_LIMITS=(

  "03|UnitTestAModule|Create_a_module_A|Created module '${MODULE_NAME}': (A)|, but [ci skip].|"
  "03|UnitTestAModule|Create_a_module_C|Created module '${MODULE_NAME}' : (C)|, but [ci skip].|"

);

StartExecuting="${RANGE_LIMITS[0]}";
StopExecuting="${RANGE_LIMITS[1]}";

START_SECTION=$(echo ${StartExecuting} | cut -f1 -d"|");
export SUDO_REQUIRED=1;
if [[ ${START_SECTION#0} -eq 1 ]]; then
  CRP=$(sudo pwd);
fi;
