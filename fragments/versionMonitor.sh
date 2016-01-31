#!/bin/bash
#
function GetLatestRelease() {

  curl -s https://api.github.com/repos/${1}/${2}/releases/latest > ${3};
  REDO=true;
  II=20;
  while [[ ${REDO} && $(cat ${3} | grep message | grep -c "Not Found") -gt 0 ]]; do
    echo "No Release  " ${II};
    (( II = II - 1 ));
    REDO=$(( II < 20 ));
    sleep 15;
    curl -s https://api.github.com/repos/${1}/${2}/releases/latest > ${3};
  done

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

  sed -i "s|const injected_tag_sha = '';|const injected_tag_sha = '${TAG_SHA:0:7}';|g" versionMonitor.js
  sed -i "s|const injected_build_num = '';|const injected_build_num = '${CIRCLE_BUILD_NUM}';|g" versionMonitor.js
  sed -i "s|const injected_commit_url = '';|const injected_commit_url = '${COMMIT_URL}';|g" versionMonitor.js
  sed -i "s|const injected_release_tag = '';|const injected_release_tag = '${LATEST_RELEASE}';|g" versionMonitor.js
  sed -i "s|const injected_release_url = '';|const injected_release_url = '${RELEASE_URL}';|g" versionMonitor.js

}
