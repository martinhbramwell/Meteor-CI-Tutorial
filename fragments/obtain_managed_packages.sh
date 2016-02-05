#!/bin/bash
#

#  This is a helper script for continuous deployment
#  It clones our packages from GitHub into a local directory and
#  then sets up a hyperlink from our project's packages directory
#

LOCAL_PACKAGES="${HOME}/packages";

pushd "$(dirname "$0")" >/dev/null;

source managed_packages.sh;

PKG_CNT="${#MANAGED_PACKAGES[@]}";
printf " Cloning %s packages into '${LOCAL_PACKAGES}'.\n" "${PKG_CNT}"
SEP=${IFS}
for IDX in "${!MANAGED_PACKAGES[@]}"
do
  PKG=${MANAGED_PACKAGES[IDX]}
  IFS='|' read -ra SPEC <<< "${PKG}"
  TGT=${LOCAL_PACKAGES}/${SPEC[2]}/${SPEC[1]}
  printf "\n   Package %s of %s :: '%s' " "$((IDX+1))" "${PKG_CNT}" "${SPEC[0]}/${SPEC[1]}"
  printf "will be stored at '%s.\n"  "${TGT}"
  rm -fr ${TGT}; mkdir -p ${TGT};
  git clone https://github.com/${SPEC[0]}/${SPEC[1]} ${TGT};
  printf "Symlinking '%s' to point to '%s.\n" "${SPEC[1]}" "${TGT}"
  rm -fr ${SPEC[1]};   ln -s ${TGT} ${SPEC[1]};
done
IFS=${SEP}

popd >/dev/null;
echo -e "\n\n----------------------------------------------------";
