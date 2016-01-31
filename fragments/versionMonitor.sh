#!/bin/bash
#
function CheckGitHub() {

  curl -s https://api.github.com/repos/${1}/${2}/releases/latest > ${3};
  return $(cat ${3} | grep message | grep -c "Not Found");

}


function GetLatestRelease() {

  LIM=10;
  IDX=${LIM};
  DLY=30;
  MSG="\n\n    Checking for at least one formal release of ${1}:${2}.\n
    Please go to the location 'https://github.com/${1}/${2}/releases' and release a version of the package.\n
              ";

  CheckGitHub "$1" "$2" "$3"; FOUND_ONE=$?;

  while [[ (${IDX} -gt 0) && (${FOUND_ONE} -gt 0) ]]; do
    if [[ ${IDX} -eq ${LIM} ]]; then echo -e ${MSG}; fi;
    printf "Try #%s. (%s sec. remaining).\n\033[1A" $(( LIM - IDX + 1 )) $(( DLY * IDX ));
    (( IDX = IDX - 1 ));
    sleep ${DLY};
    CheckGitHub "$1" "$2" "$3"; FOUND_ONE=$?;
  done

  if [[ ${TEST} -gt 0 ]]; then
    echo -e "Gave up trying to get release information.\n ";
  else
    echo -e "Release information may be found in the file '${3}'.\n ";
  fi;

}

function GetLatestReleaseTag() {

  PKG_UUID=$(cat package.js | grep name | cut -f 2 -d "'");
  OWNER_PKG=$(echo ${PKG_UUID} | cut -f 1 -d ":");
  echo "Package owner : ${OWNER_PKG}";
  NAME_PKG=$(echo ${PKG_UUID} | cut -f 2 -d ":");
  echo "Package name : ${NAME_PKG}";

  SCRATCH="scrap.json";
  GetLatestRelease ${OWNER_PKG} ${NAME_PKG} ${SCRATCH};
  LATEST_RELEASE=$(cat ${SCRATCH} | jq -r '.tag_name');
  RELEASE_URL=$(cat ${SCRATCH} | jq -r '.html_url');
  echo "LATEST RELEASE : ${LATEST_RELEASE} Location : ${RELEASE_URL}";

  # ensure ssh-agent is awake
  eval "$(ssh-agent -s)";
  # ensure release is known to local repo
  git pull;

  export TAG_SHA=$(git show-ref --tags | grep ${LATEST_RELEASE} | cut -f 1 -d " ");
  echo "TAG_SHA : " ${TAG_SHA};

  export COMMIT_URL=$(curl -s https://api.github.com/repos/${OWNER_PKG}/${NAME_PKG}/commits/${TAG_SHA} | jq -r '.html_url');
  echo "COMMIT_URL : " ${COMMIT_URL} ;

  sed -i "s|const injectedTagSha = '';|const injectedTagSha = '${TAG_SHA:0:7}';|g" versionMonitor.js
  sed -i "s|const injectedBuildNum = '';|const injectedBuildNum = '${CIRCLE_BUILD_NUM}';|g" versionMonitor.js
  sed -i "s|const injectedCommitUrl = '';|const injectedCommitUrl = '${COMMIT_URL}';|g" versionMonitor.js
  sed -i "s|const injectedReleaseTag = '';|const injectedReleaseTag = '${LATEST_RELEASE}';|g" versionMonitor.js
  sed -i "s|const injectedReleaseUrl = '';|const injectedReleaseUrl = '${RELEASE_URL}';|g" versionMonitor.js

}
