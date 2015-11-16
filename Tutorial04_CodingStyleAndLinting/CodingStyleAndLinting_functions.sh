function Try_ESLint_from_the_Command_Line() {

  pushd ~/${PARENT_DIR}/${PROJECT_NAME}/ >/dev/null;
  set +e
  eslint ./${PROJECT_NAME}.js
  set -e
  popd >/dev/null;

}


function Try_ESLint_Command_Line_Again() {

  pushd ~/${PARENT_DIR}/${PROJECT_NAME}/ >/dev/null;
  set +e
  eslint ./packages/${PKG_NAME}/${PKG_NAME}-tests.js
  set -e
  popd >/dev/null;

}

function Customize_ESLint_in_Sublime_Text() {

  pushd ~/${PARENT_DIR}/${PROJECT_NAME}/ >/dev/null;

    wget -O .eslintrc https://raw.githubusercontent.com/martinhbramwell/Meteor-CI-Tutorial/modularize/fragments/modified_eslintrc;
    cp .eslintrc ./packages/${PKG_NAME}/

  popd >/dev/null;

}


function Correct_the_indicated_code_quality_defects() {

  pushd ~/${PARENT_DIR}/${PROJECT_NAME}/packages/${PKG_NAME}/ >/dev/null;

    wget -O ${PKG_NAME}-tests.js https://raw.githubusercontent.com/martinhbramwell/Meteor-CI-Tutorial/modularize/fragments/package-tests_T04_05.js;

  popd >/dev/null;


}

# function () {
# }

# function () {
# }
