######################################################################
##Created by: Muhammad Usman (CNC-010506)
##Version:0.1
######################################################################

echo "This script installs VirtualBox and minikube along with kubectl"
if [ $(uname -m) == "x86_x64" ];
then
	echo You\'re running a comptatible OS, good, lets continue
else
	echo You\'re on the wrong OS architecture
	echo This script only works on x86_x64
	exit 66
fi

echo press enter to continue
read
echo "Installing VirtualBox 6.1"

DIST=$(lsb_release -c)
echo "deb [arch=amd64] https://download.virtualbox.org/virtualbox/debian $DIST contrib"  >> /etc/apt/sources.list

wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -

sudo apt update
sudo apt install virtualbox-6.1

# configure K8s
if [ ! -d /usr/local/bin ]; then
sudo mkdir -p /usr/local/bin/
fi

echo Configuring kubectl 
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl

echo Confguring minikube
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && chmod +x minikube

sudo install minikube /usr/local/bin/

### automatically rebooting to complete procedure

echo Installation Completed Successfully
echo 'Once rebooted you can run minikube with command "minikube start --driver=virtualbox"'
echo 'Wait for the command to finish configuring minukube cluster in a single VM'
echo 'Make sure you have a GOOD internet connection as it downloads more than 500MB of data before fully configured'
echo Good Luck and Have Fun!
## echo Press Ctrl-C now to stop this script in case you don\'t want to reboot
## sleep 5
## cat << REBOOT >> /root/completeme.sh
## vboxconfig
## rm -f /etc/profile
## mv /etc/profile.bak /etc/profile
## echo DONE
## REBOOT
## 
## chmod +x /root/completeme.sh
## cp /etc/profile /etc/profile.bak
## echo /root/completeme.sh >> /etc/profile
## 
## reboot
