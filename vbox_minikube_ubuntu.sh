######################################################################
##Created by: Muhammad Usman (CNC-010506)
##Version:0.1
######################################################################

echo -----------------------------------------------------------------
echo "This script installs VirtualBox and minikube along with kubectl."
echo "It is assumed that you have enabled the virtualization bit in BIOS of your system"
echo -----------------------------------------------------------------
if [ $(uname -m) == "x86_64" ];
then
	echo You\'re running a comptatible OS, good, lets continue
else
	echo You\'re on the wrong OS architecture
	echo This script only works on Ubuntu x86_x64
	exit 66
fi

echo Press enter to continue
read
echo ---------------------------
echo "Installing VirtualBox 6.1"
echo ---------------------------
DIST=$(lsb_release -c | awk ' { print $2 } ')
echo "deb [arch=amd64] https://download.virtualbox.org/virtualbox/debian $DIST contrib" | sudo tee -a /etc/apt/sources.list

wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -

sudo apt update
sudo apt install  -y virtualbox-6.1

# configure K8s
if [ ! -d /usr/local/bin ]; then
sudo mkdir -p /usr/local/bin/
fi
echo -------------------
echo Configuring kubectl
echo -------------------
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl

echo -------------------
echo Confguring minikube
echo -------------------
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
chmod +x minikube
sudo install minikube /usr/local/bin/
rm ./minikube
echo ################################################################
echo Installation Completed Successfully!
echo 
echo 'To Check the version of kubectl run: "kubectl version --client"'
echo
echo 'To check the version of minikube run: "minikube version"'
echo ################################################################
echo 'You can now run minikube with command "minikube start --driver=virtualbox"'
echo 'Wait for the command to finish configuring minukube cluster in a single VM'
echo 'Make sure you have a Good internet connection as it downloads more than 500MB of data before fully configured'
echo
echo Good Luck and Have Fun!
