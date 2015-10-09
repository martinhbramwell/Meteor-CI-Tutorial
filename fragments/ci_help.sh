#!/bin/bash
#

#  This is a helper script for continuous integration
#  It clones our packages from GitHub into a local directory and
#  then sets up a hyperlink from our project's packages directory 
#  
# Use the array 'OUR_PACKAGES' to specify the packages to clone.
# 
#    ORG_NAME  |  PKG_NAME  |  SUB_DIR  
#
OUR_PACKAGES=(
  "${GITHUB_ORGANIZATION_NAME}|${PKG_NAME}|${YOUR_UID}" \
  "dude-awap|dummy|thirdparty/dudeAwap"
)

pushd "$(dirname "$0")";

SEP=${IFS}
for PKG in "${OUR_PACKAGES[@]}"
do
  IFS='|' read -ra SPEC <<< "${PKG}"
  printf " %s\n" "${SPEC[2]}"
  mkdir -p ~/packages/${SPEC[2]}/${SPEC[1]};
  git clone https://github.com/${SPEC[0]}/${SPEC[1]} ~/packages/${SPEC[2]}/${SPEC[1]};
  pwd
  ls 
  rm -fr ${SPEC[1]};   ln -s ~/packages/${SPEC[2]}/${SPEC[1]} ${SPEC[1]};
done
IFS=${SEP}

popd;