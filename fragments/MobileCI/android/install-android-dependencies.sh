#!/bin/bash
#

#  This is a helper script for continuous integration
#  It pulls together just the Android SDK elementsd required by Meteor
#
function getPlugin() {

  if [[ -f "$2" ]]; then
    echo -e "Seem to have Plugin '$1' already.";
  else
    echo "Y" | ${ANDROID_HOME}/tools/android update sdk -u -a --filter $1;
    echo -e "Called for plugin '$1'.";
  fi;

}

function PrepareAndroidSDK() {

  echo "Preparing Android APK . . .";

  export PATH="$ANDROID_HOME/platform-tools:$ANDROID_HOME/tools:$PATH";

  getPlugin "platform-tools" "${ANDROID_HOME}/platform-tools/adb";
  getPlugin "build-tools" "${ANDROID_HOME}/build-tools/23.0.1/zipalign";
  getPlugin "android-22" "${ANDROID_HOME}/platforms/android-22/android.jar";

  NO_KEY_PAIR=true;
  mkdir -p "${HOME}/.meteor/security";
  if [[ -f "${HOME}/.meteor/security/.keystore" ]]; then
    echo "restoring keystore from cache";
    cp ${HOME}/.meteor/security/.keystore ${HOME};

    KTEXISTS=$(keytool -list -v  -storepass ${KEYSTORE_PWD} \
             | grep "Alias name" \
             | grep -c "${CIRCLE_PROJECT_REPONAME}");
    if [[ ${KTEXISTS} -gt 0 ]]; then
      NO_KEY_PAIR=false;
    fi;
  fi;

  if ${NO_KEY_PAIR}; then
    echo "no cached keystore";

    keytool -genkeypair \
            -dname "cn=${YOUR_FULLNAME}, ou=${CIRCLE_PROJECT_USERNAME}, o=Warehouseman, c=CA" \
            -alias ${CIRCLE_PROJECT_REPONAME} \
            -keypass ${KEYSTORE_PWD} \
            -storepass ${KEYSTORE_PWD} \
            -validity 3650;

    echo "Created key pair for '${CIRCLE_PROJECT_REPONAME}'.";

    echo "copying keystore to cache";
    cp ${HOME}/.keystore ${HOME}/.meteor/security;

  fi;

  echo " . . . prepared Android APK";

}

