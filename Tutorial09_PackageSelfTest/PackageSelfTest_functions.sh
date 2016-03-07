
function UsageExampleEndToEnd_prep() {

  pushd ~/${PARENT_DIR}/${PROJECT_NAME}/tests/nightwatch/config/ >/dev/null;

  wget -O nightwatch.json https://raw.githubusercontent.com/martinhbramwell/Meteor-CI-Tutorial/master/fragments/nightwatch_T09_02.json;
  sed -i -e "s/\${PKG_NAME}/${PKG_NAME}/" nightwatch.json;

  popd >/dev/null;

}


function UsageExampleEndToEnd() {

  pushd ~/${PARENT_DIR}/${PROJECT_NAME} >/dev/null;
    pushd ./packages/${PKG_NAME}/tools/testing >/dev/null;

    NGHTWTCH_FILE=test_usage_example.js;
    wget -O ${NGHTWTCH_FILE} https://raw.githubusercontent.com/martinhbramwell/Meteor-CI-Tutorial/master/fragments/${NGHTWTCH_FILE}
    sed -i -e "s/\${PKG_NAME}/${PKG_NAME}/" ${NGHTWTCH_FILE}
    sed -i -e "s/\${YOUR_FULLNAME}/${YOUR_FULLNAME}/" ${NGHTWTCH_FILE}
    sed -i -e "s/\${YOUR_EMAIL}/${YOUR_EMAIL}/" ${NGHTWTCH_FILE}

    popd >/dev/null;

  killMeteorProcess
  launchMeteorProcess "http://localhost:3000/"

  ./tests/nightwatch/runTests.js | bunyan

  killMeteorProcess

  popd >/dev/null;

}

function FinishDocumentation() {

  pushd ~/${PARENT_DIR}/${PROJECT_NAME}/packages/${PKG_NAME} >/dev/null;

  mkdir -p backup
  cp ${PKG_NAME}.js backup/${PKG_NAME}_$(date +%Y%m%d%H%M).js
  cp usage_example.js backup/usage_example_$(date +%Y%m%d%H%M).js

  wget -O ${PKG_NAME}.js https://raw.githubusercontent.com/martinhbramwell/Meteor-CI-Tutorial/master/fragments/yourpackage_documented.js
  sed -i -e "s/\${PKG_NAME}/${PKG_NAME}/" ${PKG_NAME}.js;
  sed -i -e "s/\${YOUR_FULLNAME}/${YOUR_FULLNAME}/" ${PKG_NAME}.js;
  sed -i -e "s/\${YOUR_EMAIL}/${YOUR_EMAIL}/" ${PKG_NAME}.js;

  wget -O usage_example.js https://raw.githubusercontent.com/martinhbramwell/Meteor-CI-Tutorial/master/fragments/usage_example_documented.js
  sed -i -e "s/\${PKG_NAME}/${PKG_NAME}/" usage_example.js;
  sed -i -e "s/\${YOUR_FULLNAME}/${YOUR_FULLNAME}/" usage_example.js;
  sed -i -e "s/\${YOUR_EMAIL}/${YOUR_EMAIL}/" usage_example.js;

  rm -fr ./docs
  jsdoc -d ./docs . ./tools/testing;
  echo -e "\n Documentation has been generated locally ..."
  echo -e "\n Look at : file://${HOME}/${PARENT_DIR}/${PROJECT_NAME}/packages/${PKG_NAME}/docs/index.html\n\n"

  popd >/dev/null;

}

function IntegratingEverything() {

  pushd ~/${PARENT_DIR}/${PROJECT_NAME} >/dev/null;
    pushd packages/${PKG_NAME} >/dev/null;

      eval "$(ssh-agent -s)";

      echo -e "Committing master branch changes of the package.\n"

      set +e
      echo -e "Adding all remaining files.\n";
      git add tools;
      git add .eslintrc;
      git add usage_example.html;
      git add usage_example.js;
      echo "Increment package version number"
      sed -i -r 's/(.*)(version: .)([0-9]+\.[0-9]+\.)([0-9]+)(.*)/echo "\1\2\3$((\4+1))\5"/ge' package.js;
      echo "git add errors : $?"
      git commit -am "save all we have done so far";
      echo "git commit errors : $?"
      git push
      echo "git push errors : $?"
      set -e

    popd >/dev/null;

    meteor list;
    git commit -am "catch update to '${PKG_NAME}'${SKIP_CI}";
    echo "git commit errors : $?"
    git push
    echo "git push errors : $?"

  popd >/dev/null;

}



function CodeMaintenanceHelperFile_B() {

  pushd ~/${PARENT_DIR}/${PROJECT_NAME} >/dev/null;
    pushd ./packages >/dev/null;
      pushd ./${PKG_NAME}/tools >/dev/null;
        echo -e "#!/bin/bash\n#\necho 'I will perform CI tasks on ${PKG_NAME}.';" > perform_ci_tasks.sh
        chmod a+x perform_ci_tasks.sh;
      popd >/dev/null;

      wget -N https://raw.githubusercontent.com/martinhbramwell/Meteor-CI-Tutorial/master/fragments/perform_per_package_ci_tasks.sh
      chmod a+x perform_per_package_ci_tasks.sh;

    popd >/dev/null;
  popd >/dev/null;

  echo "Executing 'perform_per_package_ci_tasks.sh' . . .";
  ~/${PARENT_DIR}/${PROJECT_NAME}/packages/perform_per_package_ci_tasks.sh;
  echo ". . . Executed.";


}




function CodeMaintenanceHelperFile_C() {

  pushd ~/${PARENT_DIR}/${PROJECT_NAME}/packages/${PKG_NAME} >/dev/null;
    pushd ./tools >/dev/null;

      wget -N https://raw.githubusercontent.com/martinhbramwell/Meteor-CI-Tutorial/master/fragments/perform_ci_tasks.sh
      sed -i -e "s/\${YOUR_FULLNAME}/${YOUR_FULLNAME}/" perform_ci_tasks.sh;
      sed -i -e "s/\${YOUR_EMAIL}/${YOUR_EMAIL}/" perform_ci_tasks.sh;
      chmod a+x perform_ci_tasks.sh;

    popd >/dev/null;

    # If executed locally this script leaves resideu that should not be version controlled.
    ESLNTRPT="esLintReport.txt";
    if [[ $(cat .gitignore | grep -c ${ESLNTRPT}) -lt 1 ]]; then echo ${ESLNTRPT} >> .gitignore; fi;

  popd >/dev/null;

  echo "Executing 'perform_per_package_ci_tasks.sh' . . .";
  ~/${PARENT_DIR}/${PROJECT_NAME}/packages/perform_per_package_ci_tasks.sh;
  echo ". . . Executed.";

}



function ScriptAuthorization() {

  echo -e "

  Copy the following link address to your browser . . .

         https://circleci.com/gh/${GITHUB_ORGANIZATION_NAME}/${PROJECT_NAME}/edit#checkout

  . . . to open your project's config page \"Checkout keys for ${GITHUB_ORGANIZATION_NAME}/${PROJECT_NAME}\"

  Confirm there is a valid user key and (optionally) delete the redundant deploy key.

";

}



function PushDocsToGitHubPagesFromCIBuild_A() {

  pushd ~/${PARENT_DIR}/${PROJECT_NAME} >/dev/null;

    pushd ./packages/${PKG_NAME}/tools >/dev/null;

          sed -i -e "s/# commitDocs/commitDocs/" perform_ci_tasks.sh;

    popd >/dev/null;
    wget -O circle.yml https://raw.githubusercontent.com/martinhbramwell/Meteor-CI-Tutorial/master/fragments/circle_T09.yml;

  popd >/dev/null;

}



function waitForCircleCI_ToHave_GitHub_User_Key() {

  echo -e "
  Cannot proceeed until the CircleCI project has a GitHub User Key.
  If none are found you must create one.
  ";

  CCIURI="https://circleci.com/api/v1/project";
  KEY_CNT=0;
  set +e;
  while [ ${KEY_CNT} -lt 1 ]; do
    KEY_CNT=$( curl -s ${CCIURI}/${GITHUB_ORGANIZATION_NAME}/${PROJECT_NAME}/checkout-key?circle-token=${CIRCLECI_PERSONAL_TOKEN} | grep -c "github-user-key" );
    echo "          Found ${KEY_CNT} GitHub User Keys in CircleCI.";
    if [ ${KEY_CNT} -lt 1 ]; then
      sleep 5;
    fi;
  done;
  echo " ";
  set -e;

}



function PushDocsToGitHubPagesFromCIBuild_B() {

  waitForCircleCI_ToHave_GitHub_User_Key;

  CLEAN="nothing to commit";
  UP2DT="Everything up-to-date";
  pushd ~/${PARENT_DIR}/${PROJECT_NAME} >/dev/null;
    pushd ./packages >/dev/null;
      pushd ./${PKG_NAME} >/dev/null;

        git add ./tools/perform_ci_tasks.sh;
        STS="$(git status)";
        if [ "${STS/${CLEAN}}" = "${STS}" ]; then
          git commit -am "Added code maintenance tasks";
        fi;
        PSH=$(git push);
        if [ "${PSH/${UP2DT}}" != "${PSH}" ]; then
          echo "Pushed ${PKG_NAME}";
        fi;

      popd >/dev/null;

    popd >/dev/null;

    git add ./packages/perform_per_package_ci_tasks.sh;
    git add circle.yml;

    STS="$(git status)";
    if [ "${STS/${CLEAN}}" = "${STS}" ]; then
      git commit -am "Added code maintenance tasks and augmented circle.yml${SKIP_CI}";
    fi;
    PSH=$(git push);
    if [ "${PSH/${UP2DT}}" != "${PSH}" ]; then
          echo "Pushed ${PROJECT_NAME}";
    fi;

  popd >/dev/null;


}

export ESLINT_RESULT_URL="";
export LINT_LINE="";
export LINT_RPT="";
function InspectBuildResults() {

  echo -e "Checking build status.";

  tput sc; # save cursor
  BUILD_RUNNING='"running"'; #   running OR success
  # :retried, :canceled, :infrastructure_fail, :timedout, :not_run, :running
  # , :failed, :queued, :scheduled, :not_running, :no_tests, :fixed, :success
  BUILD_STATUS=${BUILD_RUNNING};
  LIM=40; # 40
  SLP=15;
  CNT=1;
  TO=5;

  BUILD_STATUS="starting";
  printf  "          Build status '%s' for '%s/%s'; build #%s :: Elapsed %s seconds." ${BUILD_STATUS} ${GITHUB_ORGANIZATION_NAME} ${PROJECT_NAME} ${BUILD_NUMBER} ${TO};

#  BUILD_STATUS=$(cat ./tst/status_file);
#  echo ${BUILD_STATUS}

  while [ ${CNT} -lt ${LIM} ]; do

    sleep ${SLP};
    TO=$(( SLP*CNT ));
    CNT=$(( CNT + 1 ));

    # BUILD_STATUS=$(cat ./tst/status_file);
    RESP=$( curl -s https://circleci.com/api/v1/project/${GITHUB_ORGANIZATION_NAME}/${PROJECT_NAME}?circle-token=${CIRCLECI_PERSONAL_TOKEN}               -H "Accept: application/json"  | jq '.[0] | {status, build_num}' );
    BUILD_STATUS=$( echo ${RESP} | jq '.status' );
    BUILD_STATUS=$(eval echo ${BUILD_STATUS});
  #   echo ${BUILD_STATUS};"success";
    BUILD_NUMBER=$( echo ${RESP} | jq '.build_num' );
  #  echo ${BUILD_NUMBER};

    tput rc;tput el;
    case "${BUILD_STATUS}" in

      not_running)
        ;&
      queued)
        ;&
      retried)
        ;&
      running)
        ;&
      scheduled)
        printf  "          Build status '%s' for '%s/%s'; build #%s :: Elapsed %s seconds." ${BUILD_STATUS} ${GITHUB_ORGANIZATION_NAME} ${PROJECT_NAME} ${BUILD_NUMBER} ${TO};
        ;;
      *) CNT=${LIM};
        ;;

    esac

    # BUILD_STATUS=$( echo ${RESP} | jq '.status' );
    # BUILD_NUMBER=$( echo ${RESP} | jq '.build_num' );
    # echo ${BUILD_NUMBER};


  done;

   echo ${BUILD_STATUS};

# canceled failed infrastructure_fail no_tests not_run timedout
# queued  retried  running  scheduled not_running
# success fixed
  tput rc;tput el;
  case "${BUILD_STATUS}" in

    not_running)
      ;&
    queued)
      ;&
    retried)
      ;&
    running)
      ;&
    scheduled)
      echo "Build still '${BUILD_STATUS}' after $((TO/60)) minutes.  Cannot get artifacts.";
      exit 1;
      ;;
    canceled)
      ;&
    failed)
      ;&
    infrastructure_fail)
      ;&
    no_tests)
      ;&
    timedout)
      ;&
    not_run)
      echo "Build aborted with status '${BUILD_STATUS}'.  Cannot get artifacts.";
      exit 1;
      ;;
    *)
      echo -e "\n        Finished waiting.\n";
      ;;

  esac;

  BUILD_NUM=$(curl -s https://circleci.com/api/v1/project/${GITHUB_ORGANIZATION_NAME}/${PROJECT_NAME}?circle-token=${CIRCLECI_PERSONAL_TOKEN}  -H "Accept: application/json"  | jq '.[0].build_num');
  echo -e "            Collecting artifacts of CircleCI build #${BUILD_NUM};";
  curl -s https://circleci.com/api/v1/project/${GITHUB_ORGANIZATION_NAME}/${PROJECT_NAME}/${BUILD_NUM}/artifacts?circle-token=${CIRCLECI_PERSONAL_TOKEN} -H "Accept: application/json" > /tmp/circleci_artifacts.json;

  echo -e "\n\n        Here's the linting result :";
  ESLINT_RESULT_URL=$(cat /tmp/circleci_artifacts.json | jq '.[] | .url' | grep esLintReport);
  LINT_RPT=$(wget -qO- ${ESLINT_RESULT_URL//\"/} );
  echo -e "
    ${LINT_RPT}
  ";
  # wget -qO- ${ESLINT_RESULT_URL//\"/};
  printf "%0.s~" {1..80};

  echo -e "\n\n      ...and here's the NightWatch result :";
  NGHTWTCH_RESULT_URL=$(cat /tmp/circleci_artifacts.json | jq '.[] | .url' | grep 'result.json');
  wget -qO- ${NGHTWTCH_RESULT_URL//\"/} | bunyan -o short;
  printf "%0.s~" {1..80};


}


function ReportAnIssue() {

  set +e;
  LINT_LINE=$( echo -e "
    ${LINT_RPT}
  " | grep no-console );
  LINE_NUM=$(  echo -e "${LINT_LINE}" | sed "s/ //g" | cut -d ':' -f1  );
  COMMIT_SHA=$( curl -s https://api.github.com/repos/${GITHUB_ORGANIZATION_NAME}/${PKG_NAME}/commits/master | jq '.parents[].sha' | sed 's/"//g' );
  NC='\033[0m' # No Color

  echo -e "

        esLint warns of a slight defect in ${PROJECT_NAME}/packages/${PKG_NAME}/usage_example.js:
               ${LINT_LINE}

        You can create a new issue in GitHub at this page :
            https://github.com/${GITHUB_ORGANIZATION_NAME}/${PKG_NAME}/issues/new

        You can refer to permanent line number of a specific commit by clicking the
        line of text in GitHub and then typing 'y'.  Github will replace the address
        with the 'permalink' address, which can then be copied into the body of the
        issue report.

        Try using this link, to get the permalink :
            https://github.com/${GITHUB_ORGANIZATION_NAME}/${PKG_NAME}/blob/master/usage_example.js#L${LINE_NUM}

        ${NC}So, the markdown hyperlink to paste into the GitHub issue body should look like this :
            [usage_example.js - line #${LINE_NUM}](https://github.com/${GITHUB_ORGANIZATION_NAME}/${PKG_NAME}/blob/${COMMIT_SHA}/usage_example.js#L${LINE_NUM})

        ${NC}When you're done, click the [Preview] tab in the GitHub issue editor to see the result.

  "

    LINT_RPT="";
    LINT_LINE="";

  set -e;

}

