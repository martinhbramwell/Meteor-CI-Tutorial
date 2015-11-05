#!/bin/bash

set -e;
#
source ./scripts/util.sh

checkForVirtualMachine;
checkNotRoot;

export SUDOUSER=$(who am i | awk '{print $1}');

collectSectionNames;

setSection 2;
source "${BINDIR}/${SECTION}_functions.sh";

source ./scripts/explain.sh

RUN_RULE="";
explain ${BINDIR}/Introduction.md

RUN_RULE="a";
explain ${BINDIR}/Set_Up_Project_Names.md MORE_ACTION # MANUAL_INPUT_REQUIRED
RUN_RULE="";
if ! getUserData; then didNotGetUserData; fi;

explain ${BINDIR}/Configure_git_for_GitHub.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then Configure_git_for_GitHub; fi;

explain ${BINDIR}/Install_Meteor.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then Install_Meteor; fi;

explain ${BINDIR}/Create_Meteor_project.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then Create_Meteor_project; fi;

explain ${BINDIR}/Check_the_meteor_project_will_work.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then
  export METEOR_PORT=3000
  Check_the_meteor_project_will_work;
fi;

export GITHUB_RAW="https://raw.githubusercontent.com/warehouseman/meteor-swagger-client/master/.eslintrc"
explain ${BINDIR}/Add_Meteor_application_development_support_files.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then
  Add_Meteor_application_development_support_files;
fi;

explain ${BINDIR}/Create_GitHub_Repo_Deploy_Keys.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then Create_GitHub_Repo_Deploy_Keys ${PROJECT_NAME}; fi;

explain ${BINDIR}/Create_remote_GitHub_repository_A.md #

RUN_RULE="";
explain ${BINDIR}/Create_remote_GitHub_repository_B.md MORE_ACTION # CODE_BLOCK MANUAL_INPUT_REQUIRED
if [ "${RUN_RULE}" != "n" ]; then Create_remote_GitHub_repository_B; fi;

explain ${BINDIR}/Create_local_GitHub_repository.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then Create_local_GitHub_repository; fi;

## FLAG FOR INCLUSION IN SLIDES - ${BINDIR}/Fin.md explain

endOfSectionScript ${SECTION_NUM} ${SECTION} ${NEXT_SECTION};


exit 0;

