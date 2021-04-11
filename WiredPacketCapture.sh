#!/usr/bin/env bash

# get source files
source sources/colors.sh
source sources/errors.sh
source sources/networkpref.sh
source sources/crak.sh
source sources/generic.sh
source sources/shark.sh
clear

# Log logic start
checkLog
# Log logic end

dumpLog "Log for wired interface start"

# Dependency checking
echo "=========================="
echo -e "${YELLOW}${STAR}${NRML} Checking for dependencies.. "
sleep 0.5s
tsharkCheck || ( dumpLog "tShark not satisfied" && handleError )
echo "=========================="

echo -e "${YELLOW}${STAR}${NRML} Searching for wired interfaces.."
INTR=$(ip link | awk -F: '$0 !~ "lo|vir|wl|^[^0-9]"{print $2;getline}')
INTR=$(echo ${INTR//[[:blank:]]/})
sleep 0.5s

if [[ -n $INTR ]];
then
  echo -e "${GREEN}${GOOD}${NRML} Found default interface -- ${INTR}${BLUE}"
  read -p "Do you want to use another interface instead?(if yes, enter 'y' and then give valid device mount point) [no]: " RES
  echo -e "${NRML}"

  if [[ ${RES,,} = 'yes' || ${RES,,} = 'y' ]];
  then
    echo -e "${BLUE}"
    read -p "Enter the new wired mount point: " INTR
    echo -e "${NRML}"
    validateWiredInterface || interfaceError
    echo -e "${YELLOW}${STAR}${NRML} New interface given ${INTR}"
  else
    echo -e "${YELLOW}${STAR}${NRML} Continuing with ${INTR} interface.."
  fi

else
  echo -e "${RED}${ERR}${NRML} No wired interface found${BLUE}"
  read -p "Do u want to add manual wired interface? (if yes, enter 'y' and then give valid dev mount point) [no]: " RES

  if [[ ${RES,,} = 'yes' || ${RES,,} = 'y' ]];
  then
    read -p "Enter the new wired mount point: " INTR
    echo -e "${NRML}"
    validateWiredInterface || interfaceError
    echo -e "${YELLOW}${STAR}${NRML} New interface given ${INTR}"
  else
    echo -e "${RED}${ERR}${NRML} Unable to find wired interface, exiting the script.."
    echo "=========================="
    exit 1
  fi

fi
sleep 1s
echo "=========================="


startTshark && echo -e "${GREEN}${GOOD}${NRML} Successfully captured all packets"
echo "=========================="

dumpLog "Log for wired interface end"
