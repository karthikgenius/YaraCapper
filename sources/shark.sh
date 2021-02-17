# Check for tshark installation
tsharkCheck()
{
  tshark --help &> /dev/null && echo -e "${GREEN}${GOOD}${NRML} tshark Installed"
}

# Start tshark
startTshark()
{
  echo -e "${BLUE}"
  read -p "How many packet(s) do you want to capture: " PNUM
  # echo -e "${YELLOW}${STAR}${NRML} Removing existing packet capture data.."
  # sleep 1s
  # rm ./postauth/* &> /dev/null
  echo
  tshark -c ${PNUM} -i ${INTR} -w ./postauth/$(date +%Y%m%d%H%M%S).pcapng
  echo
}
