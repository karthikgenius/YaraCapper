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

dumpLog "Log for wireless interface start"

# Dependency checking point
echo "=========================="
echo -e "${YELLOW}${STAR}${NRML} Checking for dependencies.. "
sleep 0.5s
aircrackngCheck || ( dumpLog "Aircrack-ng not satisfied" && handleError )
sleep 0.5s
tsharkCheck || ( dumpLog "tShark not satisfied" && handleError )
echo "=========================="
sleep 0.5s

# Checking for wireless interfaces
echo -e "${YELLOW}${STAR}${NRML} Searching for wireless interfaces.."
INTR=$(iw dev | awk '$1=="Interface"{print $2}')
sleep 0.5s

if [[ -n $INTR ]];
then
  echo -e "${GREEN}${GOOD}${NRML} Found default interface -- ${INTR}${BLUE}"
  read -p "Do you want to use another interface instead?(if yes, enter 'y' and then give valid device mount point) [no]: " RES
  echo -e "${NRML}"
  if [[ ${RES,,} = 'yes' || ${RES,,} = 'y' ]];
  then
    echo -e "${BLUE}"
    read -p "Enter the new wireless mount point: " INTR
    echo -e "${NRML}"
    validateWirelessInterface || interfaceError
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
    validateWirelessInterface || interfaceError
    echo -e "${YELLOW}${STAR}${NRML} New interface given ${INTR}"
  else
    echo -e "${RED}${ERR}${NRML} Unable to find wireless interface, exiting the script.."
    echo "=========================="
    exit 1
  fi

fi
sleep 1s
echo "=========================="


# Configuration point
echo -e "${YELLOW}${STAR}${NRML} Configuring Wireless adapter..."
ip link set ${INTR} down &> /dev/null || handleError
ip link set ${INTR} name wlan0 &> /dev/null || handleError
INTR="wlan0"
ip link set ${INTR} up &> /dev/null || handleError
restartNetwork
echo -e "${GREEN}${GOOD}${NRML} Configuring Wireless adapter done"
echo "=========================="

# Monitor mode point
monitorMode
echo -e "${GREEN}${GOOD}${NRML} New monitor interface has been initialized: ${INTR}"

echo "=========================="
echo -e "${YELLOW}${STAR}${NRML} press 'q' two times to exit airodump screen once you have seen your target"
sleep 10s

# Dumping wifi networks
echo -e "${CYANLIGHT}"
dumpInfo
echo -e "${BLUE}"
read -p "Enter the target BSSID: " BSSID
read -p "Enter the channel of BSSID: " CH
echo -e "${NRML}"

#removeDataFiles

echo -e "${YELLOW}${STAR}${NRML} Target set to ${BSSID}, listening on channel ${CH}.."
sleep 2s

mkdir preauth 2> /dev/null || echo -e "${RED}${ERR}${NRML} Unable to create directory,directory may existed"
mkdir postauth 2> /dev/null || echo -e "${RED}${ERR}${NRML} Unable to create directory, directory may existed"

echo -e "${CYANLIGHT}"
targetSet
echo
echo -e "${YELLOW}${STAR}${NRML} Getting ready to capture packets...."
sleep 2s

# Managed mode point
managedMode
restartNetwork
sleep 20s

# tsharkCheck || echo -e "${RED}${ERR}${NRML} Error in handling packet capture, $(handleError)"
sleep 1s

startTshark && echo -e "${GREEN}${GOOD}${NRML} Successfully captured all packets"
echo "=========================="

dumpLog "Log for wireless interface end"
