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
echo -e "${YELLOW}${STAR}${NRML} Checking for log files.."
if [[ -e ./log/ymon.log ]];
then
  echo -e "${YELLOW}${STAR}${NRML} Log file existed.. Using the existed log file"
  dumpLog "Script Started"
else
  echo -e "${RED}${ERR}${NRML} No log file existed, creating new one.."
  touch ./log/ymon.log && echo -e "${GREEN}${GOOD}${NRML} Log file created successfully"
fi
echo "=========================="
sleep 1s
# Log logic end


# Dependency checking
echo "=========================="
echo -e "${YELLOW}${STAR}${NRML} Checking for dependencies.. "
sleep 0.5s
aircrackngCheck || ( dumpLog "Aircrack-ng not satisfied" && handleError )
sleep 0.5s
tsharkCheck || ( dumpLog "tShark not satisfied" && handleError )
echo "=========================="
sleep 0.5s



# Checking for wireless interfaces
INTR=$(iw dev | awk '$1=="Interface"{print $2}')
echo -e "${YELLOW}${STAR}${NRML} Searching for wireless interfaces.."
sleep 0.5s
if [[ -n $INTR ]];
then
  echo -e "${GREEN}${GOOD}${NRML} Found default interface -- ${INTR}"
  echo -e "${BLUE}"
  read -p "Do you want to use another interface instead?(if yes, enter 'y' and then give valid device mount point) [no]: " RES
  echo -e "${NRML}"
  if [[ ${RES,,} = 'yes' || ${RES,,} = 'y' ]];
  then
    echo -e "${BLUE}"
    read -p "Enter the new wireless mount point: " INTR
    echo -e "${NRML}"
    validateInterface ${INTR} || interfaceError
    echo -e "${YELLOW}${STAR}${NRML} New interface given ${INTR}"
  else
    echo -e "${YELLOW}${STAR}${NRML} Continuing with ${INTR} interface.."
  fi

else
  echo -e "${RED}${ERR}${NRML} No wireless interface found,"
  echo -e "${BLUE}"
  read -p "Do u want to add manual wireless interface? (if yes, enter 'y' and then give valid dev mount point) [no]: " RES
  if [[ ${RES,,} = 'yes' || ${RES,,} = 'y' ]];
  then
    read -p "Enter the new wireless mount point: " INTR
    echo -e "${NRML}"
    validateInterface ${INTR} || interfaceError
    echo -e "${YELLOW}${STAR}${NRML} New interface given ${INTR}"
  else
    echo -e "${RED}${ERR}${NRML} Unable to find wireless interface, exiting the script.."
    echo "=========================="
    exit 1
  fi

fi
sleep 1s
echo "=========================="

monitorMode
echo -e "${GREEN}${GOOD}${NRML} New monitor interface has been initialized: ${INTR}"

echo "==============================================================="
echo -e "${YELLOW}${STAR}${NRML} press ctrl + c to exit airodump screen once you have seen your target."
sleep 10s

echo -e "${CYANLIGHT}"
dumpInfo
echo -e "${BLUE}"
read -p "Enter the target BSSID: " BSSID
read -p "Enter the channel of BSSID: " CH
echo -e "${NRML}"

#removeDataFiles

echo -e "${YELLOW}${STAR}${NRML} Target set to ${BSSID}, listening on channel ${CH}.."
sleep 2s

mkdir preauth 2> /dev/null || echo -e "${RED}${ERR}${NRML} Unable to create directory,directory may existed "
mkdir postauth 2> /dev/null || echo -e "${RED}${ERR}${NRML} Unable to create directory, directory may existed"

echo -e "${CYANLIGHT}"
targetSet
echo
echo -e "${YELLOW}${STAR}${NRML} Getting ready to capture packets...."
sleep 2s


managedMode
restartNetwork
sleep 20s

tsharkCheck || echo -e "${RED}${ERR}${NRML} Error in handling packet capture, $(handleError)"
sleep 1s

startTshark && echo -e "${GREEN}${GOOD}${NRML} Successfully captured all packets, now they are ready to send to mail"

dumpLog "End of Script"
