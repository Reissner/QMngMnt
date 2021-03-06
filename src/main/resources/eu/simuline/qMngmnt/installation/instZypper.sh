#!/bin/sh -

# This is a shell script to install all software needed on a computer with minimal installation of suse tumbleweed. 
# It can also be used for update of these pieces of software although `zypper dup` shall be used. 
# This script is used prior to `zypper dup` in order to inform the user about most significant changes. 


zypper in -y MozillaThunderbird MozillaThunderbird-translations-common
# If the main directory is not preserved `~/.thunderbird` must be reconstructed.
# Also ensure that there is a link to thunderbird on the desktop



# TBD: reactivate later 
#zypper ar http://dl.google.com/linux/chrome/rpm/stable/x86_64 Google-Chrome
#wget https://dl.google.com/linux/linux_signing_key.pub
#rpm --import linux_signing_key.pub
#zypper ref -f
zypper in -y google-chrome-stable mathjax

# `okular` and `okular-lang` are installed in basic version but needed are also
# calligra to allow odp,... and spectre for forms 
# `evince` for support of xfa forms. 
#  As soon as okular supports them, evince is no longer needed. 
zypper in -y calligra-extras-okular okular-spectre evince

# for version control; essentially git, but also rarely mercurial which installs perl as side effect
# To make accessible in dolphin also install according plugins
# also install some further GUIs but in the long run maybe replaced by vs code
zypper in -y git git-doc bash-git-prompt git-filter-repo mercurial `# git and mercurial` \
dolphin-plugins gh gitg git-web git-cola glab git-mr `# GUI backends for git/mercurial` \
  kdiff3 kdiff3-lang diffmk diff-pdf `# diffing tools` # meld mgdiff tdiff tkdiff

#zypper in -y kdiff3 kdiff3-lang diffmk diff-pdf # meld mgdiff tdiff tkdiff


# at the moment mainly for octave:
# programming languages: 
# - gcc currently mainly for octave (with documentation with doxygen)
# - scala for eval , 
# - go 
zypper in -y gcc gcc-c++ gcc-fortran gcc-ada gcc-go cross-arm-gcc10 \
`#Also available: gcc-d, gcc-objc, gcc-obj-c++` \
 doxygen doxygen2man doxywizard `# doxygen, mainly for C` \
 autoconf automake libtool make `#make includes gnumake and cross platform cmake` \
 go-doc go `# go` \
 scala sbt `# scala; maybe not enough` \
 mono-core js `# mono used for tikz editor only, js broadly used `


rpm --import https://packages.microsoft.com/keys/microsoft.asc
#zypper addrepo https://packages.microsoft.com/yumrepos/vscode vscode
#zypper refresh
zypper in -y code
# please run instVScode.sh also 

#code --list-extensions
#code --install-extension ms-vscode.cpptools
#code --uninstall-extension ms-vscode.csharp
#code --install-extension Gimly81.matlab
#code --install-extension DavidAnson.vscode-markdownlint

zypper in -y emacs  `#emacs-auctex, maybe emacs no longer needed, maybe aspell for emacs only` \
 aspell aspell-de aspell-fr aspell-it aspell-pt_BR aspell-tl


# texlive base and more 
zypper in -y texlive `# the base` \
 texlive-xurl texlive-import texlive-verbatimbox `# xurl: line break in urls` \
 texlive-splitindex texlive-robustindex xindy texlive-uptex `# indices` \
 texlive-hanging texlive-stackengine texlive-tocloft texlive-etoc `# for doxygen` \
 pdftk texlive-pdfpagediff texlive-pdfpagediff-doc `# for pdf` \
       texlive-pdfprivacy texlive-pdfprivacy-doc`# for pdf` \
       exif exiftool `# show exif meta data, exiftool is better ` \
       `# Photini, exiv2 and gexif along the same lines as exif` \
 texlive-latex2man texlive-latex2nemeth latex2rtf `# converter` \
 unoconv pandoc texi2html texinfo libreoffice` # converter` \
 xfig gnuplot inkscape `# converter` \
 docbook2x discount `# the latter providing command 'markdown'` \
 rubber `#make utils texlive-arara? latexmake not present`
# TBD: more to come
# TBD: add for git



# maybe needed more packages and higher versions
zypper in -y java-11-openjdk-src java-11-openjdk java-11-openjdk-devel `#java11 already included in base installation ` \
             java-15-openjdk-src java-15-openjdk java-15-openjdk-devel `#java15 for trials` \
             java-1_8_0-openjdk-src java-1_8_0-openjdk java-1_8_0-openjdk-devel`#java1.8 for latex plugin` \
             maven `# basic build tool`


# some utilities 
zypper in -y kruler cheese `# webcam` \
 uucp cutecom moreutils zip bzip2-doc gparted \
 dhex ktorrent \
 xsane spectacle gimp k3b `#scanning, screenshot, image processing and burning` \
 vlc `# films` \
 whatsapp-purple `#displaylink not found` \
 kdeconnect-kde `#of course also on mobile kdeconnect must be installed. `



# there are much more packages on octave-forge worth being investigated
# octave-devel is to be able to add packages
#rpm -i ./octave-5.2.0-lp152.2.4.x86_64.rpm ./octave-devel-5.2.0-lp152.2.4.x86_64.rpm 
#octave octave-devel 
zypper in -y octave octave-devel python3-oct2py \
       octave-forge-cgi octave-forge-data-smoothing octave-forge-interval \
       octave-forge-signal octave-forge-statistics qhull \
       `# what follows is for compiling octave itself` \
       readline-devel rsvg-convert flex bison \
 f2c \
 gperf gperftools gperftools-devel gperftools-devel-static \
       libbz2-devel libcurl-devel qhull-devel icoutils \
 libQt5Core-devel libQt5Gui-devel \
       libQt5PrintSupport-devel libQt5Xml-devel libQt5Network-devel \
 qrupdate-devel sundials-devel sundials-doc \
       blas-devel libsndfile-devel freetype freetype-devel fontconfig-devel \
 mpfr-devel `# for installing certain packages`


# what is needed for docker 
zypper in -y docker-kubic docker-kubic-bash-completion \
       python3-docker-compose \
       python3-docker docker-client-java docker-client-java-javadoc \
       yast2-docker

# this is a hack only
if rpm -q firewalld  >/dev/null ;
then
    zypper rm -y python3-firewall firewalld firewalld-lang libnftables1
fi

systemctl enable docker
#usermod -aG docker `whoami`
#zypper in -y MicroOS-release # sth like alpine with suse



zypper in -y yum rpm-build `#to build rpm packages`



#if [[ -z zypper repos | egrep "^[0-9][0-9]* \| packman"]] ; then
#zypper addrepo -cfp 90 \
#       https://ftp.gwdg.de/pub/linux/misc/packman/suse/openSUSE_Tumbleweed/ \
#       packman
#fi
#zypper refresh
zypper dist-upgrade -y --from packman --allow-vendor-change
# TBD: following not found
# libavcodec58 libavdevice58 libavfilter7 libavformat58 libavutil56 
zypper in -y --from packman ffmpeg \
     gstreamer-plugins-bad gstreamer-plugins-libav gstreamer-plugins-ugly \
     libavresample4 vlc-codecs




zypper in -y virtualbox


zypper in -y gnome-keyring

#zypper rm -y ksshaskpass

# deinstall python 2.7 and dependencies
#zypper rm -y#gimp-plugins-python python-gobject2 python-gtk  python2-pycairo 
#zypper rm -y python # python-xml python-base 
#zypper rm -y libpython2_7-1_0
