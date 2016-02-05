#!/bin/bash
#

#  This is a helper script for continuous deployment
#  It uses the Android SDK elements to build a Android APK for our Meteor project
#
function DeployToMeteorServer() {

  echo "./tools/meteor/meteorAutoLogin.exp ${HOME}/.meteor/meteor ${METEOR_UID} ${METEOR_PWD}";
  ls -l ./tools/meteor/meteorAutoLogin.exp;
  ./tools/meteor/meteorAutoLogin.exp ${HOME}/.meteor/meteor ${METEOR_UID} ${METEOR_PWD};
  echo "meteor deploy ${TARGET_SERVER_URL}";
  ls -l ./public
  ${METEOR_CMD} deploy ${TARGET_SERVER_URL};

}
