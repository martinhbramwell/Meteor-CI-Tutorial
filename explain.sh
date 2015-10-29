#!/bin/bash
#

PURPLE='\033[0;35m'
ORANGE='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# function awkWork()
# {
# #  echo -en ${PURPLE};
#   envsubst '$PARENT_DIR, $PROJECT_NAME, $PKG_NAME, $GITHUB_ORGANIZATION_NAME, $PACKAGE_DEVELOPER, $YOUR_EMAIL, $YOUR_UID, $YOUR_FULLNAME' < $1 | \
# #  cat $1 | \
#   sed '1,/o 0 o/d;/<!-- B -->/,$d' | \
#   ./clean.awk;
#   # | \
# #  awk '{while(match($0,"[$]{[^}]*}")) {var=substr($0,RSTART+2,RLENGTH -3);gsub("[$]{"var"}",ENVIRON[var])}}1' | \
# #  sed "s|\(\[\)\([a-z A-Z0-9'.:/-]*\)\(\]([a-zA-Z0-9/:._-?=]*)\)|\2 |g" | \

# #  fold -w 90 -s;
# #  echo -en ${NC};
# }

function highlight()
{
#  echo -en ${ORANGE};
  envsubst '$PARENT_DIR, $PROJECT_NAME, $PKG_NAME, $GITHUB_ORGANIZATION_NAME, $PACKAGE_DEVELOPER, $YOUR_EMAIL, $YOUR_UID, $YOUR_FULLNAME' < $1 | \
  sed '1,/o 0 o/d;/<!-- B -->/,$d' | \
  ./clean.awk | \
  fold -w 95 -s;
#   | \
# fmt --width=180 --goal=95;
#  awk '{while(match($0,"[$]{[^}]*}")) {var=substr($0,RSTART+2,RLENGTH -3);gsub("[$]{"var"}",ENVIRON[var])}}1' | \
#  sed "s|\(\[\)\([a-z A-Z0-9'.:/-]*\)\(\]([a-zA-Z0-9/:._-?=]*)\)|\2 |g" | \
  #
#  fold -w 95 -s;
  echo -en ${NC};
}

FRAME=$(printf "%-80s" "~");
function explain()
{
  echo -e "\n\n\n\n${FRAME// /\~}"

  if [ ! -r "$1" ]; then
    echo -e "FIXME";
    echo -e $1;
    return 1;
  fi;

  highlight $1;


  if [ "${RUN_RULE}" != "a" ]; then
    if [[ "${2/MORE_}" != "ACTION" ]]; then
      read -p "To continue hit <enter> ::  " -n 1 -r USER_ANSWER   
    else
      LAST="";
      if [ "$2" == "MORE_ACTION" ]; then
      	echo -e "Type : '${RED}a${NC}ll' if you want to execute the rest of the script without pausing."
        LAST="'a', ";
      fi

    	echo -e "Type : '${RED}n${NC}o' to skip the group of related commands."
    	echo -e "Hit : '${RED}y${NC}es'  or '${RED}<enter>${NC}' to execute the group, '${RED}q${NC}uit' OR '${RED}<ctrl-c>${NC}' to quit"
    	read -p "  ${LAST}'n', 'q' or <enter> ::  " -n 1 -r USER_ANSWER

    	CHOICE=$(echo ${USER_ANSWER:0:1} | tr '[:upper:]' '[:lower:]')
      RUN_RULE=${CHOICE};
    	if [ "X${CHOICE}X" == "XnX" ]; then return 0; fi;
      if [ "X${CHOICE}X" == "XqX" ]; then echo ""; exit 0; fi;

    fi;
  fi;
	return 0;
}
#############################

