#!/bin/bash
#
function GetLatestReleaseTag() {

  PKG_UUID=$(cat package.js | grep name | cut -f 2 -d "'");
  OWNER_PKG=$(echo ${PKG_UUID} | cut -f 1 -d ":");
  echo "Package owner : ${OWNER_PKG}";
  NAME_PKG=$(echo ${PKG_UUID} | cut -f 2 -d ":");
  echo "Package name : ${NAME_PKG}";

  curl -s https://api.github.com/repos/${OWNER_PKG}/${NAME_PKG}/releases/latest > scrap.json;
  sleep 2;

  LATEST_RELEASE=$(cat scrap.json | jq -r '.tag_name');
  RELEASE_URL=$(cat scrap.json | jq -r '.html_url');
  echo "LATEST RELEASE : ${LATEST_RELEASE} Location : ${RELEASE_URL}";

  export TAG_SHA=$(git show-ref --tags | grep ${LATEST_RELEASE} | cut -f 1 -d " ");
  echo "TAG_SHA : " ${TAG_SHA};

  export COMMIT_URL=$(curl -s https://api.github.com/repos/${OWNER_PKG}/${NAME_PKG}/commits/${TAG_SHA} | jq -r '.html_url');
  echo "COMMIT_URL : " ${COMMIT_URL} ;

  sed -i "s|const injected_tag_sha = '';|const injected_tag_sha = '${TAG_SHA:0:7}';|g" versionMonitor.js
  sed -i "s|const injected_build_num = '';|const injected_build_num = '${CIRCLE_SHA1}';|g" versionMonitor.js
  sed -i "s|const injected_commit_url = '';|const injected_commit_url = '${COMMIT_URL}';|g" versionMonitor.js
  sed -i "s|const injected_release_tag = '';|const injected_release_tag = '${LATEST_RELEASE}';|g" versionMonitor.js
  sed -i "s|const injected_release_url = '';|const injected_release_url = '${RELEASE_URL}';|g" versionMonitor.js

}
