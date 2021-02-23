# YaraCapper

![YaraCapper](https://i.imgur.com/DwsXcoF.png)

***
## Description
YARA Rule-based Automation System to Detect And Alert Network Attacks.
 ---
 ## Install and Launch
 ### Dependencies 
 - ** Packet Capture Engine **
    	1. Aircrack-ng
    	2. Tshark  

Use your package manager to install them
```bash
apt-get install aircrack-ng tshark
```

- ** Yara Validation Engine **
		1. yara-python

Use pip package to install
```bash
pip install yara-python
```

- ** Mailing Alert Engine **
		1. smtplib
		2. email

Use pip package to install
```bash
pip install smtplib
pip install email
```

After all the dependencies are installed. Do the following
### Launch

```bash
git clone https://github.com/karthikgenius/YaraCapper.git
cd YaraCapper
./YaraCapper.sh
```
