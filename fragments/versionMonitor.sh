#!/bin/bash
#
function CheckGitHub() {

  curl -s https://api.github.com/repos/${1}/${2}/releases/latest > ${3};
  OVER_QUOTA=$(cat ${3} | grep -c "API rate limit exceeded");
  if [[ ${OVER_QUOTA} -gt 0 ]]; then echo "\n\n * * * Exceeded GitHub's limit of 60 calls per hour. * * * \n\n"; fi;
  return $(cat ${3} | grep message | grep -c "Not Found");

}


function GetLatestRelease() {

  LIM=10;
  IDX=${LIM};
  DLY=30;
  MSG="\n\n    Checking for at least one formal release of ${1}:${2}.\n
    Please go to the location 'https://github.com/${1}/${2}/releases' and release a version of the package.\n
              ";

  echo -e "Trying\ncurl -s https://api.github.com/repos/${1}/${2}/releases/latest\n";

  set +e; CheckGitHub "$1" "$2" "$3"; FOUND_ONE=$?; set -e;


  while [[ (${IDX} -gt 0) && (${FOUND_ONE} -gt 0) ]]; do
    if [[ ${IDX} -eq ${LIM} ]]; then echo -e ${MSG}; fi;
    printf "Try #%s. (%s sec. remaining).\n\033[1A" $(( LIM - IDX + 1 )) $(( DLY * IDX ));
#    printf "Try #%s. (%s sec. remaining).\n" $(( LIM - IDX + 1 )) $(( DLY * IDX ));
    (( IDX = IDX - 1 ));
    sleep ${DLY};
    set +e; CheckGitHub "$1" "$2" "$3"; FOUND_ONE=$?; set -e;
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

  sed -i "/tag_sha/c\  tag_sha: function () { return '${TAG_SHA:0:7}'; }," versionMonitor.js;
  sed -i "/commit_url/c\  commit_url: function () { return '${COMMIT_URL}'; }," versionMonitor.js;
  sed -i "/release_tag/c\  release_tag: function () { return '${LATEST_RELEASE}'; }," versionMonitor.js;
  sed -i "/release_url/c\  release_url: function () { return '${RELEASE_URL}'; }," versionMonitor.js;

  if [[ ${CIRCLE_BUILD_NUM} != '' ]]; then

    CI_BUILD_URL="https://circleci.com/gh/${CIRCLE_PROJECT_USERNAME}/${CIRCLE_PROJECT_REPONAME}/${CIRCLE_BUILD_NUM}";
    REPO_BUILD_URL="https://github.com/${CIRCLE_PROJECT_USERNAME}/${CIRCLE_PROJECT_REPONAME}/commit/${CIRCLE_SHA1}";

    sed -i "/build_num/c\  build_num: function () { return '${CIRCLE_BUILD_NUM}'; }," versionMonitor.js;
    sed -i "/build_url/c\  build_url: function () { return '${CI_BUILD_URL}'; }," versionMonitor.js;
    sed -i "/build_sha/c\  build_sha: function () { return '${CIRCLE_SHA1:0:7}'; }," versionMonitor.js;
    sed -i "/build_repourl/c\ build_repourl : function () { return '${REPO_BUILD_URL}'; }," versionMonitor.js;

  fi;

}
