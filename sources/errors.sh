
priorError()
{
  echo "Sample Test Run of errors.sh file"
}


#default exception handler
handleError()
{
  echo -e ${RED}
  echo "Some error encountered"
  echo "Better to check dependencies and wireless interfaces"
  echo "then restart the script. GOOD BYE!!"
  echo "=========================="
  exit 1

}


interfaceError()
{
  echo -e "${RED}${ERR}${NRML}Interface not found"
  echo "=========================="
  exit 1
}
