#!/bin/sh -

# This is a shell script to install all software needed on a computer 
# with minimal installation of suse tumbleweed. 
# It can also be used for update of these pieces of software 
# although `zypper dup` shall be used. 
# This script is used prior to `zypper dup` 
# in order to inform the user about most significant changes. 
# Prior to invoking this, configure the zypper repositories 
# running addRepos.sh fist. 

# basically this installation script is based on invocations of zypper 
# but there are cases where other programs are used for installation 
# - zypper and rpm are present at the basic installation 
# - wget, snapd and flatpak: must be installed and activated at first 
zypper in -y wget snapd flatpak
systemctl enable snapd

# unlike for zypper which complains if a repo is added, flatpak does not. 
# Thus we dont need a separate script for adding 
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

flatpak install -y flathub org.gaphor.Gaphor

# not permanently active 
# This is a fallback if version by zypper does not work 
flatpak install -y flathub com.visualstudio.code
cp ./CODE.sh /usr/bin/CODE
#chmod a+x /usr/bin/CODE

zypper in -y MozillaThunderbird MozillaThunderbird-translations-common
# If the main directory is not preserved `~/.thunderbird` must be reconstructed.
# Also ensure that there is a link to thunderbird on the desktop

# addrepo.sh adds special repo for that 
zypper in -y google-chrome-stable mathjax

# `okular` and `okular-lang` are installed in basic version but needed are also
# calligra to allow odp,... and spectre for forms 
# `evince` for support of xfa forms. 
#  As soon as okular supports them, evince is no longer needed. 
zypper in -y calligra-extras-okular okular-spectre evince

# for version control; essentially git, but also rarely mercurial which installs perl as side effect
# To make accessible in dolphin also install according plugins
# also install some further GUIs but in the long run maybe replaced by vs code
zypper in -y git git-doc bash-git-prompt git-filter-repo git-lfs `# git` \
  mercurial `# mercurial` \
  dolphin-plugins gh gitg git-web git-cola glab git-mr `# GUI backends for git/mercurial` \
  kdiff3 kdiff3-lang diffmk diff-pdf `# diffing tools` # meld mgdiff tdiff tkdiff

#zypper in -y kdiff3 kdiff3-lang diffmk diff-pdf # meld mgdiff tdiff tkdiff


# at the moment mainly for octave:
# programming languages: 
# - gcc currently mainly for octave (with documentation with doxygen)
# - scala for eval , 
# - go, smalltalk  
zypper in -y gcc gcc-c++ gcc-fortran gcc-ada gcc-go cross-arm-gcc13 \
  `#Also available: gcc-d, gcc-objc, gcc-obj-c++` \
  doxygen doxygen2man doxywizard `# doxygen, mainly for C` \
  autoconf automake libtool make `#make includes gnumake and cross platform cmake` \
  go-doc go `# go` \
  scala sbt `# scala; maybe not enough` \
  mono-core js `# mono used for tikz editor only, js broadly used ` \
  squeak-vm `# squeak is a dialect of smalltalk and the package provides a development environment `


zypper in -y emacs `#emacs-auctex, maybe emacs no longer needed, maybe aspell for emacs only` \
  aspell aspell-de aspell-fr aspell-it aspell-pt_BR aspell-tl `#spellchecker for emacs` \
  code
# please for vs code run instVScode.sh also 

# texlive base and more 
zypper in -y texlive-functional texlive-functional-doc `# the base` \
  texlive-functional `# provides functions like ifExists` \
  texlive-xurl        texlive-import texlive-verbatimbox `# xurl: line break in urls` \
  texlive-leaflet     texlive-leaflet-doc `# to support leaflets` \
  texlive-splitindex  texlive-robustindex xindy texlive-uptex `# indices` \
  texlive-bib2gls     texlive-bib2gls-bin texlive-bib2gls-doc `# glossaries` \
  texlive-hanging     texlive-stackengine texlive-tocloft texlive-etoc `# for doxygen` \
  texlive-draftwatermark texlive-draftwatermark-doc `# for watermarks like confidential or DRAFT` \
  texlive-jupynotex-doc `# for jupyter notebook` \
  texlive-latex2man   texlive-latex2nemeth latex2rtf `# converter` \
  texlive-pdfprivacy  texlive-pdfprivacy-doc`# for pdf` \
  texlive-dratex      texlive-dratex-doc `# only used to compile tex2ht` \
  texlive-pdfpagediff texlive-pdfpagediff-doc pdftk `# for pdf` \
  texlive-cprotect    texlive-cprotect-doc `# verbatim in macro` \
  texlive-newverbs    texlive-newverbs-doc `# verbatim as macro` \
  texlive-markdown    texlive-markdown-doc `# markdown into latex` \
  texlive-accessibility texlive-accessibility-doc `# accessibility into latex` \
  exif exiftool `# show exif meta data, exiftool is better ` \
    `# Photini, exiv2 and gexif along the same lines as exif` \
  unoconv pandoc texinfo libreoffice `# converter; texinfo implies texihtml and texiroff` \
  xfig gnuplot inkscape `# converter` \
  docbook2x discount `# the latter providing command 'markdown'` \
  rubber `# make utils texlive-arara? latexmake not present` \
  epstool `# eps files in latex also for octave`


# TBD: It is not ok just to patch into an existing and clean texlive installation. 
# To improve this, one shall install texlive in the standardized way, not via suse. 
mkdir -p /usr/share/texmf/bibtex/bst/abstract/
wget -nc -O /usr/share/texmf/bibtex/bst/abstract/abstract.bst http://tug.ctan.org/tex-archive/biblio/bibtex/utils/bibtools/abstract.bst

# TBD: It is not ok just to patch into an existing and clean texlive installation. 
# To improve this, one shall install texlive in the standardized way, not via suse. 
tikzVersion=${versionTikzuml}
#tikzuml-v1.0-2016-03-29
wget -nc -O $tikzVersion.tbz https://perso.ensta-paris.fr/~kielbasi/tikzuml/var/files/src/$tikzVersion.tbz
chmod a+w $tikzVersion.tbz
if ! [[ -e $tikzVersion ]]; then
  tar -xvf $tikzVersion.tbz
  chmod -R a+w $tikzVersion
  pushd $tikzVersion
  mkdir -p /usr/share/texmf/tex/latex/tikz-uml/
  cp tikz-uml.sty /usr/share/texmf/tex/latex/tikz-uml/
  mkdir -p /usr/share/texmf/doc/latex/tikz-uml
  cp -r doc/* /usr/share/texmf/doc/latex/tikz-uml
  popd
fi


# TBD: this shall be done inside the project. 
# this is a patch, which shall not be necessary in the long run. 
# It may even cause a problem if the package is updated. 
# The patch is from a dark channel 
# https://tex.stackexchange.com/questions/682383/htlatex-problem-with-caption-in-longtable/682399?noredirect=1#comment1693273_682399
cp ./tex4ht/longtable.4ht /usr/share/texmf/tex/generic/tex4ht/longtable.4ht 

texconfig rehash # part of texlive 


#zypper in -y jabref# this did not work: older version, problem with javafx
jabrefVersion=${versionJabref}
wget -nc -O ./jabref-$jabrefVersion.rpm https://www.fosshub.com/JabRef.html?dwl=jabref-$jabrefVersion.rpm
rpm -i ./jabref-$jabrefVersion.rpm
pushd /usr/local/bin/
ln -sf /opt/jabref/bin/JabRef JabRef
popd


# maybe needed more packages and higher versions
zypper in -y java-11-openjdk-src java-11-openjdk java-11-openjdk-devel `# java11 already included in base installation ` \
	java-17-openjdk-src java-17-openjdk java-17-openjdk-devel `#j ava17 needed for redhead plugin` \
  java-1_8_0-openjdk-src java-1_8_0-openjdk java-1_8_0-openjdk-devel `# java1.8 for latex plugin` \
  `#openjfx # also for jabref` \
  maven `# basic build tool`


# some utilities 
zypper in -y kruler cheese `# webcam` \
  system-user-uucp uucp cutecom moreutils zip bzip2-doc gparted \
  dhex ktorrent \
  xsane spectacle gimp k3b `# scanning, screenshot, image processing and burning` \
  vlc `# films` \
  whatsapp-purple `# displaylink not found` \
  `# the proper app: not working whatsie.x86_64` \
  `# skype whatsapp is with snap currently` \
  kdeconnect-kde `# of course also on mobile kdeconnect must be installed. `


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
# decativated docker-kubic docker-kubic-bash-completion \
zypper in -y python3-docker docker-client-java docker-client-java-javadoc \
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

# addrepo.sh adds special repo for that 
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
# this is a hack only
if rpm -q python  >/dev/null ;
then
  zypper rm -y gimp-plugins-python python-gobject2 python-gtk  python2-pycairo 
  zypper rm -y python `# python-xml python-base` 
  zypper rm -y libpython2_7-1_0
fi


#zypper in -y teams
#if rpm -q teams  >/dev/null ;
#then
#      zypper rm -y teams
#fi
#
# already in zypper 
snap install whatsdesk #teams-for-linux

pwd
