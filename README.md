# Dotfiles
## PowerShell Config
```powershell
# Download Package Manager
set-executionpolicy unrestricted -s cu
iex (new-object net.webclient).downloadstring('[https://get.scoop.sh')](https://get.scoop.sh%27%29/)
```
```
# Install linux coreutil on windows
scoop install sudo 7zip coreutils curl wget git grep openssh sed vim concfg pshazz
```
```
# Install GUI app
scoop bucket add extras
scoop install wsltty conemu vscode wireshark audacity vcxsrv
# Can add more
# Lie Java
scoop bucket add java
scoop install openjdk
```
```
# Install nerd-fonts via scoop
scoop bucket add nerd-fonts
# Now, need to open a PowerShell as Admin
sudo scoop install DejaVuSansMono-Nf
```
```
# Install FZF and and shell integration
scoop install fzf
Install-Module  -Name  PSFzf
```
```
# Install PowerShell Theme
concfg import  [https://raw.githubusercontent.com/h404bi/base16-concfg/master/presets/base16-oceanicnext.json](https://raw.githubusercontent.com/h404bi/base16-concfg/master/presets/base16-oceanicnext.json)
```

## sshd in WSL
```
# Open port in WSL
netsh advfirewall firewall add rule name="ICMP Allow incoming V4 echo request" protocol=icmpv4:8,any dir=in action=block
netsh advfirewall firewall add rule name="sshd" protocol=TCP dir=in localport=22 action=allow
```
```
# Configure sshd in WSL
sudo apt update
sudo apt remove openssh-server
sudo apt install openssh-server
sudo sed -i 's/^PasswordAuthentication $/PasswordAuthentication yes/' /etc/ssh/sshd_config
sudo service ssh --full-restart
```

## Configure wsltty
Open a powershell
```
vim %APPDATA%\wsltty\config
```
Write this:
```
Term=xterm-256color
Scrollbar=none
CursorType=block
Font=DejaVuSansMono NF
FontHeight=11
```

## Dotfiles Installation
```bash
# Create dotfiles dir
mkdir -p ~/.dotfiles && pushd ~/.dotfiles && \
# Grab raq dotfiles by calling dotfiles installer script
bash -c "$(curl -sL --proto-redir -all,https https://raw.githubusercontent.com/lpracette/dotfiles/master/install.sh)" && \
popd
```