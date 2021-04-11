checkLog()
{
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
}


removeDataFiles()
{
  rm -r preauth/ 2> /dev/null || echo "preauth directory will be created"
  rm -r postauth/ 2> /dev/null || echo "postauth directory will be created"
}

# Timestamps the caller
timestamp()
{
  echo "========="
  date
  echo "========="
}

dumpLog()
{
  timestamp &>> ./log/ymon.log
  echo ${1} >> ./log/ymon.log
}
