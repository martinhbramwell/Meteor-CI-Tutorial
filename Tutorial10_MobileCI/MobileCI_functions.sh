#!/bin/bash

ANDROID_SDK="android-sdk-linux";
ANDROID_PLACE="/home/yourself/opt2";
ANDROID_HOME=${ANDROID_PLACE}/${ANDROID_SDK};
ENV_FILE="/etc/environment";
TMP_PLUGIN_LIST="/tmp/plugins.txt";

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

function prepareAndroidSDK() {

  echo "     ~     ~     ~     ~     ~     ~     ~     ~     ~";
  
  mkdir -p ${ANDROID_HOME};
  pushd ${ANDROID_PLACE} >/dev/null;

  mkdir -p Downloads;
  pushd Downloads >/dev/null;
  echo -e "Download Android SDK Tools to $(pwd).";
  wget -nc http://dl-ssl.google.com/android/repository/tools_r23.0.5-linux.zip
  popd >/dev/null;

  mkdir -p ${ANDROID_SDK};
  pushd ${ANDROID_SDK} >/dev/null;
  if [[ -x ./tools/android ]]; then
    echo -e "Android SDK Tools have already been extracted to '$(pwd)'. ";
  else
    echo -e "Extract Android SDK Tools to $(pwd).";
    unzip ../Downloads/tools_r23.0.5-linux.zip;
  fi;

  echo -e "Cleaning all development toolkit plugins from '$(pwd)'.";
  rm -fr ./platforms/
  rm -fr ./platform-tools/
  rm -fr ./extras/
  rm -fr ./build-tools/
  rm -fr ./temp/

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
  
  getPluginNumber "Android SDK Platform-tools, revision 23.1 rc1";  # 2
  echo "Y" | ${ANDROID_HOME}/tools/android update sdk -u -a --filter ${PLUGIN_NUM};
  echo -e "Called for Plugin #${PLUGIN_NUM} - ${PLUGIN_NAME}.";

  getPluginNumber "Android SDK Build-tools, revision 23.0.1";  #  4
  echo "Y" | ${ANDROID_HOME}/tools/android update sdk -u -a --filter ${PLUGIN_NUM};
  echo -e "Called for Plugin #${PLUGIN_NUM} - ${PLUGIN_NAME}.";

  getPluginNumber "SDK Platform Android 5.1.1, API 22, revision 2";  #  26
  echo "Y" | ${ANDROID_HOME}/tools/android update sdk -u -a --filter ${PLUGIN_NUM};
  echo -e "Called for Plugin #${PLUGIN_NUM} - ${PLUGIN_NAME}.";

  getPluginNumber "Intel x86 Atom_64 System Image, Android API 22, revision 2";  #  76
  echo "Y" | ${ANDROID_HOME}/tools/android update sdk -u -a --filter ${PLUGIN_NUM};
  echo -e "Called for Plugin #${PLUGIN_NUM} - ${PLUGIN_NAME}.";
  
}



function BuildAndroidAPK() {

export PROJ="prj08";
export PARENT_DIR="${HOME}/project_aisle";
export BUILD_DIRECTORY="${PARENT_DIR}/${PROJ}";


export TARGET_SERVER=prj08-0ur0rg.meteor.com;
export ZIPALIGN_PATH=~/opt2/android-sdk-linux/build-tools/23.0.1

export KEYSTORE_PATH=~/.keystore;
export KEYSTORE_PWD="34erDFCV-*-*";

export ALIGNMENT=4

export TMP_DIRECTORY=${HOME}/tmp;

export TARGET_SERVER_URL="https://${TARGET_SERVER}/"

export TARGET_DIRECTORY=${TMP_DIRECTORY}/${PROJ}
mkdir -p ${TARGET_DIRECTORY}

echo "### Configuration for your '"${PROJ}"' project is :"
echo "   ~                                      Target Server is  : " ${TARGET_SERVER_URL}
echo "   ~ Align android-sdk bundle on "$ALIGNMENT"-byte boundary when using : " $ZIPALIGN_PATH
echo "   ~                              Temporary build directory : " ${TMP_DIRECTORY}
echo "### ~   ~   ~    "


KTEXISTS=$(keytool -list -v  -storepass ${KEYSTORE_PWD} | grep "Alias name" | grep -c "${PROJ}"); # -alias  ;
if [[ ${KTEXISTS} -lt 1 ]]; then
  keytool -genkeypair -dname "cn=Martin Bramwell, ou=IT, o=Warehouseman, c=CA" \
-alias ${PROJ} -keypass ${KEYSTORE_PWD} -storepass ${KEYSTORE_PWD} -validity 3650;
  echo "Created key pair '${PROJ}'.";
fi;

rm -fr ${TARGET_DIRECTORY};
mkdir -p ${TARGET_DIRECTORY};

pushd ${BUILD_DIRECTORY} >/dev/null;
  
  mkdir -p public;
  rm public/${PROJ}.apk;
  touch public/${PROJ}.apk;
  
  echo "Building project : ${BUILD_DIRECTORY} in ${TARGET_DIRECTORY} for server ${TARGET_SERVER_URL}";
  meteor build ${TARGET_DIRECTORY}         --server=${TARGET_SERVER_URL};
  echo "Stashing plain version.";
  mv ${TARGET_DIRECTORY}/android/release-unsigned.apk ${TARGET_DIRECTORY}/android/${PROJ}_unaligned.apk
  echo "Building debug version.";
  meteor build ${TARGET_DIRECTORY} --debug --server=${TARGET_SERVER_URL}
  echo "Built.";
  
popd >/dev/null;

pushd ${TARGET_DIRECTORY}/android >/dev/null;
  jarsigner -storepass ${KEYSTORE_PWD} -tsa http://timestamp.digicert.com -digestalg SHA1 ${PROJ}_unaligned.apk ${PROJ};
  ${ZIPALIGN_PATH}/zipalign -f ${ALIGNMENT} ${PROJ}_unaligned.apk ${PROJ}.apk;
  echo -e "Aligned";
  ls -l;
  mv ${PROJ}.apk ${BUILD_DIRECTORY}/public;
popd  >/dev/null;
#
exit;


}



prepareAndroidSDK;
BuildAndroidAPK

