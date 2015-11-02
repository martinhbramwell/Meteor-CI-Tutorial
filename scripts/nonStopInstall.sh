#!/bin/bash

set -e;
#
source ./scripts/util.sh
checkForVirtualMachine;


export SUDOUSER=$(who am i | awk '{print $1}');

collectSectionNames;

# Loop through all sections getting their functions
# source ./scripts/TutorialSections.sh;
II=1;
echo "Getting functions from: ";
while [ ${II} -lt ${#TUTORIAL_SECTIONS[@]} ]
do
  setSection ${II};
  echo " - ${BINDIR}/${SECTION}_functions.sh";
  source "${BINDIR}/${SECTION}_functions.sh";
  II=$[$II+1]
done;
exit;

verifyFreeSpace;
verifyRootUser;

if ! getUserData; then
    echo -e "#####################################################################"
    echo -e "#   The rest of this script will fail without correct values for : "
    echo -e "#    - project name"
    echo -e "#    - package name"
    echo -e "#    - project owner name"
    echo -e "#    - project owner full name"
    echo -e "#    - project owner email."
    echo -e "#   Please ensure you have entered these values correctly."
    echo -e "#####################################################################"
    exit 1;
fi;


#  installToolsForTheseScripts  for GAWK ????

# source ./scripts/explain.sh

# highlight ${BINDIR}/Introduction.md # explain
# echo ""
# echo "To view this embedded documentation as a browser slideshow, choose one of the following options:"
# echo " A) Open your browser to http://martinhbramwell.github.io/Meteor-CI-Tutorial/"
# echo " B) If you have Python in your machine (you have '$(python -c "import sys;t='{v[0]}.{v[1]}'.format(v=list(sys.version_info[:2]));sys.stdout.write(t)";)') you can do :"
# echo " - execute : ./concatenateTheSlides.sh n"
# echo " - then execute : python -m SimpleHTTPServer 8080"
# echo " - then launch your browser and open : http://localhost:8080/"
# echo " C) If you already know Meteor, you can just stuff a copy of this directory in the 'public' directory of a Meteor app."
# echo ""
# read -p "Hit <enter> ::  " -n 1 -r REPLY


# RUN_RULE="";
# explain ${BINDIR}/Java_7_is_required_by_Nightwatch.md MORE_ACTION # CODE_BLOCK
# if [ "${RUN_RULE}" != "n" ]; then
  Java_7_is_required_by_Nightwatch_A;
  This_tutorial_expects_to_use_the_Sublime_Text_3_editor_A;
  apt-get update;
  Java_7_is_required_by_Nightwatch_B;
# fi;

# explain ${BINDIR}/Install_other_tools.md MORE_ACTION # CODE_BLOCK
# if [ "${RUN_RULE}" != "n" ]; then
 Install_other_tools; 
# fi;

# explain ${BINDIR}/Install_NodeJS.md MORE_ACTION # CODE_BLOCK
# if [ "${RUN_RULE}" != "n" ]; then
  Install_NodeJS; 
# fi;

# explain ${BINDIR}/Install_Selenium_Webdriver_In_NodeJS.md MORE_ACTION # CODE_BLOCK
# if [ "${RUN_RULE}" != "n" ]; then 
  Install_Selenium_Webdriver_In_NodeJS; 
# fi;

# explain ${BINDIR}/Install_Google_Chrome_and_the_Selenium_Web_Driver_for_Chrome.md MORE_ACTION # CODE_BLOCK
# if [ "${RUN_RULE}" != "n" ]; then
  Install_Google_Chrome_and_the_Selenium_Web_Driver_for_Chrome;
# fi;

# explain ${BINDIR}/Install_Bunyan_Globally.md MORE_ACTION # CODE_BLOCK
# if [ "${RUN_RULE}" != "n" ]; then 
  Install_Bunyan_Globally; 
# fi;

# explain ${BINDIR}/This_tutorial_expects_to_use_the_Sublime_Text_3_editor.md MORE_ACTION # CODE_BLOCK
# if [ "${RUN_RULE}" != "n" ]; then
  This_tutorial_expects_to_use_the_Sublime_Text_3_editor_B;
# fi;

# explain ${BINDIR}/Install_eslint.md MORE_ACTION # CODE_BLOCK
# if [ "${RUN_RULE}" != "n" ]; then 
  Install_eslint; 
# fi;

# explain ${BINDIR}/Install_jsdoc.md ACTION # CODE_BLOCK
# if [ "${RUN_RULE}" != "n" ]; then 
  Install_jsdoc; 
# fi;


EnforceOwnershipAndPermissions;



export SECTION_NUM="2";
export SECTION="VersionControlInTheCloud";
export NEXT_SECTION="UnitTestAPackage";
printf -v BINDIR "./Tutorial%02d_%s" ${SECTION_NUM} ${SECTION};
source "${BINDIR}/${SECTION}_functions.sh";


# explain ${BINDIR}/Configure_git_for_GitHub.md MORE_ACTION # CODE_BLOCK
# if [ "${RUN_RULE}" != "n" ]; then
 Configure_git_for_GitHub;
# fi;

# explain ${BINDIR}/Install_Meteor.md MORE_ACTION # CODE_BLOCK
# if [ "${RUN_RULE}" != "n" ]; then
  Install_Meteor;
# fi;

# explain ${BINDIR}/Create_Meteor_project.md MORE_ACTION # CODE_BLOCK
# if [ "${RUN_RULE}" != "n" ]; then
  Create_Meteor_project;
# fi;

# explain ${BINDIR}/Check_the_meteor_project_will_work.md MORE_ACTION # CODE_BLOCK
# if [ "${RUN_RULE}" != "n" ]; then
#   export METEOR_PORT=3000
#   Check_the_meteor_project_will_work;
# fi;

export GITHUB_RAW="https://raw.githubusercontent.com/warehouseman/meteor-swagger-client/master/.eslintrc"
# explain ${BINDIR}/Add_Meteor_application_development_support_files.md MORE_ACTION # CODE_BLOCK
# if [ "${RUN_RULE}" != "n" ]; then
  Add_Meteor_application_development_support_files;
# fi;

# explain ${BINDIR}/Create_GitHub_Repo_Deploy_Keys.md MORE_ACTION # CODE_BLOCK
# if [ "${RUN_RULE}" != "n" ]; then
  Create_GitHub_Repo_Deploy_Keys;
fi;

explain ${BINDIR}/Create_remote_GitHub_repository_A.md #

RUN_RULE="";
explain ${BINDIR}/Create_remote_GitHub_repository_B.md MORE_ACTION # CODE_BLOCK MANUAL_INPUT_REQUIRED
if [ "${RUN_RULE}" != "n" ]; then
 Create_remote_GitHub_repository_B;
fi;

explain ${BINDIR}/Create_local_GitHub_repository.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then
  Create_local_GitHub_repository;
fi;





















highlight ${BINDIR}/Configure_Sublime_A.md # CODE_BLOCK explain MANUAL_INPUT_REQUIRED
echo "";
Configure_Sublime_A;
echo "";
read -p "Hit <enter> ::  " -n 1 -r REPLY


highlight ${BINDIR}/Configure_Sublime_B.md # explain MANUAL_INPUT_REQUIRED

## FLAG FOR INCLUSION IN SLIDES - ${BINDIR}/Fin.md explain

  printf "

       Done! You have finished part #%d, '%s', of the tutorial.

          Now you can execute ::  ./Tutorial%02d_%s.sh

  " ${SECTION_NUM} ${SECTION} $(($SECTION_NUM+1)) ${NEXT_SECTION};


exit 0;
