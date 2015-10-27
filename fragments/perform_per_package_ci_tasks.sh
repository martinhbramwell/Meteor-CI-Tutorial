#!/bin/bash
#

#  This is a helper script for continuous integration
#  It clones our packages from GitHub into a local directory and
#  then sets up a hyperlink from our project's packages directory 
#  

LOCAL_PACKAGES="${HOME}/packages";

pushd "$(dirname "$0")" >/dev/null;

source managed_packages.sh;

export PERFORM_CI_TASKS_SCRIPT_NAME="perform_ci_tasks.sh";
PKG_CNT="${#MANAGED_PACKAGES[@]}";
printf " Working on %s packages in '${LOCAL_PACKAGES}'." "${PKG_CNT}"
SEP=${IFS}
for IDX in "${!MANAGED_PACKAGES[@]}"
do
  PKG=${MANAGED_PACKAGES[IDX]}
  IFS='|' read -ra SPEC <<< "${PKG}"
  TGT=${LOCAL_PACKAGES}/${SPEC[2]}/${SPEC[1]}
  printf "\n\n   Package %s of %s :: '%s' " "$((IDX+1))" "${PKG_CNT}" "${SPEC[0]}/${SPEC[1]}"
  if [[ -d "${TGT}" ]];
  then
    if [[ -d "${TGT}/ci" ]];
    then
      if [[ -x "${TGT}/ci/${PERFORM_CI_TASKS_SCRIPT_NAME}" ]];
      then
          printf "\n     Found executable file '${TGT}/ci/${PERFORM_CI_TASKS_SCRIPT_NAME}'";
      else
        printf "\n     Could not find executable file '${TGT}/ci/${PERFORM_CI_TASKS_SCRIPT_NAME}'";
      fi;
    else
      printf "\n     Could not find directory '${TGT}/ci'";
    fi;
  else
      printf "\n     Could not find directory '${TGT}'";
  fi;
  # printf "will be stored at '%s.\n"  "${TGT}"
  # rm -fr ${TGT}; mkdir -p ${TGT};
  # git clone https://github.com/${SPEC[0]}/${SPEC[1]} ${TGT};
  # printf "Symlinking '%s' to point to '%s.\n" "${SPEC[1]}" "${TGT}"
  # rm -fr ${SPEC[1]};   ln -s ${TGT} ${SPEC[1]};
done
IFS=${SEP}

popd >/dev/null;
echo -e "\n\n----------------------------------------------------";
