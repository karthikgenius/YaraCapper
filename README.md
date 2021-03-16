# YaraCapper

![YaraCapper](https://i.imgur.com/DwsXcoF.png)

***
## Description
YARA Rule-based Automation System to Detect And Alert Network Attacks.
 
 ---
 ## Install Dependencies
 ### Clone  

```bash
git clone https://github.com/karthikgenius/YaraCapper.git
```

You can try *install-dependencies* script to install all the dependencies or else install them manually with your package manager.
### Install with automated script (Debian-based)
Debain-based users only
```bash
cd YaraCapper
sudo ./install-dependencies
```
This script installs all the dependencies used by YaraCapper  
### Install with package manager (Other distros)
 - **Packet Capture Engine**  
    	1. Aircrack-ng  
    	2. Tshark    

*Use your package manager to install above*

- **Yara Validation Engine**  
		1. yara-python  

- **Mailing Alert Engine**  
		1. smtplib  
		2. email  

Use pip package of python3 to install:  
```bash
pip install -r requirements.txt
```
***
## Launch  
Make sure you are in Yaracapper directory
```bash
./YaraCapper.sh
```

***
