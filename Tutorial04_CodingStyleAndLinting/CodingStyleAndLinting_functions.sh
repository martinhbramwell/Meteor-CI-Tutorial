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
