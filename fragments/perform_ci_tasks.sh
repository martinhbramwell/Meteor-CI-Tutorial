
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

  git config --global user.email "${YOUR_EMAIL}";
  git config --global user.name "${YOUR_FULLNAME}";
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

checkCodeStyle;

generateDocs;

# commitDocsToGitHubPages;
