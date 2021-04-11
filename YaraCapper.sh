#!/bin/bash

# version
VERSION="v3.0"
source sources/colors.sh

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
