#!/bin/bash
#

set -e;
#
source ./scripts/util.sh

checkForVirtualMachine;

export SUDOUSER=$(who am i | awk '{print $1}');
export BINDIR="./P01_PrepareTheMachine";

source ${BINDIR}/PrepareTheMachine_functions.sh;

verifyFreeSpace;

verifyRootUser;

installToolsForTheseScripts

source ./scripts/explain.sh

highlight ${BINDIR}/Introduction.md # explain
echo ""
echo "To view this embedded documentation as a browser slideshow choose one of the following options:"
echo " A) Open your browser to http://martinhbramwell.github.io/Meteor-CI-Tutorial/"
echo " B) If you have Python in your machine (you have '$(python -c "import sys;t='{v[0]}.{v[1]}'.format(v=list(sys.version_info[:2]));sys.stdout.write(t)";)') you can do :"
echo " - execute : ./concatenateTheSlides.sh n"
echo " - then execute : python -m SimpleHTTPServer 8080"
echo " - then launch your browser and open : http://localhost:8080/"
echo " C) If you already know Meteor, you can just stuff a copy of this directory in the 'public' directory of a Meteor app."
echo ""
read -p "Hit <enter> ::  " -n 1 -r REPLY


RUN_RULE="";
explain ${BINDIR}/Java_7_is_required_by_Nightwatch.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then 
  Java_7_is_required_by_Nightwatch_A;
  apt-get update; 
  Java_7_is_required_by_Nightwatch_B;
fi;

explain ${BINDIR}/Install_other_tools.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then Install_other_tools; fi;

explain ${BINDIR}/Install_NodeJS.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then Install_NodeJS; fi;

explain ${BINDIR}/Install_Selenium_Webdriver_In_NodeJS.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then Install_Selenium_Webdriver_In_NodeJS; fi;

explain ${BINDIR}/Install_Google_Chrome_and_the_Selenium_Web_Driver_for_Chrome.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then
  Install_Google_Chrome_and_the_Selenium_Web_Driver_for_Chrome;
fi;

explain ${BINDIR}/Install_Bunyan_Globally.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then Install_Bunyan_Globally; fi;

explain ${BINDIR}/This_tutorial_expects_to_use_the_Sublime_Text_3_editor.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then
  This_tutorial_expects_to_use_the_Sublime_Text_3_editor_A;
  apt-get update;
  This_tutorial_expects_to_use_the_Sublime_Text_3_editor_B;
fi;

explain ${BINDIR}/Install_eslint.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then Install_eslint; fi;

explain ${BINDIR}/Install_jsdoc.md ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then Install_jsdoc; fi;

highlight ${BINDIR}/Configure_Sublime_A.md # CODE_BLOCK explain
echo "";
Configure_Sublime_A;
echo "";
read -p "Hit <enter> ::  " -n 1 -r REPLY


highlight ${BINDIR}/Configure_Sublime_B.md # explain

EnforceOwnershipAndPermissions;

## FLAG FOR INCLUSION IN SLIDES - ${BINDIR}/Fin.md explain

echo -e "\n\n\nDone! You have finished with 'Part01_PrepareTheMachine.sh'."
echo -e "\n\n  Now you can execute ::  './Part02_VersionControlInTheCloud.sh'?"


echo -e "\n\n";

exit 0;

