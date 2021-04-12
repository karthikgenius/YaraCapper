#!/bin/bash

# version
VERSION="v3.0"
source sources/colors.sh

trap resetApp INT

resetApp()
{
  sleep 1s
  echo
  echo -e "${RED}${ERR}${NRML} Caught Keyboard Interrupt.."
  echo -e "${YELLOW}${STAR}${NRML} Resetting YaraCapper to stable state.."
  sleep 2s
  airmon-ng stop wlan0mon &> /dev/null && service NetworkManager restart &> /dev/null
  echo -e "${GREEN}${GOOD}${NRML} Done, Exiting YaraCapper with code 1"
  exit 1
}

print_help()
{
  echo "Usage: $0 <option>"
  echo "Options:"
  echo "-h    : help"
  echo "-e    : Ethernet Capture"
  echo "-w    : Wireless Capture"
  echo "-b    : "Prints Banner
}

wired()
{
  bannerPrinter "$(cat banner.txt | base64 -d)"
  sleep 3s
  ./WiredPacketCapture.sh && python3 ./YaraValidateMail.py -p ./postauth/ -r ./rules/
}

wireless()
{
  bannerPrinter "$(cat banner.txt | base64 -d)"
  sleep 3s
  ./WirelessPacketCapture.sh && python3 ./YaraValidateMail.py -p ./postauth/ -r ./rules/
}

# Check arguments
if [[ $# -eq 0 || $# -gt 1 ]];
then
  print_help
  exit 1
fi

case "$1" in
-h) print_help ;;
-e) wired ;;
-w) wireless ;;
-b) bannerPrinter "$(cat banner.txt | base64 -d)" ;;
*)echo -e "${RED}${ERR}${NRML} $1 is unknown option" && print_help ;;
esac
