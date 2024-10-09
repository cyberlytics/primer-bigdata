# Ensure we can run everything
Set-ExecutionPolicy Bypass -Scope Process -Force

wsl --setdefault 'Ubuntu-24.04'

$linuxUsername = Read-Host "Please enter your Ubuntu Username (chosen during install):"
Write-Output "PowerShell: You entered: $linuxUsername"
bash -c "echo 'Bash: You entered $linuxUsername'"
Write-Output "`nPress ENTER to continue..."
cmd /c Pause | Out-Null

# some version infos about distro:
bash -c "cat /etc/os-release; echo; lsb_release -a; echo; hostnamectl; echo; uname -r; echo;"

# #########
# BEWARE:
# The following shell escape with bash/echo works with powershell.exe BUT NOT with pwsh.exe (!)
# #########

# change ubuntu to allow sudo without password prompt:
#$commandString = 'echo \"' + $linuxUsername +' ALL=(ALL) NOPASSWD:ALL\" | sudo tee -a /etc/sudoers.d/'+ $linuxUsername
#bash -c $commandString
bash -c "echo '$linuxUsername ALL=(ALL) NOPASSWD:ALL' | sudo tee -a /etc/sudoers.d/$linuxUsername"

# recommended: set DNS/nameserver to idiot proof 1.1.1.1 (or 8.8.8.8)
bash -c 'echo -e \"\\n[network]\\ngenerateResolvConf = false\\n\\n[boot]\\ncommand = echo \\\"nameserver 1.1.1.1\\\" > /etc/resolv.conf\" | sudo tee -a /etc/wsl.conf'
bash -c "cat /etc/wsl.conf"
wsl --shutdown
bash -c "cat /etc/resolv.conf"

# check network/DNS from within ubuntu:
bash -c "ping -c 1 archive.ubuntu.com"
bash -c "sudo ping -c 1 security.ubuntu.com"

# upgrade distro:
bash -c "sudo DEBIAN_FRONTEND=noninteractive apt-get -y install build-essential"
bash -c "sudo DEBIAN_FRONTEND=noninteractive apt-get -y update"
bash -c "sudo DEBIAN_FRONTEND=noninteractive apt-get -y dist-upgrade"
bash -c "lsb_release -a"

# Optional: recommended explicit locale
bash -c "locale"
bash -c "sudo DEBIAN_FRONTEND=noninteractive locale-gen en_US.UTF-8"
bash -c "sudo DEBIAN_FRONTEND=noninteractive update-locale LANG=en_US.UTF-8"
bash -c "locale"

# #########
# Optional: recommended packages
# #########

bash -c "sudo DEBIAN_FRONTEND=noninteractive apt-get -y install bash-completion"
bash -c "sudo DEBIAN_FRONTEND=noninteractive apt-get -y install git"
bash -c "sudo DEBIAN_FRONTEND=noninteractive apt-get -y install dos2unix"
bash -c "sudo DEBIAN_FRONTEND=noninteractive apt-get -y install mc"
bash -c "sudo DEBIAN_FRONTEND=noninteractive apt-get -y install tree"
bash -c "sudo DEBIAN_FRONTEND=noninteractive apt-get -y install fonts-powerline"
bash -c "sudo DEBIAN_FRONTEND=noninteractive apt-get -y install zip"
bash -c "sudo DEBIAN_FRONTEND=noninteractive apt-get -y install unzip"
bash -c "sudo DEBIAN_FRONTEND=noninteractive apt-get -y install zsh"
bash -c "sudo DEBIAN_FRONTEND=noninteractive apt-get -y install ssh"
bash -c "sudo DEBIAN_FRONTEND=noninteractive apt-get -y install gcc make g++"
# PPA Repositories? Install software-properties-common package to get add-apt-repository command!
bash -c "sudo DEBIAN_FRONTEND=noninteractive apt-get -y install software-properties-common"

# #########
# Optional: Docker within WSL2
# #########
bash -c "sudo DEBIAN_FRONTEND=noninteractive sudo apt-get install ca-certificates curl"
bash -c "sudo DEBIAN_FRONTEND=noninteractive sudo install -m 0755 -d /etc/apt/keyrings"
bash -c "sudo DEBIAN_FRONTEND=noninteractive sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc"
bash -c "sudo DEBIAN_FRONTEND=noninteractive sudo chmod a+r /etc/apt/keyrings/docker.asc"
bash -c 'echo \"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo $VERSION_CODENAME) stable\" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null'
bash -c "sudo DEBIAN_FRONTEND=noninteractive sudo apt-get update"
bash -c "sudo DEBIAN_FRONTEND=noninteractive apt-get -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin"
bash -c "sudo docker run hello-world"

# #########
# Optional: recommended SSH initialization
# #########

bash -c "sudo DEBIAN_FRONTEND=noninteractive mkdir ~/.ssh"
bash -c "sudo DEBIAN_FRONTEND=noninteractive ssh-keygen -t rsa -P \'\' -f ~/.ssh/id_rsa"
bash -c "cat ~/.ssh/id_rsa.pub | sudo tee -a ~/.ssh/authorized_keys"
bash -c "sudo DEBIAN_FRONTEND=noninteractive chmod 0600 ~/.ssh/authorized_keys"

bash -c "sudo DEBIAN_FRONTEND=noninteractive chown $linuxUsername:$linuxUsername -R ~/.ssh/"
bash -c "sudo DEBIAN_FRONTEND=noninteractive sudo service ssh restart"

# #########
# sdkman
# #########
bash -c "curl -s 'https://get.sdkman.io' | bash"
bash -c "echo 'source ~/.sdkman/bin/sdkman-init.sh' >> ~/.bashrc"
bash -c "echo 'source ~/.sdkman/bin/sdkman-init.sh' >> ~/.zshrc"
bash -c "cat ~/.bashrc"
bash -c "cat ~/.zshrc"

# #########
# Hadoop requires Java!
# And python is recommended, too.
# (Only since Hadoop 3.3 the Java versions 11 and beyond are supported...)
# (Hadoop 3.0 to 3.2 supports only Java 8!)
# #########

# python
bash -c "sudo DEBIAN_FRONTEND=noninteractive apt-get -y install gcc make g++ python3 python-is-python3"

# java
bash -c "source ~/.sdkman/bin/sdkman-init.sh; sdk install java"

Write-Host "`nFINISHED with preparing ubuntu environment."
Write-Host "(You can re-enter ubuntu with PowerShell-command 'bash'!)"
Write-Output "Press ENTER to continue..."
cmd /c Pause | Out-Null