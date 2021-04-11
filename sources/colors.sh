# This color.sh file is developed as an shell library, Never run this file alone

# example lines for status

# ${RED}${ERR}${NRML}
# ${GREEN}${GOOD}${NRML}
# ${YELLOW}${STAR}${NRML}


# color vars
RED="\e[91m"
GREEN="\e[32m"
YELLOW="\e[33m"
NRML="\e[39m"
CYAN="\e[96m"
BOLD="\e[1m"
BLUE="\e[94m"
CYANLIGHT="\e[96m"
MAGENTA="\e[95m"
INVERT="\e[7m"
BLINK="\e[5m"
UNBLINK="\e[25m"

# status vars
GOOD="[+]"
ERR="[-]"
STAR="[*]"


# terminal size vars
COLS="$(tput cols)"
LINES="$(tput lines)"


# prints banner and author
bannerPrinter()
{
  if [ "${COLS}" -gt 89 ] && [ "${LINES}" -gt 16 ];
  then
    echo
    printf "${GREEN}${1}${UNBLINK}  ${NRML}                                    ${VERSION}
                                ./~
                         (=#####{>======${CYANLIGHT}Made by T34m YaraCapper${RED}============-${NRML}
                                \`\~
    ${NRML}"
    echo
  else
    return 1
  fi
}
