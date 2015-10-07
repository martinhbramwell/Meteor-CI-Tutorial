#!/bin/bash
set -e
#
if [[ $EUID -eq 0 ]]; then
   echo -e "This script SHOULD NOT be run with 'sudo' (as root). "
   exit 1
fi


DOCS="./RealWorldPackage/doc"
source ./explain.sh
source ./util.sh


explain ${DOCS}/Introduction.md


echo ""
echo ""
explain ${DOCS}/Another_NodeJS_moduleA.md

echo ""
echo ""
explain ${DOCS}/Another_NodeJS_moduleB.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then

  pushd ~/${PARENT_DIR}/${PROJECT_NAME}/packages/${PKG_NAME} >/dev/null;

  wget -O ${PKG_NAME}.js https://raw.githubusercontent.com/martinhbramwell/Meteor-CI-Tutorial/master/fragments/yourpackage.js

  popd >/dev/null;

fi

echo ""
echo ""
explain ${DOCS}/Async_Problem_Buried_Methods.md

echo ""
echo ""
explain ${DOCS}/Async_Problem_Wrapped_Proxy_A.md

echo ""
echo ""
explain ${DOCS}/Async_Problem_Wrapped_Proxy_B.md

echo ""
echo ""
explain ${DOCS}/Async_Problem_Sync_Namespace.md

echo ""
echo ""
explain ${DOCS}/Async_Problem_TinyTest_A.md

echo ""
echo ""
explain ${DOCS}/Call_Into_Package_Methods.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then

  pushd ~/${PARENT_DIR}/${PROJECT_NAME}/packages/${PKG_NAME} >/dev/null;

  wget https://raw.githubusercontent.com/martinhbramwell/Meteor-CI-Tutorial/master/fragments/usage_example.js
  wget https://raw.githubusercontent.com/martinhbramwell/Meteor-CI-Tutorial/master/fragments/usage_example.html
  sed -i -e "s/\${PKG_NAME}/${PKG_NAME}/" usage_example.html
  sed -i -e "s/\${GITHUB_ORGANIZATION_NAME}/${GITHUB_ORGANIZATION_NAME}/" usage_example.html
  popd >/dev/null;

fi

echo ""
echo ""
explain ${DOCS}/Declare_Callable_Method.md


echo ""
echo ""
explain ${DOCS}/View_and_Hide_The_Example.md



## FLAG FOR INCLUSION IN SLIDES - ${DOCS}/Fin.md explain

echo ""
echo ""
explain \
${DOCS}/dummy.md

echo ""
echo ""
explain  \
${DOCS}/dummy.md


# echo ""
# echo ""
# explain  \
# ${DOCS}/dummy.md




echo -e "\nDone.";
exit 0;

# explain "#  FIXME
# \n#
# \n#
# \n#  "
# if [ $? -eq 0 ]; then

#   pushd ~/${PARENT_DIR} >/dev/null;
#   pushd ${PROJECT_NAME} >/dev/null;


#   popd >/dev/null;
#   popd >/dev/null;

# fi


echo "Done.";
exit 0;
