#!/usr/bin/env bash

# Checks for aircrack-ng installation
aircrackngCheck()
{
  aircrack-ng &> /dev/null && echo -e "${GREEN}${GOOD}${NRML} Aircrack-ng Installed"
}

# Monitor mode functiton
monitorMode()
{
  echo -e "${YELLOW}${STAR}${NRML} Running killer for airmon-ng"
  airmon-ng check kill &> /dev/null || handleError
  echo -e "${YELLOW}${STAR}${NRML} Starting monitor mode on ${INTR}"
  timestamp >> ./log/ymon.log
  airmon-ng start ${INTR} &>> ./log/ymon.log || handleError
  echo -e "${GREEN}${GOOD}${NRML} Monitor mode successfully enabled"

  STATUS_MONITOR=$(airmon-ng | grep mon)
  set -- $STATUS_MONITOR
  INTR=$2
}

# Managed mode function
managedMode()
{
  echo -e "${YELLOW}${STAR}${NRML} Stopping monitor mode on ${INTR}"
  timestamp >> ./log/ymon.log
  airmon-ng stop ${INTR} &>> ./log/ymon.log || handleError
  echo -e "${GREEN}${GOOD}${NRML} Managed mode successfully enabled"

  STATUS_MANAGE=$(airmon-ng | grep wlan)
  set -- $STATUS_MANAGE
  INTR=$2

}

# Airodump
dumpInfo()
{
  echo -e "Dumping near WiFi networks.."
  sleep 2s
  airodump-ng ${INTR}
}

# Airodump target set
targetSet()
{
  airodump-ng --bssid ${BSSID} --channel ${CH} --write preauth/file-${BSSID} ${INTR}
  echo -e "${GREEN}${STAR}${NRML} Packets written to preauth/ folder"
}
