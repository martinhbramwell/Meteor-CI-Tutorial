#!/bin/bash
#
# declare -a UnitTestThePackage_FILENAMES=(
#   Introduction.md
#   Set_Up_Project_Names.md
#   Configure_git_for_GitHub.md
#   Create_SSH_keys_directory_if_not_exist.md
#   Install_Meteor.md
#   Create_Meteor_project.md
#   Check_the_meteor_project_will_work.md
#   Add_Meteor_application_development_support_files.md
#   Configure_Sublime_Text_to_use_ESLint.md
#   Create_remote_GitHub_repository.md
#   Create_local_GitHub_repository.md
#   Create_a_package_and_TinyTest_it.md
#   Add_a_test_runner_for_getting_TinyTest_output_on_the_command_line.md
#   Add_a_CircleCI_configuration_file_and_push_to_GitHub.md
#   Install_Bunyan_Globally.md
#   Prepare_for_NightWatch_testing.md
#   Run_NightWatch_testing.md
#   Push_Nightwatch_testing_to_GitHub_and_CircleCI.md
#   Observe_ordinary_console_logging.md
#   Add_an_NPM_module_to_your_package.md
#   Specify_Npm_modules.md
#   Bunyan_Server_Side_OnlyLogging.md
#   Add_Bunyan_Logging.md
#   Goodbye_console.md
#   Refactor_Bunyan_InstantiationA.md
#   Refactor_Bunyan_InstantiationB.md
#   Another_NodeJS_moduleA.md
#   Another_NodeJS_moduleB.md
#   The_Async_ProblemA.md
#   The_Async_ProblemB.md
#   The_Async_ProblemC.md
# )
# pushd UnitTestThePackage

# for idx in "${UnitTestThePackage_FILENAMES[@]}"
# do
#    sed -i 's|TOC](..)|TOC](./)|g' doc/${idx}
# done

# popd

declare -a FILEPATHS=(
  "UnitTestThePackage|Introduction.md"
  "UnitTestThePackage|Set_Up_Project_Names.md"
  "UnitTestThePackage|Configure_git_for_GitHub.md"
  "UnitTestThePackage|Create_SSH_keys_directory_if_not_exist.md"
  "UnitTestThePackage|Install_Meteor.md"
  "UnitTestThePackage|Create_Meteor_project.md"
  "UnitTestThePackage|Check_the_meteor_project_will_work.md"
  "UnitTestThePackage|Add_Meteor_application_development_support_files.md"
  "UnitTestThePackage|Configure_Sublime_Text_to_use_ESLint.md"
  "UnitTestThePackage|Create_remote_GitHub_repository.md"
  "UnitTestThePackage|Create_local_GitHub_repository.md"
  "UnitTestThePackage|Create_a_package_and_TinyTest_it.md"
  "UnitTestThePackage|Add_a_test_runner_for_getting_TinyTest_output_on_the_command_line.md"
  "UnitTestThePackage|Add_a_CircleCI_configuration_file_and_push_to_GitHub.md"
  "UnitTestThePackage|Install_Bunyan_Globally.md"
  "UnitTestThePackage|Prepare_for_NightWatch_testing.md"
  "UnitTestThePackage|Run_NightWatch_testing.md"
  "UnitTestThePackage|Push_Nightwatch_testing_to_GitHub_and_CircleCI.md"
  "UnitTestThePackage|Observe_ordinary_console_logging.md"
  "UnitTestThePackage|Add_an_NPM_module_to_your_package.md"
  "UnitTestThePackage|Specify_Npm_modules.md"
  "UnitTestThePackage|Bunyan_Server_Side_OnlyLogging.md"
  "UnitTestThePackage|Add_Bunyan_Logging.md"
  "UnitTestThePackage|Goodbye_console.md"
  "UnitTestThePackage|Refactor_Bunyan_InstantiationA.md"
  "UnitTestThePackage|Refactor_Bunyan_InstantiationB.md"
  "UnitTestThePackage|Another_NodeJS_moduleA.md"
  "UnitTestThePackage|Another_NodeJS_moduleB.md"
  "UnitTestThePackage|The_Async_ProblemA.md"
  "UnitTestThePackage|The_Async_ProblemB.md"
  "UnitTestThePackage|The_Async_ProblemC.md"
  "UnitTestThePackage|Fin.md"
  "PrepareTheMachine|Introduction.md"
  "PrepareTheMachine|Java_7_is_required_by_Nightwatch.md"
  "PrepareTheMachine|This_tutorial_expects_to_use_the_Sublime_Text_3_editor.md"
  "PrepareTheMachine|Install_other_tools.md"
  "PrepareTheMachine|Install_NodeJS.md"
  "PrepareTheMachine|Install_Google_Chrome_and_the_Selenium_Web_Driver_for_Chrome.md"
  "PrepareTheMachine|Install_Selenium_Webdriver_In_NodeJS.md"
  "PrepareTheMachine|Install_eslint_and_configure_SublimeLinter.md"
  "PrepareTheMachine|Configure_Sublime_A.md"
  "PrepareTheMachine|Configure_Sublime_B.md"
  "PrepareTheMachine|Fin.md"
)

for idx_d in "${FILEPATHS[@]}"
do
  FP="${idx_d}"
  FPA=(${FP//|/ })
  AFP="${FPA[0]}/doc/${FPA[1]}"
  sed -i '0,/<!-- -->]/s|<!-- -->]|<!-- B -->]|' ${AFP}
done
exit

pushd PrepareTheMachine

declare -a PrepareTheMachine_FILENAMES=(
)
pushd PrepareTheMachine

for idx in "${PrepareTheMachine_FILENAMES[@]}"
do
done

popd
exit


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

## Package slideshow part A
declare -a PrepareTheMachine_FILENAMES=(
  Introduction.md
  Java_7_is_required_by_Nightwatch.md
  This_tutorial_expects_to_use_the_Sublime_Text_3_editor.md
  Install_other_tools.md
  Install_NodeJS.md
  Install_Selenium_Webdriver_In_NodeJS.md
  Install_Google_Chrome_and_the_Selenium_Web_Driver_for_Chrome.md
  Install_eslint_and_configure_SublimeLinter.md
  Configure_Sublime_A.md
  Configure_Sublime_B.md
  Fin.md
)

pushd PrepareTheMachine
rm -f concatenatedSlides.MD

## now loop through the above array
for idx in "${PrepareTheMachine_FILENAMES[@]}"
do
   cat doc/${idx} >> concatenatedSlides.MD
done

popd

#
## Package slideshow part A
declare -a UnitTestThePackage_FILENAMES=(
  Introduction.md
  Set_Up_Project_Names.md
  Configure_git_for_GitHub.md
  Create_SSH_keys_directory_if_not_exist.md
  Install_Meteor.md
  Create_Meteor_project.md
  Check_the_meteor_project_will_work.md
  Add_Meteor_application_development_support_files.md
  Configure_Sublime_Text_to_use_ESLint.md
  Create_remote_GitHub_repository.md
  Create_local_GitHub_repository.md
  Create_a_package_and_TinyTest_it.md
  Add_a_test_runner_for_getting_TinyTest_output_on_the_command_line.md
  Add_a_CircleCI_configuration_file_and_push_to_GitHub.md
  Install_Bunyan_Globally.md
  Prepare_for_NightWatch_testing.md
  Run_NightWatch_testing.md
  Push_Nightwatch_testing_to_GitHub_and_CircleCI.md
  Observe_ordinary_console_logging.md
  Add_an_NPM_module_to_your_package.md
  Specify_Npm_modules.md
  Bunyan_Server_Side_OnlyLogging.md
  Add_Bunyan_Logging.md
  Goodbye_console.md
  Refactor_Bunyan_InstantiationA.md
  Refactor_Bunyan_InstantiationB.md
  Another_NodeJS_moduleA.md
  Another_NodeJS_moduleB.md
  The_Async_ProblemA.md
  The_Async_ProblemB.md
  The_Async_ProblemC.md
)

pushd UnitTestThePackage
rm -f concatenatedSlides.MD

for idx in "${UnitTestThePackage_FILENAMES[@]}"
do
   cat doc/${idx} >> concatenatedSlides.MD
done

popd

if  ${SKIP} ;  then  exit 0; fi;

tar zcvf pack.tar.gz index.html \
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


