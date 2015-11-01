
function Another_NodeJS_moduleB() {

  pushd ~/${PARENT_DIR}/${PROJECT_NAME}/packages/${PKG_NAME} >/dev/null;

  mkdir -p tools/testing
  pushd ./tools/testing >/dev/null;

  wget https://raw.githubusercontent.com/martinhbramwell/Meteor-CI-Tutorial/master/fragments/reloadSwaggerPetStore.sh
  chmod a+x reloadSwaggerPetStore.sh

  popd >/dev/null;
  popd >/dev/null;

}

function Another_NodeJS_moduleC() {

  pushd ~/${PARENT_DIR}/${PROJECT_NAME} >/dev/null;
  pushd ./packages/${PKG_NAME} >/dev/null;

  source ./tools/testing/reloadSwaggerPetStore.sh
  reloadSwaggerPetStore
  wget -O ${PKG_NAME}.js https://raw.githubusercontent.com/martinhbramwell/Meteor-CI-Tutorial/master/fragments/yourpackage.js

  popd >/dev/null;

  killMeteorProcess
  launchMeteorProcess "http://localhost:3000/"
  echo "Contacting Swagger Pet Store . . . "
  sleep 10
  echo "The 'tail' command shows . . . "
  tail -n 9 /var/log/meteor/ci4meteor.log  | bunyan -o short
  echo ". . . the tail end of log file.\n"

  popd >/dev/null;

  killMeteorProcess
  read -p "To continue hit <enter> ::  " -n 1 -r USER_ANSWER

}

function Call_Into_Package_Methods() {

  pushd ~/${PARENT_DIR}/${PROJECT_NAME}/packages/${PKG_NAME} >/dev/null;

  wget -N https://raw.githubusercontent.com/martinhbramwell/Meteor-CI-Tutorial/master/fragments/usage_example.js
  wget -N https://raw.githubusercontent.com/martinhbramwell/Meteor-CI-Tutorial/master/fragments/usage_example.html
  sed -i -e "s/\${PKG_NAME}/${PKG_NAME}/" usage_example.html
  sed -i -e "s/\${GITHUB_ORGANIZATION_NAME}/${GITHUB_ORGANIZATION_NAME}/" usage_example.html
  popd >/dev/null;

}

function View_and_Hide_The_Example() {

  pushd ~/${PARENT_DIR}/${PROJECT_NAME} >/dev/null;

  killMeteorProcess
  launchMeteorProcess "http://localhost:3000/"
  echo -e "\n\n     Open the URL http://localhost:3000/\n"

  read -p "To continue hit <enter> ::  " -n 1 -r USER_ANSWER
  killMeteorProcess

  popd >/dev/null;

}
