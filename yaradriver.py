#!/usr/bin/python3
try:
    import yara
except:
    raise ModuleNotFoundError

import os

def checkRule(filem, rulem):
    rulesm = yara.compile(file=rulem)
    matchm = rulesm.match(data=filem.read(), timeout=60)
    return matchm

def cultivate(pcappath, rulepath):
    infectesFiles = {}
    pcapfiles = os.listdir(pcappath)
    rulefiles = os.listdir(rulepath)

    for pfile in pcapfiles:
        if pfile.endswith(".pcapng"):
            pfile = open(pcappath + pfile, "rb")
            for rfile in rulefiles:
                if rfile.endswith(".yar"):
                    rfile = open(rulepath + rfile)
                    matcher = checkRule(pfile, rfile)
                    if matcher:
                        # print(pfile.name," is infected with ",rfile.name)
                        #matcher[0] contains rule name
                        infectesFiles.setdefault(pfile.name, []).append(str(matcher[0]))
                        # print(infectesFiles)
                    rfile.close()
            pfile.close()
    return infectesFiles

if __name__ == '__main__':
    pass
