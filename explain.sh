#!/bin/bash
#

PURPLE='\033[0;35m'
ORANGE='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

function highlight()
{
  echo -en ${PURPLE};
  envsubst < $1 | \
  awk '{while(match($0,"[$]{[^}]*}")) {var=substr($0,RSTART+2,RLENGTH -3);gsub("[$]{"var"}",ENVIRON[var])}}1' | \
  sed '1,/o 0 o/d;/<!-- B -->/,$d' | \
  sed "s|\(\[\)\([a-z A-Z0-9'.:/-]*\)\(\]([a-zA-Z0-9/:._-?=]*)\)|\2 |g" | \
  fold -w 90 -s;
  echo -en ${NC};
}

FRAME=$(printf "%-80s" "~");
function explain()
{
  echo -e "\n\n\n\n${FRAME// /\~}"

  if [ -r "$1" ]; then
#    fold -w 80 -s $1;
    highlight $1;

  else
    echo -e "FIXME";
    echo -e $1;
  fi;

	if [ "X${AUTORUN}X" == "XaX" ]; then return 0; fi;
	echo -e "Type : '${RED}a${NC}ll' if you want to execute the rest of the script without pausing."
	echo -e "Type : '${RED}n${NC}o' to skip the group of related commands."
	echo -e "Hit : '${RED}y${NC}es'  or '${RED}<enter>${NC}' to execute the group, '${RED}q${NC}uit' OR '${RED}<ctrl-c>${NC}' to quit"
	read -p "  'a', 'n', 'q' or <enter> ::  " -n 1 -r USER_ANSWER

	CHOICE=$(echo ${USER_ANSWER:0:1} | tr '[:upper:]' '[:lower:]')
#	echo X${CHOICE}X
	if [ "X${CHOICE}X" == "XnX" ]; then return 1; fi;
  if [ "X${CHOICE}X" == "XqX" ]; then echo ""; exit 0; fi;
	AUTORUN=${CHOICE};
	return 0;
}
#############################

