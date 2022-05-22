# for video; priority 90
zypper ar -c 90 https://ftp.gwdg.de/pub/linux/misc/packman/suse/openSUSE_Tumbleweed/ packman

# for whatsapp 
zypper ar https://download.opensuse.org/repositories/home:plater/Tumbleweed/home:plater.repo 

# for google chrome 
zypper ar http://dl.google.com/linux/chrome/rpm/stable/x86_64 Google-Chrome
wget https://dl.google.com/linux/linux_signing_key.pub
rpm --import linux_signing_key.pub


# for visual code
rpm --import https://packages.microsoft.com/keys/microsoft.asc
zypper addrepo https://packages.microsoft.com/yumrepos/vscode vscode

zypper refresh -f
