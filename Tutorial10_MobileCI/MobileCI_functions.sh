#!/bin/bash

function prepareAndroidSDK() {

  echo "     ~     ~     ~     ~     ~     ~     ~     ~     ~";

  ANDROID_SDK="android-sdk-linux";
  ENV_FILE="/etc/environment";
  pushd /home/hasan/opt2 >/dev/null;

  mkdir -p Downloads;
  pushd Downloads >/dev/null;
  wget -nc http://dl-ssl.google.com/android/repository/tools_r22.6.4-linux.zip
  popd >/dev/null;

  mkdir -p ${ANDROID_SDK};
  pushd ${ANDROID_SDK} >/dev/null;
  if [[ -x ./tools/android ]]; then
    echo -e "Android SDK is here already. ";
  else
    unzip ../Downloads/tools_r23.0.5-linux.zip;
  fi;

  rm -fr ./platforms/
  rm -fr ./platform-tools/
  rm -fr ./extras/
  rm -fr ./build-tools/
  rm -fr ./temp/

  chmod ug+rw -R .;

  popd >/dev/null;

  popd >/dev/null;

  if [[ $(grep -c "export ANDROID_HOME=/home/hasan/opt2/${ANDROID_SDK}"  ${ENV_FILE}) -lt 1 ]];
  then
    while [[ $(grep -c ANDROID_HOME ${ENV_FILE}) -gt 0 ]]; do
      sudo sed -i "/ANDROID_HOME/d" ${ENV_FILE};
    done;
    echo -e "\nexport ANDROID_HOME=/home/hasan/opt2/${ANDROID_SDK};\n" | sudo tee -a ${ENV_FILE};
  fi;

  source ${ENV_FILE};

  echo "Y" | ${ANDROID_HOME}/tools/android update sdk -u -a --filter 2;
  echo "Y" | ${ANDROID_HOME}/tools/android update sdk -u -a --filter 3;
  echo "Y" | ${ANDROID_HOME}/tools/android update sdk -u -a --filter 4;
  echo "Y" | ${ANDROID_HOME}/tools/android update sdk -u -a --filter 27;
  echo "Y" | ${ANDROID_HOME}/tools/android update sdk -u -a --filter 76;
  
}




function InstallAndroidStudioSDK() {

  PROGRAMS="${HOME}/programs";
  INSTALLERS="${HOME}/installers";
  ANDROID_SDK="android-studio";
  ANDROID_SDK_BIN="${PROGRAMS}/${ANDROID_SDK}/bin";


  echo -e "Obtaining Android Studio SDK . . .";
  mkdir -p ${PROGRAMS};
  pushd ${PROGRAMS};

#   wget -nc -P ${INSTALLERS} https://dl.google.com/dl/android/studio/ide-zips/2.0.0.1/android-studio-ide-143.2461418-linux.zip;
    wget -nc -P ${INSTALLERS} https://dl.google.com/dl/android/studio/ide-zips/1.5.1.0/android-studio-ide-141.2456560-linux.zip;
    if [ ! -d "${ANDROID_SDK_BIN}" ]; then
      ls -l ${INSTALLERS}/${ANDROID_SDK}*.zip;
      unzip ${INSTALLERS}/${ANDROID_SDK}*.zip;
    fi;

  popd;

  while [[ $(grep -c "${ANDROID_SDK_BIN}" ~/.profile) -gt 0 ]]; do
    sed -i "/${ANDROID_SDK}/d" ~/.profile;
  done;
  echo -e "\nexport PATH=\${PATH}:${ANDROID_SDK_BIN};" >> ~/.profile;

  while [[ $(grep -c ANDROID_HOME ~/.profile) -gt 0 ]]; do
    sed -i "/ANDROID_HOME/d" ~/.profile;
  done;
  echo -e "\nexport ANDROID_HOME=\${HOME}/Android/Sdk;" >> ~/.profile;

  while [[ $(grep -c ANDROID_SDK_ROOT ~/.profile) -gt 0 ]]; do
    sed -i "/ANDROID_SDK_ROOT/d" ~/.profile;
  done;
  echo -e "\nexport ANDROID_SDK_ROOT=\${ANDROID_HOME};" >> ~/.profile;

  while [[ $(grep -c "platform-tools" ~/.profile) -gt 0 ]]; do
    sed -i "/platform-tools/d" ~/.profile;
  done;
  echo -e "\nexport PATH=\${PATH}:\${ANDROID_HOME}/platform-tools:\${ANDROID_HOME}/tools;" >> ~/.profile;

  source ~/.profile;
    
}


function InstallAndroidStudioSDK() {

export PROJ="prj08";


export TARGET_SERVER=http://0ur0rg-prj08.meteor.com/
export ZIPALIGN_PATH=~/android-sdk-linux/build-tools/23.0.1

export KEYSTORE_PATH=~/.keystore
export KEYSTORE_PWD="34erDFCV-*-*";

export ALIGNMENT=4

export BUILD_DIRECTORY=../tmp

export TARGET_SERVER_URL="https://${TARGET_SERVER}/"

export TARGET_DIRECTORY=${BUILD_DIRECTORY}/${PROJ}
mkdir -p ${TARGET_DIRECTORY}
#
echo "### Configuration for your '"${PROJ}"' project is :"
echo "   ~                                      Target Server is  : " ${TARGET_SERVER_URL}
echo "   ~ Align android-sdk bundle on "$ALIGNMENT"-byte boundary when using : " $ZIPALIGN_PATH
echo "   ~                              Temporary build directory : " ${BUILD_DIRECTORY}
echo "### ~   ~   ~    "

  wget http://dl.google.com/android/android-sdk_r24.4.1-linux.tgz
  echo "Y" | ${ANDROID_SDK_ROOT}/tools/android update sdk -u -a --filter platform-tools,6,android-22,extra-android-support;

keytool -genkeypair -dname "cn=Martin Bramwell, ou=IT, o=Warehouseman, c=CA" \
-alias ${PROJ} -keypass ${KEYSTORE_PWD} -storepass ${KEYSTORE_PWD} -validity 3650;

pushd ${TARGET_DIRECTORY} >/dev/null;
jarsigner -storepass ${KEYSTORE_PWD} -tsa http://timestamp.digicert.com -digestalg SHA1 ${PROJ}_unaligned.apk ${PROJ};
popd  >/dev/null;


${ZIPALIGN_PATH}/zipalign -f ${ALIGNMENT} ${PROJ}_unaligned.apk ${PROJ}_aligned.apk

mv ${PROJ}_aligned.apk ..
mv ${PROJ}_unaligned.apk ../${PROJ}.apk



}



# function CheckAndroidDevReqConformance() {

#   echo -e "\nChecking GUI type is KDE or gnome . . .";
#   GUI=$(ps -A | grep -v "kdev" | egrep "gnome|kde");
#   set +e;
#   KDE=$(echo "${GUI}" | egrep -c "kde");
#   GNOME=$(echo "${GUI}" | egrep -c "gnome");
#   GUICNT=$(echo "${GUI}" | egrep -c "gnome|kde");
#   set -e;
#   if [[ ${GUICNT} -lt 1 ]]; then
#     echo " 

#           * * * WARNING * * * 

#     You don't seem to be running KDE or GNOME as needed for Android Studio.
#     See the 'Android Studio' System Requirements :
#        http://developer.android.com/sdk/index.html#Requirements
#     ";
#   else

#     if [[ ${GNOME} -gt 1 ]]; then echo "It's GNOME."; fi;
#     if [[ ${KDE} -gt 1 ]]; then echo "It's KDE. "; fi;

#   fi;

#   echo -e "\nChecking screen resolution > 1280 . . .";
#   XDIMS=$(xdpyinfo  | grep dimensions | sed "s/^\s*.*:\s*//" | sed "s/\s.*//");
#   XWIDTH=$(echo ${XDIMS} | sed "s/x.*//");
#   if [[ ${XWIDTH} -lt 1280 ]]; then 
#     echo " 

#           * * * WARNING * * * 

#     You don't seem to have enough screen resolution '${XDIMS}'' for Android Studio.
#     See the 'Android Studio' System Requirements :
#        http://developer.android.com/sdk/index.html#Requirements
#     ";
#   else
#     echo "It's ${XDIMS}";
#   fi;

#   echo -e "\nChecking gclib version > 2.15 . . .";
#   GCLIBVER=$(ldd --version | egrep ldd);
#   GCLIBVER=${GCLIBVER##*\) };
#   #   (Ubuntu EGLIBC 2.19-0ubuntu6.6) 2.19
#   if [[ "${GCLIBVER}" < "2.15" ]]; then 
#     echo " 

#           * * * WARNING * * * 

#     It seems you are using an old (${GCLIBVER}) version of gclib 
#     See the 'Android Studio' System Requirements :
#        http://developer.android.com/sdk/index.html#Requirements
#     ";
#   else
#     echo "It's ${GCLIBVER}";
#   fi;

# }
