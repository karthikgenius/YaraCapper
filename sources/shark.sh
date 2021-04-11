# Checks for tshark installation
tsharkCheck()
{
  tshark --help &> /dev/null && echo -e "${GREEN}${GOOD}${NRML} tshark Installed"
}

# tshark implementation
startTshark()
{
  echo -e "${BLUE}"
  read -p "How many packet(s) do you want to capture: " PNUM
  if [[ -n ${PNUM} ]];
  then
    tshark -c ${PNUM} -i ${INTR} -w ./postauth/$(date +%Y%m%d%H%M%S).pcapng
  else
    echo -e "${YELLOW}${STAR}${NRML} Incorrect number of packets.. Setting default to 10"
    tshark -c 10 -i ${INTR} -w ./postauth/$(date +%Y%m%d%H%M%S).pcapng
  fi
  echo
}
