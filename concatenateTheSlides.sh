#!/bin/bash
#
pushd Prep4MeteorCI_A
rm -f concatenatedSlides.MD
cat doc/Introduction.md >> concatenatedSlides.MD
cat doc/Java_7_is_required_by_Nightwatch.md >> concatenatedSlides.MD
cat doc/This_tutorial_expects_to_use_the_Sublime_Text_3_editor.md >> concatenatedSlides.MD
cat doc/Install_other_tools.md >> concatenatedSlides.MD
cat doc/Install_NodeJS.md >> concatenatedSlides.MD
cat doc/Install_Google_Chrome_and_the_Selenium_Web_Driver_for_Chrome.md >> concatenatedSlides.MD
cat doc/Install_eslint_and_configure_SublimeLinter.md >> concatenatedSlides.MD
cat doc/Configure_Sublime_A.md >> concatenatedSlides.MD
cat doc/Configure_Sublime_B.md >> concatenatedSlides.MD
cat doc/Fin.md >> concatenatedSlides.MD
# cat doc/dummy.md >> concatenatedSlides.MD

popd
#
pushd Prep4MeteorCI_B
rm -f concatenatedSlides.MD
cat doc/Introduction.md >> concatenatedSlides.MD
cat doc/Configure_git_for_GitHub.md >> concatenatedSlides.MD
cat doc/Create_SSH_keys_directory_if_not_exist.md >> concatenatedSlides.MD
cat doc/Install_Meteor.md >> concatenatedSlides.MD
cat doc/Create_Meteor_project.md >> concatenatedSlides.MD
cat doc/Check_the_meteor_project_will_work.md >> concatenatedSlides.MD
cat doc/Add_Meteor_application_development_support_files.md >> concatenatedSlides.MD
cat doc/Configure_Sublime_Text_to_use_ESLint.md >> concatenatedSlides.MD
cat doc/Create_remote_GitHub_repository.md >> concatenatedSlides.MD
cat doc/Create_local_GitHub_repository.md >> concatenatedSlides.MD
cat doc/Create_a_package_and_TinyTest_it.md >> concatenatedSlides.MD
cat doc/Install_Selenium_Webdriver.md >> concatenatedSlides.MD
cat doc/Add_a_test_runner_for_getting_TinyTest_output_on_the_command_line.md >> concatenatedSlides.MD
cat doc/Add_a_CircleCI_configuration_file_and_push_to_GitHub.md >> concatenatedSlides.MD
cat doc/Install_Bunyan_Globally.md >> concatenatedSlides.MD

cat doc/Prepare_for_NightWatch_testing.md >> concatenatedSlides.MD
cat doc/Run_NightWatch_testing.md >> concatenatedSlides.MD
cat doc/Push_Nightwatch_testing_to_GitHub_and_CircleCI.md >> concatenatedSlides.MD
cat doc/Observe_ordinary_console_logging.md >> concatenatedSlides.MD
cat doc/Add_an_NPM_module_to_your_package.md >> concatenatedSlides.MD
cat doc/Specify_Npm_modules.md >> concatenatedSlides.MD
cat doc/Bunyan_Server_Side_OnlyLogging.md >> concatenatedSlides.MD
cat doc/Add_Bunyan_Logging.md >> concatenatedSlides.MD
cat doc/Goodbye_console.md >> concatenatedSlides.MD
cat doc/Refactor_Bunyan_InstantiationA.md >> concatenatedSlides.MD
cat doc/Refactor_Bunyan_InstantiationB.md >> concatenatedSlides.MD
cat doc/Another_NodeJS_moduleA.md >> concatenatedSlides.MD
cat doc/Another_NodeJS_moduleB.md >> concatenatedSlides.MD
cat doc/The_Async_ProblemA.md >> concatenatedSlides.MD
cat doc/The_Async_ProblemB.md >> concatenatedSlides.MD
cat doc/The_Async_ProblemC.md >> concatenatedSlides.MD



cat doc/dummy.md >> concatenatedSlides.MD
cat doc/dummy.md >> concatenatedSlides.MD
# cat doc/dummy.md >> concatenatedSlides.MD



cat doc/Fin.md >> concatenatedSlides.MD
popd



