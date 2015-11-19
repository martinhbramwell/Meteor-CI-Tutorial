#!/bin/bash
#
# Loop through managed packages.
#    Run the codeMaintenance script for each package that has one.
#

pushd "$(dirname "$0")" >/dev/null;
echo -e "We're in $(pwd)";

LOCAL_PACKAGES="../../packages";
[[ "${CIRCLECI}" == "true" ]] && LOCAL_PACKAGES="${HOME}/packages";
echo -e "Expect to work with packages in '${LOCAL_PACKAGES}'";

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
  printf "has code maintenance routines at '%s.\n"  "${TGT}/tools/perform_ci_tasks.sh";
  if [[ -x ${TGT}/tools/perform_ci_tasks.sh ]]; then

    pushd ${TGT} >/dev/null;
      ./tools/perform_ci_tasks.sh;
    popd >/dev/null;

  else
    echo " No code maintenance routines found. ";
  fi;
done
IFS=${SEP}

popd >/dev/null;
echo -e "\n\n----------------------------------------------------";
