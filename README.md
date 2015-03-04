## Aimed to create a all-in-one install-script for spreads for Ubuntu and Debian based OSes.
## Where it works
Much of the program will be compiled on the client-side, so it should be cross-platform (yet it was only tested in linaro 14.04 and Mint 17 and Ubuntu-Server).
## How it works:
#Just install git on the platform of your choice:
```ubuntu terminal```
sudo apt-get update && sudo apt-get install git-core screen -y 
#Clone this repo by typing 
```ubuntu terminal```
git clone https://github.com/boredland/spreads-deploy
#Enter the directory and run the script
```ubuntu terminal```
cd spreads-deploy
screen -S "setup" -d -m
screen -r "setup" -X stuff $'./setup.sh\n'
screen -r "setup"
# Whenever the program asks for superuser-permissions this should be okay. 
