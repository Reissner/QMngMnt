
#!/bin/sh -

# ar is a shortcut for addrepo, 
# -f is a shortcut for --refresh and this is AUTO-refresh 


# Note that there seems to be no simple way to add a repository if not yet present. 
# Thus except at first run this script displays errors on repos already added. 

zypper ar --refresh https://ftp.gwdg.de/pub/linux/misc/packman/suse/openSUSE_Tumbleweed/ packman

# for whatsapp 
zypper ar --refresh https://download.opensuse.org/repositories/home:plater/Tumbleweed/home:plater.repo

# for skype
zypper addrepo --refresh https://download.opensuse.org/repositories/home:alveus:main/openSUSE_Tumbleweed/home:alveus:main.repo

# for google chrome 
zypper ar --refresh http://dl.google.com/linux/chrome/rpm/stable/x86_64 Google-Chrome
rpm --import https://dl.google.com/linux/linux_signing_key.pub
# if ! test linux_signing_key.pub ;
# then
#   wget -nc https://dl.google.com/linux/linux_signing_key.pub
# fi
# rpm --import linux_signing_key.pub


# for visual code
rpm --import https://packages.microsoft.com/keys/microsoft.asc
zypper addrepo --refresh https://packages.microsoft.com/yumrepos/vscode vscode

# for publishing, to be honest currently for epstool only 
zypper addrepo --refresh https://download.opensuse.org/repositories/Publishing/openSUSE_Tumbleweed/Publishing.repo

zypper addrepo --refresh https://download.opensuse.org/repositories/system:/snappy/openSUSE_Tumbleweed snappy

zypper --gpg-auto-import-keys refresh

## javafx, also needed for jabref
#zypper addrepo --refresh https://download.opensuse.org/repositories/home:fstrba:maven/openSUSE_Tumbleweed/home:fstrba:maven.repo

# for jabref
zypper addrepo --refresh https://download.opensuse.org/repositories/home:jloehel/openSUSE_Tumbleweed/home:jloehel.repo 

zypper refresh -f


