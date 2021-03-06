#!/bin/bash

set -e;

declare PROCESS_THIS=true;  # true OR false
declare NONSTOP="yes";

source ./tasksRange.sh;

source ./scripts/manageShellVars.sh;
source ./scripts/util.sh;

checkForVirtualMachine;
echo -e "\n   Checked for virtual machine\n          - o 0 o - \n";

verifyFreeSpace;
echo -e "\n   Verified Free Space (${FREESPACE})\n          - o 0 o - \n";

checkNotRoot;

loadShellVars;
PARM_NAMES=("PARENT_DIR" "PROJECT_NAME" "MODULE_NAME" "YOUR_FULLNAME" \
  "PACKAGE_DEVELOPER" "YOUR_EMAIL" "YOUR_UID" "GITHUB_ORGANIZATION_NAME" \
   "CIRCLECI_PERSONAL_TOKEN" "METEOR_UID" "METEOR_PWD" "KEYSTORE_PWD" \
   "GITHUB_PERSONAL_TOKEN" "REPLACE_EXISTING_PROJECT" "REPLACE_EXISTING_PACKAGE");
askUserForParameters PARM_NAMES[@];

export BUILD_DIRECTORY="${HOME}/${PARENT_DIR}/${PROJECT_NAME}";
export PROJECT_URI="${PROJECT_NAME}-${GITHUB_ORGANIZATION_NAME}.meteor.com";
export TARGET_SERVER_URL="https://${PROJECT_URI}/";

export PACKAGES=~/${PARENT_DIR}/modules;


# ~   ~   ~   ~   ~   ~   ~   ~   ~   ~   ~   ~   ~   ~   ~   ~   ~

installToolsForTheseScripts;
echo -e "\n   Installed Tools For These Scripts\n          - o 0 o - \n";

source ./scripts/explain.sh
RUN_RULE="";

Install_other_tools;
echo -e "\n   Installed Other Tools\n          - o 0 o - \n";

Configure_git_for_GitHub;
echo -e "\n   Configured git for GitHub\n          - o 0 o - \n";

#
if [[ $(ps aux | grep -v grep | grep -c ssh-agent) -gt 0 ]]; then
  set +e; sudo killall -qs SIGKILL ssh-agent; set -e;
  echo -e "\n   Killed extraneous ssh-agent instances\n          - o 0 o - \n";
fi;

#    ~    ~    ~    ~    ~    ~    ~    ~    1    ~    ~    ~    ~    ~    ~
#    ~    ~    ~    ~    ~    ~    ~    ~    ~    ~    ~    ~    ~    ~    ~

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


source ./scripts/taskRunner.sh

exit;



setSection 1;

# RUN_RULE="";
# explain ${BINDIR}/Java_7_is_required_by_Nightwatch.md MORE_ACTION # CODE_BLOCK
# if [ "${RUN_RULE}" != "n" ]; then
${PROCESS_THIS} && {
  Java_7_is_required_by_Nightwatch_A;
  This_tutorial_expects_to_use_the_Sublime_Text_3_editor_A;

  # will NOT call "sudo apt-get update;" because Node  JS installer does it.
  Install_NodeJS;

  Java_7_is_required_by_Nightwatch_B;
  echo -e "\n   Installed Java\n          - o 0 o - \n";
}
# fi;

# explain ${BINDIR}/Install_other_tools.md MORE_ACTION # CODE_BLOCK
# if [ "${RUN_RULE}" != "n" ]; then
  # Install_other_tools;
# fi;

# explain ${BINDIR}/Install_NodeJS.md MORE_ACTION # CODE_BLOCK
# if [ "${RUN_RULE}" != "n" ]; then
# ${PROCESS_THIS} && Install_NodeJS;
# fi;

# explain ${BINDIR}/Ready_for_Android_Studio.md MORE_ACTION # CODE_BLOCK
# if [ "${RUN_RULE}" != "n" ]; then
  ${PROCESS_THIS} && {
    Ready_for_Android_Studio;
    echo -e "\n   Verified ready for Android Studio.\n          - o 0 o - \n";
  }
# fi;

# explain ${BINDIR}/Install_Selenium_Webdriver_In_NodeJS.md MORE_ACTION # CODE_BLOCK
# if [ "${RUN_RULE}" != "n" ]; then
  ${PROCESS_THIS} && {
    Install_Selenium_Webdriver_In_NodeJS;
    echo -e "\n   Install Selenium Webdriver In NodeJS\n          - o 0 o - \n";
  }
# fi;

# explain ${BINDIR}/Install_Google_Chrome_and_the_Selenium_Web_Driver_for_Chrome.md MORE_ACTION # CODE_BLOCK
# if [ "${RUN_RULE}" != "n" ]; then
  ${PROCESS_THIS} && {
    Install_Google_Chrome_and_the_Selenium_Web_Driver_for_Chrome;
    echo -e "\n   Installed Google Chrome and the Selenium Web Driver for Chrome\n          - o 0 o - \n";
  }
# fi;
# explain ${BINDIR}/Install_Bunyan_Globally.md MORE_ACTION # CODE_BLOCK
# if [ "${RUN_RULE}" != "n" ]; then
  ${PROCESS_THIS} && {
    Install_Bunyan_Globally;
    echo -e "\n   Installed Bunyan Globally\n          - o 0 o - \n";
  }
# fi;

# explain ${BINDIR}/This_tutorial_expects_to_use_the_Sublime_Text_3_editor.md MORE_ACTION # CODE_BLOCK
# if [ "${RUN_RULE}" != "n" ]; then
  ${PROCESS_THIS} && {
    This_tutorial_expects_to_use_the_Sublime_Text_3_editor_B;
    echo -e "\n   Prepared the Sublime Text editor\n          - o 0 o - \n";
  }
# fi;

# explain ${BINDIR}/Install_eslint.md MORE_ACTION # CODE_BLOCK
# if [ "${RUN_RULE}" != "n" ]; then
  ${PROCESS_THIS} && {
    Install_eslint;
    echo -e "\n   Installed ESLint\n          - o 0 o - \n";
  }
# fi;

# explain ${BINDIR}/Install_jsdoc.md ACTION # CODE_BLOCK
# if [ "${RUN_RULE}" != "n" ]; then
  ${PROCESS_THIS} && {
    Install_jsdoc;
    echo -e "\n   Installed JSDoc\n          - o 0 o - \n";
  }
# fi;

EnforceOwnershipAndPermissions;

#    ~    ~    ~    ~    ~    ~    ~    ~    2    ~    ~    ~    ~    ~    ~
#    ~    ~    ~    ~    ~    ~    ~    ~    ~    ~    ~    ~    ~    ~    ~
setSection 2;

# export SECTION_NUM="2";
# export SECTION="VersionControlInTheCloud";
# export NEXT_SECTION="UnitTestAPackage";
# printf -v BINDIR "./Tutorial%02d_%s" ${SECTION_NUM} ${SECTION};
# source "${BINDIR}/${SECTION}_functions.sh";

# explain ${BINDIR}/Configure_git_for_GitHub.md MORE_ACTION # CODE_BLOCK
# if [ "${RUN_RULE}" != "n" ]; then
# Configure_git_for_GitHub;
# fi;

# explain ${BINDIR}/Install_Meteor.md MORE_ACTION # CODE_BLOCK
# if [ "${RUN_RULE}" != "n" ]; then
  ${PROCESS_THIS} && {
    Install_Meteor ${NONSTOP};
    echo -e "\n   Installed Meteor\n          - o 0 o - \n";
  }
# fi;


# explain ${BINDIR}/Create_GitHub_Repo_Deploy_Keys.md MORE_ACTION # CODE_BLOCK
# if [ "${RUN_RULE}" != "n" ]; then
  ${PROCESS_THIS} && {
    Create_GitHub_Repo_Deploy_Keys ${PROJECT_NAME} ${REPLACE_EXISTING_PROJECT};
    echo -e "\n   Created GitHub Repo Deploy Keys for '${PROJECT_NAME}'?\n          - o 0 o - \n";
  }
# fi;

# explain ${BINDIR}/Create_remote_GitHub_repository_A.md MORE_ACTION # CODE_BLOCK
# if [ "${RUN_RULE}" != "n" ]; then

  ${PROCESS_THIS} && {
    Create_GitHub_Repo ${PROJECT_NAME} ${REPLACE_EXISTING_PROJECT};
    echo -e "\n   Created GitHub Repo For '${PROJECT_NAME}' \n          - o 0 o - \n";
  }


# explain ${BINDIR}/Create_remote_GitHub_repository_B.md MORE_ACTION # CODE_BLOCK MANUAL_INPUT_REQUIRED
# if [ "${RUN_RULE}" != "n" ]; then Create_remote_GitHub_repository_B; fi;

  ${PROCESS_THIS} && {
    Add_GitHub_Repo_Deploy_Key ${PROJECT_NAME}  ${REPLACE_EXISTING_PROJECT};
    echo -e "\n   Added GitHub Repo Deploy Key for '${PROJECT_NAME}'\n          - o 0 o - \n";
  }


# explain ${BINDIR}/Create_Meteor_project.md MORE_ACTION # CODE_BLOCK
# if [ "${RUN_RULE}" != "n" ]; then
  ${PROCESS_THIS} && {
    Create_Meteor_project;
    echo -e "\n   Created Meteor project '${PROJECT_NAME}' \n          - o 0 o - \n";
  }
# fi;


# explain ${BINDIR}/Check_the_meteor_project_will_work.md MORE_ACTION # CODE_BLOCK
# if [ "${RUN_RULE}" != "n" ]; then
#   export METEOR_PORT=3000
#   Check_the_meteor_project_will_work;
# fi;


#export GITHUB_RAW="https://raw.githubusercontent.com/warehouseman/meteor-swagger-client/master/.eslintrc"
# explain ${BINDIR}/Add_Meteor_application_development_support_files.md MORE_ACTION # CODE_BLOCK
# if [ "${RUN_RULE}" != "n" ]; then
  ${PROCESS_THIS} && {
    Add_Meteor_application_development_support_files;
    echo -e "\n   Added Meteor application development support files\n          - o 0 o - \n";
  }
# fi;

# explain ${BINDIR}/Create_GitHub_Repo_Deploy_Keys.md MORE_ACTION # CODE_BLOCK
# if [ "${RUN_RULE}" != "n" ]; then
#   Create_GitHub_Repo_Deploy_Keys ${PROJECT_NAME};
# fi;

# explain ${BINDIR}/Create_remote_GitHub_repository_A.md #

# RUN_RULE="";
# explain ${BINDIR}/Create_remote_GitHub_repository_B.md MORE_ACTION # CODE_BLOCK MANUAL_INPUT_REQUIRED
# if [ "${RUN_RULE}" != "n" ]; then
#  Create_remote_GitHub_repository_B;
# fi;

# explain ${BINDIR}/Create_local_GitHub_repository.md MORE_ACTION # CODE_BLOCK
# if [ "${RUN_RULE}" != "n" ]; then
  ${PROCESS_THIS} && {
    Create_local_GitHub_repository ${NONSTOP};
    echo -e "\n   Created local GitHub repository for '${PROJECT_NAME}'\n          - o 0 o - \n";
  }
# fi;


#    ~    ~    ~    ~    ~    ~    ~    ~    3    ~    ~    ~    ~    ~    ~
#    ~    ~    ~    ~    ~    ~    ~    ~    ~    ~    ~    ~    ~    ~    ~

setSection 3;

# explain ${BINDIR}/Create_a_module_A.md MORE_ACTION # CODE_BLOCK
# if [ "${RUN_RULE}" != "n" ]; then
  ${PROCESS_THIS} && {
    Create_a_module_A;
    echo -e "\n   Created module '${MODULE_NAME}': (A)\n          - o 0 o - \n";
  }
# fi;



# explain ${BINDIR}/Create_a_module_B.md MORE_ACTION # CODE_BLOCK
# if [ "${RUN_RULE}" != "n" ]; then
  ${PROCESS_THIS} && {
    Create_a_module_B;
    echo -e "\n   Created module '${MODULE_NAME}' : (B)\n          - o 0 o - \n";
  }
# fi;

# explain ${BINDIR}/Create_a_module_C.md MORE_ACTION # CODE_BLOCK
# if [ "${RUN_RULE}" != "n" ]; then
  ${PROCESS_THIS} && {
    Create_a_module_C;
    echo -e "\n   Created module '${MODULE_NAME}' : (C)\n          - o 0 o - \n";
  }
# fi;




# explain ${BINDIR}/Create_GitHub_Repo_Deploy_Keys.md MORE_ACTION # CODE_BLOCK
# if [ "${RUN_RULE}" != "n" ]; then
#   Create_GitHub_Repo_Deploy_Keys;
# fi;
  ${PROCESS_THIS} && {
    Create_GitHub_Repo_Deploy_Keys ${MODULE_NAME} ${REPLACE_EXISTING_PACKAGE};
    echo -e "\n   Created GitHub Repo Deploy Keys for '${MODULE_NAME}'\n          - o 0 o - \n";
  }


  ${PROCESS_THIS} && {
    Create_GitHub_Repo ${MODULE_NAME} ${REPLACE_EXISTING_PACKAGE};
    echo -e "\n   Created GitHub Repo for '${MODULE_NAME}'\n          - o 0 o - \n";
  }



# RUN_RULE="";
# explain ${BINDIR}/Control_a_modules_versions_A.md MORE_ACTION # CODE_BLOCK MANUAL_INPUT_REQUIRED
# if [ "${RUN_RULE}" != "n" ]; then
  # ${PROCESS_THIS} && {
  #   Control_a_modules_versions_A ${NONSTOP};
  #   echo -e "\n   Controlling '${MODULE_NAME}' module's versions : A\n          - o 0 o - \n";
  # }
# fi;

  ${PROCESS_THIS} && {
    Add_GitHub_Repo_Deploy_Key ${MODULE_NAME}  ${REPLACE_EXISTING_PACKAGE};
    echo -e "\n   Added GitHub Repo Deploy Key for '${MODULE_NAME}' \n          - o 0 o - \n";
  }


# explain ${BINDIR}/Control_a_modules_versions_B.md  MORE_ACTION # CODE_BLOCK
# if [ "${RUN_RULE}" != "n" ]; then
  ${PROCESS_THIS} && {
    Control_a_modules_versions_B "${NONSTOP}";
    echo -e "\n   Controlled '${MODULE_NAME}' module's versions : B\n          - o 0 o - \n";
  }
# fi;



# explain ${BINDIR}/TinyTest_a_module.md MORE_ACTION # CODE_BLOCK
# if [ "${RUN_RULE}" != "n" ]; then
#   TinyTest_a_module;
# fi;

# explain ${BINDIR}/Add_a_test_runner_for_getting_TinyTest_output_on_the_command_line.md MORE_ACTION # CODE_BLOCK
# if [ "${RUN_RULE}" != "n" ]; then
  ${PROCESS_THIS} && {
    Add_a_test_runner_for_getting_TinyTest_output_on_the_command_line ${NONSTOP};
    echo -e "\n   Added a test runner for getting TinyTest output on the command line. : B\n          - o 0 o - \n";
  }
# fi;


#    ~    ~    ~    ~    ~    ~    ~    ~    4    ~    ~    ~    ~    ~    ~
#    ~    ~    ~    ~    ~    ~    ~    ~    ~    ~    ~    ~    ~    ~    ~
  ${PROCESS_THIS} && {

    setSection 4;

    Customize_ESLint_in_Sublime_Text;
    echo -e "\n   Customized ESLint in Sublime Text. : \n          - o 0 o - \n";

    Correct_the_indicated_code_quality_defects;
    echo -e "\n   Corrected the indicated code-quality defects. : \n          - o 0 o - \n";

    Ignore_Some_Files;
    echo -e "\n   Marked some files to be ignored. : \n          - o 0 o - \n";

    Try_ESLint_Command_Line_Again;
    echo -e "\n   Reran linting. : \n          - o 0 o - \n";

  }



#    ~    ~    ~    ~    ~    ~    ~    5    ~    ~    ~    ~    ~    ~    ~
#    ~    ~    ~    ~    ~    ~    ~    ~    ~    ~    ~    ~    ~    ~    ~

  ${PROCESS_THIS} && {

    setSection 5;

# explain ${BINDIR}/Try_jsDoc_from_the_Command_Line_A.md MORE_ACTION # CODE_BLOCK
# if [ "${RUN_RULE}" != "n" ]; then
    Try_jsDoc_from_the_Command_Line_A;
    echo -e "\n   Ran jsDoc against ./modules/${MODULE_NAME}\n          - o 0 o - \n";
# fi;

pwd; echo "MWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMW";
# explain ${BINDIR}/Try_jsDoc_from_the_Command_Line_B.md MORE_ACTION # CODE_BLOCK
# if [ "${RUN_RULE}" != "n" ]; then
#   Try_jsDoc_from_the_Command_Line_B;
# fi;

# RUN_RULE="";
# explain ${BINDIR}/Configure_Sublime_Text_to_use_jsDoc.md # MANUAL_INPUT_REQUIRED

# explain ${BINDIR}/Use_Sublime_Text_jsDoc_plugin_A.md MORE_ACTION # CODE_BLOCK
# if [ "${RUN_RULE}" != "n" ]; then
    Use_Sublime_Text_jsDoc_plugin_A;
    echo -e "\n   Patched ./packages/${MODULE_NAME}/${MODULE_NAME}-tests.js for slide 5\n          - o 0 o - \n";
# fi;

# RUN_RULE="";
# explain ${BINDIR}/Use_Sublime_Text_jsDoc_plugin_B.md # MANUAL_INPUT_REQUIRED
# if [ "${RUN_RULE}" != "n" ]; then
    Use_Sublime_Text_jsDoc_plugin_B;
    echo -e "\n   Patched ./packages/${MODULE_NAME}/${MODULE_NAME}-tests.js for slide 6\n          - o 0 o - \n";

# explain ${BINDIR}/Use_Sublime_Text_jsDoc_plugin_C.md MORE_ACTION # CODE_BLOCK
# if [ "${RUN_RULE}" != "n" ]; then
    Use_Sublime_Text_jsDoc_plugin_C;
    echo -e "\n   Rebuilt documentation after patches\n          - o 0 o - \n";
# fi;

# RUN_RULE="";
# explain ${BINDIR}/Publish_jsDocs_toGitHub_A.md

# TEMP_ZIP="/tmp/${MODULE_NAME}_BINDIR.zip"
# explain ${BINDIR}/Publish_jsDocs_toGitHub_B.md MORE_ACTION # CODE_BLOCK
# if [ "${RUN_RULE}" != "n" ]; then
    Publish_jsDocs_toGitHub_B;
    echo -e "\n   Published documentation to GitHub pages\n          - o 0 o - \n";
# fi;

  }

#    ~    ~    ~    ~    ~    ~    ~    6    ~    ~    ~    ~    ~    ~    ~
#    ~    ~    ~    ~    ~    ~    ~    ~    ~    ~    ~    ~    ~    ~    ~

echo -e "\n - o 0 o -|||>>> \n"; #
PROCESS_THIS=true;
# exit;


  ${PROCESS_THIS} && {

    setSection 6;

    SKIP_CI=", but [ci skip].";

    # explain ${BINDIR}/Connect_CircleCI_to_GitHub_B.md MORE_ACTION # CODE_BLOCK MANUAL_INPUT_REQUIRED
    # if [ "${RUN_RULE}" != "n" ]; then
      Connect_CircleCI_to_GitHub_B;
      echo -e "\n   Verified CircelCI tokens\n          - o 0 o - \n";
    # fi;
exit;

    # explain ${BINDIR}/Add_a_CircleCI_configuration_file_and_push_to_GitHub.md MORE_ACTION # CODE_BLOCK
    # if [ "${RUN_RULE}" != "n" ]; then
      Add_a_CircleCI_configuration_file_and_push_to_GitHub ${NONSTOP};
      echo -e "\n   Added a CircleCI configuration file and push to GitHub\n          - o 0 o - \n";
    # fi;

    # explain ${BINDIR}/Amend_the_configuration_and_push_again.md MORE_ACTION # CODE_BLOCK
    # if [ "${RUN_RULE}" != "n" ]; then
      Amend_the_configuration_and_push_again ${NONSTOP};
      echo -e "\n   Amended the configuration and push again\n          - o 0 o - \n";
    # fi;

pwd; echo "MWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMW";
    # explain ${BINDIR}/Prepare_for_NightWatch_testing.md MORE_ACTION # CODE_BLOCK
    # if [ "${RUN_RULE}" != "n" ]; then
      Prepare_for_NightWatch_testing;
      echo -e "\n   Prepared for NightWatch testing\n          - o 0 o - \n";
pwd; echo "MWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMW";
    # fi;

    # explain ${BINDIR}/Run_NightWatch_testing.md MORE_ACTION # CODE_BLOCK
    # if [ "${RUN_RULE}" != "n" ]; then
      Run_NightWatch_testing ${NONSTOP};
      echo -e "\n   Ran NightWatch_testing\n          - o 0 o - \n";
pwd; echo "MWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMW";
    # fi;

    # explain ${BINDIR}/Configure_CircleCI_for_Nightwatch_Testing.md MORE_ACTION # CODE_BLOCK
    # if [ "${RUN_RULE}" != "n" ]; then
      Configure_CircleCI_for_Nightwatch_Testing;
      echo -e "\n   Configured CircleCI for Nightwatch Testing\n          - o 0 o - \n";
pwd; echo "MWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMW";
    # fi;

    SKIP_CI="";

  }




#    ~    ~    ~    ~    ~    ~    ~    7    ~    ~    ~    ~    ~    ~    ~
#    ~    ~    ~    ~    ~    ~    ~    ~    ~    ~    ~    ~    ~    ~    ~
  ${PROCESS_THIS} && {

    setSection 7;

    # SKIP_CI=", but [ci skip].";

    # RUN_RULE="";
    # explain ${BINDIR}/Observe_ordinary_console_logging.md # MANUAL_INPUT_REQUIRED

    # RUN_RULE="";
    # explain ${BINDIR}/Add_an_NPM_module_to_your_package.md # MANUAL_INPUT_REQUIRED

    # RUN_RULE="";
    # explain ${BINDIR}/Specify_Npm_modules.md # MANUAL_INPUT_REQUIRED

    # RUN_RULE="";
    # explain ${BINDIR}/Bunyan_Server_Side_OnlyLogging.md # MANUAL_INPUT_REQUIRED

    # RUN_RULE="";
    # explain ${BINDIR}/Add_Bunyan_Logging.md # MANUAL_INPUT_REQUIRED

    # RUN_RULE="";
    # explain ${BINDIR}/Goodbye_console.md # MANUAL_INPUT_REQUIRED

    # RUN_RULE="";
    # explain ${BINDIR}/Refactor_Bunyan_InstantiationA.md MORE_ACTION # CODE_BLOCK MANUAL_INPUT_REQUIRED
    # if [ "${RUN_RULE}" != "n" ]; then
    Refactor_Bunyan_InstantiationA;
    echo -e "\n   Brought in the 'logger.js' file.\n          - o 0 o - \n";
    # fi;

pwd; echo "MWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMW";
    # RUN_RULE="";
    # explain ${BINDIR}/Refactor_Bunyan_InstantiationB.md # MANUAL_INPUT_REQUIRED

    Refactor_Bunyan_InstantiationB;
    echo -e "\n   Brought in edited 'package.js' and '${MODULE_NAME}-tests.js' files.\n          - o 0 o - \n";
pwd; echo "MWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMW";
    # RUN_RULE="";
    # explain ${BINDIR}/Refactor_Bunyan_InstantiationC.md # MANUAL_INPUT_REQUIRED

    Refactor_Bunyan_InstantiationC;
    echo -e "\n   Brought in edited 'package.js' and '${MODULE_NAME}-tests.js' files.\n          - o 0 o - \n";
pwd; echo "MWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMW";

    # explain ${BINDIR}/Package_Upgrade_and_Project_Rebuild_A.md MORE_ACTION # CODE_BLOCK
    # if [ "${RUN_RULE}" != "n" ]; then
    #   # Package_Upgrade_and_Project_Rebuild_A;
    # fi;

    # explain ${BINDIR}/Package_Upgrade_and_Project_Rebuild_B.md MORE_ACTION # CODE_BLOCK
    # if [ "${RUN_RULE}" != "n" ]; then
    Package_Upgrade_and_Project_Rebuild_B;
    echo -e "\n   Pushed production logging example to cloud.\n          - o 0 o - \n";
pwd; echo "MWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMW";

    # fi;

    SKIP_CI="";

}



#    ~    ~    ~    ~    ~    ~    ~    8    ~    ~    ~    ~    ~    ~    ~
#    ~    ~    ~    ~    ~    ~    ~    ~    ~    ~    ~    ~    ~    ~    ~
${PROCESS_THIS} && {

    setSection 8;

    SKIP_CI=", but [ci skip].";

    # echo ""
    # echo ""
    # RUN_RULE="";
    # explain ${BINDIR}/Another_NodeJS_moduleA.md # MANUAL_INPUT_REQUIRED

    # echo ""
    # echo ""
    # explain ${BINDIR}/Another_NodeJS_moduleB.md MORE_ACTION # CODE_BLOCK
    # if [ "${RUN_RULE}" != "n" ]; then
    Another_NodeJS_moduleB;
    echo -e "\n   Obtained script that resets sample data in Swagger Pet Store.\n          - o 0 o - \n";
pwd; echo "MWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMW";
    # fi;

    # echo ""
    # echo ""
    # explain ${BINDIR}/Another_NodeJS_moduleC.md MORE_ACTION # CODE_BLOCK
    # if [ "${RUN_RULE}" != "n" ]; then
    Another_NodeJS_moduleC ${NONSTOP};
    echo -e "\n   Reset Pet Store sample data.\n          - o 0 o - \n";
pwd; echo "MWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMW";
    # fi;

    # echo ""
    # echo ""
    # explain ${BINDIR}/Async_Problem_Buried_Methods.md

    # echo ""
    # echo ""
    # RUN_RULE="";
    # explain ${BINDIR}/Async_Problem_Wrapped_Proxy_A.md # MANUAL_INPUT_REQUIRED

    # echo ""
    # echo ""
    # RUN_RULE="";
    # explain ${BINDIR}/Async_Problem_Wrapped_Proxy_B.md  # MANUAL_INPUT_REQUIRED


    # echo ""
    # echo ""
    # RUN_RULE="";
    # explain ${BINDIR}/Async_Problem_Sync_Namespace.md # MANUAL_INPUT_REQUIRED

    # echo ""
    # echo ""
    # RUN_RULE="";
    # explain ${BINDIR}/Async_Problem_TinyTest_A.md # MANUAL_INPUT_REQUIRED
    Async_Problem_TinyTest_A;
    echo -e "\n   Brought in a '${MODULE_NAME}-tests.js' file, edited for the Async problem example.\n          - o 0 o - \n";
pwd; echo "MWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMW";

    # echo ""
    # echo ""
    # RUN_RULE="";
    # explain ${BINDIR}/Call_Into_Package_Methods.md MORE_ACTION # CODE_BLOCK MANUAL_INPUT_REQUIRED
    # if [ "${RUN_RULE}" != "n" ]; then
    Call_Into_Package_Methods;
    echo -e "\n   Brought in 'usage_example.js' and 'usage_example.html' files, edited for the Async problem example.\n          - o 0 o - \n";
pwd; echo "MWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMW";
    # fi;

    # echo ""
    # echo ""
    # RUN_RULE="";
    # explain ${BINDIR}/Package_Dependencies.md # MANUAL_INPUT_REQUIRED
    Package_Dependencies;
    echo -e "\n   Brought in a 'package.js' file, edited for the Async problem example.\n          - o 0 o - \n";
pwd; echo "MWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMW";

    # echo ""
    # echo ""
    # RUN_RULE="";
    # explain ${BINDIR}/Declare_Callable_Method.md # MANUAL_INPUT_REQUIRED
    Declare_Callable_Method;
    echo -e "\n   Brought in a '${MODULE_NAME}.js' file, edited for the Async problem example.\n          - o 0 o - \n";
pwd; echo "MWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMW";

    # echo ""
    # echo ""
    # explain ${BINDIR}/View_and_Hide_The_Example.md MORE_ACTION # CODE_BLOCK
    # if [ "${RUN_RULE}" != "n" ]; then
  # View_and_Hide_The_Example;
  #  echo -e "\n   \n          - o 0 o - \n";
    # fi;

    SKIP_CI="";

}


#    ~    ~    ~    ~    ~    ~    ~    9    ~    ~    ~    ~    ~    ~    ~
#    ~    ~    ~    ~    ~    ~    ~    ~    ~    ~    ~    ~    ~    ~    ~

${PROCESS_THIS} && {

    setSection 9;

    SKIP_CI=", but [ci skip].";

    UsageExampleEndToEnd_prep;
    echo -e "\n   Brought in an edited 'nightwatch.json' file.\n          - o 0 o - \n";
pwd; echo "MWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMW";

    # explain ${BINDIR}/UsageExampleEndToEnd.md MORE_ACTION # CODE_BLOCK MANUAL_INPUT_REQUIRED
    # if [ "${RUN_RULE}" != "n" ]; then
    UsageExampleEndToEnd;
    # fi;
pwd; echo "MWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMW";

    # explain ${BINDIR}/FinishDocumentation.md MORE_ACTION # CODE_BLOCK
    # if [ "${RUN_RULE}" != "n" ]; then
    FinishDocumentation;
    echo -e "\n   Brought in '${MODULE_NAME}.js' and 'usage_example.js' files edited  with jsDoc annotations.\n          - o 0 o - \n";
    # fi;
pwd; echo "MWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMW";

    # explain ${BINDIR}/IntegratingEverything.md MORE_ACTION # CODE_BLOCK
    # if [ "${RUN_RULE}" != "n" ]; then
    IntegratingEverything;
    echo -e "\n   Committed latest changes to project '${PROJECT_NAME}' and package '${MODULE_NAME}'.\n          - o 0 o - \n";
    # fi;
pwd; echo "MWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMW";


    # explain ${BINDIR}/CodeMaintenanceHelperFile_B.md MORE_ACTION # CODE_BLOCK
    # if [ "${RUN_RULE}" != "n" ]; then
    CodeMaintenanceHelperFile_B;
    echo -e "\n   Made and tested a mock version of 'perform_ci_tasks.sh'.\n          - o 0 o - \n";
    # fi;
pwd; echo "MWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMW";

    # explain ${BINDIR}/CodeMaintenanceHelperFile_C.md MORE_ACTION # CODE_BLOCK
    # if [ "${RUN_RULE}" != "n" ]; then
    CodeMaintenanceHelperFile_C;
    echo -e "\n   Obtained and tested the final 'perform_ci_tasks.sh'.\n          - o 0 o - \n";
    # fi;
pwd; echo "MWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMW";

    # explain ${BINDIR}/PushDocsToGitHubPagesFromCIBuild_A.md MORE_ACTION # CODE_BLOCK
    # if [ "${RUN_RULE}" != "n" ]; then
    PushDocsToGitHubPagesFromCIBuild_A;
    echo -e "\n   Enabled 'commitDocs' function and got 'circle_T09.yml'.\n          - o 0 o - \n";
    # fi;
pwd; echo "MWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMW";

    # explain ${BINDIR}/PushDocsToGitHubPagesFromCIBuild_B.md MORE_ACTION # CODE_BLOCK
    # if [ "${RUN_RULE}" != "n" ]; then
    SKIP_CI="";
    PushDocsToGitHubPagesFromCIBuild_B;
    echo -e "\n   Pushed project and package to GitHub.\n          - o 0 o - \n";
    SKIP_CI=", but [ci skip].";
    # fi;
pwd; echo "MWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMW";

    # explain ${BINDIR}/InspectBuildResults.md MORE_ACTION # CODE_BLOCK
    # if [ "${RUN_RULE}" != "n" ]; then
    InspectBuildResults;
    echo -e "\n   CircleCI build result reported.\n          - o 0 o - \n";
pwd; echo "MWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMW";


    # explain ${BINDIR}/ReportAnIssue.md MORE_ACTION # CODE_BLOCK
    # if [ "${RUN_RULE}" != "n" ]; then
    ReportAnIssue;
    echo -e "\n   Issue reporting explained.\n          - o 0 o - \n";
pwd; echo "MWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMW";


    SKIP_CI="";


}

#    ~    ~    ~    ~    ~    ~    10 A ~    ~    ~    ~    ~    ~    ~    ~
#    ~    ~    ~    ~    ~    ~    ~    ~    ~    ~    ~    ~    ~    ~    ~
${PROCESS_THIS} && {

  setSection 10;

  SKIP_CI=", but [ci skip].";

    # explain ${BINDIR}/PrepareAndroidSDK_A.md;

    # explain ${BINDIR}/PrepareAndroidSDK_B.md MORE_ACTION # CODE_BLOCK
    # if [ "${RUN_RULE}" != "n" ]; then
    PrepareAndroidSDK_B;
    echo -e "\n   Prepared Android SDK.\n          - o 0 o - \n";
pwd; echo "MWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMW";


    # explain ${BINDIRBuildAndroidAPK_A.md MORE_ACTION # CODE_BLOCK
    # if [ "${RUN_RULE}" != "n" ]; then
    BuildAndroidAPK_A;
    echo -e "\n   Prepared project APK.\n          - o 0 o - \n";
pwd; echo "MWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMW";

    # explain ${BINDIR}/BuildAndroidAPK_B.md MORE_ACTION # CODE_BLOCK
    # if [ "${RUN_RULE}" != "n" ]; then
    BuildAndroidAPK_B;
    echo -e "\n   Built project APK.\n          - o 0 o - \n";
pwd; echo "MWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMW";


    # explain ${BINDIR}/PushDocsToGitHubPagesFromCIBuild_B.md MORE_ACTION # CODE_BLOCK
    # if [ "${RUN_RULE}" != "n" ]; then
    DeployToMeteorServers;
    echo -e "\n   Deployed to Meteor Servers.\n          - o 0 o - \n";
pwd; echo "MWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMW";

    # explain ${BINDIR}/?????????????.md MORE_ACTION # CODE_BLOCK
    # if [ "${RUN_RULE}" != "n" ]; then
    PrepareCIwithAndroidSDK;
    echo -e "\n   Prepared CircleCI for installing AndroidSDK.\n          - o 0 o - \n";
pwd; echo "MWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMW";


    # explain ${BINDIR}/?????????????.md MORE_ACTION # CODE_BLOCK
    # if [ "${RUN_RULE}" != "n" ]; then
    PrepareCIwithAndroidBuilder;
    echo -e "\n   Prepared CircleCI with Android Builder.\n          - o 0 o - \n";
pwd; echo "MWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMW";

    # explain ${BINDIR}/?????????????.md MORE_ACTION # CODE_BLOCK
    # if [ "${RUN_RULE}" != "n" ]; then
    PrepareCIwithMeteorDeployment;
    echo -e "\n   Prepare CircleCI with Meteor deployment capability.\n          - o 0 o - \n";
pwd; echo "MWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMW";


    SKIP_CI="";

}


#    ~    ~    ~    ~    ~    ~    10 A ~    ~    ~    ~    ~    ~    ~    ~
#    ~    ~    ~    ~    ~    ~    ~    ~    ~    ~    ~    ~    ~    ~    ~
${PROCESS_THIS} && {

  setSection 10;

    # explain ${BINDIR}/?????????????.md MORE_ACTION # CODE_BLOCK
    # if [ "${RUN_RULE}" != "n" ]; then
    ShowStatusSymbol;
    echo -e "\n   Sport CircleCI Status Symbol on package README.md file.\n          - o 0 o - \n";
pwd; echo "MWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMW";


    # explain ${BINDIR}/?????????????.md MORE_ACTION # CODE_BLOCK
    # if [ "${RUN_RULE}" != "n" ]; then
    SKIP_CI="";
    PushFinalChanges;
    echo -e "\n   Pushing latest changes to GitHub for rebuild on CircleCI.\n          - o 0 o - \n";
    SKIP_CI=", but [ci skip].";
pwd; echo "MWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMW";

# TODO ::
#  - git add tools/android/install-android-dependencies.sh
#  - git commit circle.yml tools/android/install-android-dependencies.sh


}


echo -e "\n - o 0 o -|||>>> \n"; #
PROCESS_THIS=true;

exit 0;
