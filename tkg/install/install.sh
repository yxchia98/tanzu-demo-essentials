#
# Install & configure Docker
#
snap install docker
sudo groupadd docker
sudo usermod -aG docker viktor
#
#
# Prompt user if the system should be rebooted
#

echo "You should reboot your system after you've installed Docker"
echo "If you've already rebooted your system, select n to continue the script"

read -p "Do you want to reboot the system now? (y/n) " choice

# Check user's response and reboot or continue with script
if [[ $choice =~ ^[Yy]$ ]]; then
    echo "Rebooting system..."
    sudo reboot
else
    echo "Continuing with remaining steps of the script..."
    # Add remaining steps of the script here
fi

#
# Test docker
# Optional - login to dockerhub: docker login --username <USERNAME>
#
# Test docker

docker run hello-world

#
# Required configuration for Kind
#

sudo sysctl net/netfilter/nf_conntrack_max=131072

#
# Install and configure Tanzu CLI
#

tar xvzf tanzu-cli-bundle-linux-amd64.tar.gz
cd cli/
sudo install core/v0.28.0/tanzu-core-linux_amd64 /usr/local/bin/tanzu
source <(tanzu completion bash)
tanzu init
tanzu version

#
# Install kubectl
#

sudo apt-get update
sudo apt-get install -y ca-certificates curl
sudo apt-get install -y apt-transport-https
sudo curl -fsSLo /etc/apt/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get install -y kubectl

#
# Alternative installation using snap
# snap install kubectl --classic
#
# Install brew package manager for most easy installation of Carvel Tools
#

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
(echo; echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"') >> /home/viktor/.profile
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

#Install carvell tools

brew tap vmware-tanzu/carvel
brew install ytt kbld kapp imgpkg kwt vendir kctrl
