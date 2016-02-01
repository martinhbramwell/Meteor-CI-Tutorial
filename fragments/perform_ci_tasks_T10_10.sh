
function checkCodeStyle() {

  echo -e "Checking code style";
  if [[ ">${CIRCLE_ARTIFACTS}<" == "><" ]]; then CIRCLE_ARTIFACTS="."; fi;
  script -qc "eslint ." ${CIRCLE_ARTIFACTS}/esLintReport.txt  > /dev/null;
  echo -e "#################################################################
  Generated esLint report :";
  cat ${CIRCLE_ARTIFACTS}/esLintReport.txt;
  echo -e "#################################################################\n";

}


function generateDocs() {

  echo -e "Regenerating documentation . . .";
  jsdoc -d ./docs .;
  echo -e " . . . documentation regenerated.";

}

declare TEMP_DIR="${HOME}/tmp";
declare DOCS_ZIP="${TEMP_DIR}/pkg_docs.zip";
function commitDocsToGitHubPages() {

  set -e;

  echo -e "Publishing to GitHub Pages.";
  mkdir -p ${TEMP_DIR};

  echo -e "Current directory.";
  pwd;

  pushd docs >/dev/null;
    echo -e "Zipping up the documentation directory.\n"
    rm -f ${DOCS_ZIP}
    zip -qr ${DOCS_ZIP} *
  popd >/dev/null;

  eval "$(ssh-agent -s)";

  git config --global user.email "dude.awap@gmail.com";
  git config --global user.name "Dude Awap";
  git config --global push.default simple

  echo " | master | ";
  git branch;

  git checkout gh-pages;

  echo " | check which branch | ";
  git branch;
  # echo "C | ";

  echo " | find and delete | ";
  find . -not -path "./.git*" -not -path "./tools*" -delete;

  echo " | unzip | ";
  unzip ${DOCS_ZIP};

  echo " | git add | ";
  git add -A;

  echo " | git commit | ";
  git commit -am "Automated update of GitHub Pages documentation.";

  echo " | git push | ";
  git push;
  STT=$?;
  echo "Push status :: ${STT}";
  if [[ ${STT} -gt 0 ]]; then exit 1; fi;

  echo " | checkout master | ";
  git checkout master;

  echo " | check which branch | ";
  git branch;

}

# function PatchVersionMonitorHelper() {

#   PKG_UUID=$(cat package.js | grep name | cut -f 2 -d "'");
#   OWNER_PKG=$(echo ${PKG_UUID} | cut -f 1 -d ":");
#   echo "Package owner : ${OWNER_PKG}";
#   NAME_PKG=$(echo ${PKG_UUID} | cut -f 2 -d ":");
#   echo "Package name : ${NAME_PKG}";

#   curl -s https://api.github.com/repos/${OWNER_PKG}/${NAME_PKG}/releases/latest > scrap.json;
#   sleep 2;

#   LATEST_RELEASE=$(cat scrap.json | jq -r '.tag_name');
#   RELEASE_URL=$(cat scrap.json | jq -r '.html_url');
#   echo "LATEST RELEASE : ${LATEST_RELEASE} Location : ${RELEASE_URL}";

#   export TAG_SHA=$(git show-ref --tags | grep ${LATEST_RELEASE} | cut -f 1 -d " ");
#   echo "TAG_SHA : " ${TAG_SHA};

#   export COMMIT_URL=$(curl -s https://api.github.com/repos/${OWNER_PKG}/${NAME_PKG}/commits/${TAG_SHA} | jq -r '.html_url');
#   echo "COMMIT_URL : " ${COMMIT_URL} ;

#   sed -i "s|const injectedTagSha = '';|const injectedTagSha = '${TAG_SHA:0:7}';|g" versionMonitor.js
#   sed -i "s|const injectedBuildNum = '';|const injectedBuildNum = '${CIRCLE_SHA1}';|g" versionMonitor.js
#   sed -i "s|const injectedCommitUrl = '';|const injectedCommitUrl = '${COMMIT_URL}';|g" versionMonitor.js
#   sed -i "s|const injectedReleaseTag = '';|const injectedReleaseTag = '${LATEST_RELEASE}';|g" versionMonitor.js
#   sed -i "s|const injectedReleaseUrl = '';|const injectedReleaseUrl = '${RELEASE_URL}';|g" versionMonitor.js

# }


checkCodeStyle;

generateDocs;

commitDocsToGitHubPages;

source ./tools/versionMonitor.sh;
PatchVersionMonitorHelper;
