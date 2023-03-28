sudo groupadd docker
sudo usermod -aG docker viktor
shutdown -r now
docker login --username <USERNAME>
docker run hello-world
sudo sysctl net/netfilter/nf_conntrack_max=131072
tar xvzf tanzu-cli-bundle-linux-amd64.tar.gz
cd cli/
sudo install core/v0.28.0/tanzu-core-linux_amd64 /usr/local/bin/tanzu
source <(tanzu completion bash)
tanzu init
tanzu version
#Install kubectl
sudo apt-get update
sudo apt-get install -y ca-certificates curl
sudo apt-get install -y apt-transport-https
sudo curl -fsSLo /etc/apt/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get install -y kubectl
#or
snap install kubectl --classic
#Install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
(echo; echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"') >> /home/viktor/.profile
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
#Install carvell tools
brew tap vmware-tanzu/carvel
brew install ytt kbld kapp imgpkg kwt vendir kctrl