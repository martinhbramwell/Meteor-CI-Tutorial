#!/bin/bash
#

SKIP=true;
if [[ "X$1X" == "XyX" ]]; then
  SKIP=false;
elif [[ "X$1X" != "XnX" ]]; then 
  echo -e ""
  echo -e "Usage : "
  echo -e " - '$0 y' generate documentation and commit to gh-pages branch"
  echo -e " - '$0 n' generate documentation only"
  echo -e ""
  echo -e "Hit '<enter>' to generate documentation without commit"
  echo -e "Hit 'y' now to generate documentation and commit to gh-pages branch"
  echo -e "Hit 'q' to quit"
  read -p " 'y', 'q' or '<enter>' ::  " -n 1 -r USER_ANSWER
  CHOICE=$(echo ${USER_ANSWER:0:1} | tr '[:upper:]' '[:lower:]')
  echo ""
  if [ "X${CHOICE}X" == "XqX" ]; then exit 0; fi;
  if [ "X${CHOICE}X" == "XyX" ]; then SKIP=false; fi;
fi;

declare -a FILEPATHS=(
  "Step01_|PrepareTheMachine|Introduction.md"
  "Step01_|PrepareTheMachine|Java_7_is_required_by_Nightwatch.md"
  "Step01_|PrepareTheMachine|This_tutorial_expects_to_use_the_Sublime_Text_3_editor.md"
  "Step01_|PrepareTheMachine|Install_other_tools.md"
  "Step01_|PrepareTheMachine|Install_NodeJS.md"
  "Step01_|PrepareTheMachine|Install_Google_Chrome_and_the_Selenium_Web_Driver_for_Chrome.md"
  "Step01_|PrepareTheMachine|Install_Bunyan_Globally.md"
  "Step01_|PrepareTheMachine|Install_Selenium_Webdriver_In_NodeJS.md"
  "Step01_|PrepareTheMachine|Install_eslint_and_configure_SublimeLinter.md"
  "Step01_|PrepareTheMachine|Configure_Sublime_A.md"
  "Step01_|PrepareTheMachine|Configure_Sublime_B.md"
  "Step01_|PrepareTheMachine|Fin.md"
  "Step02_|UnitTestThePackage|Introduction.md"
  "Step02_|UnitTestThePackage|Set_Up_Project_Names.md"
  "Step02_|UnitTestThePackage|Configure_git_for_GitHub.md"
  "Step02_|UnitTestThePackage|Create_SSH_keys_directory_if_not_exist.md"
  "Step02_|UnitTestThePackage|Install_Meteor.md"
  "Step02_|UnitTestThePackage|Create_Meteor_project.md"
  "Step02_|UnitTestThePackage|Check_the_meteor_project_will_work.md"
  "Step02_|UnitTestThePackage|Add_Meteor_application_development_support_files.md"
  "Step02_|UnitTestThePackage|Configure_Sublime_Text_to_use_ESLint.md"
  "Step02_|UnitTestThePackage|Create_remote_GitHub_repository.md"
  "Step02_|UnitTestThePackage|Create_local_GitHub_repository.md"
  "Step02_|UnitTestThePackage|Create_a_package_and_TinyTest_it.md"
  "Step02_|UnitTestThePackage|Add_a_test_runner_for_getting_TinyTest_output_on_the_command_line.md"
  "Step02_|UnitTestThePackage|Add_a_CircleCI_configuration_file_and_push_to_GitHub.md"
  "Step02_|UnitTestThePackage|Prepare_for_NightWatch_testing.md"
  "Step02_|UnitTestThePackage|Run_NightWatch_testing.md"
  "Step02_|UnitTestThePackage|Push_Nightwatch_testing_to_GitHub_and_CircleCI.md"
  "Step02_|UnitTestThePackage|Observe_ordinary_console_logging.md"
  "Step02_|UnitTestThePackage|Add_an_NPM_module_to_your_package.md"
  "Step02_|UnitTestThePackage|Specify_Npm_modules.md"
  "Step02_|UnitTestThePackage|Bunyan_Server_Side_OnlyLogging.md"
  "Step02_|UnitTestThePackage|Add_Bunyan_Logging.md"
  "Step02_|UnitTestThePackage|Goodbye_console.md"
  "Step02_|UnitTestThePackage|Refactor_Bunyan_InstantiationA.md"
  "Step02_|UnitTestThePackage|Refactor_Bunyan_InstantiationB.md"
  "Step02_|UnitTestThePackage|Another_NodeJS_moduleA.md"
  "Step02_|UnitTestThePackage|Another_NodeJS_moduleB.md"
  "Step02_|UnitTestThePackage|The_Async_ProblemA.md"
  "Step02_|UnitTestThePackage|The_Async_ProblemB.md"
  "Step02_|UnitTestThePackage|The_Async_ProblemC.md"
  "Step02_|UnitTestThePackage|Fin.md"
)

for idx_d in "${FILEPATHS[@]}"
do
  FP="${idx_d}"
  FPA=(${FP//|/ })
  rm -f ${FPA[1]}/concatenatedSlides.MD
done


GITHUB_DIR="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/"
for idx_d in "${FILEPATHS[@]}"
do
  FP="${idx_d}"
  FPA=(${FP//|/ })
  AFP="${FPA[1]}/doc/${FPA[2]}"
  SCRIPT_FILE="${FPA[0]}${FPA[1]}.sh"
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # LNUM=$(grep -nr "${FPA[2]}.*CODE_BLOCK" ${SCRIPT_FILE}  | cut -d : -f 1)
  # if [[ "${LNUM}" -gt 0 ]]; then
  #   LNUM=$((LNUM+2))
  #   export PATTERN='<!-- B -->]'
  #   echo "Old : ${PATTERN}"
  #   export REPLACEMENT='<!-- Code for this begins at line #'
  #   REPLACEMENT="${REPLACEMENT}${LNUM}"
  #   REPLACEMENT=${REPLACEMENT}' -->\n<!-- B -->'
  #   REPLACEMENT=${REPLACEMENT}'\n.center[.footnote[.red.bold[] <a href="'
  #   REPLACEMENT="${REPLACEMENT}${GITHUB_DIR}${SCRIPT_FILE}#L${LNUM}"
  #   REPLACEMENT=${REPLACEMENT}'" target="_blank">Code for this step.</a>] ]'
  #   REPLACEMENT=${REPLACEMENT}'\n]'
  #   echo "New : ${REPLACEMENT}"
  #   echo "File : ${AFP}"
  #   echo "# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  #   sed -i "0,/${PATTERN}/s|${PATTERN}|${REPLACEMENT}|" ${AFP}
  # fi
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  cat ${AFP} >> ${FPA[1]}/concatenatedSlides.MD
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

done


if  ${SKIP} ;  then  exit 0; fi;

tar zcvf pack.tar.gz index.html \
styles.css \
PrepareTheMachine/concatenatedSlides.MD \
UnitTestThePackage/concatenatedSlides.MD

export STASH_CREATED=$(git stash) && echo $STASH_CREATED
if [[ "${STASH_CREATED}" != "No local changes to save" ]];
then
  echo ""
  echo "Changes to master branch have been stashed"
fi;
git checkout gh-pages
echo "On branch gh-pages"
tar zxvf pack.tar.gz
rm -f pack.tar.gz
echo "Unpacked all."
git commit -am "Automatic commit. See master for details."
echo "Committed"
git push
echo "Pushed"
git checkout master
echo "- - - back on branch master - - -"
if [[ "${STASH_CREATED}" != "No local changes to save" ]];
then
  git stash apply;
  echo "Reverted stash"
else
  echo "No stash to restore";
fi;



