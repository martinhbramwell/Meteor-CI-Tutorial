
function checkCodeStyle() {
  echo -e "Checking code style";
  if [[ ">${CIRCLE_ARTIFACTS}<" == "><" ]]; then CIRCLE_ARTIFACTS="."; fi;
  script -qc "eslint ." ${CIRCLE_ARTIFACTS}/esLintReport.txt  > /dev/null;
  echo -e "#################################################################
  Generated esLint report :";
  #cat ${CIRCLE_ARTIFACTS}/esLintReport.txt;
  echo -e "#################################################################\n";


}


function generateDocs() {
  echo -e "Regenerating documentation.";
  jsdoc -d ./docs .;

}

declare TEMP_DIR="${HOME}/tmp";
declare DOCS_ZIP="${TEMP_DIR}/pkg_docs.zip";
function commitDocsToGitHubPages() {

  echo -e "Publishing to GitHub Pages.";
  mkdir -p ${TEMP_DIR};

  pushd docs >/dev/null;
    echo -e "Zipping up the documentation directory.\n"
    rm -f ${DOCS_ZIP}
    zip -qr ${DOCS_ZIP} *
  popd >/dev/null;

  eval "$(ssh-agent -s)";

  ls -la;
  echo "master";
  git branch;

  git checkout gh-pages;
  ls -la;
  echo "GH";
  git branch;
  # echo "C";

  find . -not -path "./.git*" -not -path "./tools*" -delete;
  unzip ${DOCS_ZIP};
  git add -A;
  git commit -am "Automated update of GitHub Pages documentation.";
  git push;


  # rm -fr *;
  # echo "D";
  # ls -la
  # echo "E";
  git checkout master;
  ls -la
  echo "master";
  git branch;


  #                                    exit;

}



echo -e "
   In Meteor package ::  0ur0rg:pkg09
       Code maintenance functions :
        * code style check (esLint)
        * regenerate documentation (jsDoc)
        * publish docs GitHub pages site
";


#### checkCodeStyle;

generateDocs;

commitDocsToGitHubPages;

  # if [[ ! $(type -t PushDocsToGitHubPagesBranch) == "function" ]]; then
  #   wget https://raw.githubusercontent.com/martinhbramwell/Meteor-CI-Tutorial/modularize/scripts/PushDocsToGitHubPagesBranch.sh;
  # fi;
  # ./PushDocsToGitHubPagesBranch.sh \
  #             ${PKG_NAME} \
  #             ~/${PARENT_DIR}/${PROJECT_NAME}/packages/${PKG_NAME} \
  #             ${DOCS_ZIP} \
  #             ${PKG_NAME}_origin;
