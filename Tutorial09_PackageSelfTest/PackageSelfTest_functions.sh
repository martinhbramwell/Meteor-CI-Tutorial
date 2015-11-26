
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
    git commit -am "catch update to '${PKG_NAME}'";
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

  pushd ~/${PARENT_DIR}/${PROJECT_NAME}/packages/${PKG_NAME}/tools >/dev/null;

    wget -N https://raw.githubusercontent.com/martinhbramwell/Meteor-CI-Tutorial/master/fragments/perform_ci_tasks.sh
    sed -i -e "s/\${YOUR_FULLNAME}/${YOUR_FULLNAME}/" perform_ci_tasks.sh;
    sed -i -e "s/\${YOUR_EMAIL}/${YOUR_EMAIL}/" perform_ci_tasks.sh;
    chmod a+x perform_ci_tasks.sh;

  popd >/dev/null;

  echo "Executing 'perform_per_package_ci_tasks.sh' . . .";
  ~/${PARENT_DIR}/${PROJECT_NAME}/packages/perform_per_package_ci_tasks.sh;
  echo ". . . Executed.";

}



function ScriptAuthorization() {

  echo -e "

  Copy the following link address to your browser to open your project's config page -- 
         \"Checkout keys for ${GITHUB_ORGANIZATION_NAME}/${PROJECT_NAME}\"
    , then add a user key and (optionally) delete the redundant deploy key.

    URL :: 

         https://circleci.com/gh/${GITHUB_ORGANIZATION_NAME}/${PROJECT_NAME}/edit#checkout

";

}



function PushDocsToGitHubPagesFromCIBuild() {

  pushd ~/${PARENT_DIR}/${PROJECT_NAME} >/dev/null;

    pushd ./packages/${PKG_NAME}/tools >/dev/null;

          sed -i -e "s/# commitDocs/commitDocs/" perform_ci_tasks.sh;

    popd >/dev/null;
    wget -O circle.yml https://raw.githubusercontent.com/martinhbramwell/Meteor-CI-Tutorial/master/fragments/circle_T09.yml;

  popd >/dev/null;

}



function AllowCircleCIToBeMeInGitHub() {
 echo -e "
   https://github.com/login/oauth/authorize
  ?client_id=78a2ba87f071c28e65bb
  &redirect_uri=https%3A%2F%2Fcircleci.com%2Fauth%2Fgithub%3Freturn-to%3D%252Fgh%252Fyourorg%252Fyourproject%252Fedit%2523checkout
  &scope=admin%3Apublic_key%2Cuser%3Aemail%2Crepo
  &state=SM9aJIYpibO_GLpAq-7GMFthcgXKvP5IGtv-NODLIgLX2Ay12AI4YucFwCNGLur40wbe5G4Se9JKOhMF
  ";

  echo -e "
  https://circleci.com/auth/github?return-to=%2Fgh%2Fyourorg%2Fyourproject%2Fedit%23checkout
  &scope=admin:public_key,user:email,repo
  ";

  echo -e "
/gh/yourorg/yourproject/edit#checkout
  ";

  echo -e "
  ";

# curl -X POST --header "Content-Type: application/json" -d '{"type":"github-user-key"}' https://circleci.com/api/v1/project/yourorg/yourproject/checkout-key?circle-token=df1534d919e12b3cc1bb8da2840c709c49681464

# curl https://circleci.com/api/v1/me?circle-token=df1534d919e12b3cc1bb8da2840c709c49681464

# curl https://circleci.com/api/v1/project/yourorg/yourproject/checkout-key?circle-token=df1534d919e12b3cc1bb8da2840c709c49681464

}

function CodeMaintenanceHelperFile() {

  CLEAN="nothing to commit";
  UP2DT="Everything up-to-date";
  pushd ~/${PARENT_DIR}/${PROJECT_NAME} >/dev/null;
    pushd ./packages >/dev/null;
      pushd ./${PKG_NAME} >/dev/null;
        pushd ./tools >/dev/null;

          wget https://raw.githubusercontent.com/martinhbramwell/Meteor-CI-Tutorial/master/fragments/perform_ci_tasks.sh
          sed -i -e "s/\${YOUR_FULLNAME}/${YOUR_FULLNAME}/" perform_ci_tasks.sh;
          sed -i -e "s/\${YOUR_EMAIL}/${YOUR_EMAIL}/" perform_ci_tasks.sh;
          chmod a+x perform_ci_tasks.sh;

        popd >/dev/null;
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

      wget https://raw.githubusercontent.com/martinhbramwell/Meteor-CI-Tutorial/master/fragments/perform_per_package_ci_tasks.sh
      chmod a+x perform_per_package_ci_tasks.sh;

    popd >/dev/null;

    git add ./packages/perform_per_package_ci_tasks.sh;

    wget -O circle.yml https://raw.githubusercontent.com/martinhbramwell/Meteor-CI-Tutorial/master/fragments/circle_T09.yml
    git add circle.yml;

    STS="$(git status)";
    if [ "${STS/${CLEAN}}" = "${STS}" ]; then
      git commit -am "Added code maintenance tasks and augmented circle.yml";
    fi;
    PSH=$(git push);
    if [ "${PSH/${UP2DT}}" != "${PSH}" ]; then
          echo "Pushed ${PROJECT_NAME}";
    fi;
  popd >/dev/null;


                                exit;



}


# function () {
# }

