# get source files
# contact Karthik Techie @ techiekarthik.in
# CEH | Author | Pentester | Security researcher | Orator

ETHER="eth0"
LOCALHOST="lo"

restartNetwork()
{
  service NetworkManager restart 2> /dev/null || echo "Error in restarting network manager"
  sleep 1s
}

validateInterface()
{
  if [[ ${INTR} = ${ETHER} || ${INTR} = ${LOCALHOST} ]];
  then
    return 1
  elif [[ -e /sys/class/net/${INTR} ]];
  then
    return 0
  else
    return 1
  fi
}
