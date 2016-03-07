#!/bin/bash
#
MYAUTH="Authorization: token 777dc0a67e5................f3d283d38dec4d"; #  Ci4Meteor
GITHUB="https://api.github.com/repos/0ur0rg";
#
OLD_PROJECTS=();
# NUM=00;
# PRJ="prj${NUM}"; PKG="pkg${NUM}";
# curl -X DELETE -H "${MYAUTH}" ${GITHUB}/${PRJ}  &&  curl -X DELETE -H "${MYAUTH}" ${GITHUB}/${PKG}
# meteor deploy -D 0ur0rg-${PRJ}.meteor.com
for NUM in "${OLD_PROJECTS[@]}"
do
  PRJ="prj${NUM}"; PKG="pkg${NUM}";
  echo "Deleting  ::  ${PRJ} & ${PKG}";
  curl -X DELETE -H "${MYAUTH}" ${GITHUB}/${PRJ}  &&  curl -X DELETE -H "${MYAUTH}" ${GITHUB}/${PKG}
  meteor deploy -D ${PRJ}-0ur0rg.meteor.com
done

NUM=16;
#
PRJ="prj${NUM}";
PKG="pkg${NUM}";
PARENT="project_isle";

echo -e " deleting from GitHub";
curl -X DELETE -H "${MYAUTH}" ${GITHUB}/${PRJ}  &&  curl -X DELETE -H "${MYAUTH}" ${GITHUB}/${PKG};

if [[ -d ~/${PARENT}/${PRJ}/.meteor ]]; then

  echo -e " deleting from meteor.com";
  meteor deploy -D ${PRJ}-0ur0rg.meteor.com;

  echo -e " deleting projects and packages";
  rm -fr ~/${PARENT};

fi;

echo -e " deleting local SSH artifacts"
rm -fr ~/.ssh/config
rm -fr ~/.ssh/github-0ur0rg-${PRJ}*
rm -fr ~/.ssh/github-0ur0rg-${PKG}*
rm -fr ~/tmp;

echo -e " deleting Android artifacts"
WIPEALL=true; # true or false
if ${WIPEALL}; then
  rm -fr ~/installers;
  rm -fr ~/.cache;
  rm -fr ~/.meteor;
  rm -fr ~/.meteor-install-tmp;
  rm -fr ~/Android;
  rm -fr ~/.android;
  rm -fr ~/android-sdk-linux;
  rm -fr ~/AndroidStudioProjects;
  rm -fr ~/.AndroidStudioPreview2.0/;
  rm -fr ~/.AndroidStudio1.5/;
  rm -fr ~/.cordova;
  rm -fr ~/.gradle;
fi;
