#!/bin/bash
#

export DEFAULT_IFS=${IFS};

source ./tasksRange.sh;
source ${TasksList};

tutorialSections=(  );

function inSections () {
  local SOUGHT=${1};
  for PTR in "${tutorialSections[@]}"; do
    [[ "${PTR}" == "${SOUGHT}" ]] && return 0;
  done;
#  echo -e "${PTR} == ${SOUGHT}";
  return 1;
}

function putSection () {

  IFS=' ';
  if ! inSections "$1"; then
#    echo -e "putting :: ${1}";
    tutorialSections+=("${1}");
  fi;
#  echo -e "Sections : ${tutorialSections[@]}";
  return 0;

}




function ProcessTasksBetween() {

  echo -e "

  Starting .... ";

  idxStart=-1;
  StartNotFound=0;
  LIM=${#arrFunctionDefinitions[@]};
  # echo ${LIM};

  echo "Finding first task ... "
  while [[ ( ${StartNotFound} -lt 1 )  &&  ( ${idxStart} -lt ${LIM} ) ]]; do

    idxStart=$((idxStart + 1));
    #echo "-- ${idxStart} ${LIM}   ${arrFunctionDefinitions[idxStart]}  ${StartExecuting}  --"
    if [[ "${arrFunctionDefinitions[idxStart]}" == "${StartExecuting}" ]]; then
      StartNotFound=1;
      #echo " ¡¡ ${StartNotFound}  ${arrFunctionDefinitions[idxStart]} = ${StartExecuting} !! "
    fi;

  done;

  #echo ${idxStart};
  if [[ (${idxStart} -lt ${LIM}) ]]; then

    echo "Finding last task ... "
    idxStop=$((${idxStart} - 1));
    StopNotFound=0;
    while [[ ( ${StopNotFound} -lt 1 )  &&  ( ${idxStop} -lt ${LIM} ) ]]; do

      idxStop=$((idxStop + 1));
      if [[ "${arrFunctionDefinitions[idxStop]}" = "${StopExecuting}" ]]; then StopNotFound=1; fi;

    done;

    if [[ ${idxStop} -lt ${LIM} ]]; then

#      echo -e "Collecting source file names from ${arrFunctionDefinitions[idxStart]} to ${arrFunctionDefinitions[idxStop]}";

      for (( numTask=${idxStart}; numTask<=${idxStop}; numTask++ ))
      do
        IFS='|'; read -a arrTask <<< "${arrFunctionDefinitions[${numTask}]}"; IFS=' ';
   #     echo -e "Putting ${arrTask[0]}|${arrTask[1]} ---- >${IFS}<";
        putSection "${arrTask[0]}|${arrTask[1]}";
      done

    else
      echo "End Not Found";
      exit 1;
    fi;

  else
    echo "Start Not Found";
    exit 1;
  fi;





  echo -e "Sourcing required script files";
  for i in "${tutorialSections[@]}"
  do
#    echo "Section ${i} ··· ";
    IFS='|'; read -a arrSection <<< "${i}"; IFS=' ';
#    echo -e "source ${SectionPrefix}${arrSection[0]}_${arrSection[1]}/${arrSection[1]}${FileSuffix}";
    source ${SectionPrefix}${arrSection[0]}_${arrSection[1]}/${arrSection[1]}${FileSuffix};
  done

  # echo "Start : ${idxStart}";
  # echo "Stop : ${idxStop}";

#  echo -e "Processing task from ${arrFunctionDefinitions[idxStart]} to ${arrFunctionDefinitions[idxStop]}";

  for (( numTask=${idxStart}; numTask<=${idxStop}; numTask++ ))
  do
    IFS='|'; read -a arrTask <<< "${arrFunctionDefinitions[${numTask}]}"; IFS=${DEFAULT_IFS};
    SKIP_CI=${arrTask[4]};
    CI="";
    if [[ "><" == ">${arrTask[4]}<" ]]; then CI="  With CI Build"; fi;
    echo -e "\n\n\n           * * * *  Running ${arrTask[2]}${CI} * * * * ";
    ${arrTask[2]};
    MSG=${arrTask[3]};
    if [[ ">${MSG}<" != "><" ]]; then
      echo -e "\n   ${MSG}\n          - o 0 o - \n";
    fi;
  done

  echo -e " .... done.";

}


ProcessTasksBetween;

