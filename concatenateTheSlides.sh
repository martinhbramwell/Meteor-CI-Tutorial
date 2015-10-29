#!/bin/bash
#

source util.sh;

declare -a FILEPATHS=()
for filename in ./Part*.sh; do
  PT=$(echo ${filename} | sed 's/.\///g' | sed 's/_/_|/g' | sed 's/.sh/|/g');
  while read -r line; do
    FN=$(echo "${line}" | sed 's/\.md.*/.md/g')
    FN=$(echo "${FN}" | sed 's/.*DOCS}\///g')
#    echo "Processing the file :: ${PT}${FN}";
    FILEPATHS+=("${PT}${FN}");
  done < <(grep -E 'explain.*DOCS|DOCS.*explain'  ${filename})
done

SKIP=true;
if [[ "X$1X" == "XyX" ]]; then
  SKIP=false;
elif [[ "X$1X" != "XnX" ]]; then
  echo -e ""
  echo -e "Usage : "
  echo -e " - '$0 y' generate documentation and commit to gh-pages branch"
  echo -e " - '$0 n' generate documentation only"
  echo -e ""
  echo -e "Hit '<enter>' to generate documentation without commit"
  echo -e "Hit 'y' now to generate documentation and commit to gh-pages branch"
  echo -e "Hit 'q' to quit"
  read -p " 'y', 'q' or '<enter>' ::  " -n 1 -r USER_ANSWER
  CHOICE=$(echo ${USER_ANSWER:0:1} | tr '[:upper:]' '[:lower:]')
  echo ""
  if [ "X${CHOICE}X" == "XqX" ]; then exit 0; fi;
  if [ "X${CHOICE}X" == "XyX" ]; then SKIP=false; fi;
fi;


for idx_d in "${FILEPATHS[@]}"
do
  FP="${idx_d}"
  FPA=(${FP//|/ })
  rm -f ${FPA[1]}/concatenatedSlides.MD
done

#
# Process all mrkdown documents extracting just what a script user needs to see
#
GITHUB_DIR="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/"
for idx_d in "${FILEPATHS[@]}"
do

  FP="${idx_d}"
  FPA=(${FP//|/ })
  AFP="${FPA[1]}/doc/${FPA[2]}" # The complete path of the markdown file.
  SCRIPT_FILE_NAME="${FPA[0]}${FPA[1]}"
  SCRIPT_FILE="${SCRIPT_FILE_NAME}.sh" # The name of the script that 
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#    Find line number of relevant code and add hyperlink at bottom of slide
#    Expect a flag "CODEBLOCK", otherwise skip this file, and check the next one..

  LCNT=$(grep -cr "${FPA[2]}.*CODE_BLOCK" ${SCRIPT_FILE});
  if [[ "${LCNT}" -gt 1 ]]; then
    echo -e "\n\n\n    ${flashingRed}* * * * You have duplicate calls to explain * * * *${endColor} \n\n\n.";
    exit;
  fi;

  LNUM=$(grep -nr "${FPA[2]}.*CODE_BLOCK" ${SCRIPT_FILE}  | cut -d : -f 1);
  if [[ "${LNUM}" -gt 0 ]]; then
    LNUM=$((LNUM+2))

    DBGLOG=false;
    # if [[ "${FPA[1]}" == "PrepareTheMachine" && "${LNUM}" -lt 70  || "${LNUM}" -eq 44 ]]; then
    #   DBGLOG=true;
    # fi;

    ${DBGLOG} && echo "\n\n ${FPA[1]}, Line number : ${LNUM}"

    export PATTERN='<!-- B -->]'
    ${DBGLOG} && echo "Old : ${PATTERN}"
    export REPLACEMENT='<!-- Code for this begins at line #'
    REPLACEMENT="${REPLACEMENT}${LNUM}"
    REPLACEMENT=${REPLACEMENT}' -->\n<!-- B -->'
    REPLACEMENT=${REPLACEMENT}'\n.center[.footnote[.red.bold[] <a href="'
    REPLACEMENT="${REPLACEMENT}${GITHUB_DIR}${SCRIPT_FILE}#L${LNUM}"
    REPLACEMENT=${REPLACEMENT}'" target="_blank">Code for this step.</a>] ]'
    REPLACEMENT=${REPLACEMENT}'\n]'

    ${DBGLOG} && echo "Long : ${REPLACEMENT}"
#    echo "New : ${REPLACEMENT}"
#    echo "File : ${AFP}"
#    echo "# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    sed -i "0,/${PATTERN}/s|${PATTERN}|${REPLACEMENT}|" ${AFP}

    export PATTERN='#L[0-9]*'
#    echo "Old : ${PATTERN}"
    export REPLACEMENT="#L${LNUM}"
    ${DBGLOG} && echo "New : ${REPLACEMENT}"
    sed -i "0,/${PATTERN}/s|${PATTERN}|${REPLACEMENT}|" ${AFP}

    export PATTERN='begins at line #[0-9]*'
    ${DBGLOG} && echo "Old : ${PATTERN}"
    export REPLACEMENT="begins at line #${LNUM}"
    ${DBGLOG} && echo "New : ${REPLACEMENT}"
    sed -i "0,/${PATTERN}/s|${PATTERN}|${REPLACEMENT}|" ${AFP}
#
    export PATTERN='blob\/master\/[A-Za-z0-9_]*.sh'
#    echo "Old : ${PATTERN}"
    export REPLACEMENT="blob/master/${SCRIPT_FILE}"
    ${DBGLOG} && echo "New : ${REPLACEMENT}"
    sed -i "0,/${PATTERN}/s|${PATTERN}|${REPLACEMENT}|" ${AFP}

  fi

  SKIP_INTRO="Introduction.md"
  SKIP_END="Fin.md"
  if [ "${AFP/${SKIP_INTRO}}" = "${AFP}" ] ; then
    if [ "${AFP/${SKIP_END}}" = "${AFP}" ] ; then
      LNUM=$(grep -nr "${FPA[2]}.*MANUAL_INPUT_REQUIRED" ${SCRIPT_FILE}  | cut -d : -f 1)
      PATTERN='input_type_indicator'
      if [[ "${LNUM}" -gt 0 ]]; then
        REPLACEMENT='  <br \/><br \/><div class="input_type_indicator"><img src=".\/fragments\/typer.gif" \/><br \/>Manual input is required here.<\/div><br \/>'
  #      REPLACEMENT='Manual input'
      else
        REPLACEMENT='  <br \/><br \/><div class="input_type_indicator"><img src=".\/fragments\/loader.gif" \/><br \/>No manual input required here.<\/div><br \/>'
  #      REPLACEMENT='No manual input'
      fi
      sed -i "s/.*${PATTERN}.*/${REPLACEMENT}/g" ${AFP}
  #    echo "${AFP} does ${REPLACEMENT}"
    fi
  fi


# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  cat ${AFP} >> ${FPA[1]}/concatenatedSlides.MD
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

done


if  ${SKIP} ;  then  exit 0; fi;

git log -1 --pretty=%B > gitlog.txt

tar zcvf pack.tar.gz index.html \
styles.css \
gitlog.txt \
fragments/typer.gif \
fragments/loader.gif \
PrepareTheMachine/concatenatedSlides.MD \
VersionControlInTheCloud/concatenatedSlides.MD \
UnitTestAPackage/concatenatedSlides.MD \
CodingStyleAndLinting/concatenatedSlides.MD \
AutomaticDocumentationInTheCloud/concatenatedSlides.MD \
CloudContinuousIntegration/concatenatedSlides.MD \
ProductionLogging/concatenatedSlides.MD \
RealWorldPackage/concatenatedSlides.MD \
PackageSelfTest/concatenatedSlides.MD


export STASH_CREATED=$(git stash) && echo $STASH_CREATED
if [[ "${STASH_CREATED}" != "No local changes to save" ]];
then
  echo ""
  echo "Changes to master branch have been stashed"
fi;
git checkout gh-pages
echo "On branch gh-pages"
tar zxvf pack.tar.gz
rm -f pack.tar.gz
MSG=$(cat gitlog.txt)
echo "Add anything new"
git add .
echo "Unpacked all."
git commit -am "${MSG}"
echo "Committed"
git push
echo "Pushed"
git checkout master
echo "- - - back on branch master - - -"
if [[ "${STASH_CREATED}" != "No local changes to save" ]];
then
  git stash apply;
  echo "Reverted stash"
else
  echo "No stash to restore";
fi;



