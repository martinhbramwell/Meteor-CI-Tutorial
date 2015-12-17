#!/bin/bash
#

#  This is a helper script for continuous integration
#  It uses the Android SDK elements to build a Android APK for our Meteor project
#
function BuildAndroidAPK() {

  echo "Building Android APK . . .";

  export BUILD_DIRECTORY="$(pwd)";
  export TARGET_DIRECTORY="/tmp/build";

  mkdir -p ${TARGET_DIRECTORY};
  mkdir -p public;

  export TARGET_SERVER_URL="${CIRCLE_PROJECT_REPONAME}-${CIRCLE_PROJECT_USERNAME}.meteor.com";
  export ZIPALIGN_PATH="${ANDROID_HOME}/build-tools/23.0.1";
  export ALIGNMENT=4

  echo "Building project : ${BUILD_DIRECTORY} in ${TARGET_DIRECTORY} for server ${TARGET_SERVER_URL}";
  ${METEOR_CMD} add-platform android;
  ${METEOR_CMD} build ${TARGET_DIRECTORY}         --server=${TARGET_SERVER_URL};
  echo "Stashing plain version.";
  mv ${TARGET_DIRECTORY}/android/release-unsigned.apk ${TARGET_DIRECTORY}/android/${CIRCLE_PROJECT_REPONAME}_unaligned.apk
  echo "Building debug version.";
  ${METEOR_CMD} build ${TARGET_DIRECTORY} --debug --server=${TARGET_SERVER_URL}
  echo "Built.";

  echo "Creating Android app download link.";
  echo "<body><a target='_blank' href='./${CIRCLE_PROJECT_REPONAME}.apk'>Get the Android app.</a></body>" > ./getAPK.html

  pushd ${TARGET_DIRECTORY}/android >/dev/null;
    jarsigner -storepass ${KEYSTORE_PWD} -tsa http://timestamp.digicert.com -digestalg SHA1 ${CIRCLE_PROJECT_REPONAME}_unaligned.apk ${CIRCLE_PROJECT_REPONAME};
    ${ZIPALIGN_PATH}/zipalign -f ${ALIGNMENT} ${CIRCLE_PROJECT_REPONAME}_unaligned.apk ${CIRCLE_PROJECT_REPONAME}.apk;
    echo -e "Aligned";
    ls -l;
    mv ${CIRCLE_PROJECT_REPONAME}.apk ${BUILD_DIRECTORY}/public;
  popd  >/dev/null;

  ls -l ./public;

  echo ". . . built Android APK!";

}
