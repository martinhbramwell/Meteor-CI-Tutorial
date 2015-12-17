#!/bin/bash

export TMP_PLUGIN_LIST="/tmp/plugins.txt";
export PLUGIN_NAME="";
export PLUGIN_NUM="";

function getPluginNumber() {

  if [[ ! -f ${TMP_PLUGIN_LIST} ]]; then
    echo "Building '${TMP_PLUGIN_LIST}'.";
    ${ANDROID_HOME}/tools/android list sdk -u -a > ${TMP_PLUGIN_LIST};
  fi;

  PLUGIN_NAME=$1; # "Android SDK Platform-tools, revision 23.0.1";
  PLGN_REC=$(cat ${TMP_PLUGIN_LIST} | grep "${PLUGIN_NAME}");
  PLGN_REC_L=$(echo "${PLGN_REC%%- ${PLUGIN_NAME}}");
  PLUGIN_NUM=$(echo "${PLGN_REC_L}"  | tr -d '[[:space:]]');

}

function getPlugin() {

  getPluginNumber "$1";
  if [[ -f "$2" ]]; then
    echo -e "Seem to have Plugin '#${PLUGIN_NUM} - ${PLUGIN_NAME}' already.";
  else
    echo "Y" | ${ANDROID_HOME}/tools/android update sdk -u -a --filter ${PLUGIN_NUM};
    echo -e "Called for Plugin #${PLUGIN_NUM} - ${PLUGIN_NAME}.";
  fi;

}


function PrepareAndroidSDK() {

  echo "     ~     ~     ~     ~     ~     ~     ~     ~     ~  ";

  mkdir -p ${ANDROID_HOME};
  pushd ${ANDROID_PLACE} >/dev/null;

    mkdir -p ~/Downloads;
    pushd ~/Downloads >/dev/null;
      echo -e "Download Android SDK Tools to $(pwd).";
      wget -nc http://dl-ssl.google.com/android/repository/tools_r23.0.5-linux.zip
    popd >/dev/null;

    mkdir -p ${ANDROID_SDK};
    pushd ${ANDROID_SDK} >/dev/null;
      if [[ -x ./tools/android ]]; then
        echo -e "Android SDK Tools have already been extracted to '$(pwd)'. ";
      else
        echo -e "Extract Android SDK Tools to $(pwd).";
        unzip ~/Downloads/tools_r23.0.5-linux.zip;
      fi;

      # echo -e "Cleaning all development toolkit plugins from '$(pwd)'.";
      # rm -fr ./platforms/
      # rm -fr ./platform-tools/
      # rm -fr ./extras/
      # rm -fr ./build-tools/
      # rm -fr ./temp/
      # rm -fr ./system-images/

      chmod ug+rw -R .;

    popd >/dev/null;

  popd >/dev/null;

  echo -e "Correcting ANDROID_HOME in '${ENV_FILE}' variables.";
  if [[ $(grep -c "export ANDROID_HOME=${ANDROID_HOME}"  ${ENV_FILE}) -lt 1 ]];
  then
    while [[ $(grep -c ANDROID_HOME ${ENV_FILE}) -gt 0 ]]; do
      sudo sed -i "/ANDROID_HOME/d" ${ENV_FILE};
    done;
    echo -e "\nexport ANDROID_HOME=${ANDROID_HOME};\n" | sudo tee -a ${ENV_FILE};
  fi;

  while [[ $(grep -c "platform-tools" ${ENV_FILE}) -gt 0 ]]; do
  sed -i "/platform-tools/d" ${ENV_FILE};
  done;
  echo -e "\nexport PATH=\$PATH:\$ANDROID_HOME/platform-tools:\$ANDROID_HOME/tools;" \
              | sudo tee -a ${ENV_FILE};


  source ${ENV_FILE};

  echo -e "Obtaining SDK plugins.";

  # 3
  getPlugin "Android SDK Platform-tools, revision 23.0.1" ${ANDROID_HOME}/platform-tools/adb;

  # 4
  getPlugin "Android SDK Build-tools, revision 23.0.1" ${ANDROID_HOME}/build-tools/23.0.1/zipalign;

  # 25
  getPlugin "SDK Platform Android 6.0, API 23, revision 1" ${ANDROID_HOME}/platforms/android-23/android.jar;

  # 26
  getPlugin "SDK Platform Android 5.1.1, API 22, revision 2" ${ANDROID_HOME}/platforms/android-22/android.jar;

  # 76
#  getPlugin "Intel x86 Atom_64 System Image, Android API 22, revision 2" ${ANDROID_HOME}/system-images/android-22/default/x86_64/system.img;

}



function BuildAndroidAPK() {

  echo "### Configuration for your '"${PROJECT_NAME}"' project is :"
  echo "   ~                                      Target Server is  : " ${TARGET_SERVER_URL}
  echo "   ~ Align android-sdk bundle on "$ALIGNMENT"-byte boundary when using : " $ZIPALIGN_PATH
  echo "   ~                              Temporary build directory : " ${TMP_DIRECTORY}
  echo "### ~   ~   ~    "

  set +e;
  KTEXISTS=$(keytool -list -v  -storepass ${KEYSTORE_PWD} | grep "Alias name" | grep -c "${PROJECT_NAME}"); # -alias  ;
  set -e;
  echo ${KTEXISTS};
  if [[ ${KTEXISTS} -lt 1 ]]; then
    keytool -genkeypair -dname "cn=Martin Bramwell, ou=IT, o=Warehouseman, c=CA" \
  -alias ${PROJECT_NAME} -keypass ${KEYSTORE_PWD} -storepass ${KEYSTORE_PWD} -validity 3650;
    echo "Created key pair for '${PROJECT_NAME}'.";
  else
    echo "Have a key pair for '${PROJECT_NAME}'.";
  fi;

  export TARGET_DIRECTORY=${TMP_DIRECTORY}/${PROJECT_NAME}
  rm -fr ${TARGET_DIRECTORY};
  mkdir -p ${TARGET_DIRECTORY};

  pushd ${BUILD_DIRECTORY} >/dev/null;

    mkdir -p public;
    # touch public/${PROJECT_NAME}.apk;
    # rm public/${PROJECT_NAME}.apk;
    # touch public/${PROJECT_NAME}.apk;

    echo "Building project : ${BUILD_DIRECTORY} in ${TARGET_DIRECTORY} for server ${TARGET_SERVER_URL}";
    meteor add-platform android;
    meteor build ${TARGET_DIRECTORY}         --server=${TARGET_SERVER_URL};
    echo "Stashing plain version.";
    mv ${TARGET_DIRECTORY}/android/release-unsigned.apk ${TARGET_DIRECTORY}/android/${PROJECT_NAME}_unaligned.apk
    echo "Building debug version.";
    meteor build ${TARGET_DIRECTORY} --debug --server=${TARGET_SERVER_URL}
    echo "Built.";

    echo "<body><a target='_blank' href='./${PROJECT_NAME}.apk'>Get the Android app.</a></body>" > ./getAPK.html
    echo "Created Android app download link.";

  popd >/dev/null;

  pushd ${TARGET_DIRECTORY}/android >/dev/null;
    jarsigner -storepass ${KEYSTORE_PWD} -tsa http://timestamp.digicert.com -digestalg SHA1 ${PROJECT_NAME}_unaligned.apk ${PROJECT_NAME};
    ${ZIPALIGN_PATH}/zipalign -f ${ALIGNMENT} ${PROJECT_NAME}_unaligned.apk ${PROJECT_NAME}.apk;
    echo -e "Aligned";
    ls -l;
    mv ${PROJECT_NAME}.apk ${BUILD_DIRECTORY}/public;
  popd  >/dev/null;
  #

}



function ConnectToMeteorServers() {

  CAS=0;
  set +e;
  WHOAMI=$(meteor whoami 2>/dev/null);
  CAS=$(( $CAS + $? ));
  if [[ "${METEOR_UID}" != "${WHOAMI}" ]]; then CAS=$(( $CAS + 2 )); fi;
  set -e;

  echo "Meteor server connection :: ";
  case ${CAS} in
      0)
          echo "Already logged in as '${METEOR_UID}'.";
          ;;
      2)
          echo "Logging out from '${WHOAMI}' and logging in as '${METEOR_UID}'.";
          meteor logout;
          ./fragments/meteorAutoLogin.exp ${METEOR_UID} ${METEOR_PWD};
          ;;
      3)
          echo "Logging in as '${METEOR_UID}'.";
          ./fragments/meteorAutoLogin.exp ${METEOR_UID} ${METEOR_PWD};
          ;;
      *)
          echo "This can't be happening!"
  esac;

}


function DeployToMeteorServers() {

  echo -e "Deploying '${PROJECT_NAME}' app to Meteor site '${PROJECT_URI}'";

  pushd ~/${PARENT_DIR}/${PROJECT_NAME} >/dev/null;

    meteor deploy ${PROJECT_URI};
     #>/dev/null;

    echo -e "Deployment details sent.";
    CALL_STATUS=1;
    CNT=10;
    while [ ${CALL_STATUS} -gt 0 ]; do
      set +e;
      CALL_STATUS=$( wget  -q --spider http://${PROJECT_URI}/; echo $?; );
      set -e;
      echo "          Call status ${CALL_STATUS} when connecting to ${PROJECT_URI}.";
      if [ ${CALL_STATUS} -gt 0 ]; then
        sleep 6;
        CNT=$(( CNT - 1 ));
        if [ $CNT -lt 1 ]; then
          echo "Can't connect.";
          exit 1;
        fi;
      fi;
    done;
    echo " ";


  popd >/dev/null;

}


export ANDROID_TOOLS_DIR="./tools/android";
export METEOR_TOOLS_DIR="./tools/meteor";
function PrepareCIwithAndroidSDK() {

  pushd ~/${PARENT_DIR} >/dev/null;
    pushd ${PROJECT_NAME} >/dev/null;

      mkdir -p ${ANDROID_TOOLS_DIR};
      pushd ${ANDROID_TOOLS_DIR} >/dev/null;

        ANDROID_DEP_SCRIPT="install-android-dependencies.sh";
        wget -O ${ANDROID_DEP_SCRIPT} \
                  ${TUTORIAL_FRAGMENTS}/MobileCI/${ANDROID_DEP_SCRIPT};

        chmod a+x ${ANDROID_DEP_SCRIPT}:

      popd >/dev/null;

      DONE_BEFORE=$(cat circle.yml | grep -c "install-android-dependencies.sh");
      if [[  ${DONE_BEFORE} -lt 1 ]]; then
        # Add execution of 'PrepareAndroidSDK' to circle.yml
        sed -i '/ADD_MORE_DEPENDENCY_PREPARATIONS_ABOVE_THIS_LINE/c\
          # Install Android dependencies\
          - source ./tools/android/install-android-dependencies.sh && PrepareAndroidSDK\
          # ADD_MORE_DEPENDENCY_PREPARATIONS_ABOVE_THIS_LINE' circle.yml
      fi;

    popd >/dev/null;
  popd >/dev/null;

  export HEADER_JSON="--header \"Content-Type: application/json\"";
  export VAR_JSON="'{\"name\":\"KEYSTORE_PWD\", \"value\":\"${KEYSTORE_PWD}\"}'";
  eval curl -s -X POST ${HEADER_JSON} -d ${VAR_JSON} https://circleci.com/api/v1/project/${GITHUB_ORGANIZATION_NAME}/${PROJECT_NAME}/envvar?circle-token=${CIRCLECI_PERSONAL_TOKEN};

 }

