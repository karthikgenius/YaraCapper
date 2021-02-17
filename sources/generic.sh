
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
