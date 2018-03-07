#!/usr/bin/env bash

######################################################################
# loading_bar - prints a loading bar to stdout                       #
# $1 - progress (i)                                                  #
# $2 - max progress (n)                                              #
# $3 - bar length                                                    #
# $4 - decoration string                                             #
######################################################################

loading_bar() {
  DEFAULT_BAR_LEN=20
  
  # test for valid args
  USAGE="usage: ${FUNCNAME[0]} <PROGRESS> <MAX_PROGRESS> [<BAR_LENGTH>] [<DECORATOR>]\nwhere <PROGRESS> and <MAX_PROGRESS> are integers"
  if [ "$1" -eq "$1" ] &>/dev/null && [ "$2" -eq "$2" ] &>/dev/null; then
    :
  else
    echo -e "$USAGE"
    return 1
  fi

  [ -z "$3" ] && LEN="$DEFAULT_BAR_LEN" || LEN="$3"
  BAR=$(printf "%${LEN}s" "")

  # print (i*LEN)/n #'s
  printf "\r%s[%.$(expr $1 \* ${LEN} / $2 )s" "$4"\
	   "${BAR// /\#}"

  # print 1-((i*20)/n) spaces
  printf "%.$(expr ${LEN} - $1 \* ${LEN} / $2 )s]"\
           "${BAR// /-}"

  printf "[%d/%d]" $1 $2
  return 0
}

export -f loading_bar
