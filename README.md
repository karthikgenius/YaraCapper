# YaraCapper v3.0

![YaraCapper](https://i.imgur.com/y4x7dtw.png)

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
sudo pip install -r requirements.txt
```
***
## Launch  
Make sure you are in Yaracapper directory
 ```bash
Usage: ./YaraCapper.sh <option>
Options:
-h    : help
-e    : Ethernet Capture
-w    : Wireless Capture
-b    : Prints Banner
```
To run YaraCapper  for wired network:  
```bash
sudo ./YaraCapper.sh -e
```
To run YaraCapper  for wireless(wifi) network:  
```bash
sudo ./YaraCapper.sh -w
```
## Deploying custom Distro
Go to the drive link and download the latest version and deploy in VMWare
![Download here](https://drive.google.com/drive/folders/1bU1E7wos2M5Vf3SIADHdojv252WVcnrw?usp=sharing)

## Credits:
[Vineela V](https://github.com/VineelaVinni1999),
I can't thank you enough for being such a nice and cool developer. All I can say is I’m touched beyond words.  
***
