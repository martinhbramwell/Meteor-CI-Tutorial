#!/bin/bash
set -e
#
if [[ $EUID -eq 0 ]]; then
   echo -e "This script SHOULD NOT be run with 'sudo' (as root). "
   exit 1
fi


DOCS="./ProductionLogging/doc"
source ./explain.sh
source ./util.sh


explain ${DOCS}/Introduction.md


echo ""
echo ""
explain ${DOCS}/Another_NodeJS_moduleA.md

echo ""
echo ""
explain ${DOCS}/Another_NodeJS_moduleB.md

echo ""
echo ""
explain ${DOCS}/The_Async_ProblemA.md

echo ""
echo ""
explain ${DOCS}/The_Async_ProblemB.md

echo ""
echo ""
explain ${DOCS}/The_Async_ProblemC.md

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
