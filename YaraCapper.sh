#!/bin/bash
source sources/colors.sh

bannerPrinter
sleep  2s
clear

./PacketCapture.sh && python3 ./YaraValidateMail.py -p ./postauth/ -r ./rules/
