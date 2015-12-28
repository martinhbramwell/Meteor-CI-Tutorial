function ValidateCircleCiPersonalToken() {

  echo -e "\n Testing token validity. Will try to create a new CircleCi environment variable :\n";
  RESLT=$(curl -sX POST -H "Content-Type: application/json" \
  -d "{\"name\":\"YOUR_FULLNAME\", \"value\":\"${YOUR_FULLNAME}\"}" \
  https://circleci.com/api/v1/project/${GITHUB_ORGANIZATION_NAME}/${PROJECT_NAME}/envvar?circle-token=${CIRCLECI_PERSONAL_TOKEN} \
  -H "Accept: application/json");

  echo "Result was ${RESLT}";
  if [[ $(echo ${RESLT} | grep -c YOUR_FULLNAME) -gt 0 ]]; then
    echo "Token was able to authorize creation of an environment variable in CircleCI.";
    return 0;
  fi;

  echo "Token seems unable to authorize creation of an environment variable in CircleCI.";
  return 1;

}


function ObtainCircleCiPersonalToken() {

  if ValidateCircleCiPersonalToken; then return 0; fi;

  echo -e "

    ################################################################################################

    To get an API Token ::

    Copy the following link into a browser to open the API Tokens page of your
    CircleCI user's profile. Give a name for the token, eg. 'Personal token for ${YOUR_FULLNAME}'.
    Then click 'Create'. Look in the table for the 40 character code and paste it here below . . .

          https://circleci.com/account/api

    ################################################################################################
    ";

  until ValidateCircleCiPersonalToken; do
    loadShellVars;
    PARM_NAMES=("CIRCLECI_PERSONAL_TOKEN");
    askUserForParameters PARM_NAMES[@];
  done;


#   if [ -f ~/.udata.sh ]; then
#     source ~/.udata.sh
#   else
#     export CIRCLECI_PERSONAL_TOKEN="";
#   fi

#   CHOICE="n"
#   while [[ ! "X${CHOICE}X" == "XyX" ]]
#   do

# #    echo -e "${FRAME// /\~}"
#     echo "CircleCI personal token : ${CIRCLECI_PERSONAL_TOKEN}";

#     read -ep "Is this correct? (y/n/q) ::  " -n 1 -r USER_ANSWER
#     CHOICE=$(echo ${USER_ANSWER:0:1} | tr '[:upper:]' '[:lower:]')
#     if [[ "X${CHOICE}X" == "XqX" ]]; then
#       echo skip out
#       return 1;
#     elif [[ ! "X${CHOICE}X" == "XyX" ]]; then

#       echo -e "\n Please supply the following details :\n";
#       read -p "Your CircleCI personal token :: " -e -i "${CIRCLECI_PERSONAL_TOKEN}" INPUT
#       if [ ! "X${INPUT}X" == "XX" ]; then CIRCLECI_PERSONAL_TOKEN=${INPUT}; fi;

#     elif [[ "X${CHOICE}X" == "XyX" ]]; then

#       if ! ValidateCircleCiPersonalToken; then CHOICE="n"; fi;

#     fi;
#     echo "   ";
#   done;
#   echo "Recording CircleCI token for later use.";
#   saveUserData;

}


function CheckForGitHubUserKey() {

  echo -e "\n Checking for a \"github-user-key\" for \"${PACKAGE_DEVELOPER}\".\n";
  KEYCNT=$(curl -s https://circleci.com/api/v1/project/${GITHUB_ORGANIZATION_NAME}/${PROJECT_NAME}/checkout-key?circle-token=${CIRCLECI_PERSONAL_TOKEN}  -H "Accept: application/json" | grep "github-user-key" | grep -c "${PACKAGE_DEVELOPER}");
  if [[ ${KEYCNT} -gt 0 ]]; then
    echo -e "Found a seemingly valid \"github-user-key\" for \"${PACKAGE_DEVELOPER}\".";
    return 0;
  fi;

  echo -e "Did not find any \"github-user-key\" for \"${PACKAGE_DEVELOPER}\".";
  return 1;

}

function CheckForGitHubDeployKey() {

  echo -e "\n Checking if CircleCI has permission to access GitHub.";
  TEMP_DK_SPEC="/tmp/circleci_dk_spec.json";
  curl -sX POST --header "Content-Type: application/json" -d '{"type":"deploy-key"}' https://circleci.com/api/v1/project/${GITHUB_ORGANIZATION_NAME}/${PROJECT_NAME}/checkout-key?circle-token=${CIRCLECI_PERSONAL_TOKEN} -H "Accept: application/json" > ${TEMP_DK_SPEC};
  KEYCNT=$(cat ${TEMP_DK_SPEC} | jq ".type" | grep -c "deploy-key";);
  if [[ ${KEYCNT} -gt 0 ]]; then
    echo -e "  Was able to trial create a test deploy-key.";
    FINGERPRINT=$(cat ${TEMP_DK_SPEC} | jq ".fingerprint");
    FINGERPRINT=${FINGERPRINT%\"};
    FINGERPRINT=${FINGERPRINT#\"};
    echo "  Deleting trial deploy-key :: ${FINGERPRINT}.";
    curl -X DELETE https://circleci.com/api/v1/project/${GITHUB_ORGANIZATION_NAME}/${PROJECT_NAME}/checkout-key/${FINGERPRINT}?circle-token=${CIRCLECI_PERSONAL_TOKEN} -H "Accept: application/json";
    return 0;
  fi;

  echo -e "   ** Failed to trial create a test deploy-key **";
  return 1;

}


function CheckForRepoWatched() {

  echo -e "\n Verify CircleCI is watching repo :: '${GITHUB_ORGANIZATION_NAME}/${PROJECT_NAME}'.\n";


  REPONAME_CNT=$(curl -s https://circleci.com/api/v1/projects?circle-token=${CIRCLECI_PERSONAL_TOKEN} -H "Accept: application/json" \
    | jq '.[].reponame' | grep -c ${PROJECT_NAME});

#  REPONAME=${REPONAME%\"}; REPONAME=${REPONAME#\"};
#  echo "${REPONAME} vs ${PROJECT_NAME}";

  if [[ ${REPONAME_CNT} -gt 0 ]]; then
    echo -e "CircleCI is watching '${GITHUB_ORGANIZATION_NAME}/${PROJECT_NAME}'.";
    return 0;
  fi;

  echo -e "CircleCI is NOT watching '${GITHUB_ORGANIZATION_NAME}/${PROJECT_NAME}'.";
  return 1;

}


function CreateGitHubUserKey() {

  echo -e "\n Attempting to create a \"github-user-key\" for \"${PACKAGE_DEVELOPER}\".\n";

  KEYCNT=$(curl -sX POST \
     --header "Content-Type: application/json" \
     -d '{"type":"github-user-key"}' \
     https://circleci.com/api/v1/project/${GITHUB_ORGANIZATION_NAME}/${PROJECT_NAME}/checkout-key?circle-token=${CIRCLECI_PERSONAL_TOKEN} \
     -H "Accept: application/json" | grep "github-user-key" | grep -c "${PACKAGE_DEVELOPER}");
  # echo -e "\n~~~~~~~~~~~~~~~ ${KEYCNT} ";

  if [[ ${KEYCNT} -gt 0 ]]; then
    echo -e "Created a valid \"github-user-key\" for \"${PACKAGE_DEVELOPER}\".";
    return 0;
  fi;

  echo -e "Failed to create a \"github-user-key\" for \"${PACKAGE_DEVELOPER}\".";
  return 1;

}


function EnsureCircleCiAccessToGitHub() {

  if CheckForGitHubDeployKey; then return 0; fi;

  echo -e "

  ####################################################################################################

    CircleCI needs to be authorized to access GitHub.
    To set this up now, use your browser to open this URL ::

    https://github.com/organizations/${GITHUB_ORGANIZATION_NAME}/settings/oauth_application_policy

    Then either correctly enable CircleCI access, or add CircleCI from GitHub's integrations directory.

  ####################################################################################################
  ";
  CHOICE="n"
  while [[ ! "X${CHOICE}X" == "XyX" ]]
  do

    read -ep "Have you authorized CircleCI to access GitHub? (y/n/q) ::  " -n 1 -r USER_ANSWER
    CHOICE=$(echo ${USER_ANSWER:0:1} | tr '[:upper:]' '[:lower:]')
    if [[ "X${CHOICE}X" == "XqX" ]]; then
      echo skip out
      return 1;
    elif [[ ! "X${CHOICE}X" == "XyX" ]]; then

      echo -e "\n Please try again :\n";

    elif [[ "X${CHOICE}X" == "XyX" ]]; then

      if ! CheckForGitHubDeployKey; then CHOICE="n"; fi;

    fi;
    echo "       ";

  done;

}

function EnsureRepoIsWatched() {

  if CheckForRepoWatched; then return 0; fi;

  echo -e "

  ####################################################################################################

  CircleCI needs be told to watch the GitHub repo: '${GITHUB_ORGANIZATION_NAME}/${PROJECT_NAME}'.

  Copy the following link into a browser to access the page  ::

     https://circleci.com/add-projects

  If there is no button named '${GITHUB_ORGANIZATION_NAME}' follow CircleCI's \"Missing an organization?\" instructions.
  Then, click the green 'Build project' button beside the name '${PROJECT_NAME}'.

  ####################################################################################################
  ";

  CHOICE="n"
  while [[ ! "X${CHOICE}X" == "XyX" ]]
  do

    read -ep "Have you instructed CircleCI to watch the repo '${PROJECT_NAME}'? (y/n/q) ::  " -n 1 -r USER_ANSWER
    CHOICE=$(echo ${USER_ANSWER:0:1} | tr '[:upper:]' '[:lower:]')
    if [[ "X${CHOICE}X" == "XqX" ]]; then
      echo skip out
      return 1;
    elif [[ ! "X${CHOICE}X" == "XyX" ]]; then

      echo -e "\n Please try again :\n";

    elif [[ "X${CHOICE}X" == "XyX" ]]; then

      if ! CheckForRepoWatched; then CHOICE="n"; fi;

    fi;
    echo "       ";

  done;

}

function EnsureGitHubSshAccess() {

  if CheckForGitHubUserKey; then return 0; fi;
  if CreateGitHubUserKey; then return 0; fi;

  echo -e "

  ####################################################################################################

  CircleCI needs greater privileges in GitHub before it can create a \"github-user-key\" for \"${PACKAGE_DEVELOPER}\".

  Copy the following link into a browser to access the page 'Checkout keys for ${GITHUB_ORGANIZATION_NAME}/${PROJECT_NAME}' ::

     https://circleci.com/gh/${GITHUB_ORGANIZATION_NAME}/${PROJECT_NAME}/edit#checkout

  Click the green 'Authorize w/ GitHub' button.  GitHub will ask if you do indeed permit this action.
  Click the green 'Authorize Application' button, to agree.

  ####################################################################################################
  ";

  CHOICE="n"
  while [[ ! "X${CHOICE}X" == "XyX" ]]
  do

    read -ep "Have you authorized CircleCI to access GitHub SSH keys? (y/n/q) ::  " -n 1 -r USER_ANSWER
    CHOICE=$(echo ${USER_ANSWER:0:1} | tr '[:upper:]' '[:lower:]')
    if [[ "X${CHOICE}X" == "XqX" ]]; then
      echo skip out
      return 1;
    elif [[ ! "X${CHOICE}X" == "XyX" ]]; then

      echo -e "\n Please try again :\n";

    elif [[ "X${CHOICE}X" == "XyX" ]]; then

      if ! CreateGitHubUserKey; then CHOICE="n"; fi;

    fi;
    echo "       ";

  done;


}


function Connect_CircleCI_to_GitHub_B() {

  ObtainCircleCiPersonalToken;
  echo -e "We have connectivity to the CircleCI API.\n\n";

  EnsureCircleCiAccessToGitHub;
  echo -e "\nCircleCI has permission to access GitHub.\n\n";

  EnsureGitHubSshAccess;
  echo -e "We have a \"GitHub User Key\" that should bestow write privileges from CircleCI to GitHub project: '${GITHUB_ORGANIZATION_NAME}/${PROJECT_NAME}'.
     Validity can only be proven during an actual build run.
  "

  EnsureRepoIsWatched;
  echo -e "We have a \"GitHub User Key\" that should bestow write privileges from CircleCI to GitHub project: '${GITHUB_ORGANIZATION_NAME}/${PROJECT_NAME}'.
     Validity can only be proven during an actual build run.
  "

  return 0;

}

function Add_a_CircleCI_configuration_file_and_push_to_GitHub() {


  pushd ~/${PARENT_DIR}/${PROJECT_NAME} >/dev/null;

  # Get a circle.yml file
  cp example_circle.yml circle.yml;

  git add circle.yml;
  git add tests;
  set +e;    git commit -am 'Added circle.yml and unit testing.';   set -e;

#  echo -e "\n#####  eval \"\$(ssh-agent -s)\" ##### ";
  eval "$(ssh-agent -s)";

#  echo -e "\n#####  git push -u ${PROJECT_NAME}_origin master ##### ";
  git push -u ${PROJECT_NAME}_origin master;

  echo -e "

    ############################################################################################
    #   Open the page https://circleci.com/gh/${GITHUB_ORGANIZATION_NAME}/${PROJECT_NAME}/tree/master and explore
    #   the most recent build.  In the build section at the line 'tests/tinyTests/test-all.sh'
    #   you will find that tests failed for lack of a package to test.  We need to clone our package
    #   and depend a symbolic link to it.
    ############################################################################################
    ";
  if [[ "${1}" != "${NONSTOP}" ]]; then
    echo -e "Hit <enter> when ready to continue ::  ";
    read -n 1 -r USER_ANSWER;
  fi;

  popd >/dev/null;

}

# function StartCircleCiBuild() {

#   echo -e "\n >>  - - - - - -  ";
#   # TEMP_PROJECTS_STORE="/tmp/circleci_projects.json";
#   # curl -s https://circleci.com/api/v1/projects?circle-token=${CIRCLECI_PERSONAL_TOKEN} -H "Accept: application/json" > ${TEMP_PROJECTS_STORE};
#   # cat ${TEMP_PROJECTS_STORE} | jq ".[].reponame";

#   TEMP_BUILDS_STORE="/tmp/circleci_builds.json";
#   curl -s https://circleci.com/api/v1/project/${GITHUB_ORGANIZATION_NAME}/prj08?circle-token=${CIRCLECI_PERSONAL_TOKEN} -H "Accept: application/json" > ${TEMP_BUILDS_STORE};
#   cat ${TEMP_BUILDS_STORE} | jq ".[]";
#   echo -e "\n- - - - - - <<";

# }

function Amend_the_configuration_and_push_again() {

  pushd ~/${PARENT_DIR} >/dev/null;
  pushd ${PROJECT_NAME} >/dev/null;

  # 'obtain_managed_packages.sh' is called by the circle.yml script.
  # It depends on the array of package descriptions in 'managed_packages.sh'
  # It loops through the listed packages, clones them and links them into the project

  wget -O ./packages/managed_packages.sh https://raw.githubusercontent.com/martinhbramwell/Meteor-CI-Tutorial/master/fragments/managed_packages.sh
  wget -O ./packages/obtain_managed_packages.sh https://raw.githubusercontent.com/martinhbramwell/Meteor-CI-Tutorial/master/fragments/obtain_managed_packages.sh

  # Fix project specific flag variables
  sed -i -e "s/\${GITHUB_ORGANIZATION_NAME}/${GITHUB_ORGANIZATION_NAME}/" ./packages/managed_packages.sh
  sed -i -e "s/\${PKG_NAME}/${PKG_NAME}/" ./packages/managed_packages.sh
  sed -i -e "s/\${YOUR_UID}/${YOUR_UID}/" ./packages/managed_packages.sh

  chmod a+x ./packages/obtain_managed_packages.sh

  # Add execution of obtain_managed_packages.sh to circle.yml
  sed -i '/ADD_MORE_DEPENDENCY_PREPARATIONS_ABOVE_THIS_LINE/c\
    # Pull each of our packages and link them into our project\
    - ./packages/obtain_managed_packages.sh\
    # ADD_MORE_DEPENDENCY_PREPARATIONS_ABOVE_THIS_LINE' circle.yml

  git add packages;
  set +e;    git commit -am "Add script to clone packages and symlink to them${SKIP_CI}";   set -e;
#  git push -u ${PROJECT_NAME}_origin master;
  git push;

  echo -e "


  #########################################################################################
  #   Open your CircleCI site and explore the most recent build.  In the build section you
  #   should find the same lines as before when we ran the test runner locally :
  #   [INFO] http://127.0.0.1:4096/packages/test-in-console.js?59dde1f. . . 07b3f499 75:17 S: tinytest - example
  #########################################################################################";

  if [[ "${1}" != "${NONSTOP}" ]]; then
    echo -e "Hit <enter> after you have confirmed that CircleCI ran successful tests ::  ";
    read -n 1 -r USER_ANSWER;
  fi;

  popd >/dev/null;
  popd >/dev/null;

}

function Prepare_for_NightWatch_testing() {

  pushd ~/${PARENT_DIR}/${PROJECT_NAME} >/dev/null;

    wget -N https://github.com/warehouseman/meteor-nightwatch-runner/raw/master/meteor-nightwatch-runner.run;
    chmod ug+x meteor-nightwatch-runner.run;

    ./meteor-nightwatch-runner.run;

  popd >/dev/null;

}

function Run_NightWatch_testing() {

  pushd ~/${PARENT_DIR} >/dev/null;
  pushd ${PROJECT_NAME} >/dev/null;

  killMeteorProcess

  METEOR_URL="http://localhost:3000/";
  STARTED=false;

  until wget -q --spider ${METEOR_URL};
  do
    echo "Waiting for ${METEOR_URL}";
    if ! ${STARTED}; then
      meteor &
      STARTED=true;
    fi;
    sleep 2;
  done

  echo "Meteor is running on ${METEOR_URL}";

  ./tests/nightwatch/runTests.js | bunyan

  killMeteorProcess
  echo "Done.";


  echo -e "

    #########################################################################################
    #   You ought to see lines similar to these :
    #
    #   [2015-08-16T16:26:46.081Z]  INFO: demo/11123 on PkgTestDemo: Running:  Layout and Static Pages
    #   [2015-08-16T16:26:51.343Z]  INFO: demo/11123 on PkgTestDemo: ✔ Testing if element <body> is present.
    #   [2015-08-16T16:26:51.934Z]  INFO: demo/11123 on PkgTestDemo: OK. 1 assertions passed. (5.851s)
    #   [2015-08-16T16:26:51.936Z]  INFO: demo/11123 on PkgTestDemo:
    #   [2015-08-16T16:26:51.936Z]  INFO: demo/11123 on PkgTestDemo: OK. 1 assertion passed. (6.554s)
    #   [2015-08-16T16:26:52.253Z]  INFO: demo/11123 on PkgTestDemo: Finished!  Nightwatch ran all the tests!
    #
    #########################################################################################
    ";

  if [[ "${1}" != "${NONSTOP}" ]]; then
    echo -e "Hit <enter> after you have confirmed that you have these results ::  ";
    read -n 1 -r USER_ANSWER;
  fi;


  EXISTING_METEOR_PIDS=$(ps aux | grep meteor  | grep -v grep | grep ~/.meteor/packages | awk '{print $2}')
  for pid in ${EXISTING_METEOR_PIDS}; do
    echo "Kill Meteor process : ${pid}";
    kill -9 ${pid};
  done;

  popd >/dev/null;
  popd >/dev/null;


}

function Configure_CircleCI_for_Nightwatch_Testing() {

  pushd ~/${PARENT_DIR}/${PROJECT_NAME} >/dev/null;

  cp tests/nightwatch/config/example_circle.yml circle.yml;
  # Add execution of obtain_managed_packages.sh to circle.yml
  sed -i '/ADD_MORE_DEPENDENCY_PREPARATIONS_ABOVE_THIS_LINE/c\
    # Pull each of our packages and link them into our project\
    - ./packages/obtain_managed_packages.sh\
    # ADD_MORE_DEPENDENCY_PREPARATIONS_ABOVE_THIS_LINE' circle.yml

  git add tests/nightwatch;

  set +e;    git commit -am "Added Nightwatch testing${SKIP_CI}";   set -e;
  git push

  popd >/dev/null;

}

