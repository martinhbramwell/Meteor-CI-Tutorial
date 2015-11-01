
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

function CodeLintingHelperFile() {

  pushd ~/${PARENT_DIR}/${PROJECT_NAME}/packages >/dev/null;

    wget https://raw.githubusercontent.com/martinhbramwell/Meteor-CI-Tutorial/master/fragments/perform_per_package_ci_tasks.sh

  popd >/dev/null;

}


# function () {
# }

