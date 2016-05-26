#!/bin/bash

declare -A SHELLVARS;
declare SHELLVARNAMES=();

function addShellVar() {

  declare -A SHELLVAR;

  SHELLVARNAMES+=($1);
  SHELLVAR['LONG']=$2;
  SHELLVAR['SHORT']=$3;
  SHELLVAR['VAL']=$4;
  for key in "${!SHELLVAR[@]}"; do
    SHELLVARS[$1,$key]=${SHELLVAR[$key]}
  done

};

# PREPARE ALL NEEDED SHELL VARIABLES BELOW THIS LINE
# EXAMPLE
# addShellVar 'NAME' \
#             'LONG' \
#             'SHORT' \
#             'VAL';


addShellVar 'PARENT_DIR' \
            'Your directory for projects in the ${HOME} directory  :: ' \
            'Projects folder in ${HOME} directory : ${PARENT_DIR}' \
            '1';

addShellVar 'PROJECT_NAME' \
            'The exact project name for use in GitHub  :: ' \
            'Project name : ${PROJECT_NAME}' \
            '2';

addShellVar 'MODULE_NAME' \
            'The exact package name for use in GitHub  :: ' \
            'Package name : ${MDL_NAME}' \
            '3';

addShellVar 'GITHUB_ORGANIZATION_NAME' \
            'The exact name for the GitHub organization  :: ' \
            'GitHub organization name : ${GITHUB_ORGANIZATION_NAME}' \
            '4';

addShellVar 'PACKAGE_DEVELOPER' \
            'The project owner user id in GitHub  :: ' \
            'GutHub user id: ${PACKAGE_DEVELOPER}' \
            '5';

addShellVar 'YOUR_EMAIL' \
            'The email address for the project owner in GitHub  :: ' \
            'Project owner email : ${YOUR_EMAIL}' \
            '6';

addShellVar 'YOUR_UID' \
            'The project owner name to use within the project  :: ' \
            'Project owner local user id : ${YOUR_UID}' \
            '7';

addShellVar 'YOUR_FULLNAME' \
            'The project owner full name to use to publish it in GitHub  :: ' \
            'GutHub user full name : ${YOUR_FULLNAME}' \
            '8';

addShellVar 'CIRCLECI_PERSONAL_TOKEN' \
            'Your CircleCI personal token  :: ' \
            'CircleCI personal token : ${CIRCLECI_PERSONAL_TOKEN};' \
            '9';

addShellVar 'METEOR_UID' \
            'Meteor account user name for Meteor deployment server  :: ' \
            'Meteor server user ID : ${METEOR_UID};' \
            '10';

addShellVar 'METEOR_PWD' \
            'Meteor account password for Meteor deployment server  :: ' \
            'Meteor server password : ${METEOR_PWD};' \
            '11';

addShellVar 'KEYSTORE_PWD' \
            'Password for disposable Android app signature keys and key store  :: ' \
            'Password for disposable Android app signature keys and key store : ${KEYSTORE_PWD};' \
            '12';

addShellVar 'GITHUB_PERSONAL_TOKEN' \
            'Your GitHub personal token  :: ' \
            'GitHub personal token : ${GITHUB_PERSONAL_TOKEN};' \
            '13';

addShellVar 'REPLACE_EXISTING_PROJECT' \
            'Should the project "${PROJECT_NAME}" be COMPLETELY ERASED? (yes/no)  :: ' \
            'You approve deleting and replacing project "${PROJECT_NAME}" : ${REPLACE_EXISTING_PROJECT};' \
            '14';

addShellVar 'REPLACE_EXISTING_PACKAGE' \
            'Should the package "${MDL_NAME}" be COMPLETELY ERASED? (yes/no)  :: ' \
            'You approve deleting and replacing package "${MDL_NAME}" : ${REPLACE_EXISTING_PACKAGE};' \
            '15';

# addShellVar 'METEOR_UID' \
#             'Meteor account user name for Meteor deployment server :: ' \
#             'Meteor server user ID : ${METEOR_UID}' \
#             'durwent';

# addShellVar 'METEOR_PWD' \
#             'Meteor account password for Meteor deployment server :: ' \
#             'Meteor server password : ${METEOR_PWD}' \
#             'nnnnnnnnnnn';

# addShellVar 'METEOR_PWD' \
#             'Meteor account password for Meteor deployment server ' \
#             'Meteor server password : ${METEOR_PWD};' \
#             '11';

# addShellVar 'FLOOZIE' \
#             'WHAT DATA FOR floozz :: ' \
#             'The floozie is : ${FLOOZIE}' \
#             'floo';
