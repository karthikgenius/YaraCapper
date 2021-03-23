#!/usr/bin/python3

try:
    import smtplib
    from email.message import EmailMessage
except:
    raise ModuleNotFoundError

class YaraCapperMail:
    mailer = EmailMessage()

    def addEmail(self, mailid, passwd):
        self.emailaddress = mailid
        self.emailpasswd = passwd

    def set(self, tomail, message = " YaraCapper Demo Content!"):
        YaraCapperMail.mailer['Subject']  = "YaraCapper Alert!!!"
        YaraCapperMail.mailer['From'] = self.emailaddress
        YaraCapperMail.mailer['To'] = tomail
        YaraCapperMail.mailer.set_content(message)
        # return YaraCapperMail.mailer['Subject']

    def loadpcap(self, attachList):
        for file in attachList.keys():
                with open(file, "rb") as f:
                    file_data = f.read()
                    file_type = "vnd.tcpdump.pcap"
                    file_name = f.name
                    YaraCapperMail.mailer.add_attachment(file_data, maintype="application", subtype=file_type, filename=file_name)

    def launch(self):
        with smtplib.SMTP_SSL('smtp.gmail.com', 465) as smtp:
            smtp.login(self.emailaddress, self.emailpasswd)
            smtp.send_message(YaraCapperMail.mailer)
            return True


if __name__ == '__main__':
    pass
