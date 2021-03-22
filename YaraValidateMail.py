#!/usr/bin/python3

# color coded outputs - colorama
from colorama import Fore, Style

# yaradriver and maildriver module
try:
    import yaradriver
except ModuleNotFoundError:
    print(f"{Fore.RED}[-]{Style.RESET_ALL} Yara dependencies are missing")
    exit(1)

try:
    import maildriver
except ModuleNotFoundError:
    print(f"{Fore.RED}[-]{Style.RESET_ALL} Mail dependencies are missing")
    exit(1)

# generic module
import time
import argparse

# Assigning sender and reciever mail addresses
frommail = "xyz@gmail.com" # change from mail here
passwd = "" # add passwd here
tomail = "" # add admin mail here

#Passing pcap and rule files as function arguments
# packetfiles = sys.argv[1]
# rulefiles = sys.argv[2]

parser = argparse.ArgumentParser(description = "YaraValidateMail.py [options]")
parser.add_argument("-p", dest = "packetfiles", help = "Specify Packet file path", required = True)
parser.add_argument("-r", dest = "rulefiles", help = "Specify Rule files path", required = True)
options = parser.parse_args()

packetfiles = options.packetfiles
rulefiles = options.rulefiles


# main
def main():
    content = ""

    print(f"{Fore.YELLOW}[*]{Style.RESET_ALL} Cultivating Packet files and Rule files")
    print(f"{Fore.GREEN}[+]{Style.RESET_ALL} Scanning Started")
    time.sleep(0.3)

    try:
        validator = yaradriver.cultivate(packetfiles, rulefiles)
    except:
        print(f"{Fore.RED}[-]{Style.RESET_ALL} Error raised during cultivation of rules with packet files")
        exit(1)

    print(f"{Fore.GREEN}[+]{Style.RESET_ALL} Scanning Done Successfully")
    print(f"{Fore.GREEN}[+]{Style.RESET_ALL} Cultivation Done")
    time.sleep(0.3)


    #Validate each pcap file with all rules
    if validator:
        for key in validator.keys():
            for rule in validator.get(key):
                # content = content+ "File Name: "+ key.replace(packetfiles,'')+ " infected with: "+ rule.replace(rulefiles,'')+ "\n"
                content = content + "File Name: " + key.replace(packetfiles, '') + " infected with: " + rule + "\n"
    else:
        print(f"{Fore.GREEN}[+]{Style.RESET_ALL} Whola! No Matches!")
        exit()

    print(f"{Fore.YELLOW}[*]{Style.RESET_ALL} YaraCapper is sending mail to " +tomail)
    time.sleep(0.3)

    mailref = maildriver.YaraCapperMail()
    mailref.addEmail(frommail, passwd)
    mailref.set(tomail, content)
    try:
        mailref.loadpcap(validator)
    except:
        print(f"{Fore.RED}[-]{Style.RESET_ALL} Error occured while adding packet attachments")
        exit(1)

    try:
        stat = mailref.launch()
        if stat:
            print(f"{Fore.GREEN}[+]{Style.RESET_ALL} Mail sent successfully")
    except:
        print(f"{Fore.RED}[-]{Style.RESET_ALL} Error while connecting or logging in")
        exit(1)


if __name__ == '__main__':
    main()
